/obj/structure/launcher
	name = "rocket launch platform"
	desc = "A rotating platform capable of launching objects."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "launcher_base"
	anchored = TRUE
	density = TRUE
	max_integrity = 250
	/// How far can this launcher detect it's target, in tiles.
	var/detection_range = 10
	/// The types that we are scanning for.
	var/list/target_types = list(
		/mob/living,
		/obj/spacepod,
		/obj/drone,
		/obj/vehicle,
	)
	/// What we are currently targeting.
	var/atom/target
	/// How long it takes to reload a round.
	var/reload_time = 5 SECONDS
	/// The type of physics projectile we launch at things.
	var/obj/launch_type = /obj/physics_rocket
	/// The angle between us and our target, updated automatically.
	var/angle_to_target = 0
	/// Our last angle
	var/last_angle = 0
	var/image/turret_overlay
	/// Our factions.
	var/list/friendly_factions = list()

	COOLDOWN_DECLARE(reload_time_cooldown)

/obj/structure/launcher/Initialize(mapload)
	. = ..()
	turret_overlay = image(icon = initial(launch_type.icon), icon_state = initial(launch_type.icon_state), layer = OBJ_LAYER)
	START_PROCESSING(SSphysics, src)
	update_appearance()


/obj/structure/launcher/update_overlays()
	. = ..()
	. += turret_overlay

/obj/structure/launcher/process(seconds_per_tick)
	if(!target)
		find_target(detection_range)
	else
		process_target()

/obj/structure/launcher/proc/process_target()
	if(!target)
		return
	if(get_dist(src, target) > detection_range || !target_check(target))
		lose_target()
		return
	angle_to_target = get_angle(src, target)
	update_turret_angle()
	last_angle = angle_to_target
	fire_at()

/obj/structure/launcher/proc/update_turret_angle()
	var/matrix/mat_from = new()
	var/matrix/mat_to = new()
	mat_from.Turn(last_angle)
	mat_to.Turn(angle_to_target)

	turret_overlay.transform = mat_from
	animate(turret_overlay, transform = mat_to, time = 10, flags = ANIMATION_END_NOW)
	update_appearance()

/obj/structure/launcher/proc/fire_at()
	if(!COOLDOWN_FINISHED(src, reload_time_cooldown))
		return

	// it's go time baby
	new launch_type(get_turf(src), angle_to_target, 0, 0, 0, 0, target, 0, src, TRUE, friendly_factions)

	COOLDOWN_START(src, reload_time_cooldown, reload_time)

/**
 * find_target
 *
 * Finds a target within a specific range while also checking said target.
 */
/obj/structure/launcher/proc/find_target(range)
	var/min_distance = INFINITY
	var/closest_object
	for(var/iterating_target in view(range, src))
		if(!is_type_in_list(iterating_target, target_types))
			continue
		if(!target_check(iterating_target))
			continue
		var/distance = get_dist(src, iterating_target)
		if(distance < min_distance)
			min_distance = distance
			closest_object = iterating_target
	if(closest_object)
		set_target(closest_object)

/**
 * set_target
 *
 * Sets the target and starts tracking accordingly.
 */
/obj/structure/launcher/proc/set_target(atom/target_to_set)
	if(!target_to_set)
		return
	target = target_to_set
	RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(lose_target))

/obj/structure/launcher/proc/lose_target(atom/lost_target)
	SIGNAL_HANDLER
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	target = null

/**
 * target_check
 *
 * Performs checks on a target, returns TRUE if they pass or FALSE if they dont, thus targeting the target.
 */
/obj/structure/launcher/proc/target_check(target_to_check)
	// Living checks
	if(isliving(target_to_check))
		var/mob/living/living_target = target_to_check
		if(living_target.stat != CONSCIOUS)
			return FALSE
		if(faction_check(living_target.faction, friendly_factions))
			return FALSE
	// Drone checks
	if(istype(target_to_check, /obj/drone))
		var/obj/drone/target_drone = target_to_check
		if(faction_check(target_drone.friendly_factions, friendly_factions))
			return FALSE
		return TRUE

	// Spacepod checks
	if(istype(target_to_check, /obj/spacepod))
		var/obj/spacepod/target_spacepod = target_to_check
		if(faction_check(target_spacepod.get_factions(), friendly_factions))
			return FALSE
		return TRUE

	// Mecha checks
	if(ismecha(target_to_check))
		var/obj/vehicle/sealed/mecha/target_mecha = target_to_check
		for(var/occupant in target_mecha.occupants)
			var/mob/living/living_occupant = occupant
			if(faction_check(living_occupant.faction, friendly_factions))
				return FALSE
		return TRUE
	return TRUE


/obj/structure/launcher/missile
	name = "missile launch platform"
	launch_type = /obj/physics_missile

/obj/structure/launcher/target_lead
	name = "advanced missile launch platform"
	launch_type = /obj/physics_missile/lead_angle
	target_types = list(
		/obj/spacepod,
		/obj/drone,
	)

/obj/structure/launcher/CanAllowThrough(atom/movable/mover, border_dir)
	if(istype(mover, launch_type))
		return TRUE
	return ..()
