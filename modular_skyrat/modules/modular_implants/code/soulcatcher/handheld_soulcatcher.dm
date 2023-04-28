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
	/// Associative list of (target -> (modified_key -> datum instance))
	/// A temporary "map" of modified strings corresponding to room datums. See the tgui list proc for more information, as it's just a copy.
	/// Target cleared on UI close or destroy.
	var/list/items_map = list()
	/// A list of mobs that currently have the "Do you want to join this room" pop-up. Used to prevent spam of the popup.
	/// Target removed on popup close or popup holder destroy.
	var/list/mob/confirming_entry = list()
	/// A assoc list of (user -> time_used), where time_used is the world.time reported when the list TGUI window was opened.
	/// User removed on UI close.
	var/list/start_times = list()

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
	items_map = null
	start_times = null

	for (var/mob/soul as anything in confirming_entry)
		UnregisterSignal(soul, COMSIG_PARENT_QDELETING)
		confirming_entry -= soul
	confirming_entry = null

	return ..()

/obj/item/handheld_soulcatcher/ui_interact(mob/user, datum/tgui/ui, mob/target)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		interacting_mobs[user] = target
		start_times[user] = world.time
		ui = new(user, src, "ListInputModal", name)
		ui.open()

/obj/item/handheld_soulcatcher/ui_act(action, list/params)
	. = ..()

	switch (action)
		if ("submit")
			// this looks confusing because it is
			// all this is doing is accessing the datum instance of a room that the modified key corresponds to
			// the reason this is done this way is because specific rooms may be open or closed to specific people,
			// necessitating the use of target as a key in the item map
			var/mob/target_mob = interacting_mobs[usr]
			var/list/target_specific_item_map = items_map[target_mob]
			// this was built off the assumption the user's UI would close apon selecting an option
			// so we cant wait for the alerts in this to finish. so we invoke async
			INVOKE_ASYNC(src, PROC_REF(room_selected), target_specific_item_map[params["entry"]], usr, interacting_mobs[usr])
	SStgui.close_user_uis(usr, src)
	return TRUE

/obj/item/handheld_soulcatcher/ui_data(mob/user)
	var/list/data = list()

	data["timeout"] = get_time_limit(user)

	return data

/obj/item/handheld_soulcatcher/proc/get_time_limit(mob/user)
	return clamp((SOULCATCHER_CATCH_TIME_LIMIT - (world.time - start_times[user]) - 1 SECONDS) / (SOULCATCHER_CATCH_TIME_LIMIT - 1 SECONDS), 0, 1)

/obj/item/handheld_soulcatcher/ui_static_data(mob/user)

	var/list/data = list()
	var/list/items = linked_soulcatcher.get_open_rooms(interacting_mobs[user])
	var/list/sanitized_items = list()
	var/list/repeat_items = list()

	LAZYINITLIST(items_map[interacting_mobs[user]])
	var/static/regex/whitelistedWords = regex(@{"([^\u0020-\u8000]+)"})
	for(var/i as anything in items)
		//avoids duplicated keys E.g: when areas have the same name
		var/string_key = whitelistedWords.Replace("[i]", "")
		string_key = avoid_assoc_duplicate_keys(string_key, repeat_items)
		sanitized_items += string_key
		src.items_map[interacting_mobs[user]][string_key] = i

	data["items"] = sanitized_items
	data["init_value"] = sanitized_items[1]
	data["large_buttons"] = user.client.prefs.read_preference(/datum/preference/toggle/tgui_input_large)
	data["message"] = "Choose a room to send [interacting_mobs[user]]'s soul to."
	data["swapped_buttons"] = user.client.prefs.read_preference(/datum/preference/toggle/tgui_input_swapped)
	data["title"] = name

	return data

/obj/item/handheld_soulcatcher/ui_close(mob/user)
	. = ..()

	items_map -= interacting_mobs[user]
	interacting_mobs -= user
	start_times -= user

#define SOULCATCHER_MAX_CATCHING_DISTANCE 7

/obj/item/handheld_soulcatcher/ui_status(mob/living/user)
	. = ..()

	var/mob/target_mob = interacting_mobs[user]
	if (!target_mob)
		return UI_CLOSE

	if (!istype(user))
		return UI_CLOSE

	var/is_holding = user.is_holding(src)

	if (!is_holding)
		if (user.z != z)
			return UI_CLOSE

	var/dist_from_src_to_target = get_dist(get_turf(src), get_turf(target_mob))
	if (dist_from_src_to_target > SOULCATCHER_MAX_CATCHING_DISTANCE)
		to_chat(user, span_warning("[target_mob] left range of [src]!"))
		return UI_CLOSE

	if (get_time_limit(user) <= 0)
		to_chat(user, span_warning("Ran out of time to pick your room!"))
		return UI_CLOSE

	var/default_flag = (is_holding ? UI_INTERACTIVE : user.shared_living_ui_distance(src))

	return min(., default_flag)

#undef SOULCATCHER_MAX_CATCHING_DISTANCE

/obj/item/handheld_soulcatcher/ui_state(mob/user)
	return GLOB.not_incapacitated_state

/obj/item/handheld_soulcatcher/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	if(target_mob.GetComponent(/datum/component/previous_body))
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	if(!target_mob.mind)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

  ui_interact(user, target = target_mob)
	return TRUE

/obj/item/handheld_soulcatcher/proc/room_selected(datum/soulcatcher_room/target_room, mob/living/user, mob/living/target_mob)

	// no variable can be trusted - re-sanitize EVERYTHING

	// nightmare code

	if(!target_room)
		return FALSE

	if(!target_mob.mind)
		to_chat(user, span_warning("You are unable to remove a mind from an empty body."))
		return FALSE

	if (!user.can_join_soulcatcher_room(target_room, TRUE))
		return FALSE

	var/target_dead = (target_mob.stat == DEAD)
	var/mob/real_target = target_mob

	to_chat(user, span_blue("[target_mob] has been requested to join [target_room]."))
	if (!invite_soul(target_room, user, target_mob))
		to_chat(user, span_warning("[target_mob] doesn't seem to want to enter."))
		return FALSE

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

#undef SOULCATCHER_CATCH_TIME_LIMIT
