/datum/map_template/shuttle/pirate/nri_raider
	prefix = "_maps/shuttles/skyrat/"
	suffix = "nri_raider"
	name = "pirate ship (NRI Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5


/area/shuttle/pirate/nri
	name = "NRI Starship"
	forced_ambience = TRUE
	ambient_buzz = 'modular_skyrat/modules/encounters/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list(
		'modular_skyrat/modules/encounters/sounds/alarm_radio.ogg',
		'modular_skyrat/modules/encounters/sounds/alarm_small_09.ogg',
		'modular_skyrat/modules/encounters/sounds/gear_loop.ogg',
		'modular_skyrat/modules/encounters/sounds/gear_start.ogg',
		'modular_skyrat/modules/encounters/sounds/gear_stop.ogg',
		'modular_skyrat/modules/encounters/sounds/intercom_loop.ogg',
	)

/obj/machinery/computer/shuttle/pirate/nri
	name = "police shuttle console"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/nri
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."

/obj/machinery/base_alarm/nri_raider
	alarm_sound_file = 'modular_skyrat/modules/encounters/sounds/env_horn.ogg'
	alarm_cooldown = 32

/obj/docking_port/mobile/pirate/nri_raider
	name = "NRI IAC-PV 'Evangelium'" //Nobody will care about the translation but basically NRI Internal Affairs Collegium-Patrol Vessel
	initial_engine_power = 6
	port_direction = EAST
	preferred_direction = EAST
	callTime = 2 MINUTES
	rechargeTime = 3 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	can_move_docking_ports = TRUE
	takeoff_sound = sound('modular_skyrat/modules/encounters/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_skyrat/modules/encounters/sounds/env_ship_down.ogg')

/obj/structure/plaque/static_plaque/golden/commission/ks13/nri_raider
	desc = "NRI Terentiev-Yermolayev Orbital Shipworks, Providence High Orbit, Ship OSTs-02\n'Potato Beetle' Class Corvette\nCommissioned 10/11/2562 'Keeping Promises'"
