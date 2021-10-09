/datum/circuit_datatype/datum
	datatype = PORT_TYPE_DATUM
	color = "yellow"
<<<<<<< HEAD
	datatype_flags = DATATYPE_FLAG_ALLOW_MANUAL_INPUT

/datum/circuit_datatype/datum/can_receive_from_datatype(datatype_to_check)
	. = ..()
	if(.)
		return

	return datatype_to_check == PORT_TYPE_ATOM
=======
	datatype_flags = DATATYPE_FLAG_ALLOW_MANUAL_INPUT|DATATYPE_FLAG_ALLOW_ATOM_INPUT
	can_receive_from = list(
		PORT_TYPE_ATOM,
	)
>>>>>>> 1590ae1f932 (Makes it so that datums can take entity inputs too (#61930))

/datum/circuit_datatype/datum/convert_value(datum/port/port, value_to_convert)
	var/datum/object = value_to_convert
	if(QDELETED(object))
		return null
	return object
