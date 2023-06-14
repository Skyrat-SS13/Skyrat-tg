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

	data["current_rooms"] = list()
	for(var/datum/soulcatcher_room/room in soulcatcher_rooms)
		var/list/room_data = list(
		"name" = html_decode(room.name),
		"description" = html_decode(room.room_description),
		"reference" = REF(room),
		"joinable" = room.joinable,
		"color" = room.room_color,
		)

		for(var/mob/living/soulcatcher_soul/soul in room.current_souls)
			var/list/soul_list = list(
				"name" = soul.name,
				"description" = soul.soul_desc,
				"reference" = REF(soul),
				"internal_hearing" = soul.internal_hearing,
				"internal_sight" = soul.internal_sight,
				"outside_hearing" = soul.outside_hearing,
				"outside_sight" = soul.outside_sight,
				"able_to_emote" = soul.able_to_emote,
				"able_to_speak" = soul.able_to_speak,
				"ooc_notes" = soul.ooc_notes
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
			qdel(target_room)
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
			var/new_name = tgui_input_text(usr,"Choose a new name to send messages as", name, target_room.room_description, multiline = TRUE)
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
						available_rooms.Add(nifsoft_soulcatcher.soulcatcher_rooms)

				for(var/obj/item/held_item in human_user.held_items)
					if(parent == held_item)
						continue

					var/datum/component/soulcatcher/soulcatcher_component = held_item.GetComponent(/datum/component/soulcatcher)
					if(!soulcatcher_component)
						continue

					for(var/datum/soulcatcher_room/room in soulcatcher_component.soulcatcher_rooms)
						available_rooms += room

			var/datum/soulcatcher_room/transfer_room = tgui_input_list(usr, "Choose a room to transfer to", name, available_rooms)
			if(!(transfer_room in available_rooms))
				return FALSE

			target_room.transfer_soul(target_soul, transfer_room)
			return TRUE

		if("change_room_color")
			var/new_room_color = input(usr, "", "Choose Color", SOULCATCHER_DEFAULT_COLOR) as color
			if(!new_room_color)
				return FALSE

			target_room.room_color = new_room_color

		if("toggle_soul_outside_sense")
			if(params["sense_to_change"] == "hearing")
				target_soul.toggle_hearing()
			else
				target_soul.toggle_sight()

			return TRUE

		if("toggle_soul_sense")
			if(params["sense_to_change"] == "hearing")
				target_soul.internal_hearing = !target_soul.internal_hearing
			else
				target_soul.internal_sight = !target_soul.internal_sight

			return TRUE

		if("toggle_soul_communication")
			if(params["communication_type"] == "emote")
				target_soul.able_to_emote = !target_soul.able_to_emote
			else
				target_soul.able_to_speak = !target_soul.able_to_speak

			return TRUE

		if("send_message")
			var/message_to_send = ""
			var/emote = params["emote"]
			var/message_sender = target_room.outside_voice
			if(params["narration"])
				message_sender = FALSE

			message_to_send = tgui_input_text(usr, "Input the message you want to send", name, multiline = TRUE)

			if(!message_to_send)
				return FALSE

			target_room.send_message(message_to_send, message_sender, emote)
			return TRUE
