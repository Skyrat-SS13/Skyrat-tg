GLOBAL_LIST_EMPTY(drone_control_nodes)

#define DRONE_MODE_PATROL "patrol"
#define DRONE_MODE_ATTACK "attack"
#define DRONE_MODE_IDLE "idle"
#define DRONE_MODE_AVOIDING "avoiding"
#define DRONE_MODE_EXPLODING "exploding"

/**
 * Drones
 *
 * Drones are a new type of space fairing enemy. They are hostile and will shoot you on sight.
 *
 * They are also able to patrol a set of patrol nodes, and will return to their control node if they lose their target.
 */
/obj/drone
	name = "drone"
	desc = "A mindless drone out to kill you."
	icon = 'modular_skyrat/modules/spacepods/icons/pod1x1.dmi'
	icon_state = "drone"
	density = TRUE
	opacity = FALSE
	dir = NORTH
	max_integrity = 100
	/// The angle of our component
	var/component_angle = 0
	/// The target that we are going towards.
	var/atom/movable/target_atom
	/// Are we dodging an obstacle?
	var/is_avoiding_obstacle = FALSE
	/// A list of friendly factions.
	var/list/friendly_factions = list(FACTION_ROGUE_DRONE)
	/// A list of target types that we will target.
	var/list/target_types = list(
		/obj/spacepod,
		/mob/living,
		/obj/drone,
		/obj/vehicle/sealed/mecha,
	)
	/// Our current node.
	var/obj/effect/abstract/drone_patrol_node/current_node
	/// Our control node.
	var/obj/effect/abstract/drone_control_node/control_node
	/// Do we patrol?
	var/patrol_enabled = TRUE
	/// Our patrol ID, used for patrol beacons.
	var/patrol_id = "default"
	/// Our detection range.
	var/detection_range = 12
	/// The projectile we fire.
	var/obj/projectile/projectile_type = /obj/projectile/beam/laser
	/// The sound we play when we fire.
	var/fire_sound = 'modular_skyrat/modules/spacepods/sound/drone/drone_shot_laser.ogg'
	/// Our reload time.
	var/reload_time = 2 SECONDS
	/// The minimum distance at which we can fire at a target.
	var/min_fire_distance = 10
	/// The min angle that we can fire at a target.
	var/fire_angle_tolerance = 10

	COOLDOWN_DECLARE(reload_cooldown)

	/// A list of mode speeds
	var/list/mode_speeds = list(
		DRONE_MODE_PATROL = 1,
		DRONE_MODE_ATTACK = 3,
		DRONE_MODE_IDLE = 1,
		DRONE_MODE_AVOIDING = 2,
		DRONE_MODE_EXPLODING = 5,
	)
	/// What is our current mode?
	var/mode = DRONE_MODE_IDLE

	/// What is our target distance from the target?
	var/engage_distance = 5

	/// Our follow trail
	var/datum/effect_system/trail_follow/ion/grav_allowed/trail
	/// Are we in the process of melting down and about to explode?
	var/exploding = FALSE

	var/dying_sound = 'modular_skyrat/modules/spacepods/sound/drone/drone_dying.ogg'
	var/death_sound = 'modular_skyrat/modules/spacepods/sound/drone/drone_death.ogg'
	var/target_acquired_sound = 'modular_skyrat/modules/spacepods/sound/drone/drone_spot.ogg'


/obj/drone/Initialize()
	. = ..()
	// Attach the physics component to the drone
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics, _max_thrust_velocity = mode_speeds[mode], _thrust_check_required = FALSE, _stabilisation_check_required = FALSE, _reset_thrust_dir = FALSE)
	// Register the signal to trigger the process_bump() proc
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(process_bump))
	RegisterSignal(physics_component, COMSIG_PHYSICS_UPDATE_MOVEMENT, PROC_REF(physics_update_movement))
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(on_integrity_changed))

	START_PROCESSING(SSphysics, src)

	trail = new(src)
	trail.set_up(src)
	trail.start()

/obj/drone/Destroy()
	// Stop the movement loop when the drone is destroyed
	STOP_PROCESSING(SSphysics, src)
	current_node = null
	control_node = null
	target_atom = null
	QDEL_NULL(trail)
	return ..()

/obj/drone/process()
	switch(mode)
		if(DRONE_MODE_EXPLODING)
			SEND_SIGNAL(src, COMSIG_PHYSICS_SET_MAX_THRUST, 10, 10, 10)
			SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_FORWARD)
			SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, rand(0, 360))
			return

		if(DRONE_MODE_AVOIDING) // We are avoiding an obstacle
			return

		if(DRONE_MODE_ATTACK) // We are attacking a target
			process_attack()

		if(DRONE_MODE_IDLE) // We are idle
			if(!find_target(detection_range) && patrol_enabled)
				start_patrol()

		if(DRONE_MODE_PATROL) // We are patrolling
			if(!find_target(detection_range) && patrol_enabled)
				process_patrol()

/**
 * process_attack
 *
 * Process the attack mode, calculate all that good stuff and FIRE.
 */
/obj/drone/proc/process_attack()
	if(!target_atom)
		return

	var/distance_to_target = get_dist(src, target_atom)
	if(distance_to_target > detection_range || !check_target(target_atom))
		lose_target(target_atom)
		return

	if(distance_to_target > engage_distance)
		go_to(target_atom)
	else if(distance_to_target < engage_distance)
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, get_angle(src, target_atom))
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_BACKWARD)
	else
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, get_angle(src, target_atom))
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_STOP)

	if(distance_to_target <= min_fire_distance && COOLDOWN_FINISHED(src, reload_cooldown) && check_angle_tolerance(target_atom))
		// We are in range, so we can shoot
		shoot_at(target_atom)
		COOLDOWN_START(src, reload_cooldown, reload_time)


/**
 * shoot_at
 *
 * Fires our projectile type at a set target while also making noise!
 */
/obj/drone/proc/shoot_at(atom/movable/target)
	var/turf/our_turf = get_turf(src)
	var/obj/projectile/projectile = new projectile_type(our_turf)
	projectile.starting = our_turf
	projectile.firer = src
	projectile.def_zone = CHEST
	projectile.original = target
	projectile.fire(component_angle)

	playsound(src, fire_sound, 50, TRUE)

/**
 * check_angle_tolerance
 *
 * Checks if the drone is within the angle tolerance of the target.
 */
/obj/drone/proc/check_angle_tolerance(atom/movable/target)
	var/new_angle = get_angle(src, target)
	var/angle_diff = abs(new_angle - component_angle)

	if(angle_diff > 180)
		angle_diff = 360 - angle_diff

	if(angle_diff > fire_angle_tolerance)
		return FALSE

	return TRUE

/**
 * go_to
 *
 * Automatically paths the drone to a select atom.
 */
/obj/drone/proc/go_to(atom/movable/target)
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, get_angle(src, target))
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, THRUST_DIR_FORWARD)

/**
 * start_patrol
 *
 * Starts the patrol mode.
 */
/obj/drone/proc/start_patrol()
	switch_mode(DRONE_MODE_PATROL)
	balloon_alert_to_viewers("PATROL MODE: Engaging.")
	current_node = null
	process_patrol()

/**
 * switch_mode
 *
 * Switches the drone's mode.
 */
/obj/drone/proc/switch_mode(new_mode)
	mode = new_mode
	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_MAX_THRUST_VELOCITY, mode_speeds[mode], mode_speeds[mode])

/**
 * process_patrol
 *
 * Processes patrolling and automatically moves between patrol nodes.
 */
/obj/drone/proc/process_patrol()
	if(!control_node)
		find_control_node()
		return

	if(!current_node)
		current_node = control_node.get_closest_node(src)
		return

	if(get_dist(src, current_node) < 1) // We are on top of it
		current_node = current_node.next_node
		balloon_alert_to_viewers("PATROL MODE: Moving to next node.")

	go_to(current_node)

/**
 * find_control_node
 *
 * Finds the control node for the drone to use.
 */
/obj/drone/proc/find_control_node()
	if(!LAZYLEN(GLOB.drone_control_nodes))
		return
	for(var/obj/effect/abstract/drone_control_node/iterating_control_node in GLOB.drone_control_nodes)
		if(iterating_control_node.patrol_id == patrol_id)
			control_node = iterating_control_node
			return


/**
 * process_bump
 *
 * Handles the drone bumping into something.
 */
/obj/drone/proc/process_bump()
	SIGNAL_HANDLER
	// When the drone bumps into something, change the desired angle to the opposite direction for a short duration
	if(mode != DRONE_MODE_AVOIDING)
		switch_mode(DRONE_MODE_AVOIDING)
		var/opposite_angle = (component_angle + 180) % 360
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, opposite_angle)
		addtimer(CALLBACK(src, PROC_REF(finish_avoiding_obstacle)), 1 SECONDS)
		balloon_alert_to_viewers("AVOIDING OBSTACLE")

/**
 * finish_avoiding_obstacle
 *
 * Finishes the obstacle avoidance process.
 */
/obj/drone/proc/finish_avoiding_obstacle()
	switch_mode(DRONE_MODE_IDLE)
	balloon_alert_to_viewers("AVOIDANCE COMPLETE")

/**
 * set_target
 *
 * Sets the target that the drone will move towards.
 */
/obj/drone/proc/set_target(atom/movable/target_to_set)
	if(target_atom)
		lose_target(target_atom)
	target_atom = target_to_set
	switch_mode(DRONE_MODE_ATTACK)
	balloon_alert_to_viewers("TARGET ACQUIRED: [target_to_set.name]")
	playsound(src, target_acquired_sound, 30, TRUE, pressure_affected = FALSE)
	RegisterSignal(target_to_set, COMSIG_PARENT_QDELETING, PROC_REF(lose_target))

/**
 * lose_target
 *
 * Removes the target from the drone.
 */
/obj/drone/proc/lose_target(atom/movable/target_to_lose)
	SIGNAL_HANDLER
	UnregisterSignal(target_to_lose, COMSIG_PARENT_QDELETING)
	target_atom = null
	switch_mode(DRONE_MODE_IDLE)
	balloon_alert_to_viewers("TARGET LOST")


/**
 * physics_update_movement
 *
 * Updates the drone's component angle.
 */
/obj/drone/proc/physics_update_movement(datum/source, updated_angle, updated_velocity_x, updated_velocity_y, updated_offset_x, updated_offset_y, updated_last_rotate, updated_last_thrust_forward, updated_last_thrust_right)
	SIGNAL_HANDLER
	component_angle = updated_angle

/**
 * find_target
 *
 * Finds the closest target in range.
 */
/obj/drone/proc/find_target(range)
	var/min_distance = INFINITY
	var/atom/movable/closest_atom
	for(var/atom/movable/iterating_atom in view(range, src))
		if(!check_target(iterating_atom))
			continue
		var/distance = get_dist(src, iterating_atom)
		if(distance < min_distance)
			min_distance = distance
			closest_atom = iterating_atom
	if(closest_atom)
		set_target(closest_atom)
		return TRUE
	return FALSE

/**
 * check_target
 *
 * Checks if the target is valid.
 */
/obj/drone/proc/check_target(target_to_check)
	if(!is_type_in_list(target_to_check, target_types))
		return FALSE

	// Living checks
	if(isliving(target_to_check))
		var/mob/living/target_mob = target_to_check
		if(target_mob.stat != CONSCIOUS)
			return FALSE // No ultra dead people pls.
		if(faction_check(target_mob.faction, friendly_factions))
			return FALSE
		return TRUE

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


/obj/drone/proc/on_integrity_changed(datum/source, new_integrity, old_integrity)
	SIGNAL_HANDLER
	update_appearance()

// Destruction seqence
/obj/drone/deconstruct(disassembled)
	lose_target(target_atom)
	switch_mode(DRONE_MODE_EXPLODING)
	exploding = TRUE
	playsound(src, dying_sound, 100)
	addtimer(CALLBACK(src, PROC_REF(final_death), disassembled), 1 SECONDS)
	update_appearance()

/obj/drone/proc/final_death(disassembled)
	playsound(src, death_sound, 100)
	explosion(src, 0, 0, 2, 3)
	new /obj/structure/drone_wreckage(get_turf(src))
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	qdel(src)

/obj/drone/update_overlays()
	. = ..()
	if(exploding)
		. += "explosion_overlay"

	if((get_integrity() / max_integrity) * 100 < 30)
		. += "fire"

/obj/drone/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	if(atom_integrity <= 0)
		return
	. = ..()

/obj/structure/drone_wreckage
	name = "drone wreckage"
	desc = "A pile of scrap metal and circuitry."
	icon = 'modular_skyrat/modules/spacepods/icons/pod1x1.dmi'
	icon_state = "drone_wreckage"
	max_integrity = 50
	anchored = FALSE
	density = TRUE
	/// What can we spawn when clicked.
	var/list/possible_salvage = list(
		/obj/item/stack/sheet/iron/ten,
		/obj/item/stack/sheet/glass/fifty,
		/obj/item/stack/sheet/mineral/diamond,
		/obj/item/stack/sheet/bluespace_crystal,
		/obj/item/circuitboard/mecha/pod,
		/obj/item/ammo_box/c9mm,
		/obj/item/stock_parts/cell/upgraded,
		/obj/item/stock_parts/cell/high,
		/obj/item/gun/energy/e_gun/old,
	)
	/// How many times someone can press us and get salvage before we break.
	var/amount_of_salvage = 1

/obj/structure/drone_wreckage/Initialize(mapload)
	. = ..()
	amount_of_salvage = rand(1, 3)

/obj/structure/drone_wreckage/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	to_chat(user, span_notice("You start to salvage [src]..."))

	if(!do_after(user, 2 SECONDS, target = src))
		return

	if(amount_of_salvage <= 0)
		to_chat(user, span_warning("There's nothing left to salvage!"))
		return

	var/salvage_type = pick(possible_salvage)
	var/obj/salvage = new salvage_type(get_turf(src))
	user.put_in_hands(salvage)
	amount_of_salvage--


#undef DRONE_MODE_PATROL
#undef DRONE_MODE_ATTACK
#undef DRONE_MODE_IDLE
#undef DRONE_MODE_AVOIDING
#undef DRONE_MODE_EXPLODING
