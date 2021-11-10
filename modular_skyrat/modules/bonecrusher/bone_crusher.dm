///***BONE CRUSHER***///
//So basically this is shamelessly copy pasta'd crusher code because I cant figure out a good way to remove a component thats already been
//initialized by the game, in this case the primary reason would be the adjustment of force_wielded from 20 to 15. I cant exactly figure out
//how to do this so if someone has a good idea, drop it in the comments and I'll commit it. The only actual changes to this should be on
//lines 11-16, 36, 38 and lines 48-49. Changes are noted where made.
//Also yes this is recipe locked to ashwalkers only, since thats the primary demographic this is intended for. Intended to be slightly weaker
//than the PKC, but better than most weapons ashwalkers can make because of trophies existing.


/obj/item/bone_crusher
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	inhand_icon_state = "crusher0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "makeshift proto-kinetic axe"
	desc = "Upon closer examination, this appears to be what could be called a definitive 'tech club', compared to its estranged cousin, the Proto-Kinetic Crusher. Resembling more akin to a bone axe with metal strapped to it, this crude but effective weapon is the Ashwalkers response to the PKC."
	force = 0 //You can't hit stuff unless wielded
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	armour_penetration = 10
	custom_materials = list(/datum/material/iron=1000, /datum/material/bone = 12000)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("smashes", "crushes", "cleaves", "chops", "pulps")
	attack_verb_simple = list("smash", "crush", "cleave", "chop", "pulp")
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/toggle_light)
	obj_flags = UNIQUE_RENAME
	light_system = MOVABLE_LIGHT
	light_range = 5
	light_on = FALSE
	var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 20 // Original value: 15
	var/detonation_damage = 50
	var/backstab_bonus = 25 // Original value: 25
	var/wielded = FALSE // track wielded status on item

/obj/item/bone_crusher/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/bone_crusher/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 50, 125) //Slightly faster and more efficient, original value: 60, 110
	AddComponent(/datum/component/two_handed, force_unwielded=0, force_wielded=15) //Slightly weaker when wielded, original value: 20

/obj/item/bone_crusher/Destroy()
	QDEL_LIST(trophies)
	return ..()

/// triggered on wield of two handed item
/obj/item/bone_crusher/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/bone_crusher/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER
	wielded = FALSE

/obj/item/bone_crusher/examine(mob/living/user)
	. = ..()
	. += span_notice("Mark a large creature with the destabilizing force, then hit them in melee to do <b>[force + detonation_damage]</b> damage.")
	. += span_notice("Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.")
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += span_notice("It has \a [T] attached, which causes [T.effect_desc()].")

/obj/item/bone_crusher/attackby(obj/item/I, mob/living/user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(LAZYLEN(trophies))
			to_chat(user, span_notice("You remove [src]'s trophies."))
			I.play_tool_sound(src)
			for(var/t in trophies)
				var/obj/item/crusher_trophy/T = t
				T.remove_from(src, user)
		else
			to_chat(user, span_warning("There are no trophies on [src]."))
	else if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()

/obj/item/bone_crusher/attack(mob/living/target, mob/living/carbon/user)
	if(!wielded)
		to_chat(user, span_warning("[src] is too heavy to use with one hand! You fumble and drop everything."))
		user.drop_all_held_items()
		return
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	if(!C)
		C = target.apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/bone_crusher/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	var/modifiers = params2list(clickparams)
	if(!wielded)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/destabilizer/D = new /obj/projectile/destabilizer(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, modifiers)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, TRUE)
		D.fire()
		charged = FALSE
		update_appearance()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		if(!C)
			C = L.apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = BOMB)
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, TRUE) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

/obj/item/bone_crusher/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_appearance()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE)

/obj/item/bone_crusher/ui_action_click(mob/user, actiontype)
	set_light_on(!light_on)
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()


/obj/item/bone_crusher/update_icon_state()
	inhand_icon_state = "crusher[wielded]" // this is not icon_state and not supported by 2hcomponent
	return ..()

/obj/item/bone_crusher/update_overlays()
	. = ..()
	if(!charged)
		. += "[icon_state]_uncharged"
	if(light_on)
		. += "[icon_state]_lit"


///CRAFTING RECIPE

/datum/crafting_recipe/bone_crusher
	name = "Makeshift Proto-Kinetic Axe"
	result = /obj/item/bone_crusher
	reqs = list(/obj/item/fireaxe/boneaxe = 1,
				/obj/item/gun/energy/kinetic_accelerator = 1,
				/obj/item/forging/complete/plate = 4,
				/obj/item/stack/sheet/sinew = 4,
				/obj/item/stack/sheet/bone = 4)
	tool_behaviors = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WELDER)
	always_available = FALSE
	time = 80
	category = CAT_PRIMAL
