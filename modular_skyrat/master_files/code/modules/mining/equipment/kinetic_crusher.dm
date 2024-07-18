/obj/item/kinetic_crusher
	name = "proto-kinetic crusher"
	desc = "An early design of the proto-kinetic accelerator, it is little more than a combination of various mining tools cobbled together, forming a high-tech club. \
	While it is an effective mining tool, it did little to aid any but the most skilled and/or suicidal miners against local fauna."
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	inhand_icon_state = "crusher0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	resistance_flags = FIRE_PROOF
	force = 0 //You can't hit stuff unless wielded
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	armour_penetration = 10
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 1.15,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 2.075
	)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("smashes", "crushes", "cleaves", "chops", "pulps")
	attack_verb_simple = list("smash", "crush", "cleave", "chop", "pulp")
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/toggle_light)
	obj_flags = UNIQUE_RENAME
	light_color = "#ffff66"
	light_on = FALSE
	light_power = 1.2
	light_range = 5
	light_system = OVERLAY_LIGHT

	var/charge_time = 1.5 SECONDS
	var/detonation_damage = 50
	var/backstab_bonus = 30

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, speed = 6 SECONDS, effectiveness = 110)
	AddComponent(/datum/component/kinetic_crusher, detonation_damage, backstab_bonus, charge_time, CALLBACK(src, PROC_REF(attack_check)), CALLBACK(src, PROC_REF(attack_check)))
	AddComponent(/datum/component/two_handed, force_wielded = 20, force_unwielded = 0, unwield_callback = CALLBACK(src, PROC_REF(on_unwield)))
	RegisterSignal(src, COMSIG_HIT_BY_SABOTEUR, PROC_REF(on_saboteur))

/obj/item/kinetic_crusher/proc/attack_check(mob/user, cancel_attack)
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		return TRUE

	to_chat(user, span_warning("[src] is too heavy to use with one hand! You fumble and drop everything."))
	user.drop_all_held_items()
	if(cancel_attack)
		*cancel_attack = COMPONENT_CANCEL_ATTACK_CHAIN
	return FALSE

/obj/item/kinetic_crusher/ui_action_click(mob/user, actiontype)
	set_light_on(!light_on)
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()

//////////////////////////////////////////////////////////////////////////////////
/////// HACK TO WORK AROUND TWOHANDED NOT RESPECTING FORCE_UNWIELDED=0 ///////////
//////////////////////////////////////////////////////////////////////////////////
/obj/item/kinetic_crusher/proc/on_unwield()
	SIGNAL_HANDLER

	force = 0 //the abrasive comments is so you notice. seriously, this is BAD.

//////////////////////////////////////////////////////////////////////////////////
/////// HACK TO WORK AROUND TWOHANDED NOT RESPECTING FORCE_UNWIELDED=0 ///////////
//////////////////////////////////////////////////////////////////////////////////

/obj/item/kinetic_crusher/proc/on_saboteur(datum/source, disrupt_duration)
	set_light_on(FALSE)
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	return COMSIG_SABOTEUR_SUCCESS

/obj/item/kinetic_crusher/update_icon_state()
	inhand_icon_state = "crusher[HAS_TRAIT(src, TRAIT_WIELDED)]" // this is not icon_state and not supported by 2hcomponent
	return ..()

/obj/item/kinetic_crusher/update_overlays()
	. = ..()
	if(light_on)
		. += "[icon_state]_lit"

/obj/item/kinetic_crusher/compact //for admins
	name = "compact kinetic crusher"
	w_class = WEIGHT_CLASS_NORMAL

//stupid to have both crusher and crusher_comp as params but it helps with reducing core code mods
/obj/item/crusher_trophy/proc/add_to(obj/item/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	for(var/obj/item/crusher_trophy/trophy as anything in crusher_comp.stored_trophies)
		if(istype(trophy, denied_type) || istype(src, trophy.denied_type))
			to_chat(user, span_warning("You can't seem to attach [src] to [crusher]. Maybe remove a few trophies?"))
			return FALSE

	if(!user.transferItemToLoc(src, crusher))
		return

	crusher_comp.stored_trophies += src
	crusher_comp.RegisterSignal(src, COMSIG_MOVABLE_MOVED, TYPE_PROC_REF(/datum/component/kinetic_crusher, on_trophy_moved))
	to_chat(user, span_notice("You attach [src] to [crusher]."))
	return TRUE

/obj/item/crusher_trophy/proc/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	crusher_comp.UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	crusher_comp.stored_trophies -= src
	forceMove(get_turf(crusher))
	return TRUE

/obj/projectile/destabilizer
	name = "destabilizing force"
	icon_state = "pulse1"
	damage = 0 //We're just here to mark people. This is still a melee weapon.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 6
	log_override = TRUE
	var/datum/component/kinetic_crusher/hammer_synced

/obj/projectile/destabilizer/Destroy()
	hammer_synced = null
	return ..()

/obj/projectile/destabilizer/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isliving(target))
		var/mob/living/living = target
		var/has_owned_mark = FALSE
		for(var/datum/status_effect/crusher_mark/crusher_mark as anything in living.get_all_status_effect_of_id(/datum/status_effect/crusher_mark))
			if(crusher_mark.hammer_synced != hammer_synced)
				continue

			has_owned_mark = TRUE
			break

		if(!has_owned_mark)
			living.apply_status_effect(/datum/status_effect/crusher_mark, hammer_synced)

	var/turf/closed/mineral/target_turf = get_turf(target) //sure i guess
	if(istype(target_turf))
		new /obj/effect/temp_visual/kinetic_blast(target_turf)
		target_turf.gets_drilled(firer)

	return ..()

/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	. = ..()
	if(.)
		crusher_comp.recharge_speed -= bonus_value

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	. = ..()
	if(.)
		crusher_comp.recharge_speed += bonus_value


/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	. = ..()
	if(!.)
		return

	crusher.force += bonus_value * 0.2
	crusher_comp.detonation_damage += bonus_value * 0.8

	var/datum/component/two_handed/two_handed = crusher.GetComponent(/datum/component/two_handed)
	two_handed?.force_wielded += bonus_value * 0.2

/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	. = ..()
	if(!.)
		return

	crusher.force -= bonus_value * 0.2
	crusher_comp.detonation_damage -= bonus_value * 0.8

	var/datum/component/two_handed/two_handed = crusher.GetComponent(/datum/component/two_handed)
	two_handed?.force_wielded -= bonus_value * 0.2


/obj/item/crusher_trophy/wendigo_horn/add_to(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(!.)
		return

	crusher.force *= 2

	var/datum/component/two_handed/two_handed = crusher.GetComponent(/datum/component/two_handed)
	two_handed?.force_wielded *= 2

/obj/item/crusher_trophy/wendigo_horn/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(!.)
		return

	crusher.force *= 0.5

	var/datum/component/two_handed/two_handed = crusher.GetComponent(/datum/component/two_handed)
	two_handed?.force_wielded *= 0.5


/obj/item/crusher_trophy/watcher_eye
	name = "watcher eye"
	desc = "An eye ripped out from some unfortunate watcher's eyesocket. Suitable as a trophy for a kinetic crusher."
	icon = 'modular_skyrat/master_files/icons/obj/artifacts.dmi'
	icon_state = "watcher_eye"
	denied_type = /obj/item/crusher_trophy/watcher_eye
	var/used_color = "#ff7777" //gay by default

/obj/item/crusher_trophy/watcher_eye/effect_desc()
	return "<font color='[used_color]'>very pretty colors</font> to imbue the destabilizer shots"

/obj/item/crusher_trophy/watcher_eye/attack_self(mob/user, modifiers)
	var/chosen_color = input(user, "Pick a new color", "[src]", used_color) as color|null
	if(chosen_color)
		used_color = chosen_color
		to_chat(user, span_notice("You recolor [src]."))
		update_appearance()

/obj/item/crusher_trophy/watcher_eye/update_overlays()
	. = ..()
	var/mutable_appearance/overlay = mutable_appearance('modular_skyrat/master_files/icons/obj/artifacts.dmi', "watcher_eye_iris")
	overlay.color = used_color
	. += overlay

/obj/item/crusher_trophy/watcher_eye/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	marker.icon = 'modular_skyrat/master_files/icons/obj/weapons/guns/projectiles.dmi'
	marker.icon_state = "pulse1_g"
	marker.color = used_color
