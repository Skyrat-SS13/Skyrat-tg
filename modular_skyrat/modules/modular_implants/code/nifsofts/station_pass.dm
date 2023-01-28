/obj/item/disk/nifsoft_uploader/station_pass
	name = "Automatic Apprasial"
	loaded_nifsoft = /datum/nifsoft/station_pass

//Modular Persistence variables for the station_pass NIFSoft
/datum/modular_persistence
	///What name is saved to the station pass NIFSoft?
	var/station_pass_nifsoft_name
	///What message is saved to the station pass NIFSoft?
	var/station_pass_nifsoft_message

/datum/nifsoft/station_pass
	name = "Poem of Communal Souls"
	program_desc = "The Poem of Communal Souls was the first commission the Altspace Coven ever took; a rare occasion for their involvement in NIFSoft development. This program was originally commissioned by a then-underground group of ravers as a sort of 'social contagion' for the purpose of spreading peace, love, unity, and respect. The software operates by allowing different users running it to ambiently share 'Verses' with each other, small portions of their unique nanomachine fields that carry user-set messages; sometimes actual poetry, short biographies, or simple hope to meet and bond with other NIF users. Each trade of nanomachine packets represents a physical memory of the user who traded it, some long-time 'Poets' surrounded with a dazzling rainbow of different past messages."
	persistence = TRUE

	///Is the NIFSoft transmitting data?
	var/transmitting_data = TRUE
	///Is the NIFSoft recieving data?
	var/recieving_data = TRUE
	///What username is being sent out?
	var/transmitted_name = ""
	///What message is being sent to other users?
	var/transmitted_message = ""
	///What ckey is being used by the owner? This is mostly here so that messages can't get spammed
	var/transmitted_identifier = ""

	///What messages has the user recieved?
	var/list/message_list = list()
	///The datum that is being used to receive messages
	var/datum/proximity_monitor/advanced/station_pass/proximity_datum

/datum/nifsoft/station_pass/New()
	. = ..()

	if(!transmitted_name)
		transmitted_name = linked_mob.name
	if(!transmitted_message)
		transmitted_message = "Hello, I am [transmitted_name], it's nice to meet you!"
	transmitted_identifier = linked_mob.ckey

	add_message("station_pass_nifsoft", name, "Hello World")
	proximity_datum = new(linked_mob, 1)
	proximity_datum.parent_nifsoft = src

/datum/nifsoft/station_pass/New()
	qdel(proximity_datum)
	proximity_datum = null

	return ..()

///Adds a message to the message_list based off the name and message
/datum/nifsoft/station_pass/proc/add_message(sender_identifier, recieved_name, recieved_message)
	if(!recieved_message)
		return FALSE
	if(!name)
		name = "Unknown User"
	else
		for(var/message in message_list)
			if(message["identifier"] == sender_identifier)
				message["sender_name"] = recieved_name
				message["message"] = recieved_message
				message["timestamp"] = station_time_timestamp()
				return TRUE

	message_list.Insert(1, list(list(identifier = sender_identifier, sender_name = recieved_name, message = recieved_message, timestamp = station_time_timestamp())))
	return TRUE

///Removes a message from the message_list based on the message_to_remove
/datum/nifsoft/station_pass/proc/remove_message(message_to_remove)
	var/removed_message = locate(message_to_remove) in message_list
	if(!removed_message)
		return FALSE

	message_list -= list(removed_message)
	return TRUE

/datum/nifsoft/station_pass/activate()
	. = ..()
	ui_interact(linked_mob)


/datum/nifsoft/station_pass/load_persistence_data()
	. = ..()
	var/datum/modular_persistence/persistence = .
	if(!persistence)
		return FALSE

	transmitted_name = persistence.station_pass_nifsoft_name
	transmitted_message = persistence.station_pass_nifsoft_message

/datum/nifsoft/station_pass/save_persistence_data(datum/modular_persistence/persistence)
	. = ..()
	if(!.)
		return FALSE

	persistence.station_pass_nifsoft_message = transmitted_message
	persistence.station_pass_nifsoft_name = transmitted_name

///The proximty_monitor datum used by the station_pass NIFSoft
/datum/proximity_monitor/advanced/station_pass
	///What NIFSoft is this currently attached to?
	var/datum/weakref/parent_nifsoft

/datum/proximity_monitor/advanced/station_pass/on_entered(turf/source, atom/movable/entered)
	. = ..()
	if(host == entered)
		return FALSE

	var/datum/nifsoft/station_pass/recieving_nifsoft = parent_nifsoft
	if(!recieving_nifsoft || (!recieving_nifsoft.transmitting_data && !recieving_nifsoft.recieving_data))
		return FALSE

	var/mob/living/carbon/human/entered_human = entered
	if(!entered)
		return FALSE

	var/datum/nifsoft/station_pass/sending_nifsoft = entered_human.find_nifsoft(/datum/nifsoft/station_pass)
	if(!sending_nifsoft)
		return FALSE

	if(recieving_nifsoft.recieving_data && sending_nifsoft.transmitting_data)
		recieving_nifsoft.add_message(sending_nifsoft.transmitted_identifier, sending_nifsoft.transmitted_name, sending_nifsoft.transmitted_message)
	if(sending_nifsoft.recieving_data && recieving_nifsoft.transmitting_data)
		sending_nifsoft.add_message(recieving_nifsoft.transmitted_identifier, recieving_nifsoft.transmitted_name, recieving_nifsoft.transmitted_message)
	return TRUE

//TGUI
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

	data["recieving_data"] = recieving_data
	data["transmitting_data"] = transmitting_data

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

		if("remove_message")
			if(!params["message_to_remove"])
				return FALSE

			if(!remove_message(list(params["message_to_remove"])))
				return FALSE

			return TRUE

		if("toggle_transmitting")
			transmitting_data = !transmitting_data
			return TRUE

		if("toggle_recieving")
			recieving_data = !recieving_data
			return TRUE
