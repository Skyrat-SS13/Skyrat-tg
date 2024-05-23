/datum/component/carrier/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(usr, src, ui)

	if(!ui)
		ui = new(usr, src, "Soulcatcher", name)
		ui.open()

/datum/component/carrier/soulcatcher/nifsoft/ui_state(mob/user)
	return GLOB.conscious_state

/datum/component/carrier/ui_data(mob/user)
	var/list/data = list()

	var/datum/component/carrier/soulcatcher/soulcatcher_carrier = src
	if(istype(soulcatcher_carrier))
		data["removable"] = soulcatcher_carrier.removable
		data["ghost_joinable"] = soulcatcher_carrier.ghost_joinable

	data["require_approval"] = require_approval
	data["theme"] = ui_theme
	data["communicate_as_parent"] = communicate_as_parent
	data["current_mob_count"] = length(get_current_mobs())
	data["max_mobs"] = max_mobs

	var/carrier_targeted = FALSE
	var/datum/component/carrier_communicator/communicator = user.GetComponent(/datum/component/carrier_communicator)
	if(istype(communicator) && communicator?.target_carrier?.resolve())
		var/datum/component/carrier/held_carrier = communicator.target_carrier.resolve()
		carrier_targeted = (held_carrier == src)
	data["carrier_targeted"] = carrier_targeted

	data["current_rooms"] = list()
	for(var/datum/carrier_room/room in carrier_rooms)
		var/currently_targeted = (room == targeted_carrier_room)

		var/list/room_data = list(
		"name" = html_decode(room.name),
		"description" = html_decode(room.room_description),
		"reference" = REF(room),
		"joinable" = room.joinable,
		"overlay_name" = (ispath(room.current_overlay_path) && initial(room.current_overlay_path.name)),
		"overlay_recolorable" = room.overlay_recolorable,
		"overlay_color" = room.overlay_color,
		"color" = room.room_color,
		"currently_targeted" = currently_targeted,
		)

		for(var/mob/living/soul in room.current_mobs)
			var/datum/component/carrier_user/soul_component = soul.GetComponent(/datum/component/carrier_user)
			if(!soul_component)
				continue

			var/mob/living/soulcatcher_soul/soul_to_check = soul // So that we can check if a body scan is needed if we are working with a soul
			var/list/soul_list = list(
				"name" = soul_component.name,
				"description" = soul_component.desc,
				"reference" = REF(soul),
				"internal_hearing" = soul_component.internal_hearing,
				"internal_sight" = soul_component.internal_sight,
				"outside_hearing" = soul_component.outside_hearing,
				"outside_sight" = soul_component.outside_sight,
				"able_to_emote" = soul_component.able_to_emote,
				"able_to_speak" = soul_component.able_to_speak,
				"able_to_rename" = soul_component.able_to_rename,
				"ooc_notes" = soul_component.ooc_notes,
				"able_to_speak_as_container" = soul_component.able_to_speak_as_container,
				"able_to_emote_as_container" = soul_component.able_to_emote_as_container,
				"scan_needed" = soul_to_check?.body_scan_needed,
				"is_soul" = istype(soul_to_check),
			)
			room_data["souls"] += list(soul_list)

		data["current_rooms"] += list(room_data)

	return data

/datum/component/carrier/ui_static_data(mob/user)
	var/list/data = list()

	data["current_vessel"] = parent

	return data

/datum/component/carrier/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/datum/component/carrier/soulcatcher/soulcatcher_carrier = src
	var/datum/carrier_room/target_room
	if(params["room_ref"])
		target_room = locate(params["room_ref"]) in carrier_rooms
		if(!target_room)
			return FALSE

	var/mob/living/target_mob
	if(params["target_mob"])
		target_mob = locate(params["target_mob"]) in target_room.current_mobs
		if(!target_mob)
			return FALSE

	switch(action)
		if("delete_room")
			if(length(carrier_rooms) <= 1)
				return FALSE

			carrier_rooms -= target_room
			targeted_carrier_room = carrier_rooms[1]
			qdel(target_room)
			return TRUE

		if("change_targeted_room")
			targeted_carrier_room = target_room
			return TRUE

		if("change_targeted_carrier")
			update_targeted_carrier()
			return TRUE

		if("create_room")
			create_room()
			return TRUE

		if("rename_room")
			var/new_room_name = tgui_input_text(usr,"Choose a new name for the room", name, target_room.name)
			if(!new_room_name)
				return FALSE

			target_room.name = new_room_name
			return TRUE

		if("redescribe_room")
			var/new_room_desc = tgui_input_text(usr,"Choose a new description for the room", name, target_room.room_description, multiline = TRUE)
			if(!new_room_desc)
				return FALSE

			target_room.room_description = new_room_desc
			return TRUE

		if("toggle_joinable_room")
			if(!istype(soulcatcher_carrier))
				return FALSE

			target_room.joinable = !target_room.joinable
			return TRUE

		if("toggle_joinable")
			if(!istype(soulcatcher_carrier))
				return FALSE

			soulcatcher_carrier.ghost_joinable = !soulcatcher_carrier.ghost_joinable
			return TRUE

		if("toggle_approval")
			require_approval = !require_approval
			return TRUE

		if("modify_name")
			var/new_name = tgui_input_text(usr,"Choose a new name to send messages as", name, target_room.outside_voice)
			if(!new_name)
				return FALSE

			target_room.outside_voice = new_name
			return TRUE

		if("remove_mob")
			target_room.remove_mob(target_mob)
			return TRUE

		if("transfer_mob")
			var/list/available_rooms = carrier_rooms.Copy()
			available_rooms -= target_room
			if(able_to_transfer_to_another_carrier && ishuman(usr))
				var/mob/living/carbon/human/human_user = usr
				for(var/obj/item/carrier_holder/holder in human_user.contents)
					var/datum/component/carrier/holder_carrier = holder.GetComponent(/datum/component/carrier)
					if(!istype(holder_carrier))
						continue

					available_rooms += holder_carrier.get_open_rooms()

				for(var/obj/item/held_item in human_user.get_all_gear())
					if(parent == held_item)
						continue

					var/datum/component/carrier/carrier_component = held_item.GetComponent(/datum/component/carrier)
					if(!carrier_component)
						continue

					if(same_type_only_transfer && !istype(carrier_component, src))
						continue

					available_rooms += carrier_component.get_open_rooms()

			var/datum/carrier_room/transfer_room = tgui_input_list(usr, "Choose a room to transfer to", name, available_rooms)
			if(!(transfer_room in available_rooms))
				return FALSE

			transfer_mob(target_mob, transfer_room)
			return TRUE

		if("change_room_color")
			var/new_room_color = input(usr, "", "Choose Color", SOULCATCHER_DEFAULT_COLOR) as color
			if(!new_room_color)
				return FALSE

			target_room.room_color = new_room_color

		if("change_overlay_color")
			var/new_overlay_color = input(usr, "", "Choose Color", SOULCATCHER_DEFAULT_COLOR) as color
			// It's okay for us not to have an overlay color

			target_room.overlay_color = new_overlay_color
			target_room.change_fullscreen_overlay(target_room.current_overlay_path)

		if("change_overlay")
			var/mob/living/user = usr
			var/disable_vore_overlays = CONFIG_GET(flag/disable_erp_preferences) || !safe_read_pref(user.client, /datum/preference/toggle/erp/vore_overlay_options)
			var/list/available_overlays = list()

			for(var/path in subtypesof(/atom/movable/screen/fullscreen/carrier))
				var/atom/movable/screen/fullscreen/carrier/carrier_atom = path
				var/atom_name = initial(carrier_atom.name)

				if(initial(carrier_atom.vore_overlay))
					if(disable_vore_overlays) // No, we don't want that.
						continue
					atom_name += " (Vore)"

				available_overlays[atom_name] = path

			available_overlays += "None"
			var/target_overlay = tgui_input_list(usr, "Choose a overlay to use", name, available_overlays)
			if(target_overlay != "None")
				target_overlay = available_overlays[target_overlay]

			if(!target_overlay)
				return FALSE

			target_room.change_fullscreen_overlay(target_overlay)
			return TRUE

		if("preview_overlay")
			var/mob/living/user = usr
			if(!istype(user))
				return FALSE

			var/atom/movable/screen/fullscreen/carrier/new_screen = user.overlay_fullscreen("carrier", target_room.current_overlay_path)
			if(new_screen.recolorable && target_room.overlay_color)
				new_screen.color = target_room.overlay_color

			addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, clear_fullscreen), "carrier"), 15 SECONDS)


		if("toggle_soul_sense")
			var/sense_to_change = params["sense_to_change"]
			if(!sense_to_change)
				return FALSE

			SEND_SIGNAL(target_mob, COMSIG_CARRIER_MOB_TOGGLE_SENSE, sense_to_change)
			return TRUE

		if("change_name")
			var/new_name = tgui_input_text(usr, "Enter a new name for [target_mob]", "Soulcatcher", target_mob)
			if(!new_name)
				return FALSE

			return SEND_SIGNAL(target_mob, COMSIG_CARRIER_MOB_RENAME, new_name)

		if("reset_name")
			if(tgui_alert(usr, "Do you wish to reset [target_mob]'s name to default?", "Soulcatcher", list("Yes", "No")) != "Yes")
				return FALSE

			return SEND_SIGNAL(target_mob, COMSIG_CARRIER_MOB_RESET_NAME)

		if("send_message")
			var/message_to_send = ""
			var/emote_sent = params["emote"]
			var/message_sender = target_room.outside_voice
			if(params["narration"])
				message_sender = null

			message_to_send = tgui_input_text(usr, "Input the message you want to send", name, multiline = TRUE)

			if(!message_to_send)
				return FALSE

			target_room.send_message(message_to_send, message_sender, emote = emote_sent)
			return TRUE


		if("delete_self")
			if(!istype(soulcatcher_carrier))
				return FALSE

			if(tgui_alert(usr, "Are you sure you want to detach the soulcatcher?", parent, list("Yes", "No")) != "Yes")
				return FALSE

			soulcatcher_carrier.remove_self()
			return TRUE

/datum/component/carrier_user/New()
	. = ..()
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return COMPONENT_INCOMPATIBLE

	return TRUE

/datum/component/carrier_user/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(usr, src, ui)
	if(!ui)
		ui = new(usr, src, "SoulcatcherUser")
		ui.open()

/datum/component/carrier_user/ui_state(mob/user)
	return GLOB.conscious_state

/datum/component/carrier_user/ui_data(mob/user)
	var/list/data = list()

	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return FALSE //uhoh

	var/datum/component/carrier_communicator/communicator = parent.GetComponent(/datum/component/carrier_communicator)
	data["targeted"] = communicator?.carried_mob

	var/mob/living/soulcatcher_soul/user_soul = parent_mob
	data["user_data"] = list(
		"name" = name,
		"description" = desc,
		"reference" = REF(parent_mob),
		"internal_hearing" = internal_hearing,
		"internal_sight" = internal_sight,
		"outside_hearing" = outside_hearing,
		"outside_sight" = outside_sight,
		"able_to_emote" = able_to_emote,
		"able_to_speak" = able_to_speak,
		"able_to_rename" = able_to_rename,
		"able_to_speak_as_container" = able_to_speak_as_container,
		"able_to_emote_as_container" = able_to_emote_as_container,
		"communicating_externally" = communicating_externally,
		"ooc_notes" = ooc_notes,
		"scan_needed" = user_soul?.body_scan_needed,
	)

	var/datum/carrier_room/current_carrier_room = current_room.resolve()
	if(!current_carrier_room)
		current_room = null
		return FALSE

	data["current_room"] = list(
		"name" = html_decode(current_carrier_room.name),
		"description" = html_decode(current_carrier_room.room_description),
		"reference" = REF(current_carrier_room),
		"color" = current_carrier_room.room_color,
		"owner" = current_carrier_room.outside_voice,
		)

	var/datum/component/carrier/master_carrier = current_carrier_room.master_carrier.resolve()
	if(!master_carrier)
		current_carrier_room.master_carrier = null

	var/datum/component/carrier/soulcatcher/master_soulcatcher
	if(istype(master_soulcatcher))
		data["communicate_as_parent"] = master_soulcatcher.communicate_as_parent

	for(var/mob/living/soul in current_carrier_room.current_mobs)
		if(soul == user_soul)
			continue

		var/datum/component/carrier_user/soul_component = soul.GetComponent(/datum/component/carrier_user)
		if(!soul_component)
			continue

		var/list/soul_list = list(
			"name" = soul_component.name,
			"description" = soul_component.desc,
			"ooc_notes" = soul_component.ooc_notes,
			"reference" = REF(soul),
		)
		data["souls"] += list(soul_list)

	return data

/datum/component/carrier_user/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("change_name")
			var/new_name = tgui_input_text(usr, "Enter a new name", "Soulcatcher", name)
			if(!new_name)
				return FALSE

			change_name(new_name = new_name)
			return TRUE

		if("reset_name")
			if(tgui_alert(usr, "Do you wish to reset your name to default?", "Soulcatcher", list("Yes", "No")) != "Yes")
				return FALSE

			reset_name()
			return TRUE

		if("toggle_external_communication")
			communicating_externally = !communicating_externally
			return TRUE

		if("toggle_target")
			var/datum/component/carrier_communicator/communicator = parent.GetComponent(/datum/component/carrier_communicator)
			if(!istype(communicator))
				return FALSE

			communicator.carried_mob = !communicator.carried_mob
			return TRUE
