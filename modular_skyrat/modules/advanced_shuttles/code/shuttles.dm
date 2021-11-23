/datum/map_template/shuttle/ferry
	name = "NAV Monarch"
	port_id = "ferry"
	suffix = "skyrat"
	who_can_purchase = null

/datum/map_template/shuttle/cargo
	name = "NLV Consign"
	port_id = "cargo"
	suffix = "skyrat"
	name = "NLV Consign (Cargo)"
	who_can_purchase = null

/obj/docking_port/mobile/arrivals_skyrat
	name = "NTV Relay"
	id = "arrivals_shuttle"
	dwidth = 1
	width = 5
	height = 13
	dir = WEST
	port_direction = SOUTH

	callTime = 30 SECONDS
	ignitionTime = 6 SECONDS

	rechargeTime = 20 SECONDS

	movement_force = list("KNOCKDOWN" = 3, "THROW" = 0)

	can_be_called_in_transit = FALSE

/obj/machinery/computer/shuttle/arrivals
	name = "arrivals shuttle control"
	desc = "The terminal used to control the arrivals interlink shuttle."
	shuttleId = "arrivals_shuttle"
	possible_destinations = "arrivals_stationary;arrivals_shuttle"
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/computer.dmi'
	icon_state = "wagon"
	icon_keyboard = ""
	icon_screen = ""
	light_color = COLOR_ORANGE_BROWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	connectable = FALSE //connecting_computer change: since icon_state is not a typical console, it cannot be connectable.

/obj/machinery/computer/shuttle/arrivals/recall
	name = "arrivals shuttle recall terminal"
	desc = "Use this if your friends left you behind."
	possible_destinations = "arrivals_stationary;arrivals_shuttle"

/datum/map_template/shuttle/arrivals_skyrat
	name = "arrivals shuttle"
	prefix = "_maps/skyrat/shuttles/"
	port_id = "arrivals"
	suffix = "skyrat"
	who_can_purchase = null

/datum/map_template/shuttle/escape_pod/default
	name = "escape pod (Default)"
	prefix = "_maps/skyrat/shuttles/"
	port_id = "escape_pod"
	suffix = "default_skyrat"

/datum/map_template/shuttle/emergency/skyrat
	suffix = "skyrat"
	name = "Standard Emergency Shuttle"
	description = "Nanotrasen's standard issue emergency shuttle."

