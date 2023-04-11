/datum/map_template/shuttle/ruin/tarkon_driver
	prefix = "_maps/shuttles/skyrat/"
	suffix = "tarkon_driverdc54"
	name = "Tarkon Drill Driver"

/obj/machinery/computer/shuttle/tarkon_driver
	name = "Tarkon Driver Control"
	desc = "Used to control the Tarkon Driver."
	circuit = /obj/item/circuitboard/computer/tarkon_driver
	shuttleId = "tarkon_driver"
	possible_destinations = "tarkon_driver_custom;port_tarkon;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/tarkon_driver
	name = "Tarkon Driver Navigation Computer"
	desc = "The Navigation console for the Tarkon Driver. A broken \"Engage Drill\" button seems to dimly blink in a yellow colour"
	shuttleId = "tarkon_driver"
	lock_override = NONE
	shuttlePortId = "tarkon_driver_custom"
	jump_to_ports = list("port_tarkon" = 1, "whiteship_home" = 1)
	view_range = 0

/obj/item/circuitboard/computer/tarkon_driver
	name = "Tarkon Driver Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/tarkon_driver

/datum/map_template/shuttle/ruin/tarkon_driver/defcon3
	suffix = "tarkon_driverdc3"

/datum/map_template/shuttle/ruin/tarkon_driver/defcon2
	suffix = "tarkon_driverdc2"
