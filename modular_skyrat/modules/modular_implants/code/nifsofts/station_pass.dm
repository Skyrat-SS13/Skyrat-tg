/obj/item/disk/nifsoft_uploader/station_pass
	name = "Automatic Apprasial"
	loaded_nifsoft = /datum/nifsoft/station_pass

/datum/nifsoft/station_pass
	name = "Station Pass" //WIP NAME
	program_desc = "Allows the user to share and recieve data from other NIF users with this NIF installed"

	///Is the NIFSoft transmitting data?
	var/transmitting_data = TRUE
	///Is the NIFSoft recieving data?
	var/recieving_data = TRUE
	///What username is being sent out?
	var/transmitted_name = ""
	///What message is being sent to other users?
	var/transmitted_message = ""
	///What messages has the user recieved?
	var/message_list = list()

/datum/nifsoft/station_pass/New()
	. = ..()
	transmitted_name = linked_mob.name
	transmitted_message = "Hello, I am [transmitted_name], it's nice to meet you!"

	add_message(name, "Hello World")

///Adds a message to the message_list based off the name and message
/datum/nifsoft/station_pass/proc/add_message(recieved_name, recieved_message)
	if(!recieved_message)
		return FALSE
	if(!name)
		name = "unknown user"

	message_list += list(list(sender_name = recieved_name, message = recieved_message, timestamp = station_time_timestamp()))
	return TRUE

///Removes a message from the message_list based on the message_to_remove
/datum/nifsoft/station_pass/proc/remove_message(message_to_remove)
	var/removed_message = locate(message_to_remove) in message_list
	if(!removed_message)
		return FALSE

	message_list -= removed_message
	return TRUE

// TEST STUFF
/datum/nifsoft/station_pass/activate()
	. = ..()
	ui_interact(linked_mob)

/datum/nifsoft/station_pass/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(linked_mob, src, ui)

	if(!ui)
		ui = new(linked_mob, src, "NifStationPass", name)
		ui.open()

/datum/nifsoft/station_pass/ui_data(mob/user)
	var/list/data = list()
	data["messages"] = list()

	for(var/message in message_list)
		data["messages"] += list(message)

	return data

/datum/nifsoft/station_pass/ui_static_data(mob/user)
	var/list/data = list()

	data["name_to_send"] = transmitted_name
	data["text_to_send"] = transmitted_message

	return data

/datum/nifsoft/station_pass/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("change_message")
			if(!params["new_message"])
				return FALSE

			transmitted_message = params["new_message"]
			return TRUE

		if("change_name")
			if(!params["new_name"])
				return FALSE

			transmitted_name = params["new_name"]
			return TRUE

