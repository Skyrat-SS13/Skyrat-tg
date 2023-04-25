/obj/item/handheld_soulcatcher
	name = "\improper Evoker-type RSD"
	desc = "The Evoker-Type Resonance Simulation Device is a sort of 'Soulcatcher' instrument that's been designated for handheld usage. These RSDs were designed with the Medical field in mind, a tool meant to offer comfort to the temporarily-departed while their bodies are being repaired, healed, or produced. The Evoker is essentially a very specialized handheld NIF, still using the same nanomachinery for the software and hardware. This careful instrument is able to host a virtual space for a great number of Engrams for an essentially indefinite amount of time in an unlimited variety of simulations, even able to transfer them to and from a NIF. However, it's best Medical practice to not lollygag."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "soulcatcher-device"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	/// What soulcatcher datum is associated with this item?
	var/datum/component/soulcatcher/linked_soulcatcher

/obj/item/handheld_soulcatcher/attack_self(mob/user, modifiers)
	linked_soulcatcher.ui_interact(user)

/obj/item/handheld_soulcatcher/New(loc, ...)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/soulcatcher)

/obj/item/handheld_soulcatcher/Destroy(force)
	if(linked_soulcatcher)
		qdel(linked_soulcatcher)

	return ..()

/obj/item/handheld_soulcatcher/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	var/datum/component/previous_body/body_component = target_mob.GetComponent(/datum/component/previous_body)
	if(body_component)
		linked_soulcatcher.scan_body(body_component, user)
		return TRUE

	if(!target_mob.mind || !target_mob.ckey)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

	if(target_mob.stat == DEAD) //We can temporarily store souls of dead mobs.
		target_mob.ghostize(TRUE) //Incase they are staying in the body.
		var/mob/dead/observer/target_ghost = target_mob.get_ghost(TRUE, TRUE)
		if(!target_ghost)
			to_chat(user, span_warning("You are unable to get the soul of [target_mob]!"))
			return FALSE

		var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms, timeout = 30 SECONDS)
		if(!target_room)
			return FALSE

		if(tgui_alert(target_ghost, "[user] wants to transfer you to [target_room] inside of a soulcatcher, do you accept?", name, list("Yes", "No"), 30 SECONDS, autofocus = TRUE) != "Yes")
			to_chat(user, span_warning("[target_mob] doesn't seem to want to enter."))
			return FALSE

		if(!target_room.add_soul_from_ghost(target_ghost))
			return FALSE

		body_component = target_mob.GetComponent(/datum/component/previous_body)
		if(!body_component)
			return FALSE

		var/turf/source_turf = get_turf(user)
		log_admin("[key_name(user)] used [src] to put [key_name(target_mob)]'s mind into a soulcatcher at [AREACOORD(source_turf)]")
		linked_soulcatcher.scan_body(body_component, user)
		return TRUE

	var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms, timeout = 30 SECONDS)
	if(!target_room)
		return FALSE

	if((tgui_alert(target_mob, "Do you wish to enter [target_room]? This will remove you from your body until you leave.", name, list("Yes", "No"), 30 SECONDS) != "Yes") || (tgui_alert(target_mob, "Are you sure about this?", name, list("Yes", "No"), 30 SECONDS) != "Yes"))
		to_chat(user, span_warning("[target_mob] doesn't seem to want to enter."))
		return FALSE

	if(!target_mob.mind)
		return FALSE

	target_room.add_soul(target_mob.mind, TRUE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] beeps: [target_mob]'s mind transfer is now complete."))

	body_component = target_mob.GetComponent(/datum/component/previous_body)
	linked_soulcatcher.scan_body(body_component, user)

	var/turf/source_turf = get_turf(user)
	log_admin("[key_name(user)] used [src] to put [key_name(target_mob)]'s mind into a soulcatcher while they were still alive at [AREACOORD(source_turf)]")

	return TRUE

/obj/item/handheld_soulcatcher/attack_secondary(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return FALSE

	if(target_mob.mind || target_mob.ckey || !ishuman(target_mob) || GetComponent(/datum/component/previous_body))
		to_chat(user, span_warning("[target_mob] is not able to recieve a soul"))
		return FALSE

	var/list/soul_list = list()
	for(var/datum/soulcatcher_room/room as anything in linked_soulcatcher.soulcatcher_rooms)
		for(var/mob/living/soulcatcher_soul/soul as anything in room.current_souls)
			if(!soul.round_participant || soul.body_scan_needed)
				continue

			soul_list += soul

	if(!length(soul_list))
		to_chat(user, span_warning("There are no souls that can be transfered to [target_mob]."))
		return FALSE

	var/mob/living/soulcatcher_soul/chosen_soul = tgui_input_list(user, "Choose a soul to transfer into the body", name, soul_list)
	if(!chosen_soul)
		return FALSE

	if(chosen_soul.previous_body)
		var/mob/living/old_body = chosen_soul.previous_body.resolve()
		if(!old_body)
			return FALSE

		SEND_SIGNAL(old_body, COMSIG_SOULCATCHER_RETURN_SOUL, FALSE)


	chosen_soul.mind.transfer_to(target_mob, TRUE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src] beeps: Body transfer complete."))

	var/turf/source_turf = get_turf(user)
	log_admin("[src] was used by [user] to transfer [chosen_soul]'s soulcatcher soul to [target_mob] at [AREACOORD(source_turf)]")
	qdel(chosen_soul)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
