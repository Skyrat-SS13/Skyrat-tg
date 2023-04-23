// This is like paradise spacepods but with a few differences:
// - no spacepod fabricator, parts are made in techfabs and frames are made using metal rods.
// - not tile based, instead has velocity and acceleration. why? so I can put all this math to use.
// - damages shit if you run into it too fast instead of just stopping. You have to have a huge running start to do that though and damages the spacepod as well.
// - doesn't explode

GLOBAL_LIST_INIT(spacepods_list, list())

/obj/spacepod
	name = "space pod"
	desc = "A frame for a spacepod."
	icon = 'modular_skyrat/modules/spacepods/icons/construction2x2.dmi'
	icon_state = "pod_1"
	density = TRUE
	opacity = FALSE
	dir = NORTH // always points north because why not
	layer = SPACEPOD_LAYER
	anchored = TRUE
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF // it floats above lava or something, I dunno
	base_pixel_x = -16
	base_pixel_y = -16
	pixel_x = -16
	pixel_y = -16

	max_integrity = 50
	integrity_failure = 0.1
	light_system = MOVABLE_LIGHT
	light_range = 6
	light_power = 6
	light_on = FALSE

	/// The overlay icon that we will use for our cool looks.
	var/icon/overlay_file = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	/// Hard ref to our equipment
	var/list/equipment = list()
	/// What slots the ship has and how many of them
	var/list/equipment_slot_limits = SPACEPOD_DEFAULT_EQUIPMENT_LIMITS_LIST
	/// What is our active weapon slot?
	var/active_weapon_slot
	/// Is the weapon able to be fired?
	var/weapon_safety = FALSE
	/// A list of our weapon slots, the association is the offset for pixel shooting.
	var/list/weapon_slots = list(
		SPACEPOD_WEAPON_SLOT_LEFT = list(30, 16),
		SPACEPOD_WEAPON_SLOT_RIGHT = list(30, -16),
	)
	/// A list of installed cargo bays
	var/list/cargo_bays = list()
	/// Next fire delay
	var/next_firetime = 0
	/// Are we...locked? or... unlocked.......
	var/locked = FALSE
	/// Is the door... open... or... closed.........
	var/hatch_open = FALSE
	/// What construction state we are in
	var/construction_state = SPACEPOD_EMPTY
	/// Our armor, stuff that deflects incoming badstuff, ye?
	var/obj/item/pod_parts/armor/pod_armor = null
	/// The cell that powers the ship.
	var/obj/item/stock_parts/cell/cell = null
	/// Are the lights on or off?
	var/light_toggle = FALSE
	/// The air inside the cabin, no AC included.
	var/datum/gas_mixture/cabin_air
	/// The air inside the cabin.
	var/obj/machinery/portable_atmospherics/canister/internal_tank

	/// People inside the pod, an associative list, the list structure is as follows [occupant mob][list data type][list data type entry]
	var/list/occupants = list()

	/// A list of our slots, and how many people can fit in said slot.
	var/list/occupant_slots = list(
		SPACEPOD_RIDER_TYPE_PILOT = 1,
		SPACEPOD_RIDER_TYPE_PASSENGER = 0
	)

	/// A list of action types to grant depending on rider type.
	var/list/action_types_to_grant = list(
		SPACEPOD_RIDER_TYPE_PILOT = list(
			/datum/action/spacepod/controls,
			/datum/action/spacepod/exit,
			/datum/action/spacepod/toggle_lights,
			/datum/action/spacepod/toggle_brakes,
			/datum/action/spacepod/toggle_gyroscope,
			/datum/action/spacepod/thrust_up,
			/datum/action/spacepod/thrust_down,
			/datum/action/spacepod/quantum_entangloporter,
			/datum/action/spacepod/open_poddoors,
			/datum/action/spacepod/cycle_weapons,
			/datum/action/spacepod/toggle_safety,
			/datum/action/spacepod/deploy_flare,
		),
		SPACEPOD_RIDER_TYPE_PASSENGER = list(
			/datum/action/spacepod/exit,
		),
	)

	/// A list of traits that we will grant to the rider, as well as the trait acquirement type
	var/list/traits_to_grant = list(
		SPACEPOD_RIDER_TYPE_PILOT = list(
			TRAIT_HANDS_BLOCKED = VEHICLE_TRAIT,
		)
	)
	/// How long it takes to enter the pod.
	var/pod_enter_time = 4 SECONDS

	/// Our RCS breaking system, if it's on, the ship will try to keep itself stable.
	var/brakes = TRUE
	/// Is the angular vectoring system enabled?
	var/gyroscope_enabled = TRUE
	/// A system for preventing any thrust from being applied.
	var/thrust_lockout = FALSE

	/// Our looping alarm sound for something bad happening.
	var/datum/looping_sound/spacepod_alarm/alarm_sound
	/// Have we muted the alarm?
	var/alarm_muted = FALSE
	/// Our looping thrust sound.
	var/datum/looping_sound/spacepod_thrust/thrust_sound

	/// Our looping missile lock sound.
	var/datum/looping_sound/missile_lock/missile_lock_sound

	/// Our teleporter warp effect
	var/atom/movable/warp_effect/warp
	/// How long it takes us to warp
	var/warp_time = 5 SECONDS
	/// Our follow trail
	var/datum/effect_system/trail_follow/ion/grav_allowed/trail

	/// Are we dirty?
	var/dirty = FALSE
	/// What dirt overlay do we add?
	var/dirt_overlay = "pod_dirt_1"

	/// Component physics values
	var/component_angle = 0
	var/component_velocity_x = 0
	var/component_velocity_y = 0
	var/component_offset_x = 0
	var/component_offset_y = 0
	var/component_last_rotate = 0
	var/component_last_thrust_right = 0
	var/component_last_thrust_forward = 0

	// Overlay stuff
	/// Our image overlay for the back thrusters.
	var/image/back_thrust_overlay
	/// Our image overlay for the front thrusters.
	var/image/front_thrust_overlay
	/// Our image overlay for the

	var/image/left_thrust_overlay

	var/image/right_thrust_overlay

	var/atom/movable/screen/spacepod/spacepod_hud

	var/flare_reload_time = 10 SECONDS
	COOLDOWN_DECLARE(flare_reload_cooldown)

	var/static/list/explosion_sounds = list(
		'modular_skyrat/modules/spacepods/sound/explosion_medium_1.ogg',
		'modular_skyrat/modules/spacepods/sound/explosion_medium_2.ogg',
		'modular_skyrat/modules/spacepods/sound/explosion_medium_3.ogg',
		'modular_skyrat/modules/spacepods/sound/explosion_medium_4.ogg',
		'modular_skyrat/modules/spacepods/sound/explosion_medium_5.ogg',
		'modular_skyrat/modules/spacepods/sound/explosion_medium_6.ogg',
		'modular_skyrat/modules/spacepods/sound/explosion_medium_7.ogg',
	)

	/// How much fuel we have to jump to deep space levels.
	var/jump_fuel = 0


/**
 * Okay so
 *
 * BYOND doesn't do collision detection properly for bound_ overrides, so we have to do it ourselves. Nice.
 */
/obj/spacepod/Move(atom/newloc, direct, glide_size_override, update_dir)
	var/turf/turf_one = get_step(newloc, dir)
	var/turf/turf_two

	switch(dir)
		if(NORTH, SOUTH)
			turf_two = get_step(turf_one, (component_offset_x > 0) ? EAST : WEST)

		if(EAST, WEST)
			turf_two = get_step(turf_one, (component_offset_y > 0) ? NORTH : SOUTH)

	if(!turf_one || !turf_two || !turf_one.Enter(src) || !turf_two.Enter(src))
		if(turf_one)
			Bump(turf_one)
		if(turf_two)
			Bump(turf_two)
		return FALSE
	. = ..()

/obj/spacepod/Initialize()
	. = ..()
	var/datum/component/physics/physics_component = AddComponent(/datum/component/physics)
	RegisterSignal(physics_component, COMSIG_PHYSICS_UPDATE_MOVEMENT, PROC_REF(physics_component_update_movement))
	RegisterSignal(physics_component, COMSIG_PHYSICS_PROCESSED_BUMP, PROC_REF(process_physics_bump))
	RegisterSignal(physics_component, COMSIG_PHYSICS_THRUST_CHECK, PROC_REF(check_thrust))
	RegisterSignal(physics_component, COMSIG_PHYSICS_AUTOSTABILISE_CHECK, PROC_REF(check_autostabilisation))
	RegisterSignal(src, COMSIG_MISSILE_LOCK, PROC_REF(missile_lock))
	RegisterSignal(src, COMSIG_MISSILE_LOCK_LOST, PROC_REF(missile_lock_lost))
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(process_integrity))
	active_weapon_slot = pick(weapon_slots)
	GLOB.spacepods_list += src
	START_PROCESSING(SSobj, src)
	cabin_air = new
	cabin_air.temperature = T20C
	cabin_air.volume = 200
	alarm_sound = new(src)
	thrust_sound = new(src)
	missile_lock_sound = new(src)
	trail = new(src)
	trail.set_up(src)
	trail.start()
	spacepod_hud = new()


/obj/spacepod/Destroy()
	GLOB.spacepods_list -= src
	remove_all_riders(forced = TRUE)
	if(warp)
		vis_contents -= warp
		QDEL_NULL(warp)
	QDEL_LIST(occupants)
	QDEL_LIST_ASSOC_VAL(equipment)
	QDEL_NULL(cabin_air)
	QDEL_NULL(internal_tank)
	QDEL_NULL(cell)
	QDEL_NULL(pod_armor)
	QDEL_NULL(alarm_sound)
	QDEL_NULL(thrust_sound)
	QDEL_NULL(missile_lock_sound)
	QDEL_NULL(trail)
	UnregisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED)
	return ..()



/**
 * process
 *
 * Processes the atmospherics of the pod.
 */
/obj/spacepod/process(seconds_per_tick)
	// Cool the cabin air to T20C if it's not empty
	if(cabin_air && cabin_air.return_volume() > 0)
		var/temperature_delta = cabin_air.return_temperature() - T20C
		cabin_air.temperature -= max(-10, min(10, round(temperature_delta / 4, 0.1)))

	// Process internal air tank and cabin air interactions
	if(internal_tank && cabin_air)
		var/datum/gas_mixture/tank_air = internal_tank.return_air()
		var/release_pressure = ONE_ATMOSPHERE
		var/cabin_pressure = cabin_air.return_pressure()
		var/pressure_delta = min(release_pressure - cabin_pressure, (tank_air.return_pressure() - cabin_pressure) / 2)
		var/transfer_moles = 0

		// Cabin pressure lower than release pressure
		if(pressure_delta > 0 && tank_air.return_temperature() > 0)
			transfer_moles = pressure_delta * cabin_air.return_volume() / (cabin_air.return_temperature() * R_IDEAL_GAS_EQUATION)
			var/datum/gas_mixture/removed = tank_air.remove(transfer_moles)
			cabin_air.merge(removed)

		// Cabin pressure higher than release pressure
		else if(pressure_delta < 0)
			var/turf/our_turf = get_turf(src)
			var/datum/gas_mixture/turf_air = our_turf.return_air()
			pressure_delta = cabin_pressure - release_pressure

			if(turf_air)
				pressure_delta = min(cabin_pressure - turf_air.return_pressure(), pressure_delta)

			// If location pressure is lower than cabin pressure
			if(pressure_delta > 0)
				transfer_moles = pressure_delta * cabin_air.return_volume() / (cabin_air.return_temperature() * R_IDEAL_GAS_EQUATION)
				var/datum/gas_mixture/removed = cabin_air.remove(transfer_moles)

				if(our_turf)
					our_turf.assume_air(removed)
				else // Delete the cabin gas if we're in space or a similar environment
					qdel(removed)

/obj/spacepod/attackby(obj/item/attacking_item, mob/living/user)
	if(user.combat_mode)
		return ..()
	else if(construction_state != SPACEPOD_ARMOR_WELDED)
		. = handle_spacepod_construction(attacking_item, user)
		if(.)
			return
		else
			return ..()
	// and now for the real stuff
	else
		if(attacking_item.tool_behaviour == TOOL_CROWBAR)
			if(hatch_open || !locked)
				hatch_open = !hatch_open
				attacking_item.play_tool_sound(src)
				to_chat(user, span_notice("You [hatch_open ? "open" : "close"] the maintenance hatch."))
			else
				to_chat(user, span_warning("The hatch is locked shut!"))
			return TRUE
		if(istype(attacking_item, /obj/item/stock_parts/cell))
			if(!hatch_open)
				to_chat(user, span_warning("The maintenance hatch is closed!"))
				return TRUE
			if(cell)
				to_chat(user, span_notice("The pod already has a battery."))
				return TRUE
			if(user.transferItemToLoc(attacking_item, src))
				to_chat(user, span_notice("You insert [attacking_item] into the pod."))
				cell = attacking_item
			return TRUE
		if(istype(attacking_item, /obj/item/spacepod_equipment))
			if(!hatch_open)
				to_chat(user, span_warning("The maintenance hatch is closed!"))
				return TRUE
			attach_equipment(attacking_item, user)
			return TRUE
		if(istype(attacking_item, /obj/item/device/lock_buster))
			try_to_break_lock(attacking_item, user)
			return TRUE
		if(istype(attacking_item, /obj/item/soap))
			var/obj/item/soap/soap = attacking_item
			if(!dirty)
				to_chat(user, span_notice("The pod is not dirty!"))
				return TRUE
			to_chat(user, span_notice("You start cleaning the pod..."))
			if(do_after(soap.cleanspeed))
				dirty = FALSE
				update_appearance()
				to_chat(user, span_notice("You clean the pod."))
			return TRUE
		if(attacking_item.tool_behaviour == TOOL_WELDER)
			var/obj_integrity = get_integrity()
			var/repairing = cell || internal_tank || equipment.len || (obj_integrity < max_integrity) || LAZYLEN(occupants)
			if(!hatch_open)
				to_chat(user, span_warning("You must open the maintenance hatch before [repairing ? "attempting repairs" : "unwelding the armor"]."))
				return TRUE
			if(repairing && obj_integrity >= max_integrity)
				to_chat(user, span_warning("[src] is fully repaired!"))
				return TRUE
			to_chat(user, span_notice("You start [repairing ? "repairing [src]" : "slicing off [src]'s armor'"]"))
			if(attacking_item.use_tool(src, user, 50, amount = 3, volume = 50))
				if(repairing)
					update_integrity(min(max_integrity, obj_integrity + 10))
					update_appearance()
					to_chat(user, span_notice("You mend some [pick("dents","bumps","damage")] with [attacking_item]"))
				else if(!cell && !internal_tank && !equipment.len && !LAZYLEN(occupants) && construction_state == SPACEPOD_ARMOR_WELDED)
					user.visible_message("[user] slices off [src]'s armor.", span_notice("You slice off [src]'s armor."))
					construction_state = SPACEPOD_ARMOR_SECURED
					update_icon()
			return TRUE
		if(istype(attacking_item, /obj/item/fuel_cell))
			jump_fuel++
			to_chat(user, span_notice("Fuel cell loaded. [src] now has [jump_fuel] fuel cells installed."))
			qdel(attacking_item)
			return TRUE
	return ..()

/obj/spacepod/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!locked)
		var/mob/living/target
		var/list/pilots = get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT)
		var/list/passengers = get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PASSENGER)
		if(LAZYLEN(pilots))
			target = pilots[1]
		else if(LAZYLEN(passengers))
			target = passengers[1]

		if(target && istype(target))
			src.visible_message(span_warning("[user] is trying to rip the door open and pull [target] out of [src]!") ,
				span_warning("You see [user] outside the door trying to rip it open!"))
			if(do_after(user, 5 SECONDS, target = src) && construction_state == SPACEPOD_ARMOR_WELDED)
				if(remove_rider(target, TRUE))
					target.Stun(20)
					target.visible_message(span_warning("[user] flings the door open and tears [target] out of [src]") ,
						span_warning("The door flies open and you are thrown out of [src] and to the ground!"))
				return
			target.visible_message(span_warning("[user] was unable to get the door open!") ,
					span_warning("You manage to keep [user] out of [src]!"))

/obj/spacepod/attack_hand(mob/user)
	if(!hatch_open)
		return ..()
	show_detachable_equipment(user)

/obj/spacepod/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	update_appearance()

/obj/spacepod/return_air()
	return cabin_air

/obj/spacepod/remove_air(amount)
	return cabin_air.remove(amount)


/obj/spacepod/ex_act(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			for(var/mob/living/living_mob in contents)
				living_mob.ex_act(severity + 1)
			deconstruct()
		if(EXPLODE_HEAVY)
			take_damage(100, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			if(prob(40))
				take_damage(40, BRUTE, BOMB)

/obj/spacepod/deconstruct(disassembled = FALSE)
	if(!get_turf(src))
		qdel(src)
		return

	play_alarm(FALSE)
	missile_lock_sound.stop()

	if(disassembled)
		handle_disassembly()
	else
		handle_destruction()

/obj/spacepod/update_overlays()
	. = ..()
	if(construction_state != SPACEPOD_ARMOR_WELDED && pod_armor && construction_state >= SPACEPOD_ARMOR_LOOSE)
		var/mutable_appearance/armor = mutable_appearance(pod_armor.pod_icon, pod_armor.pod_icon_state)
		. += armor
		return

	// Dirt overlays
	if(dirty)
		. += dirt_overlay

	// Weapon overlays
	if(LAZYLEN(equipment[SPACEPOD_SLOT_WEAPON]))
		for(var/obj/item/spacepod_equipment/weaponry/iterating_weaponry in equipment[SPACEPOD_SLOT_WEAPON])
			var/mutable_appearance/weapon_overlay = mutable_appearance(iterating_weaponry.overlay_icon, iterating_weaponry.overlay_icon_state) // Default state should fill in the left gunpod.
			if(equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry])
				var/weapon_offset_y = weapon_slots[equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry]][2]
				if(weapon_offset_y < 0) // Positive value means it's supposed to be overlayed on the right side of the pod, thus, flip le image so it fits.
					var/matrix/flip_matrix = matrix(-1, 0, 0, 0, 1, 0)
					weapon_overlay.transform = flip_matrix

			. += weapon_overlay


	// Now do actual equipment overlays

	for(var/key_type in equipment)
		if(key_type == SPACEPOD_SLOT_WEAPON)
			continue
		for(var/obj/item/spacepod_equipment/iterating_equipment as anything in equipment[key_type])
			if(iterating_equipment.overlay_icon && iterating_equipment.overlay_icon_state)
				. += mutable_appearance(iterating_equipment.overlay_icon, iterating_equipment.overlay_icon_state)


	// Damage overlays
	var/obj_integrity = get_integrity()
	var/obj_integrity_percent = (obj_integrity / max_integrity) * 100
	if(obj_integrity_percent < 50)
		. += "pod_damage"
	if(obj_integrity_percent < 25)
		. += "pod_critical_damage"
	if(obj_integrity_percent < 10)
		. += "pod_fire"
	if(obj_integrity <= 0)
		. += "explosion_overlay"


/obj/spacepod/update_icon()
	. = ..()
	if(construction_state != SPACEPOD_ARMOR_WELDED)
		icon = 'modular_skyrat/modules/spacepods/icons/construction2x2.dmi'
		icon_state = "pod_[construction_state]"
		thrust_sound.stop()
		return

	if(pod_armor)
		icon = pod_armor.pod_icon
		icon_state = pod_armor.pod_icon_state
	else
		icon = initial(icon)
		icon_state = initial(icon_state)

/obj/spacepod/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	if(atom_integrity <= 0)
		return
	. = ..()


/obj/spacepod/proc/handle_thruster_effects()
	cut_overlay(list(back_thrust_overlay, front_thrust_overlay, left_thrust_overlay, right_thrust_overlay))
	// Initialize left and right thrust lists with zeros
	var/list/left_thrusts = list(0, 0, 0, 0, 0, 0, 0, 0)
	var/list/right_thrusts = list(0, 0, 0, 0, 0, 0, 0, 0)
	var/back_thrust = 0
	var/front_thrust = 0

	// Calculate left and right thrusts based on last_thrust_right
	if(component_last_thrust_right != 0)
		var/tdir = component_last_thrust_right > 0 ? WEST : EAST
		var/thrust_val = abs(component_last_thrust_right)
		left_thrusts[tdir] = thrust_val
		right_thrusts[tdir] = thrust_val

	// Calculate front and back thrusts based on last_thrust_forward
	if(component_last_thrust_forward > 0)
		back_thrust = component_last_thrust_forward
	else
		front_thrust = -component_last_thrust_forward

	// Update left and right thrust overlays based on calculated values
	for(var/cardinal_direction in GLOB.cardinals)
		var/left_thrust = left_thrusts[cardinal_direction]
		var/right_thrust = right_thrusts[cardinal_direction]
		if(left_thrust)
			if(!left_thrust_overlay)
				left_thrust_overlay = image(icon = overlay_file, icon_state = "rcs_left", dir = cardinal_direction)
			left_thrust_overlay.dir = cardinal_direction
			add_overlay(left_thrust_overlay)
		if(right_thrust)
			if(!right_thrust_overlay)
				right_thrust_overlay = image(icon = overlay_file, icon_state = "rcs_right", dir = cardinal_direction)
			right_thrust_overlay.dir = cardinal_direction
			add_overlay(right_thrust_overlay)

	// Update back thrust overlay and play thrust sound if back_thrust is not 0b
	if(back_thrust)
		if(!back_thrust_overlay)
			back_thrust_overlay = image(icon = overlay_file, icon_state = "thrust")
			back_thrust_overlay.transform = matrix(1, 0, 0, 0, 1, -32)
		add_overlay(back_thrust_overlay)
		thrust_sound.start()
	else
		thrust_sound.stop()

	// Update front thrust overlay if front_thrust is not 0
	if(front_thrust)
		if(!front_thrust_overlay)
			front_thrust_overlay = image(icon = overlay_file, icon_state = "front_thrust")
		add_overlay(front_thrust_overlay)


/obj/spacepod/relaymove(mob/user, direction)
	if(check_occupant(user) != SPACEPOD_RIDER_TYPE_PILOT || user.incapacitated())
		return

	SEND_SIGNAL(src, COMSIG_PHYSICS_SET_THRUST_DIR, direction)

/obj/spacepod/MouseDrop_T(atom/movable/dropped_atom, mob/living/user)
	if(check_occupant(user) || construction_state != SPACEPOD_ARMOR_WELDED)
		return

	if(istype(dropped_atom, /obj/machinery/portable_atmospherics/canister))
		if(internal_tank)
			to_chat(user, span_warning("[src] already has an internal_tank!"))
			return
		if(!dropped_atom.Adjacent(src))
			to_chat(user, span_warning("The canister is not close enough!"))
			return
		if(hatch_open)
			to_chat(user, span_warning("The hatch is shut!"))
		to_chat(user, span_notice("You begin inserting the canister into [src]"))
		if(do_after(user, 5 SECONDS, dropped_atom) && construction_state == SPACEPOD_ARMOR_WELDED)
			to_chat(user, span_notice("You insert the canister into [src]"))
			dropped_atom.forceMove(src)
			internal_tank = dropped_atom
		return

	if(isliving(dropped_atom))
		var/mob/living/living_mob = dropped_atom
		if(living_mob != user && !locked)
			if(check_rider_slot(living_mob, SPACEPOD_RIDER_TYPE_PASSENGER))
				visible_message(span_danger("[user] starts loading [living_mob] into [src]!"))
				if(do_after(user, 5 SECONDS, src) && construction_state == SPACEPOD_ARMOR_WELDED)
					add_rider(living_mob, SPACEPOD_RIDER_TYPE_PASSENGER)
			else
				to_chat(user, span_warning("[src] is full!"))
			return
		if(living_mob == user)
			enter_pod(user)
			return

	return ..()

/obj/spacepod/AltClick(user)
	if(!verb_check(user = user))
		return
	brakes = !brakes
	to_chat(usr, span_notice("You toggle the brakes [brakes ? "on" : "off"]."))

// PHYSICS PROCS
/**
 * physics_component_update_movement
 *
 * Updates the corresponding component values for each time the physics component is processed.
 */
/obj/spacepod/proc/physics_component_update_movement(datum/source, updated_angle, updated_velocity_x, updated_velocity_y, updated_offset_x, updated_offset_y, updated_last_rotate, updated_last_thrust_forward, updated_last_thrust_right)
	SIGNAL_HANDLER
	component_angle = updated_angle
	component_velocity_x = updated_velocity_x
	component_velocity_y = updated_velocity_y
	component_offset_x = updated_offset_x
	component_offset_y = updated_offset_y
	component_last_rotate = updated_last_rotate
	component_last_thrust_forward = updated_last_thrust_forward
	component_last_thrust_right = updated_last_thrust_right

	handle_thruster_effects()

// MISC PROCS

/**
 * try to break lock
 *
 * Attempts to break a spacepod lock.
 */

/obj/spacepod/proc/try_to_break_lock(mob/user)
	if(!LAZYLEN(equipment[SPACEPOD_SLOT_LOCK]))
		to_chat(user, span_warning("[src] does not have a lock!"))
		return FALSE

	var/obj/item/spacepod_equipment/lock/spacepod_lock = equipment[SPACEPOD_SLOT_LOCK][1]

	user.visible_message(user, span_warning("[user] is drilling through [src]'s lock!"), span_notice("You start drilling through [src]'s lock!"))

	if(do_after(user, 10 SECONDS, src))
		detach_equipment(spacepod_lock)
		qdel(spacepod_lock)
		user.visible_message(user, span_warning("[user] has destroyed [src]'s lock!"), span_notice("You destroy [src]'s lock!"))
	else
		user.visible_message(user, span_warning("[user] fails to break through [src]'s lock!"), span_notice("You were unable to break through [src]'s lock!"))

/**
 * On Mouse Moved
 *
 * Handles the vector movement of the shuttle when the pilot moves their mouse.
 */
/obj/spacepod/proc/on_mouse_moved(mob/user, object, location, control, params)
	SIGNAL_HANDLER

	if(!gyroscope_enabled)
		return

	// Parse the input parameters
	var/list/modifiers = params2list(params)

	// Return if the object is the spacepod itself, the object is in the user's contents, or the user is not the pilot
	if(object == src || (object && (object in user.get_all_contents())) || check_occupant(user) != SPACEPOD_RIDER_TYPE_PILOT)
		return

	// Split the "screen-loc" parameter into its X and Y components
	var/list/screen_loc_list = splittext(modifiers["screen-loc"], ",")
	var/list/screen_loc_x_list = splittext(screen_loc_list[1], ":")
	var/list/screen_loc_y_list = splittext(screen_loc_list[2], ":")

	// Get the view dimensions of the user's client
	var/list/view_dimensions_list = isnum(user.client.view) ? list("[user.client.view * 2 + 1]", "[user.client.view * 2 + 1]") : splittext(user.client.view, "x")

	// Calculate the difference between the mouse position and the center of the screen
	var/delta_x = text2num(screen_loc_x_list[1]) + (text2num(screen_loc_x_list[2]) / world.icon_size) - 1 - text2num(view_dimensions_list[1]) / 2
	var/delta_y = text2num(screen_loc_y_list[1]) + (text2num(screen_loc_y_list[2]) / world.icon_size) - 1 - text2num(view_dimensions_list[2]) / 2

	// Calculate the distance between the mouse position and the center of the screen
	var/distance = sqrt(delta_x * delta_x + delta_y * delta_y)

	// Set the desired angle of the spacepod based on the mouse position
	if(distance > 1)
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, 90 - ATAN2(delta_x, delta_y))
	else
		SEND_SIGNAL(src, COMSIG_PHYSICS_SET_DESIRED_ANGLE, null)

/**
 * handle_destruction
 *
 * Handles the destruction of the spacepod, ejecting all occupants and deleting the spacepod.
 */
/obj/spacepod/proc/handle_destruction()
	spacepod_hud.icon_state = "eject"
	spacepod_hud.invisibility = 0

	if(cabin_air)
		var/datum/gas_mixture/gas_mixture = cabin_air.remove_ratio(1)
		var/turf/our_turf = get_turf(src)
		if(gas_mixture && our_turf)
			our_turf.assume_air(gas_mixture)
	playsound(src, 'modular_skyrat/modules/spacepods/sound/alarm_death.ogg', 100, TRUE, pressure_affected = FALSE)
	addtimer(CALLBACK(src, PROC_REF(destruction)), 5 SECONDS)
	for(var/i in 1 to 5)
		addtimer(CALLBACK(src, PROC_REF(popcorn)), i SECONDS)

/**
 * After all that cinematic stuff has played, we actually delete the spacepod.
 */
/obj/spacepod/proc/destruction()
	if(pod_armor)
		remove_armor()
		QDEL_NULL(pod_armor)
		if(prob(40))
			new /obj/item/stack/sheet/iron/five(get_turf(src))
	remove_all_riders(forced = TRUE)
	playsound(src, 'modular_skyrat/modules/spacepods/sound/explosion_big.ogg', 100, TRUE, pressure_affected = FALSE)
	explosion(src, 0, 2, 3, 4)
	var/list/possible_parts = subtypesof(/obj/item/pod_parts/pod_frame)
	var/list/possible_dirs = list(NORTH, EAST, SOUTH, WEST)
	for(var/i in 1 to rand(2, 4))
		var/obj/item/pod_parts/pod_frame/pod_frame = pick_n_take(possible_parts)
		var/dir = pick_n_take(possible_dirs)
		pod_frame = new pod_frame(get_step(src, dir))
		pod_frame.anchored = TRUE
	qdel(src)

/**
 * popcorn
 *
 * pop pop pop
 */
/obj/spacepod/proc/popcorn()
	playsound(src, pick(explosion_sounds), 100, TRUE, pressure_affected = FALSE)

/**
 * handle_disassembly
 *
 * Handles the non-destructive dissasembly process.
 */
/obj/spacepod/proc/handle_disassembly()
	// First remove all the riders safely.
	remove_all_riders(forced = TRUE)
	// Now we remove all the bits and bobs from the bod.
	detach_all_equipment()
	// remove any other stray stuff.
	for(var/atom/movable/iterating_movable_atom in contents)
		iterating_movable_atom.forceMove(get_turf(src))

	// Now we deconstruct the pod and place the bits.
	var/clamped_angle = (round(component_angle, 90) % 360 + 360) % 360
	var/target_dir = NORTH
	switch(clamped_angle)
		if(0)
			target_dir = NORTH
		if(90)
			target_dir = EAST
		if(180)
			target_dir = SOUTH
		if(270)
			target_dir = WEST

	var/list/frame_piece_types = list(/obj/item/pod_parts/pod_frame/aft_port, /obj/item/pod_parts/pod_frame/aft_starboard, /obj/item/pod_parts/pod_frame/fore_port, /obj/item/pod_parts/pod_frame/fore_starboard)
	var/obj/item/pod_parts/pod_frame/current_piece = null
	var/turf/our_turf = get_turf(src)
	var/list/frame_pieces = list()
	for(var/frame_type in frame_piece_types)
		var/obj/item/pod_parts/pod_frame/frame_to_drop = new frame_type
		frame_to_drop.dir = target_dir
		frame_to_drop.anchored = TRUE
		if(1 == turn(frame_to_drop.dir, -frame_to_drop.link_angle))
			current_piece = frame_to_drop
		frame_pieces += frame_to_drop
	while(current_piece && !current_piece.loc)
		if(!our_turf)
			break
		current_piece.forceMove(our_turf)
		our_turf = get_step(our_turf, turn(current_piece.dir, -current_piece.link_angle))
		current_piece = locate(current_piece.link_to) in frame_pieces

	// Now we delete ourselves.
	qdel(src)

/**
 * Play alarm
 *
 * Checks if the alarm can play or not, then does so.
 */

/obj/spacepod/proc/play_alarm(toggle)
	if(alarm_muted)
		alarm_sound.stop()
		return
	if(toggle)
		alarm_sound.start()
	else
		alarm_sound.stop()


/**
 * Process Integrity
 *
 * This is used for any unique behaviour as the pod is damaged, so far it is used for alarms.
 */
/obj/spacepod/proc/process_integrity(obj/source, old_value, new_value)
	SIGNAL_HANDLER
	var/obj_integrity_percent = (new_value / max_integrity) * 100
	if(obj_integrity_percent < 25) // Less than a quarter health.
		play_alarm(TRUE)
	else
		play_alarm(FALSE)
	update_appearance()



// TELEPORTATION

/**
 * Handles teleportation
 *
 * Shuttles have cool teleport effects.
 */
/obj/spacepod/proc/warp_to(turf/turf_to_warp_to, mob/user)
	warp = new(src)
	vis_contents += warp

	to_chat(user, span_notice("Initiating quantum entangloporter warp systems..."))

	thrust_lockout = TRUE

	addtimer(CALLBACK(src, PROC_REF(actually_warp_to), turf_to_warp_to, user), warp_time)

/**
 * Actually handles teleportation
 */
/obj/spacepod/proc/actually_warp_to(turf/turf_to_warp_to, mob/user)
	if(!cell || cell.charge < 5000) // Final energy check
		vis_contents -= warp
		QDEL_NULL(warp)
		to_chat(usr, span_warning("Not enough energy!"))
		thrust_lockout = FALSE
		return
	var/turf/our_turf = get_turf(src)
	playsound(our_turf, 'sound/magic/Repulse.ogg', 100, TRUE)
	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, our_turf)
	sparks.attach(our_turf)
	sparks.start()
	forceMove(src, turf_to_warp_to)
	to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_notice("TELEPORTING!"))
	vis_contents -= warp
	QDEL_NULL(warp)
	thrust_lockout = FALSE

// MOVEMENT PROCS

/**
 * check_thrust
 *
 * checks if the thrusters can be fired.
 */
/obj/spacepod/proc/check_thrust(datum/component/physics/source_component, total_x, total_y, desired_thrust_dir, seconds_per_tick)
	SIGNAL_HANDLER
	if(!cell)
		if(desired_thrust_dir)
			to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("No powercell installed!"))
		return FALSE
	if(!check_has_equipment(/obj/item/spacepod_equipment/thruster))
		if(desired_thrust_dir)
			to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("No thrusters installed!"))
		return FALSE
	if(thrust_lockout)
		if(desired_thrust_dir)
			to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Unable to comply due to thruster lockout."))
		return FALSE
	if(desired_thrust_dir && brakes && !check_has_equipment(/obj/item/spacepod_equipment/rcs_upgrade))
		to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Brakes are enabled!"))
		return FALSE
	if(!cell.use(10 * sqrt((total_x * total_x) + (total_y * total_y)) * seconds_per_tick))
		if(desired_thrust_dir)
			to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Insufficient power!"))
		return FALSE
	handle_thruster_effects()
	return COMPONENT_PHYSICS_THRUST

/**
 * check_autostabilisation
 *
 * checks if autostabilisation is enabled.
 */
/obj/spacepod/proc/check_autostabilisation(datum/component/physics/source_component)
	SIGNAL_HANDLER
	if(brakes)
		return COMPONENT_PHYSICS_AUTO_STABILISATION
	return FALSE

/obj/spacepod/proc/missile_lock()
	SIGNAL_HANDLER
	missile_lock_sound.start()
	spacepod_hud.invisibility = 0

/obj/spacepod/proc/missile_lock_lost()
	SIGNAL_HANDLER
	missile_lock_sound.stop()
	spacepod_hud.invisibility = INVISIBILITY_ABSTRACT

/obj/spacepod/proc/deploy_flare()
	if(!check_has_equipment(/obj/item/spacepod_equipment/flare))
		to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("No flare module!"))
		return
	if(!COOLDOWN_FINISHED(src, flare_reload_cooldown))
		to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("Flares recharging!"))
		return
	new /obj/physics_decoy_flare(get_turf(src), component_angle, component_velocity_x, component_velocity_y)
	playsound(src, 'sound/items/match_strike.ogg', 100)
	to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_notice("Flare deployed!"))

	COOLDOWN_START(src, flare_reload_cooldown, flare_reload_time)

