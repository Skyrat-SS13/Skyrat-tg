/obj/physics_decoy_flare
	name = "decoy flare"
	desc = "A flare designed to disrupt targeted missiles."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "flare"
	anchored = TRUE
	density = FALSE
	layer = ABOVE_MOB_LAYER
	/// How far of a range do we decoy missiles
	var/decoy_range = 12
	/// have we been used?
	var/used = FALSE
	/// how long we last for
	var/flare_duration = 10 SECONDS
	/// How long we apply forward momentum upon deploying
	var/thrust_duration = 1 SECONDS


/obj/physics_decoy_flare/Initialize(mapload, start_angle, start_velocity_x, start_velocity_y)
	. = ..()
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, starting_angle = -start_angle, _thrust_check_required = FALSE, _forward_maxthrust = 20, _takes_atmos_damage = FALSE)
	physics_component.velocity_x = start_velocity_x
	physics_component.velocity_y = start_velocity_y

	START_PROCESSING(SSphysics, src)

	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_FORWARD)

	addtimer(CALLBACK(src, PROC_REF(cut_initial_thrust)), thrust_duration)

	QDEL_IN(src, flare_duration)


/obj/physics_decoy_flare/process(seconds_per_tick)
	if(used)
		return
	for(var/obj/physics_missile/iterating_missile in view(12, src))
		iterating_missile.set_target(src)
		used = TRUE
		STOP_PROCESSING(SSphysics, src)

/obj/physics_decoy_flare/CanAllowThrough(atom/movable/mover, border_dir)
	if(istype(mover, /obj/physics_missile))
		return FALSE
	return ..()


/obj/physics_decoy_flare/proc/cut_initial_thrust()
	SIGNAL_HANDLER
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, 0)
