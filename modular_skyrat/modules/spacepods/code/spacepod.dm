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
		SPACEPOD_SLOT_WEAPON = 2,
		SPACEPOD_SLOT_LOCK = 1,
		SPACEPOD_SLOT_LIGHT = 1,
		SPACEPOD_SLOT_THRUSTER = 1,
		)
	/// What is our active weapon slot?
	var/active_weapon_slot
	/// Is the weapon able to be fired?
	var/weapon_safety = FALSE
	/// A list of our weapon slots, the association is the offset for pixel shooting.
	var/list/weapon_slots = list(
		SPACEPOD_WEAPON_SLOT_LEFT = list(-16, 0),
		SPACEPOD_WEAPON_SLOT_RIGHT = list(16, 0),
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
		/datum/action/spacepod/toggle_lights,
		/datum/action/spacepod/toggle_brakes,
		/datum/action/spacepod/thrust_up,
		/datum/action/spacepod/thrust_down,
		/datum/action/spacepod/quantum_entangloporter,
		/datum/action/spacepod/cycle_weapons,
		/datum/action/spacepod/toggle_safety,
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

	/// Are our engines turned on or off?
	var/engines = TRUE

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
	/// Our looping thrust sound.
	var/datum/looping_sound/spacepod_thrust/thrust_sound

	/// Our teleporter warp effect
	var/atom/movable/warp_effect/warp
	/// How long it takes us to warp
	var/warp_time = 5 SECONDS
	/// Our follow trail
	var/datum/effect_system/trail_follow/ion/grav_allowed/trail


/obj/spacepod/Initialize()
	. = ..()
	active_weapon_slot = pick(weapon_slots)
	GLOB.spacepods_list += src
	START_PROCESSING(SSfastprocess, src)
	cabin_air = new
	cabin_air.temperature = T20C
	cabin_air.volume = 200
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(process_integrity))
	alarm_sound = new(src)
	thrust_sound = new(src)
	trail = new(src)
	trail.set_up(src)
	trail.start()

/obj/spacepod/Destroy()
	GLOB.spacepods_list -= src
	if(pilot)
		clear_pilot()
	if(warp)
		vis_contents -= warp
		QDEL_NULL(warp)
	QDEL_LIST(passengers)
	QDEL_LIST(occupants)
	QDEL_LIST_ASSOC_VAL(equipment)
	QDEL_NULL(cabin_air)
	QDEL_NULL(internal_tank)
	QDEL_NULL(cell)
	QDEL_NULL(pod_armor)
	QDEL_NULL(alarm_sound)
	QDEL_NULL(thrust_sound)
	QDEL_NULL(trail)
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
			attach_equipment(attacking_item, user)
			return TRUE
		if(istype(attacking_item, /obj/item/device/lock_buster))
			try_to_break_lock(attacking_item, user)
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
					update_overlays()
					to_chat(user, span_notice("You mend some [pick("dents","bumps","damage")] with [attacking_item]"))
				else if(!cell && !internal_tank && !equipment.len && !pilot && !passengers.len && construction_state == SPACEPOD_ARMOR_WELDED)
					user.visible_message("[user] slices off [src]'s armor.", span_notice("You slice off [src]'s armor."))
					construction_state = SPACEPOD_ARMOR_SECURED
					update_overlays()
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
	show_detachable_equipment(user)

/obj/spacepod/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	update_overlays()

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
 * We handle our own atom breaking.
 * This is because we have unique damage overlays and destruction phases.
 */
/obj/spacepod/atom_break(damage_flag)
	if(get_integrity() <= 0)
		return ..()
	play_alarm(FALSE)
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
	// Remove everything inside us.
	for(var/atom/movable/iterating_movable_atom in contents)
		if(iterating_movable_atom in equipment)
			var/obj/item/spacepod_equipment/spacepod_equipment = check_equipment(iterating_movable_atom)
			if(spacepod_equipment)
				detach_equipment(spacepod_equipment)
				continue

		if(ismob(iterating_movable_atom))
			forceMove(iterating_movable_atom, loc)
			remove_rider(iterating_movable_atom)
			continue

		if(prob(60))
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

/obj/spacepod/update_overlays()
	. = ..()
	cut_overlays()
	// Initial check, make sure it's not in construction
	if(construction_state != SPACEPOD_ARMOR_WELDED)
		if(pod_armor && construction_state >= SPACEPOD_ARMOR_LOOSE)
			var/mutable_appearance/masked_armor = mutable_appearance(icon = 'modular_skyrat/modules/spacepods/icons/construction2x2.dmi', icon_state = "armor_mask")
			var/mutable_appearance/armor = mutable_appearance(pod_armor.pod_icon, pod_armor.pod_icon_state)
			armor.blend_mode = BLEND_MULTIPLY
			masked_armor.overlays = list(armor)
			masked_armor.appearance_flags = KEEP_TOGETHER
			. += masked_armor
		return .

	// Weapon overlays
	if(LAZYLEN(equipment[SPACEPOD_SLOT_WEAPON]))
		for(var/obj/item/spacepod_equipment/weaponry/iterating_weaponry in equipment[SPACEPOD_SLOT_WEAPON])
			var/mutable_appearance/weapon_overlay = mutable_appearance(iterating_weaponry.overlay_icon, iterating_weaponry.overlay_icon_state) // Default state should fill in the left gunpod.
			if(equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry])
				var/offset_x = weapon_slots[equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry]][1]
				if(offset_x > 0) // Positive value means it's supposed to be overlayed on the right side of the pod, thus, flip le image so it fits.
					var/matrix/flip_matrix = matrix(-1, 0, 0, 0, 1, 0)
					weapon_overlay.transform = flip_matrix

			. += weapon_overlay

	// Damage overlays
	var/obj_integrity = get_integrity()
	if(obj_integrity <= max_integrity / 2)
		. += "pod_damage"
		if(obj_integrity <= max_integrity / 4)
			. += "pod_fire"

	// Thrust overlays

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
			var/image/left_thrust_overlay = image(icon = overlay_file, icon_state = "rcs_left", dir = cardinal_direction)
			add_overlay(left_thrust_overlay)
		if(right_thrust)
			var/image/right_thrust_overlay = image(icon = overlay_file, icon_state = "rcs_right", dir = cardinal_direction)
			add_overlay(right_thrust_overlay)
	if(back_thrust)
		var/image/new_image = image(icon = overlay_file, icon_state = "thrust")
		new_image.transform = matrix(1, 0, 0, 0, 1, -32)
		add_overlay(new_image)
		thrust_sound.start() // TODO: Refactor this into
	else
		thrust_sound.stop()
	if(front_thrust)
		. += "front_thrust"

/obj/spacepod/update_icon()
	. = ..()
	if(construction_state != SPACEPOD_ARMOR_WELDED)
		icon = 'modular_skyrat/modules/spacepods/icons/construction2x2.dmi'
		icon_state = "pod_[construction_state]"
		return

	if(pod_armor)
		icon = pod_armor.pod_icon
		icon_state = pod_armor.pod_icon_state
	else
		icon = initial(icon)
		icon_state = initial(icon_state)

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

// EQUIPMENT PROCS

/**
 * Get all equipment
 *
 * returns all current spacepod equipment in the spacepod.
 */
/obj/spacepod/proc/get_all_equipment()
	var/list/equipment_list = list()
	for(var/slot in equipment)
		for(var/obj/item/spacepod_equipment/iterating_equipment in equipment[slot])
			equipment_list += iterating_equipment
	return equipment_list

/**
 * Checks if an item is part of our equipment.
 *
 * Returns FALSE if no or the item if yes.
 */
/obj/spacepod/proc/check_equipment(obj/item_to_check)
	for(var/slot in equipment)
		for(var/obj/item/spacepod_equipment/iterating_equipment in equipment[slot])
			if(item_to_check == iterating_equipment)
				return iterating_equipment
	return FALSE

/**
 * Show detachable equipment
 *
 * shows a basic list of things that can be detached, then detaches whatever the user wants to detach.
 */
/obj/spacepod/proc/show_detachable_equipment(mob/user)
	var/list/detachable_equipment = list()

	for(var/slot in equipment)
		for(var/obj/thing in equipment[slot])
			detachable_equipment += thing

	if(!LAZYLEN(detachable_equipment))
		return

	var/obj/thing_to_remove = tgui_input_list(user, "Please select an item to remove:", "Equipment Removal", detachable_equipment)

	if(!thing_to_remove) // User cancelled out
		return

	detach_equipment(thing_to_remove, user)

/**
 * Basic proc to attach a piece of equipment to the shuttle.
 */
/obj/spacepod/proc/attach_equipment(obj/item/spacepod_equipment/equipment_to_attach, mob/user)
	if(!(equipment_to_attach.slot in equipment_slot_limits)) // Slot not present on ship
		to_chat(user, span_warning("[equipment_to_attach] is not compatable with [src]!"))
		return FALSE

	if(LAZYLEN(equipment[equipment_to_attach.slot]) >= equipment_slot_limits[equipment_to_attach.slot]) // Equipment slot full
		to_chat(user, span_warning("[src] cannot fit [equipment_to_attach], slot full!"))
		return FALSE

	if(!equipment_to_attach.can_install(src, user)) // Slot checks
		return FALSE

	if(user && !user.temporarilyRemoveItemFromInventory(equipment_to_attach))
		return FALSE

	if(!islist(equipment[equipment_to_attach.slot]))
		equipment[equipment_to_attach.slot] = list()

	equipment[equipment_to_attach.slot] += equipment_to_attach
	equipment_to_attach.forceMove(src)
	equipment_to_attach.on_install(src)

	// Weapon handling
	if(istype(equipment_to_attach, /obj/item/spacepod_equipment/weaponry))
		if(user)
			INVOKE_ASYNC(src, PROC_REF(async_weapon_slot_selection), equipment_to_attach, user)
		else
			var/list/available_slots = get_free_weapon_slots()
			equipment[SPACEPOD_SLOT_WEAPON][equipment_to_attach] = pick(available_slots)

	return TRUE

/**
 * async weapon slot selection
 *
 * Asynchronously asks the user what weapon slot they want to put the weapon in.
 */
/obj/spacepod/proc/async_weapon_slot_selection(equipment_to_attach, mob/user)
	var/list/available_slots = get_free_weapon_slots()
	var/weapon_slot_to_apply
	weapon_slot_to_apply = tgui_input_list(user, "Please select a weapon slot to put the weapon into:", "Weapon Slot", available_slots)
	if(!weapon_slot_to_apply)
		detach_equipment(equipment_to_attach)
		return
	equipment[SPACEPOD_SLOT_WEAPON][equipment_to_attach] = weapon_slot_to_apply

/**
 * Basic proc to detatch a piece of equipment from the shuttle.
 *
 * Also performs checks to see if its equipment or not.
 */
/obj/spacepod/proc/detach_equipment(obj/equipment_to_detach, mob/user)
	if(isspacepodequipment(equipment_to_detach)) // If it is equipment, handle it
		var/obj/item/spacepod_equipment/spacepod_equipment = equipment_to_detach
		if(!spacepod_equipment.can_uninstall(src, user))
			return FALSE

		equipment[spacepod_equipment.slot] -= spacepod_equipment

		spacepod_equipment.on_uninstall(src)

	equipment_to_detach.forceMove(get_turf(src))

	if(user && isitem(equipment_to_detach))
		user.put_in_hands(equipment_to_detach)

	return TRUE

/obj/spacepod/proc/check_has_equipment(type_to_check)
	var/list/equipment_list = get_all_equipment()

	for(var/thing as anything in equipment_list)
		if(istype(thing, type_to_check))
			return TRUE

	return FALSE

// MISC PROCS

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
 *
 * TODO: Convert this alarm sound to a looping sound
 */
/obj/spacepod/proc/process_integrity(obj/source, old_value, new_value)
	if(new_value < (max_integrity / 4)) // Less than a quarter health.
		play_alarm(TRUE)
	else
		play_alarm(FALSE)


// ARMOR PROCS

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
	update_appearance()

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
		update_appearance()

// WEAPON PROCS

/**
 * Try Fire Weapon
 *
 * It's a signal handler to then invoke async the actual firing of the weapons. Triggered by mouseclick.
 */
/obj/spacepod/proc/try_fire_weapon(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	if(istype(_target, /atom/movable/screen))
		return
	if(weapon_safety)
		to_chat(source, span_warning("Safety is on!"))
		return
	if(pilot != source.mob)
		return
	var/obj/item/spacepod_equipment/weaponry/active_weaponry = get_active_weapon()
	if(!active_weaponry)
		to_chat(source, span_warning("No active weapons!"))
		return
	INVOKE_ASYNC(src, PROC_REF(async_fire_weapons_at), active_weaponry, _target)

/**
 * Async fires weapons.
 */
/obj/spacepod/proc/async_fire_weapons_at(obj/item/spacepod_equipment/weaponry/weapon_to_fire, atom/target)
	var/x_offset = weapon_slots[active_weapon_slot][1]
	var/y_offset = weapon_slots[active_weapon_slot][2]
	weapon_to_fire.fire_weapon(target, x_offset, y_offset)

/**
 * set active weaponslot
 *
 * Sets the pods active weapon slot.
 */
/obj/spacepod/proc/set_active_weapon_slot(new_slot, mob/user)
	active_weapon_slot = new_slot
	if(user)
		var/obj/item/spacepod_equipment/weaponry/selected_weapon = get_weapon_in_slot(new_slot)
		to_chat(user, span_notice("Weapon slot switched to: <b>[new_slot] ([selected_weapon ? selected_weapon : "Empty"])</b>"))

/**
 * get free weapon slots
 *
 * Returns any available weapon slots.
 */
/obj/spacepod/proc/get_free_weapon_slots()
	var/list/free_slots = LAZYCOPY(weapon_slots)
	for(var/iterating_weaponry in equipment[SPACEPOD_SLOT_WEAPON])
		if(equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry] in free_slots)
			free_slots -= equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry]
	return free_slots

/**
 * get active weapon
 *
 * returns the active weapon in the currently selected slot or false if nothing is selected
 */
/obj/spacepod/proc/get_active_weapon()
	for(var/weaponry in equipment[SPACEPOD_SLOT_WEAPON])
		if(equipment[SPACEPOD_SLOT_WEAPON][weaponry] == active_weapon_slot)
			return weaponry
	return FALSE

/**
 * get weapon in slot
 *
 * Returns the weapon that is currently using up the aforementioned slot, if none, returns false.
 */
/obj/spacepod/proc/get_weapon_in_slot(weapon_slot)
	for(var/iterating_weaponry in equipment[SPACEPOD_SLOT_WEAPON])
		if(equipment[SPACEPOD_SLOT_WEAPON][iterating_weaponry] == weapon_slot)
			return iterating_weaponry
	return FALSE

// RIDER PROCS

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
 * exit pod
 *
 * Makes the user exit the pod.
 */
/obj/spacepod/proc/exit_pod(mob/user)
	if(HAS_TRAIT(user, TRAIT_RESTRAINED))
		to_chat(user, span_notice("You attempt to stumble out of [src]. This will take two minutes."))
		if(pilot)
			to_chat(pilot, span_warning("[user] is trying to escape [src]."))
		if(!do_after(user, 1200, target = src))
			return

	if(remove_rider(user))
		to_chat(user, span_notice("You climb out of [src]."))

/**
 * Is Occupant
 *
 * Checks if a mob is an occupant within the pod.
 */
/obj/spacepod/proc/is_occupant(mob/mob_to_check)
	return !isnull(LAZYACCESS(occupants, mob_to_check))

/**
 * Returns the relevant status tab items for the pilot
 */
/obj/spacepod/proc/get_status_tab_items(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += ""
	items += "Spacepod Charge: [cell ? "[round(cell.charge,0.1)]/[cell.maxcharge] KJ" : "NONE"]"
	items += "Spacepod Integrity: [round(get_integrity(), 0.1)]/[max_integrity]"
	items += "Spacepod Velocity: [round(sqrt(velocity_x * velocity_x + velocity_y * velocity_y), 0.1)] m/s"
	var/obj/item/spacepod_equipment/weaponry/selected_weapon = get_weapon_in_slot(active_weapon_slot)
	items += "Spacepod Weapon: [active_weapon_slot] ([selected_weapon ? selected_weapon.name : "Empty"])"
	items += ""


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
	to_chat(pilot, span_notice("TELEPORTING!"))
	vis_contents -= warp
	QDEL_NULL(warp)
	thrust_lockout = FALSE

// TOGGLES

/**
 * Togggle weapon lock
 *
 * Toggles the weapon lock systems of the pod.
 */
/obj/spacepod/proc/toggle_weapon_lock(mob/user)
	weapon_safety = !weapon_safety
	to_chat(user, span_notice("Weapon lock is now [weapon_safety ? "on" : "off"]."))


/**
 * toggle lights
 *
 * Toggles the spacepod lights and sets them accordingly, if a light system is present.
 */
/obj/spacepod/proc/toggle_lights(mob/user)
	if(!LAZYLEN(equipment[SPACEPOD_SLOT_LIGHT]))
		to_chat(user, span_warning("No lights installed!"))
		return

	var/obj/item/spacepod_equipment/lights/light_equipment = equipment[SPACEPOD_SLOT_LIGHT][1]
	light_color = light_equipment.color_to_set
	light_toggle = !light_toggle
	if(light_toggle)
		set_light_on(TRUE)
	else
		set_light_on(FALSE)
	to_chat(user, "Lights toggled [light_toggle ? "on" : "off"].")

/**
 * Toggle breaks
 *
 * Toggles vector braking systems.
 */
/obj/spacepod/proc/toggle_brakes(mob/user)
	brakes = !brakes
	to_chat(user, span_notice("You toggle the brakes [brakes ? "on" : "off"]."))

/**
 * toggle lock
 *
 * Toggles the lock provoding there is a lock.
 */
/obj/spacepod/proc/toggle_locked(mob/user)
	if(!LAZYLEN(equipment[SPACEPOD_SLOT_LOCK]))
		to_chat(user, span_warning("[src] has no locking mechanism."))
		locked = FALSE //Should never be false without a lock, but if it somehow happens, that will force an unlock.
	else
		locked = !locked
		to_chat(user, span_warning("You [locked ? "lock" : "unlock"] the doors."))

/**
 * toggle doors
 *
 * Toggles near by doors and checks items.
 */
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

/**
 * mute alarm
 *
 * Mutes the alarm and prevents it from starting. Provides feedback.
 */
/obj/spacepod/proc/mute_alarm(mob/user)
	alarm_muted = !alarm_muted
	play_alarm(FALSE)
	to_chat(user, span_notice("System alarm [alarm_muted ? "muted" : "enabled"]."))

