/obj/item/circuit_component/hear
	/// Whether the voice activator is on or not
	var/datum/port/input/on

/obj/item/circuit_component/hear/populate_ports()
	on = add_input_port("On", PORT_TYPE_NUMBER, default = 1) //Add new on port to component (and default to on)
	. = ..()

/obj/item/circuit_component/hear/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	if(!on.value) //Check if the on setting is set to off
		return FALSE
	. = ..()
