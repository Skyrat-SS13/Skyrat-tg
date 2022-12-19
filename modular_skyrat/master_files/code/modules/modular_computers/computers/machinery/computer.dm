// Not given to standard identification consoles, as only the HoP can actually use the program.
/obj/machinery/modular_computer/console/preset/id/centcom/LateInitialize()
	. = ..()
	cpu.store_file(new /datum/computer_file/program/passport_mod)
