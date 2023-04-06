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
	animate_movement = NO_STEPS // we do our own gliding here
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
	var/list/equipment_slot_limits = list(
		SPACEPOD_SLOT_MISC = 1,
		SPACEPOD_SLOT_CARGO = 2,
		SPACEPOD_SLOT_WEAPON = 1,
		SPACEPOD_SLOT_LOCK = 1,
		SPACEPOD_SLOT_LIGHT = 1,
		SPACEPOD_SLOT_THRUSTER = 1,
		)
	/// The lock on the ship
	var/obj/item/spacepod_equipment/lock/lock
	/// The weapon on the ship, thing that goes pew pew
	var/obj/item/spacepod_equipment/weaponry/selected_weapon
	/// Is the weapon able to be fired?
	var/weapon_safety = FALSE
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
	/// Do we got them headlights my man? They on? y--- OH SHIT A DEER
	var/obj/item/spacepod_equipment/lights/our_lights
	/// Are the lights on or off?
	var/light_toggle = FALSE
	/// The air inside the cabin, no AC included.
	var/datum/gas_mixture/cabin_air
	/// The air inside the cabin.
	var/obj/machinery/portable_atmospherics/canister/internal_tank
	/// Control timer for slow process, please don't fuck with it.
	var/last_slowprocess = 0

	/// Total occupants
	var/list/occupants = list()

	/// US!
	var/mob/living/pilot
	/// OUR FRIENDS!
	var/list/passengers = list()
	/// How many friends we can have!
	var/max_passengers = 0
	/// List of action types for passengers
	var/list/passenger_actions = list(
		/datum/action/spacepod/exit,
		)
	/// List of action types for the pilot
	var/list/pilot_actions = list(
		/datum/action/spacepod/controls,
		/datum/action/spacepod/exit,
		/datum/action/spacepod/thrust_up,
		/datum/action/spacepod/thrust_down,
		/datum/action/spacepod/quantum_entangloporter,
		)

	/// List of occupants with actions attached.
	var/list/mob/occupant_actions = list()

	// Physics stuff, we calculate our own velocity and acceleration, in tiles per second.
	var/velocity_x = 0
	var/velocity_y = 0
	var/offset_x = 0 // like pixel_x/y but in tiles
	var/offset_y = 0
	var/angle = 0 // degrees, clockwise
	var/desired_angle = null // set by pilot moving his mouse
	var/angular_velocity = 0 // degrees per second
	var/max_angular_acceleration = 360 // in degrees per second per second
	var/last_thrust_forward = 0
	var/last_thrust_right = 0
	var/last_rotate = 0
	// End of physics stuff

	/// Our RCS breaking system, if it's on, the ship will try to keep itself stable.
	var/brakes = TRUE
	/// A system for preventing any thrust from being applied.
	var/thrust_lockout = FALSE
	/// Users thrust direction
	var/user_thrust_dir = 0
	/// Max forward thrust, in tiles per second
	var/forward_maxthrust = 6
	/// Max reverse thrust, in tiles per second
	var/backward_maxthrust = 3
	/// Max side thrust, in tiles per second
	var/side_maxthrust = 1

	/// Bounce factor, how much we bounce off walls
	var/bump_impulse = 0.6
	/// how much of our velocity to keep on collision
	var/bounce_factor = 0.2
	/// mostly there to slow you down when you drive (pilot?) down a 2x2 corridor
	var/lateral_bounce_factor = 0.95
	/// Our icon direction number.
	var/icon_dir_num = 1
	/// Our looping alarm sound for something bad happening.
	var/datum/looping_sound/spacepod_alarm/alarm_sound
	/// Have we muted the alarm?
	var/alarm_muted = FALSE

	/// Our teleporter warp effect
	var/atom/movable/warp_effect/warp
	/// How long it takes us to warp
	var/warp_time = 5 SECONDS


/obj/spacepod/Initialize()
	. = ..()
	GLOB.spacepods_list += src
	START_PROCESSING(SSfastprocess, src)
	cabin_air = new
	cabin_air.temperature = T20C
	cabin_air.volume = 200
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(process_integrity))
	alarm_sound = new(src)

/obj/spacepod/Destroy()
	GLOB.spacepods_list -= src
	if(pilot)
		clear_pilot()
	if(warp)
		vis_contents -= warp
		QDEL_NULL(warp)
	QDEL_LIST(passengers)
	QDEL_LIST(occupants)
	QDEL_LIST(equipment)
	QDEL_NULL(cabin_air)
	QDEL_NULL(internal_tank)
	QDEL_NULL(cell)
	QDEL_NULL(pod_armor)
	QDEL_NULL(lock)
	QDEL_NULL(selected_weapon)
	QDEL_NULL(alarm_sound)
	UnregisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED)
	return ..()


// We want the pods to have gravity all the time to prevent them being touched by spacedrift.
/obj/spacepod/has_gravity(turf/gravity_turf)
	return TRUE

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
			var/obj/item/spacepod_equipment/new_equipment = attacking_item
			if(new_equipment.can_install(src, user) && user.temporarilyRemoveItemFromInventory(new_equipment))
				new_equipment.forceMove(src)
				new_equipment.on_install(src)
			return TRUE
		if(lock && istype(attacking_item, /obj/item/device/lock_buster))
			var/obj/item/device/lock_buster/lock_buster = attacking_item
			if(lock_buster.on)
				user.visible_message(user, span_warning("[user] is drilling through [src]'s lock!") ,
					span_notice("You start drilling through [src]'s lock!"))
				if(do_after(user, 100 * attacking_item.toolspeed, target = src))
					if(lock)
						lock.on_uninstall()
						QDEL_NULL(lock)
						user.visible_message(user, span_warning("[user] has destroyed [src]'s lock!") ,
							span_notice("You destroy [src]'s lock!"))
				else
					user.visible_message(user, span_warning("[user] fails to break through [src]'s lock!") ,
					span_notice("You were unable to break through [src]'s lock!"))
				return TRUE
			to_chat(user, span_notice("Turn the [lock_buster] on first."))
			return TRUE
		if(attacking_item.tool_behaviour == TOOL_WELDER)
			var/obj_integrity = get_integrity()
			var/repairing = cell || internal_tank || equipment.len || (obj_integrity < max_integrity) || pilot || passengers.len
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
					update_icon()
					to_chat(user, span_notice("You mend some [pick("dents","bumps","damage")] with [attacking_item]"))
				else if(!cell && !internal_tank && !equipment.len && !pilot && !passengers.len && construction_state == SPACEPOD_ARMOR_WELDED)
					user.visible_message("[user] slices off [src]'s armor.", span_notice("You slice off [src]'s armor."))
					construction_state = SPACEPOD_ARMOR_SECURED
					update_icon()
			return TRUE
	return ..()

/obj/spacepod/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!locked)
		var/mob/living/target
		if(pilot)
			target = pilot
		else if(passengers.len > 0)
			target = passengers[1]

		if(target && istype(target))
			src.visible_message(span_warning("[user] is trying to rip the door open and pull [target] out of [src]!") ,
				span_warning("You see [user] outside the door trying to rip it open!"))
			if(do_after(user, 50, target = src) && construction_state == SPACEPOD_ARMOR_WELDED)
				if(remove_rider(target))
					target.Stun(20)
					target.visible_message(span_warning("[user] flings the door open and tears [target] out of [src]") ,
						span_warning("The door flies open and you are thrown out of [src] and to the ground!"))
				return
			target.visible_message(span_warning("[user] was unable to get the door open!") ,
					span_warning("You manage to keep [user] out of [src]!"))

/obj/spacepod/attack_hand(mob/user)
	if(!hatch_open)
		return ..()
	var/list/items = list(cell, internal_tank)
	items += equipment
	var/list/item_map = list()
	var/list/used_key_list = list()
	for(var/obj/iterating_item in items)
		item_map[avoid_assoc_duplicate_keys(iterating_item.name, used_key_list)] = iterating_item
	var/selection = input(user, "Remove which equipment?", null, null) as null|anything in item_map
	var/obj/equipment_to_remove = item_map[selection]

	uninstall_equipment(equipment_to_remove, user)

/obj/spacepod/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	..()
	update_icon()

/obj/spacepod/return_air()
	return cabin_air

/obj/spacepod/remove_air(amount)
	return cabin_air.remove(amount)


/obj/spacepod/ex_act(severity)
	switch(severity)
		if(1)
			for(var/mob/living/living_mob in contents)
				living_mob.ex_act(severity+1)
			deconstruct()
		if(2)
			take_damage(100, BRUTE, "bomb", 0)
		if(3)
			if(prob(40))
				take_damage(40, BRUTE, "bomb", 0)

/**
 * We handle our own atom breaking.area
 * This is because we have unique damage overlays and destruction phases.
 */
/obj/spacepod/atom_break(damage_flag)
	if(get_integrity() <= 0)
		return ..()
	if(construction_state < SPACEPOD_ARMOR_LOOSE)
		return
	if(pod_armor)
		remove_armor()
		QDEL_NULL(pod_armor)
		if(prob(40))
			new /obj/item/stack/sheet/iron/five(get_turf(src))
	if(prob(40))
		new /obj/item/stack/sheet/iron/five(get_turf(src))
	construction_state = SPACEPOD_CORE_SECURED
	if(cabin_air)
		var/datum/gas_mixture/gas_mixture = cabin_air.remove_ratio(1)
		var/turf/our_turf = get_turf(src)
		if(gas_mixture && our_turf)
			our_turf.assume_air(gas_mixture)
	cell = null
	internal_tank = null
	for(var/atom/movable/iterating_movable_atom in contents)
		if(iterating_movable_atom in equipment)
			var/obj/item/spacepod_equipment/spacepod_equipment = iterating_movable_atom
			if(istype(spacepod_equipment))
				spacepod_equipment.on_uninstall(src)
		if(ismob(iterating_movable_atom))
			forceMove(iterating_movable_atom, loc)
			remove_rider(iterating_movable_atom)
		else if(prob(60))
			iterating_movable_atom.forceMove(loc)
		else if(isitem(iterating_movable_atom) || !isobj(iterating_movable_atom))
			qdel(iterating_movable_atom)
		else
			var/obj/object = iterating_movable_atom
			object.forceMove(loc)
			object.deconstruct()

/obj/spacepod/deconstruct(disassembled = FALSE)
	if(!get_turf(src))
		qdel(src)
		return
	remove_rider(pilot)
	while(passengers.len)
		remove_rider(passengers[1])
	passengers.Cut()
	if(disassembled)
		// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
		// alright fine fine you can have the frame pieces back
		var/clamped_angle = (round(angle, 90) % 360 + 360) % 360
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
		// there here's your frame pieces back, happy?
	qdel(src)


/obj/spacepod/update_icon()
	. = ..()
	cut_overlays()
	if(construction_state != SPACEPOD_ARMOR_WELDED)
		icon = 'modular_skyrat/modules/spacepods/icons/construction2x2.dmi'
		icon_state = "pod_[construction_state]"
		if(pod_armor && construction_state >= SPACEPOD_ARMOR_LOOSE)
			var/mutable_appearance/masked_armor = mutable_appearance(icon = 'modular_skyrat/modules/spacepods/icons/construction2x2.dmi', icon_state = "armor_mask")
			var/mutable_appearance/armor = mutable_appearance(pod_armor.pod_icon, pod_armor.pod_icon_state)
			armor.blend_mode = BLEND_MULTIPLY
			masked_armor.overlays = list(armor)
			masked_armor.appearance_flags = KEEP_TOGETHER
			add_overlay(masked_armor)
		return

	var/obj_integrity = get_integrity()

	if(obj_integrity <= max_integrity / 2)
		add_overlay(image(icon = initial(icon), icon_state = "pod_damage"))
		if(obj_integrity <= max_integrity / 4)
			add_overlay(image(icon = initial(icon), icon_state = "pod_fire"))

	if(selected_weapon && selected_weapon.overlay_icon_state)
		add_overlay(image(icon = selected_weapon.overlay_icon,icon_state = selected_weapon.overlay_icon_state))

	if(pod_armor)
		icon = pod_armor.pod_icon
		icon_state = pod_armor.pod_icon_state
	else
		icon = initial(icon)
		icon_state = initial(icon_state)

	// Thrust!
	var/list/left_thrusts = list()
	left_thrusts.len = 8
	var/list/right_thrusts = list()
	right_thrusts.len = 8
	for(var/cardinal_direction in GLOB.cardinals)
		left_thrusts[cardinal_direction] = 0
		right_thrusts[cardinal_direction] = 0
	var/back_thrust = 0
	var/front_thrust = 0
	if(last_thrust_right != 0)
		var/tdir = last_thrust_right > 0 ? WEST : EAST
		left_thrusts[tdir] = abs(last_thrust_right) / side_maxthrust
		right_thrusts[tdir] = abs(last_thrust_right) / side_maxthrust
	if(last_thrust_forward > 0)
		back_thrust = last_thrust_forward / forward_maxthrust
	if(last_thrust_forward < 0)
		front_thrust = -last_thrust_forward / backward_maxthrust
	if(last_rotate != 0)
		var/fraction = abs(last_rotate) / max_angular_acceleration
		for(var/cardinal_direction in GLOB.cardinals)
			if(last_rotate > 0)
				right_thrusts[cardinal_direction] += fraction
			else
				left_thrusts[cardinal_direction] += fraction
	for(var/cardinal_direction in GLOB.cardinals)
		var/left_thrust = left_thrusts[cardinal_direction]
		var/right_thrust = right_thrusts[cardinal_direction]
		if(left_thrust)
			add_overlay(image(icon = overlay_file, icon_state = "rcs_left", dir = cardinal_direction))
		if(right_thrust)
			add_overlay(image(icon = overlay_file, icon_state = "rcs_right", dir = cardinal_direction))
	if(back_thrust)
		var/image/new_image = image(icon = overlay_file, icon_state = "thrust")
		new_image.transform = matrix(1, 0, 0, 0, 1, -32)
		add_overlay(new_image)
	if(front_thrust)
		add_overlay(image(icon = overlay_file, icon_state = "front_thrust"))


/obj/spacepod/relaymove(mob/user, direction)
	if(user != pilot || pilot.incapacitated())
		return
	user_thrust_dir = direction

/obj/spacepod/MouseDrop_T(atom/movable/dropped_atom, mob/living/user)
	if(user == pilot || (user in passengers) || construction_state != SPACEPOD_ARMOR_WELDED)
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
			if(passengers.len >= max_passengers && !pilot)
				to_chat(user, span_danger("<b>[living_mob.p_they()] can't fly the pod!</b>"))
				return
			if(passengers.len < max_passengers)
				visible_message(span_danger("[user] starts loading [living_mob] into [src]!"))
				if(do_after(user, 5 SECONDS, src) && construction_state == SPACEPOD_ARMOR_WELDED)
					add_rider(living_mob, FALSE)
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

/obj/spacepod/proc/uninstall_equipment(obj/equipment_to_remove, mob/user)
	if(!equipment_to_remove)
		return
	if(!istype(equipment_to_remove))
		return
	if(!(equipment_to_remove in contents))
		return

	// alrightey now to figure out what it is
	if(equipment_to_remove == cell)
		cell = null
	else if(equipment_to_remove == internal_tank)
		internal_tank = null
	else if(equipment_to_remove in equipment)
		var/obj/item/spacepod_equipment/spacepod_equipment = equipment_to_remove
		if(!spacepod_equipment.can_uninstall(user))
			return
		spacepod_equipment.on_uninstall(src)
	else
		return
	equipment_to_remove.forceMove(loc)
	if(isitem(equipment_to_remove))
		user.put_in_hands(equipment_to_remove)

/**
 * Slowprocess
 *
 * This is the slower, more intensive version of process. It's slower.
 */
/obj/spacepod/proc/slowprocess()
	if(cabin_air && cabin_air.return_volume() > 0)
		var/delta = cabin_air.return_temperature() - T20C
		cabin_air.temperature = cabin_air.return_temperature() - max(-10, min(10, round(delta/4,0.1)))
	if(internal_tank && cabin_air)
		var/datum/gas_mixture/tank_air = internal_tank.return_air()

		var/release_pressure = ONE_ATMOSPHERE
		var/cabin_pressure = cabin_air.return_pressure()
		var/pressure_delta = min(release_pressure - cabin_pressure, (tank_air.return_pressure() - cabin_pressure)/2)
		var/transfer_moles = 0
		if(pressure_delta > 0) //cabin pressure lower than release pressure
			if(tank_air.return_temperature() > 0)
				transfer_moles = pressure_delta*cabin_air.return_volume()/(cabin_air.return_temperature() * R_IDEAL_GAS_EQUATION)
				var/datum/gas_mixture/removed = tank_air.remove(transfer_moles)
				cabin_air.merge(removed)
		else if(pressure_delta < 0) //cabin pressure higher than release pressure
			var/turf/our_turf = get_turf(src)
			var/datum/gas_mixture/turf_air = our_turf.return_air()
			pressure_delta = cabin_pressure - release_pressure
			if(turf_air)
				pressure_delta = min(cabin_pressure - turf_air.return_pressure(), pressure_delta)
			if(pressure_delta > 0) //if location pressure is lower than cabin pressure
				transfer_moles = pressure_delta*cabin_air.return_volume()/(cabin_air.return_temperature() * R_IDEAL_GAS_EQUATION)
				var/datum/gas_mixture/removed = cabin_air.remove(transfer_moles)
				if(our_turf)
					our_turf.assume_air(removed)
				else //just delete the cabin gas, we're in space or some shit
					qdel(removed)

/**
 * Add Armor
 *
 * Adds armor to the spacepod and updates it accordingly.
 */
/obj/spacepod/proc/add_armor(obj/item/pod_parts/armor/armor)
	desc = armor.pod_desc
	max_integrity = armor.pod_integrity
	update_integrity(max_integrity - integrity_failure + get_integrity())
	pod_armor = armor
	update_icon()

/**
 * Remove Armor
 *
 * Removes armor from the spacepod...
 */
/obj/spacepod/proc/remove_armor()
	if(!pod_armor)
		update_integrity(min(integrity_failure, get_integrity()))
		max_integrity = integrity_failure
		desc = initial(desc)
		pod_armor = null
		update_icon()

/**
 * On Mouse Moved
 *
 * Handles the vector movement of the shuttle when the pilot moves their mouse.
 */
/obj/spacepod/proc/on_mouse_moved(mob/user, object, location, control, params)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params)
	if(object == src ||  (object && (object in user.get_all_contents())) || user != pilot)
		return
	var/list/sl_list = splittext(modifiers["screen-loc"],",")
	var/list/sl_x_list = splittext(sl_list[1], ":")
	var/list/sl_y_list = splittext(sl_list[2], ":")
	var/list/view_list = isnum(pilot.client.view) ? list("[pilot.client.view*2+1]","[pilot.client.view*2+1]") : splittext(pilot.client.view, "x")
	var/dx = text2num(sl_x_list[1]) + (text2num(sl_x_list[2]) / world.icon_size) - 1 - text2num(view_list[1]) / 2
	var/dy = text2num(sl_y_list[1]) + (text2num(sl_y_list[2]) / world.icon_size) - 1 - text2num(view_list[2]) / 2
	if(sqrt(dx * dx + dy * dy) > 1)
		desired_angle = 90 - ATAN2(dx, dy)
	else
		desired_angle = null

/**
 * Returns the relevant status tab items for the pilot
 */
/obj/spacepod/proc/get_status_tab_items(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += ""
	items += "Spacepod Charge: [cell ? "[round(cell.charge,0.1)]/[cell.maxcharge] KJ" : "NONE"]"
	items += "Spacepod Integrity: [round(get_integrity(), 0.1)]/[max_integrity]"
	items += "Spacepod Velocity: [round(sqrt(velocity_x * velocity_x + velocity_y * velocity_y), 0.1)] m/s"
	items += ""

/**
 * Try Fire Weapon
 *
 * It's a signal handler to then invoke async the actual firing of the weapons. Triggered by mouseclick.
 */
/obj/spacepod/proc/try_fire_weapon(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	if(istype(_target, /atom/movable/screen))
		return
	if(!selected_weapon)
		return
	if(weapon_safety)
		return
	if(pilot != source.mob)
		return
	INVOKE_ASYNC(src, PROC_REF(async_fire_weapons_at), _target)

/**
 * Async fires weapons.
 */
/obj/spacepod/proc/async_fire_weapons_at(atom/target)
	if(selected_weapon)
		selected_weapon.fire_weapons(target)

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
 *
 * TODO: Convert this alarm sound to a looping sound
 */
/obj/spacepod/proc/process_integrity(obj/source, old_value, new_value)
	if(new_value < (max_integrity / 4)) // Less than a quarter health.
		play_alarm(TRUE)
	else
		play_alarm(FALSE)

/**
 * Enter Pod
 *
 * Basic control for entering the pod, it has all the required checks.area
 *
 * returns TRUE OR FALSE.
 */
/obj/spacepod/proc/enter_pod(mob/living/user)
	if(user.stat != CONSCIOUS)
		return FALSE

	if(locked)
		to_chat(user, span_warning("[src]'s doors are locked!"))
		return FALSE

	if(!istype(user))
		return FALSE

	if(user.incapacitated())
		return FALSE
	if(!ishuman(user))
		return FALSE

	if(passengers.len <= max_passengers || !pilot)
		visible_message(span_notice("[user] starts to climb into [src]."))
		if(do_after(user, 40, target = src) && construction_state == SPACEPOD_ARMOR_WELDED)
			var/success = add_rider(user)
			if(!success)
				to_chat(user, span_notice("You were too slow. Try better next time, loser."))
			return success
		else
			to_chat(user, span_notice("You stop entering [src]."))
	else
		to_chat(user, span_danger("You can't fit in [src], it's full!"))
	return FALSE

/**
 * Add Rider
 *
 * Adds a rider to the spacepod and sets up conrols if they are a pilot.
 */
/obj/spacepod/proc/add_rider(mob/living/living_mob, allow_pilot = TRUE)
	if(living_mob == pilot || (living_mob in passengers))
		return FALSE
	if(!pilot && allow_pilot)
		LAZYSET(occupants, living_mob, NONE)
		pilot = living_mob
		RegisterSignal(living_mob, COMSIG_MOB_CLIENT_MOUSE_MOVE, PROC_REF(on_mouse_moved))
		RegisterSignal(living_mob.client, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(try_fire_weapon))
		RegisterSignal(living_mob, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_items))
		grant_pilot_actions(living_mob)
		ADD_TRAIT(living_mob, TRAIT_HANDS_BLOCKED, VEHICLE_TRAIT)
		if(living_mob.client)
			living_mob.client.view_size.setTo(2)
			living_mob.movement_type = GROUND
	else if(passengers.len < max_passengers)
		LAZYSET(occupants, living_mob, NONE)
		grant_passenger_actions(living_mob)
		passengers += living_mob
	else
		return FALSE
	living_mob.stop_pulling()
	living_mob.forceMove(src)
	playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
	return TRUE

/**
 * Remove Rider
 *
 * Checks and removes a rider and clears everything up.
 */
/obj/spacepod/proc/remove_rider(mob/living/living_mob)
	if(!living_mob)
		return
	if(locked)
		to_chat(living_mob, span_warning("[src]'s doors are locked!"))
		return
	if(living_mob == pilot)
		clear_pilot()
	else if(living_mob in passengers)
		remove_passenger_actions(living_mob)
		passengers -= living_mob
	else
		return FALSE
	LAZYREMOVE(occupants, living_mob)
	if(living_mob.loc == src)
		living_mob.forceMove(loc)
	cleanup_actions_for_mob(living_mob)
	if(living_mob.client)
		living_mob.client.pixel_x = 0
		living_mob.client.pixel_y = 0
	return TRUE

/**
 * Clear Pilot
 *
 * Removes any references and signals that the pilot once had.
 */
/obj/spacepod/proc/clear_pilot()
	if(pilot)
		remove_pilot_actions(pilot)
		REMOVE_TRAIT(pilot, TRAIT_HANDS_BLOCKED, VEHICLE_TRAIT)
		if(pilot.client)
			pilot.client.view_size.resetToDefault()
		UnregisterSignal(pilot, COMSIG_MOB_CLIENT_MOUSE_MOVE)
		UnregisterSignal(pilot.client, COMSIG_CLIENT_MOUSEDOWN)
		UnregisterSignal(pilot, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_items))
		pilot = null


/**
 * Is Occupant
 *
 * Checks if a mob is an occupant within the pod.
 */
/obj/spacepod/proc/is_occupant(mob/mob_to_check)
	return !isnull(LAZYACCESS(occupants, mob_to_check))

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
	to_chat(pilot, span_notice("TELEPORTING!"))
	vis_contents -= warp
	QDEL_NULL(warp)
	thrust_lockout = FALSE

/**
 * UI CONTROL FUNCTIONS
 *
 * These functions are called by the client to control the UI.
 */

/obj/spacepod/verb/open_menu()
	set name = "Open Menu"
	set category = "Spacepod"
	set src = usr.loc

	if(!verb_check())
		return

	if(!pilot)
		to_chat(usr, span_warning("You are not in a pod."))
	else if(pilot.incapacitated())
		to_chat(usr, span_warning("You are incapacitated."))
	else
		ui_interact(pilot)

/obj/spacepod/proc/check_interact(mob/living/user, require_pilot = TRUE)
	if(require_pilot && user != pilot)
		to_chat(user, span_notice("You can't reach the controls from your chair"))
		return FALSE
	return !user.incapacitated() && isliving(user) && user.loc == src


/obj/spacepod/ui_interact(mob/user, datum/tgui/ui)
	if(user != pilot)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SpacepodControl")
		ui.open()

/obj/spacepod/ui_state(mob/user)
	return GLOB.conscious_state

/obj/spacepod/ui_data(mob/user)
	. = ..()
	var/list/data = list()

	data["pod_pilot"] = pilot ? pilot.name : "none"

	data["has_occupants"] = FALSE
	if(LAZYLEN(passengers))
		data["occupants"] = list()
		for(var/mob/iterating_mob as anything in passengers)
			data["occupants"] += iterating_mob.name
		data["has_occupants"] = TRUE

	data["integrity"] = round(get_integrity(), 0.1)
	data["max_integrity"] = max_integrity

	data["velocity"] = round(sqrt(velocity_x * velocity_x + velocity_y * velocity_y), 0.1)

	data["locked"] = locked
	data["brakes"] = brakes
	data["lights"] = light_toggle
	data["alarm_muted"] = alarm_muted

	data["has_cell"] = FALSE
	if(cell)
		data["has_cell"] = TRUE
		data["cell_data"] = list(
			"type" = capitalize(cell.name),
			"charge" = cell.charge,
			"max_charge" = cell.maxcharge,
		)

	data["weapon_lock"] = weapon_safety

	data["has_weapon"] = FALSE
	if(selected_weapon)
		data["has_weapon"] = TRUE
		data["weapon_data"] = list(
			"type" = capitalize(selected_weapon.name),
			"desc" = selected_weapon.desc,
		)

	if(LAZYLEN(equipment))
		data["has_equipment"] = TRUE
		data["equipment"] = list()
		for(var/obj/item/spacepod_equipment/spacepod_equipment as anything in equipment)
			data["equipment"] += list(list(
				"name" = uppertext(spacepod_equipment.name),
				"desc" = spacepod_equipment.desc,
				"slot" = capitalize(spacepod_equipment.slot) + " Slot",
				"can_uninstall" = spacepod_equipment.can_uninstall(),
				"ref" = REF(spacepod_equipment),
			))
	else
		data["has_attachments"] = FALSE

	if(LAZYLEN(cargo_bays))
		data["has_bays"] = TRUE
		data["cargo_bays"] = list()
		for(var/obj/item/spacepod_equipment/cargo/large/cargo_bay as anything in cargo_bays)
			data["cargo_bays"] += list(list(
				"name" = uppertext(cargo_bay.name),
				"ref" = REF(cargo_bay),
				"storage" = cargo_bay.storage ? cargo_bay.storage.name : "none",
			))
	else
		data["has_bays"] = FALSE

	return data

/obj/spacepod/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!check_interact(usr))
		return
	switch(action)
		if("exit_pod")
			exit_pod(usr)
		if("toggle_lights")
			toggle_lights(usr)
		if("toggle_brakes")
			toggle_brakes(usr)
		if("toggle_locked")
			toggle_locked(usr)
		if("toggle_doors")
			toggle_doors(usr)
		if("toggle_weapon_lock")
			toggle_weapon_lock(usr)
		if("unload_cargo")
			var/obj/item/spacepod_equipment/cargo/large/cargo = locate(params["cargo_bay_ref"]) in src
			if(!cargo)
				return
			cargo.unload_cargo()
		if("remove_equipment")
			var/obj/item/spacepod_equipment/equipment_to_remove = locate(params["equipment_ref"]) in src
			uninstall_equipment(equipment_to_remove, usr)
		if("mute_alarm")
			mute_alarm(usr)

/obj/spacepod/proc/toggle_weapon_lock(mob/user)
	if(!selected_weapon)
		return
	weapon_safety = !weapon_safety
	to_chat(user, span_notice("Weapon lock is now [weapon_safety ? "on" : "off"]."))

/obj/spacepod/proc/exit_pod(mob/user)
	if(HAS_TRAIT(user, TRAIT_RESTRAINED))
		to_chat(user, span_notice("You attempt to stumble out of [src]. This will take two minutes."))
		if(pilot)
			to_chat(pilot, span_warning("[user] is trying to escape [src]."))
		if(!do_after(user, 1200, target = src))
			return

	if(remove_rider(user))
		to_chat(user, span_notice("You climb out of [src]."))

/obj/spacepod/proc/toggle_lights(mob/user)
	if(!our_lights)
		to_chat(user, span_warning("No lights installed!"))
		return
	light_color = our_lights.color_to_set
	light_toggle = !light_toggle
	if(light_toggle)
		set_light_on(TRUE)
	else
		set_light_on(FALSE)
	to_chat(user, "Lights toggled [light_toggle ? "on" : "off"].")
	for(var/mob/mob in passengers)
		to_chat(mob, "Lights toggled [light_toggle ? "on" : "off"].")

/obj/spacepod/proc/toggle_brakes(mob/user)
	brakes = !brakes
	to_chat(user, span_notice("You toggle the brakes [brakes ? "on" : "off"]."))

/obj/spacepod/proc/toggle_locked(mob/user)
	if(!lock)
		to_chat(user, span_warning("[src] has no locking mechanism."))
		locked = FALSE //Should never be false without a lock, but if it somehow happens, that will force an unlock.
	else
		locked = !locked
		to_chat(user, span_warning("You [locked ? "lock" : "unlock"] the doors."))

/obj/spacepod/proc/toggle_doors(mob/user)
	for(var/obj/machinery/door/poddoor/multi_tile/P in orange(3,src))
		for(var/mob/living/carbon/human/O in contents)
			if(P.check_access(O.get_active_held_item()) || P.check_access(O.wear_id))
				if(P.density)
					P.open()
					return TRUE
				else
					P.close()
					return TRUE
		to_chat(user, span_warning("Access denied."))
		return

	to_chat(user, span_warning("You are not close to any pod doors."))

/obj/spacepod/proc/mute_alarm(mob/user)
	alarm_muted = !alarm_muted
	to_chat(user, span_notice("System alarm [alarm_muted ? "muted" : "enabled"]."))

// LEGACY CONTROL - Important that this works at all times as we don't want to brick people.
/obj/spacepod/proc/verb_check(require_pilot = TRUE, mob/user = null)
	if(!user)
		user = usr
	if(require_pilot && user != pilot)
		to_chat(user, span_notice("You can't reach the controls from your chair"))
		return FALSE
	return !user.incapacitated() && isliving(user)
