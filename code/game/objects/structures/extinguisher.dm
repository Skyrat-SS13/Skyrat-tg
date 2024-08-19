/obj/structure/extinguisher_cabinet
<<<<<<< HEAD
	name = "extinguisher cabinet"
	desc = "A small wall mounted cabinet designed to hold a fire extinguisher."
	icon = 'icons/obj/wallmounts.dmi' //ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	icon_state = "extinguisher_closed"
=======
	name = "extinguisher rack"
	desc = "A small wall mounted rack designed to hold a fire extinguisher."
	icon = 'icons/obj/structures/cabinet.dmi'
	icon_state = "rack"
>>>>>>> e7b5d07c9bfa (Extinguisher cabinet resprite (#85961))
	anchored = TRUE
	density = FALSE
	max_integrity = 200
	integrity_failure = 0.25
	var/obj/item/extinguisher/stored_extinguisher

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/extinguisher_cabinet, 29)

/obj/structure/extinguisher_cabinet/Initialize(mapload, ndir, building)
	. = ..()
<<<<<<< HEAD
	if(building)
		opened = TRUE
		//icon_state = "extinguisher_empty" ORIGINAL
		icon_state = "extinguisher_empty_open"	//SKYRAT EDIT CHANGE - AESTHETICS
	else
=======
	if(!building)
>>>>>>> e7b5d07c9bfa (Extinguisher cabinet resprite (#85961))
		stored_extinguisher = new /obj/item/extinguisher(src)
	update_appearance(UPDATE_ICON)
	register_context()
	find_and_hang_on_wall()

/obj/structure/extinguisher_cabinet/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(isnull(held_item))
		if(stored_extinguisher)
			context[SCREENTIP_CONTEXT_LMB] = "Take extinguisher"
		return CONTEXTUAL_SCREENTIP_SET

	if(stored_extinguisher)
		return NONE

	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = "Disassemble cabinet"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/extinguisher))
		context[SCREENTIP_CONTEXT_LMB] = "Insert extinguisher"
		return CONTEXTUAL_SCREENTIP_SET
	return .

/obj/structure/extinguisher_cabinet/Destroy()
	if(stored_extinguisher)
		QDEL_NULL(stored_extinguisher)
	return ..()

/obj/structure/extinguisher_cabinet/contents_explosion(severity, target)
	if(!stored_extinguisher)
		return

	switch(severity)
		if(EXPLODE_DEVASTATE)
			SSexplosions.high_mov_atom += stored_extinguisher
		if(EXPLODE_HEAVY)
			SSexplosions.med_mov_atom += stored_extinguisher
		if(EXPLODE_LIGHT)
			SSexplosions.low_mov_atom += stored_extinguisher

/obj/structure/extinguisher_cabinet/Exited(atom/movable/gone, direction)
	if(gone == stored_extinguisher)
		stored_extinguisher = null
		update_appearance(UPDATE_ICON)

/obj/structure/extinguisher_cabinet/attackby(obj/item/used_item, mob/living/user, params)
	if(used_item.tool_behaviour == TOOL_WRENCH && !stored_extinguisher)
		user.balloon_alert(user, "deconstructing rack...")
		used_item.play_tool_sound(src)
		if(used_item.use_tool(src, user, 60))
			playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
			user.balloon_alert(user, "rack deconstructed")
			deconstruct(TRUE)
		return

	if(iscyborg(user) || isalien(user))
		return
	if(istype(used_item, /obj/item/extinguisher))
		if(!stored_extinguisher)
			if(!user.transferItemToLoc(used_item, src))
				return
			stored_extinguisher = used_item
			user.balloon_alert(user, "extinguisher stored")
			update_appearance(UPDATE_ICON)
			return TRUE
		else
			return
	else
		return ..()


/obj/structure/extinguisher_cabinet/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(iscyborg(user) || isalien(user))
		return
	if(stored_extinguisher)
		user.put_in_hands(stored_extinguisher)
		user.balloon_alert(user, "extinguisher removed")

/obj/structure/extinguisher_cabinet/attack_tk(mob/user)
	. = COMPONENT_CANCEL_ATTACK_CHAIN
	if(stored_extinguisher)
		stored_extinguisher.forceMove(loc)
		to_chat(user, span_notice("You telekinetically remove [stored_extinguisher] from [src]."))
		stored_extinguisher = null
		update_appearance(UPDATE_ICON)
		return

/obj/structure/extinguisher_cabinet/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

<<<<<<< HEAD
/obj/structure/extinguisher_cabinet/proc/toggle_cabinet(mob/user)
	if(opened && broken)
		user.balloon_alert(user, "it's broken!")
	else
		playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
		opened = !opened
		update_appearance(UPDATE_ICON)

/* SKYRAT EDIT REMOVAL BEGIN - AESTHETICS - MOVED TO MODULAR.
/obj/structure/extinguisher_cabinet/update_icon_state()
	icon_state = "extinguisher"

	if(isnull(stored_extinguisher))
		icon_state += ""
	else if(istype(stored_extinguisher, /obj/item/extinguisher/mini))
		icon_state += "_mini"
	else if(istype(stored_extinguisher, /obj/item/extinguisher/advanced))
		icon_state += "_advanced"
	else if(istype(stored_extinguisher, /obj/item/extinguisher/crafted))
		icon_state += "_crafted"
	else if(istype(stored_extinguisher, /obj/item/extinguisher))
		icon_state += "_default"

	if(!opened)
		icon_state += "_closed"

	return ..()
*/

=======
>>>>>>> e7b5d07c9bfa (Extinguisher cabinet resprite (#85961))
/obj/structure/extinguisher_cabinet/atom_break(damage_flag)
	. = ..()
	if(!broken)
		broken = 1
		if(stored_extinguisher)
			stored_extinguisher.forceMove(loc)
			stored_extinguisher = null
		update_appearance(UPDATE_ICON)


/obj/structure/extinguisher_cabinet/atom_deconstruct(disassembled = TRUE)
	if(disassembled)
		new /obj/item/wallframe/extinguisher_cabinet(loc)
	else
		new /obj/item/stack/sheet/iron (loc, 2)
	if(stored_extinguisher)
		stored_extinguisher.forceMove(loc)
		stored_extinguisher = null

<<<<<<< HEAD
=======
/obj/structure/extinguisher_cabinet/update_overlays()
	. = ..()
	if(stored_extinguisher)
		. += stored_extinguisher.cabinet_icon_state

>>>>>>> e7b5d07c9bfa (Extinguisher cabinet resprite (#85961))
/obj/item/wallframe/extinguisher_cabinet
	name = "extinguisher rack frame"
	desc = "Used for building wall-mounted extinguisher cabinets."
<<<<<<< HEAD
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "extinguisher_assembly"
=======
	icon = 'icons/obj/structures/cabinet.dmi'
	icon_state = "rack"
>>>>>>> e7b5d07c9bfa (Extinguisher cabinet resprite (#85961))
	result_path = /obj/structure/extinguisher_cabinet
	pixel_shift = 29
