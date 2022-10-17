/obj/docking_port/mobile/clock_ship
	name = "T.G.E. Brass Hope"
	shuttle_id = "clock_shuttle"
	hidden = TRUE
	dir = 8
	port_direction = 4
	height = 32
	width = 21
	dwidth = 10

/obj/docking_port/mobile/cult_meteor
	name = "The Bloody Revenge"
	shuttle_id = "cult_meteor"
	hidden = TRUE
	dir = 4
	port_direction = 8
	height = 22
	width = 11
	dwidth = 9

/area/shuttle/clock_ship
	name = "T.G.E. Brass Hope"
	ambience_index = AMBIENCE_REEBE
	area_limited_icon_smoothing = /area/shuttle/clock_ship

/area/shuttle/cult_meteor
	name = "The Bloody Revenge"
	ambience_index = AMBIENCE_CREEPY
	area_limited_icon_smoothing = /area/shuttle/clock_ship

/obj/machinery/computer/shuttle/clock_ship
	name = "Brass Hope Console"
	desc = "Used to control the T.G.E. Brass Hope."
	circuit = /obj/item/circuitboard/computer/clock_ship
	shuttleId = "clock_shuttle"
	possible_destinations = "whiteship_home;clock_shuttle_custom"
	admin_controlled = TRUE

/obj/item/circuitboard/computer/clock_ship
	name = "Brass Hope"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/clock_ship

/obj/machinery/computer/camera_advanced/shuttle_docker/clock_ship
	name = "Brass Hope Navigation Computer"
	desc = "Used to designate a precise transit location for the T.G.E. Brass Hope."
	shuttleId = "clock_shuttle"
	shuttlePortId = "clock_shuttle_custom"
	jump_to_ports = list("whiteship_home" = 1)

/obj/item/circuitboard/computer/clock_ship_nav
	name = "Brass Hope Navigation Computer (Computer Board)"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/clock_ship

/obj/machinery/computer/shuttle/cult_meteor
	name = "Bloody Revenge Console"
	desc = "Used to control the Bloody Revenge."
	circuit = /obj/item/circuitboard/computer/cult_meteor
	shuttleId = "cult_meteor"
	possible_destinations = "whiteship_home;cult_meteor_custom"
	admin_controlled = TRUE

/obj/item/circuitboard/computer/cult_meteor
	name = "The Bloody Revenge"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/cult_meteor

/obj/machinery/computer/camera_advanced/shuttle_docker/cult_meteor
	name = "Bloody Revenge Navigation Computer"
	desc = "Used to designate a precise transit location for The Bloody Revenge."
	shuttleId = "cult_meteor"
	shuttlePortId = "cult_meteor_custom"
	jump_to_ports = list("whiteship_home" = 1)

/obj/item/circuitboard/computer/cult_meteor_nav
	name = "Bloody Revenge Navigation Computer (Computer Board)"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/cult_meteor

/datum/map_template/shuttle/clock_shuttle
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"
	who_can_purchase = null
	name = "T.G.E. Brass Hope"
	port_id = "clock_shuttle"

/datum/map_template/shuttle/cult_meteor
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"
	who_can_purchase = null
	name = "The Bloody Revenge"
	port_id = "cult_meteor"
