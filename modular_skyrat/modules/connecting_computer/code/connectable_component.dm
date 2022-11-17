/**
 * If attached to a machine, adds the connectable computer overlays and smooths to other computers.
 */
/datum/component/connectable_computer
	var/icon/overlay_icon = 'modular_skyrat/modules/connecting_computer/icons/connectors.dmi'

/datum/component/connectable_computer/Initialize()
	if(!ismachinery(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/connectable_computer/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))

	update_neighbors()

/datum/component/connectable_computer/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS)

	update_neighbors()

/**
 * Update neighboring computers.
 */
/datum/component/connectable_computer/proc/update_neighbors()
	// Clean up overlays on adjacent computers after we're gone.
	for(var/obj/machinery/target in range(1, parent))
		if(target.GetComponent(/datum/component/connectable_computer))
			target.update_appearance()

/**
 * Find a connectable computer on this turf.
 *
 * Arguments:
 * * search_dir - the direction to search
 */
/datum/component/connectable_computer/proc/find_connectable_computer(search_dir)
	var/obj/machinery/parent_machine = parent
	var/turf/adjacent_turf = get_step(parent_machine, search_dir)

	for(var/obj/machinery/target in adjacent_turf)
		if(target.dir == parent_machine.dir && target.GetComponent(/datum/component/connectable_computer))
			return target

	return null

/**
 * Handles COMSIG_ATOM_UPDATE_OVERLAYS for machines.
 *
 * Arguments:
 * * parent_machine - The parent we're manipulating
 * * overlays - The overlays list
 */
/datum/component/connectable_computer/proc/on_update_overlays(obj/machinery/parent_machine, list/overlays)
	SIGNAL_HANDLER

	// Add the connecting overlays.
	var/obj/machinery/computer/left_turf = null
	var/obj/machinery/computer/right_turf = null
	switch(parent_machine.dir)
		if(NORTH)
			left_turf = find_connectable_computer(WEST)
			right_turf = find_connectable_computer(EAST)

		if(EAST)
			left_turf = find_connectable_computer(NORTH)
			right_turf = find_connectable_computer(SOUTH)

		if(SOUTH)
			left_turf = find_connectable_computer(EAST)
			right_turf = find_connectable_computer(WEST)

		if(WEST)
			left_turf = find_connectable_computer(SOUTH)
			right_turf = find_connectable_computer(NORTH)

	if(left_turf)
		overlays += mutable_appearance(overlay_icon, "left")

	if(right_turf)
		overlays += mutable_appearance(overlay_icon, "right")
