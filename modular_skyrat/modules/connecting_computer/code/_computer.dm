/obj/machinery/computer
	///Determines if the computer can connect to other computers (no arcades, etc.)
	var/connectable = TRUE

/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	if(connectable)
		AddComponent(/datum/component/connectable_computer)

/obj/machinery/modular_computer/console/Initialize(mapload)
	. = ..()

	// Modular consoles all have the same case.
	AddComponent(/datum/component/connectable_computer)
