/datum/component/soulcatcher/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(usr, src, ui)

	if(!ui)
		ui = new(usr, src, "Soulcatcher", name)
		ui.open()

/datum/component/soulcatcher/nifsoft/ui_state(mob/user)
	return GLOB.conscious_state

/datum/component/soulcatcher/ui_data(mob/user)
	var/list/data = list()

	data["ghost_joinable"] = ghost_joinable
	data["require_approval"] = require_approval
	data["theme"] = ui_theme
	data["communicate_as_parent"] = communicate_as_parent
	data["current_soul_count"] = length(get_current_souls())
	data["max_souls"] = max_souls
	data["removable"] = removable

	data["current_rooms"] = list()
	for(var/datum/soulcatcher_room/room in soulcatcher_rooms)
		var/currently_targeted = (room == targeted_soulcatcher_room)

		var/list/room_data = list(
		"name" = html_decode(room.name),
		"description" = html_decode(room.room_description),
		"reference" = REF(room),
		"joinable" = room.joinable,
		"color" = room.room_color,
		"currently_targeted" = currently_targeted,
		)

		for(var/mob/living/soul in room.current_souls)
			var/datum/component/soulcatcher_user/soul_component = soul.GetComponent(/datum/component/soulcatcher_user)
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
			)
			room_data["souls"] += list(soul_list)

		data["current_rooms"] += list(room_data)

	return data

/datum/component/soulcatcher/ui_static_data(mob/user)
	var/list/data = list()

	data["current_vessel"] = parent

	return data

/datum/component/soulcatcher/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/datum/soulcatcher_room/target_room
	if(params["room_ref"])
		target_room = locate(params["room_ref"]) in soulcatcher_rooms
		if(!target_room)
			return FALSE

	var/mob/living/soulcatcher_soul/target_soul
	if(params["target_soul"])
		target_soul = locate(params["target_soul"]) in target_room.current_souls
		if(!target_soul)
			return FALSE

	switch(action)
		if("delete_room")
			if(length(soulcatcher_rooms) <= 1)
				return FALSE

			soulcatcher_rooms -= target_room
			targeted_soulcatcher_room = soulcatcher_rooms[1]
			qdel(target_room)
			return TRUE

		if("change_targeted_room")
			targeted_soulcatcher_room = target_room
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
			target_room.joinable = !target_room.joinable
			return TRUE

		if("toggle_joinable")
			ghost_joinable = !ghost_joinable
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

		if("remove_soul")
			target_room.remove_soul(target_soul)
			return TRUE

		if("transfer_soul")
			var/list/available_rooms = soulcatcher_rooms.Copy()
			available_rooms -= target_room

			if(ishuman(usr))
				var/mob/living/carbon/human/human_user = usr
				var/datum/nifsoft/soulcatcher/soulcatcher_nifsoft = human_user.find_nifsoft(/datum/nifsoft/soulcatcher)
				if(soulcatcher_nifsoft && (parent != soulcatcher_nifsoft.parent_nif.resolve()))
					var/datum/component/soulcatcher/nifsoft_soulcatcher = soulcatcher_nifsoft.linked_soulcatcher.resolve()
					if(istype(nifsoft_soulcatcher))
						available_rooms += nifsoft_soulcatcher.get_open_rooms()

				for(var/obj/item/held_item in human_user.get_all_gear())
					if(parent == held_item)
						continue

					var/datum/component/soulcatcher/soulcatcher_component = held_item.GetComponent(/datum/component/soulcatcher)
					if(!soulcatcher_component)
						continue

					available_rooms += soulcatcher_component.get_open_rooms()

			var/datum/soulcatcher_room/transfer_room = tgui_input_list(usr, "Choose a room to transfer to", name, available_rooms)
			if(!(transfer_room in available_rooms))
				return FALSE

			transfer_soul(target_soul, transfer_room)
			return TRUE

		if("change_room_color")
			var/new_room_color = input(usr, "", "Choose Color", SOULCATCHER_DEFAULT_COLOR) as color
			if(!new_room_color)
				return FALSE

			target_room.room_color = new_room_color

		if("toggle_soul_sense")
			var/sense_to_change = params["sesnse_to_change"]
			if(!sense_to_change)
				return FALSE

			SEND_SIGNAL(target_soul, COMSIG_SOULCATCHER_TOGGLE_SENSE, sense_to_change)
			return TRUE

		if("change_name")
			var/new_name = tgui_input_text(usr, "Enter a new name for [target_soul]", "Soulcatcher", target_soul)
			if(!new_name)
				return FALSE

			return SEND_SIGNAL(target_soul, COMSIG_SOULCATCHER_SOUL_RENAME, new_name)

		if("reset_name")
			if(tgui_alert(usr, "Do you wish to reset [target_soul]'s name to default?", "Soulcatcher", list("Yes", "No")) != "Yes")
				return FALSE

			return SEND_SIGNAL(target_soul, COMSIG_SOULCATCHER_SOUL_RESET_NAME)

		if("send_message")
			var/message_to_send = ""
			var/emote = params["emote"]
			var/message_sender = target_room.outside_voice
			if(params["narration"])
				message_sender = FALSE

			message_to_send = tgui_input_text(usr, "Input the message you want to send", name, multiline = TRUE)

			if(!message_to_send)
				return FALSE

			target_room.send_message(message_to_send, message_sender, usr, emote)
			return TRUE


		if("delete_self")
			if(tgui_alert(usr, "Are you sure you want to detach the soulcatcher?", parent, list("Yes", "No")) != "Yes")
				return FALSE

			remove_self()
			return TRUE

/datum/component/soulcatcher_user/New()
	. = ..()
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return COMPONENT_INCOMPATIBLE

	return TRUE

/datum/component/soulcatcher_user/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(usr, src, ui)
	if(!ui)
		ui = new(usr, src, "SoulcatcherUser")
		ui.open()

/datum/component/soulcatcher_user/ui_state(mob/user)
	return GLOB.conscious_state

/datum/component/soulcatcher_user/ui_data(mob/user)
	var/list/data = list()

	var/mob/living/parent_mob = parent
	var/mob/living/soulcatcher_soul/user_soul = parent_mob
	if(!istype(user_soul))
		return FALSE //uhoh

	data["user_data"] = list(
		"name" = name,
		"description" = desc,
		"reference" = REF(user_soul),
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

	var/datum/soulcatcher_room/current_soulcatcher_room = current_room.resolve()
	if(!current_soulcatcher_room)
		return FALSE

	data["current_room"] = list(
		"name" = html_decode(current_soulcatcher_room.name),
		"description" = html_decode(current_soulcatcher_room.room_description),
		"reference" = REF(current_soulcatcher_room),
		"color" = current_soulcatcher_room.room_color,
		"owner" = current_soulcatcher_room.outside_voice,
		)

	var/datum/component/soulcatcher/master_soulcatcher = current_soulcatcher_room.master_soulcatcher.resolve()
	data["communicate_as_parent"] = master_soulcatcher.communicate_as_parent

	for(var/mob/living/soulcatcher_soul/soul in current_soulcatcher_room.current_souls)
		if(soul == user_soul)
			continue

		var/datum/component/soulcatcher_user/soul_component = soul.GetComponent(/datum/component/soulcatcher_user)
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

/datum/component/soulcatcher_user/ui_act(action, list/params)
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
