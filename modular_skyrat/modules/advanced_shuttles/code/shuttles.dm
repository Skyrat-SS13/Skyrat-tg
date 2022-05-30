/obj/docking_port/mobile/arrivals_skyrat
	name = "NTV Relay"
	id = "arrivals_shuttle"
	dwidth = 1
	width = 5
	height = 13
	dir = WEST
	port_direction = SOUTH

	callTime = 15 SECONDS
	ignitionTime = 6 SECONDS
	rechargeTime = 15 SECONDS

	movement_force = list("KNOCKDOWN" = 3, "THROW" = 0)
	can_be_called_in_transit = FALSE

/obj/machinery/computer/shuttle/arrivals
	name = "arrivals shuttle control"
	desc = "The terminal used to control the arrivals interlink shuttle."
	shuttleId = "arrivals_shuttle"
	possible_destinations = "arrivals_stationary;arrivals_shuttle"
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/computer.dmi'
	icon_state = "computer_frame"
	icon_keyboard = "arrivals_key"
	icon_screen = "arrivals"
	light_color = COLOR_ORANGE_BROWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	connectable = FALSE //connecting_computer change: since icon_state is not a typical console, it cannot be connectable.

/obj/machinery/computer/shuttle/arrivals/recall
	name = "arrivals shuttle recall terminal"
	desc = "Use this if your friends left you behind."
	possible_destinations = "arrivals_stationary;arrivals_shuttle"

/*
*	MAP TEMPLATES
*/

/datum/map_template/shuttle/ferry
	name = "NAV Monarch (Ferry)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "ferry"
	suffix = "skyrat"
	who_can_purchase = null

/datum/map_template/shuttle/cargo/skyrat
	name = "NLV Consign (Cargo)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "cargo"
	suffix = "skyrat"

/datum/map_template/shuttle/cargo/skyrat/delta
	suffix = "delta_skyrat"	//I hate this. Delta station is one tile different docking-wise, which fucks it ALL up unless we either a) change the map (this would be nonmodular and also press the engine against disposals) or b) this (actually easy, just dumb)

/datum/map_template/shuttle/arrivals_skyrat
	name = "NTV Relay (Arrivals)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "arrivals"
	suffix = "skyrat"
	who_can_purchase = null

/datum/map_template/shuttle/escape_pod/default
	name = "escape pod (Default)"
	prefix = "_maps/shuttles/skyrat/"
	port_id = "escape_pod"
	suffix = "default_skyrat"

/datum/map_template/shuttle/emergency/default
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"
	name = "Standard Emergency Shuttle"
	description = "Nanotrasen's standard issue emergency shuttle."

/datum/map_template/shuttle/labour/skyrat
	name = "NMC Drudge (Labour)"
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"

/datum/map_template/shuttle/mining_common/skyrat
	name = "NMC Chimera (Mining)"
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"

/datum/map_template/shuttle/mining/skyrat
	name = "NMC Phoenix (Mining)"
	prefix = "_maps/shuttles/skyrat/"
	suffix = "skyrat"

/datum/map_template/shuttle/mining/skyrat/large
	name = "NMC Manticore (Mining)"
	suffix = "large_skyrat"
