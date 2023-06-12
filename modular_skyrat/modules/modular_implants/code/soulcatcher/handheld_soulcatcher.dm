/obj/item/handheld_soulcatcher
	name = "\improper Evoker-type RSD"
	desc = "The Evoker-Type Resonance Simulation Device is a sort of 'Soulcatcher' instrument that's been designated for handheld usage. These RSDs were designed with the Medical field in mind, a tool meant to offer comfort to the temporarily-departed while their bodies are being repaired, healed, or produced. The Evoker is essentially a very specialized handheld NIF, still using the same nanomachinery for the software and hardware. This careful instrument is able to host a virtual space for a great number of Engrams for an essentially indefinite amount of time in an unlimited variety of simulations, even able to transfer them to and from a NIF. However, it's best Medical practice to not lollygag."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "soulcatcher-device"
	inhand_icon_state = "electronic"
	/// Associative list of (user -> target), where user is anyone that used this object on a target mob.
	/// Merely a advanced form of boolean that considers the possibility of this item being dropped/handed to someone else - the actual value of an entry is irrelevant.
	/// User is removed on ui close.
	var/list/mob/interacting_mobs = list()
	/// A list of mobs that currently have the "Do you want to join this room" pop-up. Used to prevent spam of the popup.
	/// Target removed on popup close or popup holder destroy.
	var/list/mob/confirming_entry = list()
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	/// What soulcatcher datum is associated with this item?
	var/datum/component/soulcatcher/linked_soulcatcher

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
	if(!target_mob || !user)
		return ..()

	if(target_mob.GetComponent(/datum/component/previous_body))
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	if(!target_mob.mind)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

	if (interacting_mobs[user])
		to_chat(user, span_warning("You already have room selection open, close it or choose a room!"))
		return FALSE

	// dont worry about invalid states in regards to this tgui_list, it uses a custom ui_state that prevents abuse
	interacting_mobs[user] = target_mob // prevents list spam by storing the fact we clicked on this mob
	var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms, ui_state = new /datum/ui_state/handheld_soulcatcher_state(src), timeout = 30 SECONDS)
	interacting_mobs -= user // tgui lists sleep - trust no variables after this point
	if(!target_room)
		return FALSE

	if(!target_mob.mind)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

	to_chat(user, span_blue("[target_mob] has been requested to join [target_room]."))
	if (!invite_soul(target_room, user, target_mob))
		to_chat(user, span_warning("[target_mob] doesn't seem to want to enter."))
		return FALSE

	var/target_dead = (target_mob.stat == DEAD)
	var/mob/dead/observer/ghost = target_mob.get_ghost(TRUE, TRUE)

	if (target_dead && !ghost)
		target_mob.ghostize(TRUE)
		ghost = target_mob.get_ghost(TRUE, TRUE) // ghostized, new ghost could be here

	if (!target_mob.can_join_soulcatcher_room(target_room, TRUE)) // sanity
		return FALSE

	var/turf/source_turf = get_turf(user)
	var/admin_log = "[key_name(user)] used [src] to put [key_name(target_mob)]'s mind into a soulcatcher at [AREACOORD(source_turf)]."
	if (ghost)
		if(!target_room.add_soul_from_ghost(ghost))
			return FALSE
	else
		admin_log += " [target_mob] was still alive."
		target_room.add_soul(target_mob.mind, TRUE)

		playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message(span_notice("[src] beeps: [target_mob]'s mind transfer is now complete."))

	log_admin(admin_log)

	if(!target_mob.GetComponent(/datum/component/previous_body))
		return FALSE
	linked_soulcatcher.scan_body(target_mob, user)

	return TRUE

/**
 * Invites target_mob into target_room by giving them a tgui_alert.
 * target_mob cannot be invited more than once while a alert from a given soulcatcher is open, enforced by
 * src.confirming_entry += real_target and a check surrounding that.
 *
 * Args:
 * datum/soulcatcher/target_room: The room we are inviting target_mob to.
 * mob/living/user (Nullable): The individual who invited the mob.
 * mob/living/target_mob: The mob that was clicked on/invited into the room.
 *
 * Returns:
 * False if the invitation wasn't delivered, the result of the tgui_alert otherwise.
 */
/obj/item/handheld_soulcatcher/proc/invite_soul(datum/soulcatcher_room/target_room, mob/living/user, mob/living/target_mob)
	if (target_mob in confirming_entry)
		if (user)
			to_chat(user, span_warning("You've already invited this person to a room, wait for them to respond!"))
		return FALSE

	var/message = "Do you want to transfer your soul into [target_room]?"
	if (user)
		message = "[user] wants to transfer you to [target_room] inside of a soulcatcher, do you accept?"
	var/target_dead = (target_mob.stat == DEAD)
	var/mob/dead/observer/ghost = target_mob.get_ghost(TRUE, TRUE)
	var/mob/real_target = target_mob

	if(ghost || target_dead) //We can temporarily store souls of dead mobs.
		target_mob.ghostize(TRUE) //Incase they are staying in the body.
		ghost = target_mob.get_ghost(TRUE, TRUE) // ghostized, new ghost could be here
		if(!ghost)
			if (user)
				to_chat(user, span_warning("You are unable to get the soul of [target_mob]!"))
			return FALSE
		else
			real_target = ghost
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

// This proc exists just to be safe and ensure no reference schenanigans happen.
/obj/item/handheld_soulcatcher/proc/handle_confirming_soul_del(mob/soul)
	SIGNAL_HANDLER

	confirming_entry -= soul
	UnregisterSignal(soul, COMSIG_PARENT_QDELETING)

