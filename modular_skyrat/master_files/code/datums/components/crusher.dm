/datum/component/kinetic_crusher
	/// The attached trophies.
	var/list/stored_trophies = list()
	/// How much damage to deal on mark detonation?
	var/detonation_damage
	/// How much EXTRA damage to deal on a backstab?
	var/backstab_bonus
	/// Does what you think it does.
	var/recharge_speed
	/// Callback to check against for most actions.
	var/datum/callback/attack_check
	/// Callback to check against for mark detonation.
	var/datum/callback/detonate_check
	/// Callback to execute after a successful mark detonation.
	var/datum/callback/after_detonate

	/// Are we ready to shoot another destabilizer shot?
	var/charged = TRUE
	/// COMSIG_ITEM_ATTACK procs before the damage is applied. Egh.
	var/cached_health = null

/datum/component/kinetic_crusher/Initialize(detonation_damage, backstab_bonus, recharge_speed, datum/callback/attack_check, datum/callback/detonate_check, datum/callback/after_detonate)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.detonation_damage = detonation_damage
	src.backstab_bonus = backstab_bonus
	src.recharge_speed = recharge_speed

	src.attack_check = attack_check
	src.detonate_check = detonate_check
	src.after_detonate = after_detonate

/datum/component/kinetic_crusher/RegisterWithParent(datum/parent = src.parent)
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))

	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(on_attack))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SECONDARY, PROC_REF(on_attack_secondary))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_afterattack))
	RegisterSignal(parent, COMSIG_ITEM_INTERACTING_WITH_ATOM, PROC_REF(on_interact))
	RegisterSignal(parent, COMSIG_ITEM_INTERACTING_WITH_ATOM_SECONDARY, PROC_REF(on_interact_secondary))
	RegisterSignal(parent, COMSIG_RANGED_ITEM_INTERACTING_WITH_ATOM_SECONDARY, PROC_REF(on_interact_secondary))

/datum/component/kinetic_crusher/Destroy(force)
	QDEL_LIST(stored_trophies) //dont be a dummy
	attack_check = null
	detonate_check = null
	after_detonate = null
	return ..()

/datum/component/kinetic_crusher/proc/on_examine(obj/item/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/force
	var/datum/component/two_handed/comp = source.GetComponent(/datum/component/two_handed)
	if(istype(source, /obj/item/clothing/gloves/kinetic_gauntlets)) //ughhhhh
		var/obj/item/clothing/gloves/kinetic_gauntlets/gauntlets = parent
		force = gauntlets.right_gauntlet?.force || gauntlets.left_gauntlet.force
	else if(comp)
		force = comp.force_wielded
	else
		force = source.force

	examine_list += span_notice("Mark a large creature with a destabilizing force with right-click, then hit them in melee to do <b>[force + detonation_damage]</b> damage.")
	examine_list += span_notice("Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.")
	for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
		examine_list += span_notice("It has \a [trophy] attached, which causes [trophy.effect_desc()].")

/datum/component/kinetic_crusher/proc/on_update_overlays(atom/source, list/overlays)
	SIGNAL_HANDLER

	if(!charged)
		overlays += "[source.icon_state]_uncharged"

/datum/component/kinetic_crusher/proc/on_attackby(datum/source, obj/item/attacking_item, mob/user, params)
	SIGNAL_HANDLER

	if(attacking_item.tool_behaviour == TOOL_CROWBAR)
		if(!LAZYLEN(stored_trophies))
			to_chat(user, span_warning("There are no trophies on [source]."))
			return COMPONENT_NO_AFTERATTACK

		to_chat(user, span_notice("You remove [source]'s trophies."))
		attacking_item.play_tool_sound(src)
		for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
			trophy.remove_from(parent, user, src)

		if(istype(parent, /obj/item/clothing/gloves/kinetic_gauntlets))
			var/obj/item/clothing/gloves/kinetic_gauntlets/gauntlets = parent //CODE DEBT CODE DEBT WOOOOO
			gauntlets.left_gauntlet?.force = gauntlets.force * 5
			gauntlets.right_gauntlet?.force = gauntlets.force * 5

		return COMPONENT_NO_AFTERATTACK

	if(istype(attacking_item, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/trophy = attacking_item
		trophy.add_to(parent, user, src)
		return COMPONENT_NO_AFTERATTACK

/datum/component/kinetic_crusher/proc/on_trophy_moved(obj/item/crusher_trophy/source, atom/oldloc, direction)
	SIGNAL_HANDLER

	source.remove_from(parent, null, src)

/datum/component/kinetic_crusher/proc/on_attack(obj/item/source, mob/living/target, mob/living/carbon/user)
	SIGNAL_HANDLER

	cached_health = target.health

	var/cancel_attack = NONE
	if(attack_check && !attack_check.Invoke(user, &cancel_attack))
		return cancel_attack

	if(!target.has_status_effect(/datum/status_effect/crusher_damage))
		target.apply_status_effect(/datum/status_effect/crusher_damage)

	for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
		trophy.on_melee_hit(target, user)


/datum/component/kinetic_crusher/proc/on_attack_secondary(obj/item/source, mob/living/victim, mob/living/user, params)
	SIGNAL_HANDLER

	var/cancel_attack = NONE
	if(attack_check && !attack_check.Invoke(user, &cancel_attack))
		return cancel_attack

	return COMPONENT_SECONDARY_CONTINUE_ATTACK_CHAIN

/datum/component/kinetic_crusher/proc/on_afterattack(obj/item/source, mob/living/target, mob/living/user, click_parameters)
	SIGNAL_HANDLER

	if(!isliving(target))
		return

	var/datum/status_effect/crusher_damage/damage_effect = target.has_status_effect(/datum/status_effect/crusher_damage) || target.apply_status_effect(/datum/status_effect/crusher_damage)
	if(damage_effect && isnum(cached_health)) //legiooooons
		damage_effect.total_damage += cached_health - target.health //carry over from the /on_attack()
		cached_health = null

	if(detonate_check && !detonate_check.Invoke(user))
		return

	if(!target.remove_status_effect(/datum/status_effect/crusher_mark, src))
		return

	var/backstabbed = FALSE
	var/dealt_damage = detonation_damage
	if(target.dir & get_dir(user, target))
		backstabbed = TRUE
		dealt_damage += backstab_bonus
		playsound(user, 'sound/weapons/kinetic_accel.ogg', 100, TRUE)

	damage_effect.total_damage += dealt_damage
	new /obj/effect/temp_visual/kinetic_blast(get_turf(target))

	var/past_damage = target.maxHealth - target.health
	for(var/obj/item/crusher_trophy/trophy as anything in stored_trophies)
		trophy.on_mark_detonation(target, user)

	damage_effect.total_damage += dealt_damage + target.get_total_damage() - past_damage //we did some damage, but let's not assume how much we did

	after_detonate?.InvokeAsync(user, target)
	SEND_SIGNAL(user, COMSIG_LIVING_CRUSHER_DETONATE, target, parent, backstabbed)
	target.apply_damage(dealt_damage, BRUTE, blocked = target.getarmor(type = BOMB))


/datum/component/kinetic_crusher/proc/on_interact(obj/item/source, mob/living/user, atom/target, modifiers)
	SIGNAL_HANDLER

	if(!istype(target, /obj/item/crusher_trophy))
		return

	. = ITEM_INTERACT_SUCCESS
	var/obj/item/crusher_trophy/trophy = target
	trophy.add_to(parent, user, src)

	if(istype(parent, /obj/item/clothing/gloves/kinetic_gauntlets))
		var/obj/item/clothing/gloves/kinetic_gauntlets/gauntlets = parent //CODE DEBT CODE DEBT WOOOOO
		gauntlets.left_gauntlet?.force = gauntlets.force * 5
		gauntlets.right_gauntlet?.force = gauntlets.force * 5

/datum/component/kinetic_crusher/proc/on_interact_secondary(obj/item/source, mob/living/user, atom/target, list/modifiers)
	SIGNAL_HANDLER

	var/_ = TRUE
	if(attack_check && _ /*unused var error*/&& !attack_check.Invoke(user, &_))
		return

	if(!charged)
		return

	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return

	var/obj/projectile/destabilizer/destabilizer = new(proj_turf)
	for(var/obj/item/crusher_trophy/attached_trophy as anything in stored_trophies)
		attached_trophy.on_projectile_fire(destabilizer, user)

	destabilizer.preparePixelProjectile(target, user, modifiers)
	destabilizer.hammer_synced = src
	destabilizer.firer = user

	// just typing spawn(-1) is faster ugghhh tg
	INVOKE_ASYNC(destabilizer, TYPE_PROC_REF(/obj/projectile, fire))
	playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, TRUE)

	var/obj/item/crusher = parent
	charged = FALSE
	crusher.update_appearance()
	addtimer(CALLBACK(src, PROC_REF(recharge_shot)), recharge_speed)
	return ITEM_INTERACT_SUCCESS



/datum/component/kinetic_crusher/proc/recharge_shot()
	var/obj/item/crusher = parent
	charged = TRUE
	crusher.update_appearance()
	playsound(crusher.loc, 'sound/weapons/kinetic_reload.ogg', 60, TRUE)

