#define SOULCATCHER_CATCH_TIME_LIMIT 30 SECONDS

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
	/// Associative list of (user -> target), where user is anyone that used this object on a target mob.
	/// User is removed on ui close.
	var/list/mob/interacting_mobs = list()
	/// A list of mobs that currently have the "Do you want to join this room" pop-up. Used to prevent spam of the popup.
	/// Target removed on popup close or popup holder destroy.
	var/list/mob/confirming_entry = list()

/obj/item/handheld_soulcatcher/attack_self(mob/user, modifiers)
	linked_soulcatcher.ui_interact(user)

/obj/item/handheld_soulcatcher/New(loc, ...)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/soulcatcher)
	linked_soulcatcher.name = "[src] soulcatcher"

/obj/item/handheld_soulcatcher/Destroy(force)
	if(linked_soulcatcher)
		qdel(linked_soulcatcher)

	interacting_mobs = null

	for (var/mob/soul as anything in confirming_entry)
		UnregisterSignal(soul, COMSIG_PARENT_QDELETING)
		confirming_entry -= soul
	confirming_entry = null

	return ..()

/obj/item/handheld_soulcatcher/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	if(target_mob.GetComponent(/datum/component/previous_body))
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	if(!target_mob.mind)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

	interacting_mobs[user] = target_mob
	var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms, ui_state = new /datum/ui_state/handheld_soulcatcher_state(src))
	interacting_mobs -= user
	if(!target_room)
		return FALSE

	if(!target_mob.mind)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

	if (!user.can_join_soulcatcher_room(target_room, TRUE))
		return FALSE

	to_chat(user, span_blue("[target_mob] has been requested to join [target_room]."))
	if (!invite_soul(target_room, user, target_mob))
		to_chat(user, span_warning("[target_mob] doesn't seem to want to enter."))
		return FALSE

	var/target_dead = (target_mob.stat == DEAD)
	var/mob/real_target = target_mob
	if (target_dead)
		var/mob/dead/observer/ghost = target_mob.get_ghost(TRUE, TRUE)
		if (ghost)
			real_target = ghost

	if (!real_target.can_join_soulcatcher_room(target_room))
		return FALSE

	var/turf/source_turf = get_turf(user)
	var/admin_log = "[key_name(user)] used [src] to put [key_name(real_target)]'s mind into a soulcatcher at [AREACOORD(source_turf)]."
	if (target_dead)
		if(!target_room.add_soul_from_ghost(real_target))
			return FALSE
	else
		admin_log += " [real_target] was still alive."
		target_room.add_soul(real_target.mind, TRUE)

		playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message(span_notice("[src] beeps: [real_target]'s mind transfer is now complete."))

	if(!real_target.GetComponent(/datum/component/previous_body))
		return FALSE
	linked_soulcatcher.scan_body(real_target, user)

	log_admin(admin_log)
	return TRUE

/obj/item/handheld_soulcatcher/proc/invite_soul(datum/soulcatcher_room/target_room, mob/living/user, mob/living/target_mob)
	if (target_mob in confirming_entry)
		to_chat(user, span_warning("You've already invited this person to a room, wait for them to respond!"))
		return FALSE

	var/message = "[user] wants to transfer you to [target_room] inside of a soulcatcher, do you accept?"
	var/target_dead = (target_mob.stat == DEAD)
	var/mob/real_target = target_mob

	if(target_dead) //We can temporarily store souls of dead mobs.
		target_mob.ghostize(TRUE) //Incase they are staying in the body.
		var/mob/dead/observer/target_ghost = target_mob.get_ghost(TRUE, TRUE)
		if(!target_ghost)
			to_chat(user, span_warning("You are unable to get the soul of [target_mob]!"))
			return FALSE
		else
			real_target = target_ghost
	else
		message += " This will remove you from your body until you leave."

	confirming_entry += real_target
	RegisterSignal(real_target, COMSIG_PARENT_QDELETING, PROC_REF(handle_confirming_soul_del))
	SEND_SOUND(real_target, 'sound/misc/notice2.ogg')
	window_flash(real_target.client)
	var/invitation_results = (((tgui_alert(real_target, message, name, list("Yes", "No"), 30 SECONDS) == "Yes") && (tgui_alert(real_target, "Are you sure about this?", name, list("Yes", "No"), 30 SECONDS) == "Yes")))
	UnregisterSignal(real_target, COMSIG_PARENT_QDELETING)
	confirming_entry -= real_target

	return invitation_results

/obj/item/handheld_soulcatcher/proc/handle_confirming_soul_del(mob/soul)
	SIGNAL_HANDLER

	confirming_entry -= soul
	UnregisterSignal(soul, COMSIG_PARENT_QDELETING)

#undef SOULCATCHER_CATCH_TIME_LIMIT
