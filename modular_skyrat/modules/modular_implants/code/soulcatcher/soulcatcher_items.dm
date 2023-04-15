/obj/item/soulcatcher_item
	name = "soulcatcher item"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "soulcatcher-device"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	/// What soulcatcher datum is associated with this item?
	var/datum/component/soulcatcher/linked_soulcatcher

/obj/item/soulcatcher_item/attack_self(mob/user, modifiers)
	. = ..()
	linked_soulcatcher.ui_interact(user)

/obj/item/soulcatcher_item/New(loc, ...)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/soulcatcher)

/obj/item/soulcatcher_item/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	var/datum/component/previous_body/body_component = target_mob.GetComponent(/datum/component/previous_body)
	if(body_component)
		scan_body(body_component, user)
		to_chat(user, span_warning("[target_mob]'s soul is already in a soulcatcher"))
		return TRUE

	if(!target_mob.mind || !target_mob.ckey)
		var/list/soul_list = list()
		for(var/datum/soulcatcher_room/room in linked_soulcatcher.soulcatcher_rooms)
			for(var/mob/living/soulcatcher_soul/soul in room.current_souls)
				if(!soul.round_participant)
					continue

				soul_list += soul

		if(length(soul_list) == 0)
			to_chat(user, span_warning("There are no souls that can be transfered to [target_mob]"))

	if(target_mob.stat == DEAD) //We can temporarily store souls of dead mobs.
		var/mob/dead/observer/target_ghost = target_mob.get_ghost(TRUE, TRUE)
		if(!target_ghost)
			to_chat(user, span_warning("You are unable to get the soul of [target_mob]!"))
			return FALSE

		var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Chose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms)
		if(!target_room)
			return FALSE

		if(tgui_alert(target_ghost, "[user] wants to transfer you to a soulcatcher, do you accept?", name, list("Yes", "No"), autofocus = TRUE) != "Yes")
			to_chat(user, span_warning("[target_mob]'s doesn't seem to want to enter."))

		if(target_room.add_soul_from_ghost(target_ghost))
			return FALSE

		body_component = target_mob.GetComponent(/datum/component/previous_body)
		if(!body_component)
			return FALSE

		scan_body(body_component, user)
		return TRUE

	var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Chose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms)
	if(!target_room)
		return FALSE

	if(tgui_alert(target_mob, "Do you wish to enter [target_room]?", name, list("Yes", "No")) != "Yes")
		return FALSE

	target_room.add_soul(target_mob.mind, TRUE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] beeps: [target_mob]'s mind transfer is now complete."))

	return TRUE

/obj/item/soulcatcher_item/attack_secondary(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return FALSE

	if(target_mob.mind || target_mob.ckey || !ishuman(target_mob))
		to_chat(user, span_warning("[target_mob] is not able to recieve a soul"))

	var/list/soul_list = list()
	for(var/datum/soulcatcher_room/room in linked_soulcatcher.soulcatcher_rooms)
		for(var/mob/living/soulcatcher_soul/soul in room.current_souls)
			if(!soul.round_participant || soul.body_scan_needed)
				continue

			soul_list += soul

	if(length(soul_list) == 0)
		to_chat(user, span_warning("There are no souls that can be transfered to [target_mob]"))
		return FALSE

	var/mob/living/soulcatcher_soul/chosen_soul = tgui_input_list(user, "Chose a soul to transfer into the body", name, soul_list)
	if(!chosen_soul)
		return FALSE

	if(chosen_soul.previous_body)
		var/mob/living/old_body = chosen_soul.previous_body.resolve()
		var/datum/component/previous_body/body_component = old_body.GetComponent()
		body_component.restore_mind = FALSE
		qdel(body_component)

	chosen_soul.mind.transfer_to(target_mob, TRUE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] beeps: Body transfer complete."))

	return TRUE

/// Attemps to scan the body for the `previous_body component`
/obj/item/soulcatcher_item/proc/scan_body(datum/component/previous_body/body_to_scan, mob/living/user)
	var/mob/living/parent_body = body_to_scan.parent
	var/mob/living/soulcatcher_soul/target_soul = body_to_scan.soulcatcher_soul.resolve()
	if(!body_to_scan || !target_soul)
		return FALSE

	if(!target_soul.body_scan_needed)
		to_chat(user, span_blue("[parent_body] has already been scanned!"))
		return FALSE

	target_soul.body_scan_needed = FALSE
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] beeps: [parent_body] is now scanned."))

	to_chat(target_soul, span_blue("Your body has scanned, revealing  your true identity."))
	target_soul.name = parent_body.real_name

	return TRUE

