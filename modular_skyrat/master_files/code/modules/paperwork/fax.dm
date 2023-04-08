/obj/machinery/fax
	/// The radio used by the fax machine.
	var/obj/item/radio/fax_radio
	/// The radio frequency the fax machine speaks onto.
	var/fax_radio_frequency = null

/obj/machinery/fax/Initialize(mapload)
	. = ..()

	fax_radio = new /obj/item/radio(src)
	fax_radio.set_listening(FALSE)

	assign_radio_frequency()

/**
 * Procedure for assigning the right frequency to the fax machine radio.
 *
 * Called on initialization.
 * It compares the location of the fax machine with the lists of every station area with a fax machine.
 * If the location matches, the correct radio frequency is assigned.
 */
/obj/machinery/fax/proc/assign_radio_frequency()

	var/location = get_area(src)

	//this looks like shitcode
	if(is_type_in_list(location, list(/area/station/command))) fax_radio_frequency = FREQ_COMMAND
	else if(is_type_in_list(location, list(/area/station/security))) fax_radio_frequency = FREQ_SECURITY
	else if(is_type_in_list(location, list(/area/station/medical))) fax_radio_frequency = FREQ_MEDICAL
	else if(is_type_in_list(location, list(/area/station/science))) fax_radio_frequency = FREQ_SCIENCE
	else if(is_type_in_list(location, list(/area/station/engineering))) fax_radio_frequency = FREQ_ENGINEERING
	else if(is_type_in_list(location, list(/area/station/cargo))) fax_radio_frequency = FREQ_SUPPLY
	else if(is_type_in_list(location, list(/area/station/service))) fax_radio_frequency = FREQ_SERVICE //law office
	else if(is_type_in_list(location, list(/area/station/hallway/secondary/service))) fax_radio_frequency = FREQ_SERVICE //service hallway
	else if(is_type_in_list(location, list(/area/command/heads_quarters/captain/private/nt_rep))) fax_radio_frequency = FREQ_COMMAND //nt rep

/**
 * Procedure for making the fax machine announce correspondence on comms.
 *
 * Called on /receive(obj/item/loaded, sender_name) proc.
 * Checks if the fax radio frequency has been previously assigned.
 * If TRUE, announces the fax receival on comms.
 */
/obj/machinery/fax/proc/speak_on_receival(sender_name)
	//Has a radio frequency been assigned?
	if(!isnull(fax_radio_frequency))
		fax_radio.set_frequency(fax_radio_frequency)
		fax_radio.talk_into(src, "Received correspondence from [sender_name].", fax_radio_frequency)
	remove_radio_all(fax_radio)
