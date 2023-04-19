/**
 * Rockets
 *
 * These rockets use the physics component to simulate a rocket engine.
 *
 * Unlike missiles, these are dumb and do not have any kind of course correction.
 */
/obj/physics_rocket
	name = "rocket"
	desc = "A long tube filled with explosives with a rocket strapped to the back."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "missile"
	density = TRUE
	opacity = FALSE
	dir = NORTH
	max_integrity = 10
	/// The maximum amount of thrust we can output.
	var/max_forward_thrust = 12
	/// Our looping thrust sound.
	var/datum/looping_sound/rocket_thrust/rocket_sound
	/// How much fuel the rocket has.
	var/fuel = 10
	/// How big the payload size is. EX calculations used for the list.
	var/list/payload_size = list(0, 0, 3, 4)
	var/engine_on = FALSE

/obj/physics_rocket/Initialize(mapload, start_angle, start_velocity_x, start_velocity_y, start_offset_x, start_offset_y)
	. = ..()
	rocket_sound = new(src)
	// Attach the physics component to the physics_missile
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, _forward_maxthrust = max_forward_thrust, _thrust_check_required = FALSE, _stabilisation_check_required = FALSE, _reset_thrust_dir = FALSE, starting_angle = start_angle, starting_velocity_x = start_velocity_x, starting_velocity_y = start_velocity_y, _takes_atmos_damage = FALSE, _max_thrust_velocity = max_forward_thrust)

	// Register the signal to trigger the process_bump() proc
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(explode))

	physics_component.offset_x = start_offset_x
	physics_component.offset_y = start_offset_y


	ignite_engine()

/obj/physics_rocket/Destroy()
	rocket_sound.stop()
	QDEL_NULL(rocket_sound)
	return ..()

/obj/physics_rocket/update_overlays()
	. = ..()
	if(engine_on)
		. += "[icon_state]_thrust_overlay"

/obj/physics_rocket/Bumped(atom/movable/bumped_atom)
	. = ..()
	explode()

/obj/physics_rocket/proc/ignite_engine()
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, NORTH)
	rocket_sound.start()
	playsound(src, 'modular_skyrat/modules/spacepods/sound/rocket_fire.ogg', 100)
	engine_on = TRUE
	update_appearance()


/obj/physics_rocket/proc/explode()
	SIGNAL_HANDLER
	explosion(src, payload_size[1], payload_size[2], payload_size[3], payload_size[4])
	qdel(src)

