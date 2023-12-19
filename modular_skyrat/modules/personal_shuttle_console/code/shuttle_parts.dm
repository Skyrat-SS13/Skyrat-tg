/area/shuttle/personally_bought
	name = "Personal Shuttle Debug Area"
	requires_power = TRUE
	area_limited_icon_smoothing = /area/shuttle/personally_bought
	// Ambience brought to you by the nri shuttle, thanks guys
	ambient_buzz = 'modular_skyrat/modules/encounters/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 30
	ambientsounds = list(
		'modular_skyrat/modules/encounters/sounds/alarm_radio.ogg',
		'modular_skyrat/modules/encounters/sounds/gear_loop.ogg',
		'modular_skyrat/modules/encounters/sounds/gear_start.ogg',
		'modular_skyrat/modules/encounters/sounds/gear_stop.ogg',
		'modular_skyrat/modules/encounters/sounds/intercom_loop.ogg',
	)

/obj/docking_port/mobile/personally_bought
	name = "personal shuttle"
	shuttle_id = "personal_shuttle"
	callTime = 15 SECONDS
	rechargeTime = 30 SECONDS
	prearrivalTime = 5 SECONDS
	preferred_direction = EAST
	dir = NORTH
	port_direction = EAST
	movement_force = list(
		"KNOCKDOWN" = 2,
		"THROW" = 0,
	)

/obj/item/circuitboard/computer/personally_bought
	name = "Personal Ship Console"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/personally_bought

/obj/machinery/computer/shuttle/personally_bought
	name = "Personal Ship Console"
	desc = "Used to control the ship its currently in, ideally."
	circuit = /obj/item/circuitboard/computer/personally_bought
	shuttleId = "personal_shuttle"
	possible_destinations = "whiteship_away;whiteship_home;whiteship_z4;whiteship_waystation;whiteship_lavaland;personal_ship_custom"

#define PERSONAL_SHIP_GPS_TAG "Shuttle Homing Beacon"

/obj/machinery/computer/shuttle/personally_bought/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	AddComponent(/datum/component/gps, PERSONAL_SHIP_GPS_TAG)

#undef PERSONAL_SHIP_GPS_TAG

/obj/machinery/computer/camera_advanced/shuttle_docker/personally_bought
	name = "Personal Ship Navigation Computer"
	desc = "Used to designate a precise transit location for the ship its currently in, ideally."
	shuttleId = "personal_shuttle"
	lock_override = NONE
	shuttlePortId = "personal_ship_custom"
	jump_to_ports = list("whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1, "whiteship_waystation" = 1)
	designate_time = 5 SECONDS
