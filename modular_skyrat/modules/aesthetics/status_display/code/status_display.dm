/obj/machinery/status_display
	icon = 'modular_skyrat/modules/aesthetics/status_display/icons/status_display.dmi'

/obj/machinery/status_display/post_machine_initialize()
	. = ..()
	set_picture("default")

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/post_machine_initialize()
	. = ..()
	set_picture("synd")
