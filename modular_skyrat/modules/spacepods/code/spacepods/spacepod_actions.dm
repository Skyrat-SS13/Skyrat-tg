/**
 * Spacepod actions
 *
 * These are basic action types that the spacepod will give to it's controller.
 */
/obj/spacepod/proc/generate_action_type(action_type)
	var/new_action = new action_type
	if(istype(new_action, /datum/action/spacepod))
		var/datum/action/spacepod/spacepod_action = new_action
		spacepod_action.spacepod_target = src
	return new_action


/**
 * ACTION TYPES
 */

/datum/action/spacepod
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'modular_skyrat/modules/spacepods/icons/actions_spacepod.dmi'
	button_icon_state = "mech_eject"
	/// The spacepod we are linked to.
	var/obj/spacepod/spacepod_target

/**
 * Exit
 *
 * Simply tries to make the user exit the pod.
 */
/datum/action/spacepod/exit
	name = "Exit pod"

/datum/action/spacepod/exit/Trigger(trigger_flags)
	if(!owner)
		return
	if(!spacepod_target || !(owner in spacepod_target.occupants))
		return
	spacepod_target.exit_pod(owner)

/**
 * Opens the control system of the pod.
 */
/datum/action/spacepod/controls
	name = "Spacepod controls"
	button_icon_state = "mech_view_stats"

/datum/action/spacepod/controls/Trigger(trigger_flags)
	if(!owner)
		return
	if(!spacepod_target || !(owner in spacepod_target.occupants))
		return
	if(spacepod_target.check_occupant(owner) != SPACEPOD_RIDER_TYPE_PILOT)
		to_chat(owner, span_warning("You are not in a pod."))
		return
	if(owner.incapacitated())
		to_chat(owner, span_warning("You are incapacitated."))
		return
	spacepod_target.ui_interact(owner)

/**
 * Moves the craft up a z-level if it can.
 */

/datum/action/spacepod/thrust_up
	name = "Thrust upwards"
	button_icon_state = "move_up"

/datum/action/spacepod/thrust_up/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	var/turf/current_turf = get_turf(src)
	var/turf/above_turf = SSmapping.get_turf_above(current_turf)

	if(!above_turf)
		to_chat(owner, span_warning("There's nowhere to go in that direction!"))
		return

	if(!spacepod_target.cell || !spacepod_target.cell.use(10))
		to_chat(owner, span_warning("Not enough energy!"))
		return

	if(spacepod_target.zMove(UP, z_move_flags = ZMOVE_ALLOW_ANCHORED|ZMOVE_FEEDBACK))
		to_chat(src, span_notice("You move upwards."))

/**
 * Moves the craft up a z-level if it can.
 */

/datum/action/spacepod/thrust_down
	name = "Thrust downwards"
	button_icon_state = "move_down"

/datum/action/spacepod/thrust_down/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	var/turf/current_turf = get_turf(src)
	var/turf/below_turf = SSmapping.get_turf_below(current_turf)

	if(!below_turf)
		to_chat(owner, span_warning("There's nowhere to go in that direction!"))
		return

	if(!spacepod_target.cell || !(spacepod_target.cell.charge < 10))
		to_chat(owner, span_warning("Not enough energy!"))
		return

	if(spacepod_target.zMove(DOWN, z_move_flags = ZMOVE_ALLOW_ANCHORED|ZMOVE_FEEDBACK))
		spacepod_target.cell.use(10)
		to_chat(src, span_notice("You move downwards."))

/**
 * Wayback Teleportation
 */
/datum/action/spacepod/quantum_entangloporter
	name = "Engage quantum entangloporter"
	button_icon_state = "teleport"

/datum/action/spacepod/quantum_entangloporter/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	if(!spacepod_target.check_has_equipment(/obj/item/spacepod_equipment/teleport))
		to_chat(owner, span_warning("No teleportation device!"))
		return

	if(!LAZYLEN(GLOB.spacepod_beacons))
		to_chat(owner, span_warning("No lighthouses detected!"))
		return

	var/obj/machinery/spacepod_lighthouse/selected_lighthouse = tgui_input_list(owner, "Select a lighthouse to travel to:", "Teleportation", GLOB.spacepod_beacons)

	if(!selected_lighthouse)
		return

	var/turf/lighthouse_turf = get_turf(selected_lighthouse)

	spacepod_target.warp_to(lighthouse_turf, owner)

/**
 * Toggles vector braking
 */
/datum/action/spacepod/toggle_brakes
	name = "Toggle vector brakes"
	button_icon_state = "brakes_on"


/datum/action/spacepod/toggle_brakes/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	spacepod_target.toggle_brakes(owner)

	button_icon_state = "brakes_[spacepod_target.brakes ? "on" : "off"]"
	build_all_button_icons()

/**
 * Cycles through the weapons
 */
/datum/action/spacepod/cycle_weapons
	name = "Cycle weapons"
	button_icon_state = "cycle_weapons"


/datum/action/spacepod/cycle_weapons/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	var/current_index
	for(var/i = 1, i <= LAZYLEN(spacepod_target.weapon_slots), i++)
		if(spacepod_target.weapon_slots[i] == spacepod_target.active_weapon_slot)
			current_index = i
			break

	current_index = (current_index % LAZYLEN(spacepod_target.weapon_slots)) + 1

	spacepod_target.set_active_weapon_slot(spacepod_target.weapon_slots[current_index], owner)

/**
 * Cycles through the weapons
 */
/datum/action/spacepod/toggle_safety
	name = "Toggle safety"
	button_icon_state = "safety_off"


/datum/action/spacepod/toggle_safety/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	spacepod_target.toggle_weapon_lock(owner)

	button_icon_state = "safety_[spacepod_target.weapon_safety ? "on" : "off"]"
	build_all_button_icons()

/**
 * Cycles through the weapons
 */
/datum/action/spacepod/toggle_lights
	name = "Toggle lights"
	button_icon_state = "lights_off"


/datum/action/spacepod/toggle_lights/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	spacepod_target.toggle_lights(owner)

	button_icon_state = "lights_[spacepod_target.light_toggle ? "on" : "off"]"
	build_all_button_icons()

/**
 * Stops angular movement
 */
/datum/action/spacepod/toggle_gyroscope
	name = "Toggle gyroscope"
	button_icon_state = "gyroscope_on"


/datum/action/spacepod/toggle_gyroscope/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	spacepod_target.toggle_gyroscope(owner)

	button_icon_state = "gyroscope_[spacepod_target.gyroscope_enabled ? "on" : "off"]"
	build_all_button_icons()

/**
 * Opens any nearby pod doors
 */
/datum/action/spacepod/open_poddoors
	name = "Open Nearby Poddoors"
	button_icon_state = "open_doors"


/datum/action/spacepod/open_poddoors/Trigger(trigger_flags)
	if(!owner || !spacepod_target || !(owner in spacepod_target.occupants) || owner.incapacitated())
		return

	spacepod_target.toggle_doors(owner)
