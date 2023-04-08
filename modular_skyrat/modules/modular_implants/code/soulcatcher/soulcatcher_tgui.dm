//REMOVE THIS LATER
/datum/component/soulcatcher/ui_state(mob/user)
	return GLOB.conscious_state
//REMOVE THIS LATER - END

/datum/component/soulcatcher/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(usr, src, ui)

	if(!ui)
		ui = new(usr, src, "Soulcatcher", name)
		ui.open()

/datum/component/soulcatcher/ui_data(mob/user)
	var/list/data = list()

	return data

/datum/component/soulcatcher/ui_static_data(mob/user)
	var/list/data = list()

	data["current_vessel"] = parent
	data["current_rooms"] = list()
	for(var/datum/soulcatcher_room/room in soulcatcher_rooms)
		var/list/room_data = list(
		"name" = room.name,
		"description" = room.room_description,
		"reference" = REF(room),
		)

		for(var/mob/living/soulcatcher_soul/soul in room.current_souls)
			var/list/soul_list = list(
				"name" = soul.name,
				"description" = soul.soul_desc,
				"ref" = REF(soul),
			)
			room_data["souls"] += list(soul_list)

		data["current_rooms"] += list(room_data)


	return data

/datum/component/soulcatcher/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("delete_room")
			var/datum/soulcatcher_room/target_room = locate(params["room_ref"]) in soulcatcher_rooms
			if(!target_room)
				return FALSE

			soulcatcher_rooms -= target_room
			qdel(target_room)
			return TRUE

		if("create_room")
			create_room()
			return TRUE

		if("rename_room")
			var/datum/soulcatcher_room/target_room = locate(params["room_ref"]) in soulcatcher_rooms
			if(!target_room || !params["new_room_name"])
				return FALSE

			target_room.name = params["new_room_name"]
			return TRUE

		if("redescribe_room")
			var/datum/soulcatcher_room/target_room = locate(params["room_ref"]) in soulcatcher_rooms
			if(!target_room || !params["new_room_name"])
				return FALSE

			target_room.room_description = params["new_room_desc"]
			return TRUE

		if("remove_soul")
			var/datum/soulcatcher_room/target_room = locate(params["room_ref"]) in soulcatcher_rooms
			if(!target_room || !params["new_room_name"])
				return FALSE
			var/mob/living/soulcatcher_soul/soul = locate(params["soul_to_remove"]) in target_room.current_souls
			if(!soul)
				return FALSE

			target_room.remove_soul(soul)
			return TRUE

		if("transfer_soul")
			var/datum/soulcatcher_room/target_room = locate(params["room_ref"]) in soulcatcher_rooms
			if(!target_room || !params["new_room_name"])
				return FALSE
			var/mob/living/soulcatcher_soul/soul = locate(params["soul_to_transfer"]) in target_room.current_souls
			if(!soul)
				return FALSE

			var/list/available_rooms = soulcatcher_rooms.Copy()
			soulcatcher_rooms -= target_room

			var/datum/soulcatcher_room/transfer_room = tgui_input_list(usr, "Chose a room to transfer to", name, available_rooms)
			if(!(transfer_room in soulcatcher_rooms))
				return FALSE

			target_room.transfer_soul(soul, transfer_room)

			return TRUE
