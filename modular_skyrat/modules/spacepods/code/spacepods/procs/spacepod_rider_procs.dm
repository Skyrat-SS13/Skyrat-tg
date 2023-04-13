
// RIDER CONTROL PROCS

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

	// We will decide the type we enter as depending on what slots are free.
	var/type_to_enter_as = null

	if(get_remaining_slots(SPACEPOD_RIDER_TYPE_PILOT) > 0)
		type_to_enter_as = SPACEPOD_RIDER_TYPE_PILOT
	else if(get_remaining_slots(SPACEPOD_RIDER_TYPE_PASSENGER) > 0)
		type_to_enter_as = SPACEPOD_RIDER_TYPE_PASSENGER
	else
		to_chat(user, span_danger("You can't fit in [src], it's full!"))
		return FALSE

	visible_message(span_notice("[user] starts to climb into [src]'s [type_to_enter_as]'s seat."))

	if(do_after(user, pod_enter_time, target = src) && construction_state == SPACEPOD_ARMOR_WELDED)
		var/success = add_rider(user, type_to_enter_as)
		if(!success)
			to_chat(user, span_notice("You were too slow. Try better next time, loser."))
		return success
	else
		to_chat(user, span_notice("You stop entering [src]."))

/**
 * Check rider slot
 *
 * Checks if we can actually put a rider into said slot, and if we can, also return how many slots there are, if none, return false.
 */
/obj/spacepod/proc/check_rider_slot(mob/living/mob_to_check, slot_to_check)
	// If we are already in here, don't allow us to add ourselves again.
	if(mob_to_check in occupants)
		return FALSE
	var/slots_taken = 0
	for(var/mob/living/iterating_mob as anything in occupants[slot_to_check])
		slots_taken++

	if(slots_taken >= occupant_slots[slot_to_check])
		return FALSE

	return TRUE

/**
 * grant actions
 *
 * Grants actions to a given player depending on their rider_type
 */
/obj/spacepod/proc/grant_actions(mob/living/mob_to_grant_to, rider_type)
	for(var/datum/action/iterating_action_type as anything in action_types_to_grant[rider_type])
		grant_action_type_to_occupant(mob_to_grant_to, iterating_action_type)

/**
 * Grants an action to a occupant and adds it to the system.
 */

/obj/spacepod/proc/grant_action_type_to_occupant(mob/living/mob_to_grant_to, action_type_to_grant)
	// Generate and deploy the action
	var/datum/action/created_action = generate_action_type(action_type_to_grant)
	created_action.Grant(mob_to_grant_to)

	// Add the action to the occupant
	LAZYINITLIST(occupants[mob_to_grant_to][SPACEPOD_RIDER_ACTIONS])
	occupants[mob_to_grant_to][SPACEPOD_RIDER_ACTIONS] += created_action

	// Edge case hard del prevention. ROBUST.
	RegisterSignal(created_action, COMSIG_PARENT_QDELETING, PROC_REF(action_deleting))

/**
 * Handles the deletion of an action.
 *
 * This should really never happen, but let's keep our code ROBUST.
 */
/obj/spacepod/proc/action_deleting(datum/source)
	SIGNAL_HANDLER
	for(var/occupant in occupants)
		if(source in occupants[occupant][SPACEPOD_RIDER_ACTIONS])
			occupants[occupant][SPACEPOD_RIDER_ACTIONS] -= source

/**
 * give traits
 *
 * Gives the mob all the required traits depening on the rider_type
 */
/obj/spacepod/proc/give_traits(mob/living/mob_to_give_to, rider_type)
	for(var/iterating_trait in traits_to_grant[rider_type])
		give_trait_to_occupant(mob_to_give_to, iterating_trait, traits_to_grant[rider_type][iterating_trait])

/**
 * give trait to occupant
 *
 * Gives a trait to an occupant and adds it to the assoc list for later use.
 */
/obj/spacepod/proc/give_trait_to_occupant(mob/living/mob_to_give_to, trait_to_give, trait_source)
	ADD_TRAIT(mob_to_give_to, trait_to_give, trait_source)
	LAZYINITLIST(occupants[mob_to_give_to][SPACEPOD_RIDER_TRAITS])
	occupants[mob_to_give_to][SPACEPOD_RIDER_TRAITS] += trait_to_give
	occupants[mob_to_give_to][SPACEPOD_RIDER_TRAITS][trait_to_give] = trait_source

/**
 * Add Rider
 *
 * Adds a rider to the spacepod and sets up controls if they are a pilot.
 */
/obj/spacepod/proc/add_rider(mob/living/living_mob, rider_type)
	// Check if we can actually add them.
	if(!check_rider_slot(living_mob, rider_type))
		return FALSE

	LAZYINITLIST(occupants[living_mob])

	// Set the rider type data
	occupants[living_mob][SPACEPOD_RIDER_TYPE] = rider_type

	// Give em the actions
	grant_actions(living_mob, rider_type)

	// Give em the traits
	give_traits(living_mob, rider_type)

	if(rider_type == SPACEPOD_RIDER_TYPE_PILOT)
		// Set up the signals here
		RegisterSignal(living_mob, COMSIG_MOB_CLIENT_MOUSE_MOVE, PROC_REF(on_mouse_moved))
		RegisterSignal(living_mob.client, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(try_fire_weapon))
		RegisterSignal(living_mob, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_items))

		if(living_mob.client)
			living_mob.client.view_size.setTo(2)
			living_mob.movement_type = GROUND

		var/datum/hud/rider_hud = living_mob.hud_used
		if(rider_hud)
			rider_hud.spacepod_hud = spacepod_hud
			rider_hud.infodisplay += spacepod_hud
			living_mob.client?.screen += spacepod_hud

	living_mob.stop_pulling()
	living_mob.forceMove(src)

	playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
	return TRUE


/**
 * Remove actions
 *
 * Removes actions from a given player depending on their rider_type
 */
/obj/spacepod/proc/remove_all_actions(mob/living/mob_to_remove_from)
	for(var/datum/action/iterating_action_instance as anything in occupants[mob_to_remove_from][SPACEPOD_RIDER_ACTIONS])
		remove_action_from_occupant(mob_to_remove_from, iterating_action_instance)

/**
 * Removes an action type or instance from an occupant. Can be a type or instance.
 */
/obj/spacepod/proc/remove_action_from_occupant(mob/living/mob_to_remove_from, action_type_or_instance_to_remove)
	// Remove the action type
	for(var/datum/action/iterating_action_instance in occupants[mob_to_remove_from][SPACEPOD_RIDER_ACTIONS])
		if(ispath(action_type_or_instance_to_remove) && istype(iterating_action_instance, action_type_or_instance_to_remove))
			iterating_action_instance.Remove(mob_to_remove_from)
			occupants[mob_to_remove_from][SPACEPOD_RIDER_ACTIONS] -= iterating_action_instance
			UnregisterSignal(iterating_action_instance, COMSIG_PARENT_QDELETING)
			qdel(iterating_action_instance)
			continue
		if(iterating_action_instance == action_type_or_instance_to_remove)
			iterating_action_instance.Remove(mob_to_remove_from)
			occupants[mob_to_remove_from][SPACEPOD_RIDER_ACTIONS] -= iterating_action_instance
			UnregisterSignal(iterating_action_instance, COMSIG_PARENT_QDELETING)
			qdel(iterating_action_instance)



/**
 * remove_traits
 *
 * Removes the traits from the mob, depending on the rider_type
 */
/obj/spacepod/proc/remove_all_traits(mob/living/mob_to_remove_from)
	for(var/iterating_trait in occupants[mob_to_remove_from][SPACEPOD_RIDER_TRAITS])
		remove_trait_from_occupant(mob_to_remove_from, iterating_trait)

/**
 * remove_trait_from_occupant
 *
 * Removes a trait from an occupant and cleans up the assoc list.
 */
/obj/spacepod/proc/remove_trait_from_occupant(mob/living/mob_to_remove_from, trait_to_remove)
	REMOVE_TRAIT(mob_to_remove_from, trait_to_remove, occupants[mob_to_remove_from][SPACEPOD_RIDER_TRAITS][trait_to_remove])
	occupants[mob_to_remove_from][SPACEPOD_RIDER_TRAITS] -= trait_to_remove

/**
 * remove_rider
 *
 * Checks and removes a rider and clears everything up.
 */
/obj/spacepod/proc/remove_rider(mob/living/mob_to_remove, forced)
	if(locked && !forced)
		to_chat(mob_to_remove, span_warning("[src]'s doors are locked!"))
		return FALSE

	remove_all_actions(mob_to_remove)

	remove_all_traits(mob_to_remove)

	if(occupants[mob_to_remove][SPACEPOD_RIDER_TYPE] == SPACEPOD_RIDER_TYPE_PILOT)
		UnregisterSignal(mob_to_remove, COMSIG_MOB_CLIENT_MOUSE_MOVE)
		UnregisterSignal(mob_to_remove.client, COMSIG_CLIENT_MOUSEDOWN)
		UnregisterSignal(mob_to_remove, COMSIG_MOB_GET_STATUS_TAB_ITEMS)

		var/datum/hud/rider_hud = mob_to_remove.hud_used
		if(rider_hud)
			rider_hud.spacepod_hud = null
			rider_hud.infodisplay -= spacepod_hud
			mob_to_remove.client?.screen -= spacepod_hud

	occupants -= mob_to_remove

	if(mob_to_remove.loc == src)
		mob_to_remove.forceMove(get_turf(src))

	if(mob_to_remove.client)
		mob_to_remove.client.view_size.resetToDefault()
		mob_to_remove.client.pixel_x = 0
		mob_to_remove.client.pixel_y = 0



	return TRUE

/**
 * remove all riders
 *
 * Removes all current riders
 */
/obj/spacepod/proc/remove_all_riders(rider_type_to_remove, forced)
	for(var/occupant in occupants)
		if(rider_type_to_remove)
			if(occupants[occupant][SPACEPOD_RIDER_TYPE] != rider_type_to_remove)
				continue
		remove_rider(occupant, forced)

/**
 * exit pod
 *
 * Makes the user exit the pod.
 */
/obj/spacepod/proc/exit_pod(mob/user)
	if(HAS_TRAIT(user, TRAIT_RESTRAINED))
		to_chat(user, span_notice("You attempt to stumble out of [src]. This will take two minutes."))
		to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_warning("[user] is trying to escape [src]."))
		if(!do_after(user, 2 MINUTES, target = src))
			return

	if(remove_rider(user))
		to_chat(user, span_notice("You climb out of [src]."))

/**
 * to_chat_to_riders
 *
 * Sends a message to a list of rider types, or just a rider type.
 *
 * rider_types can be a list or a singleton
 */
/obj/spacepod/proc/to_chat_to_riders(rider_types, message)
	if(islist(rider_types))
		for(var/rider_type in rider_types)
			for(var/occupant in get_all_occupants_by_type(rider_type))
				to_chat(occupant, message)
		return
	for(var/occupant in get_all_occupants_by_type(rider_types))
		to_chat(occupant, message)

/**
 * check_occupant
 *
 * Checks if a mob is an occupant within the pod.
 *
 * Returns false if they are not, or returns the rider type if they are.
 */
/obj/spacepod/proc/check_occupant(mob/mob_to_check)
	if(mob_to_check in occupants)
		return occupants[mob_to_check][SPACEPOD_RIDER_TYPE]
	return FALSE

/**
 * get_all_occupants
 *
 * returns a list of all the occupants
 */
/obj/spacepod/proc/get_all_occupants()
	return occupants

/**
 * get_all_occupants_by_type
 *
 * returns a list of all the occupants depending on rider type
 */
/obj/spacepod/proc/get_all_occupants_by_type(rider_types)
	var/list/vaid_occupants = list()
	if(islist(rider_types))
		for(var/type in rider_types)
			for(var/mob/living/iterating_mob as anything in occupants)
				if(occupants[iterating_mob][SPACEPOD_RIDER_TYPE] == type)
					vaid_occupants += iterating_mob
	else
		for(var/mob/living/iterating_mob as anything in occupants)
			if(occupants[iterating_mob][SPACEPOD_RIDER_TYPE] == rider_types)
				vaid_occupants += iterating_mob
	return vaid_occupants

/**
 * get_remaining_slots
 *
 * returns the remaining slots for a rider type
 */
/obj/spacepod/proc/get_remaining_slots(rider_type)
	return occupant_slots[rider_type] - LAZYLEN(get_all_occupants_by_type(rider_type))

/**
 * Returns the relevant status tab items for the pilot
 */
/obj/spacepod/proc/get_status_tab_items(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += ""
	items += "Spacepod Charge: [cell ? "[round(cell.charge,0.1)]/[cell.maxcharge] KJ" : "NONE"]"
	items += "Spacepod Integrity: [round(get_integrity(), 0.1)]/[max_integrity]"
	items += "Spacepod Velocity: [round(sqrt(component_velocity_x * component_velocity_x + component_velocity_y * component_velocity_y), 0.1)] m/s"
	var/obj/item/spacepod_equipment/weaponry/selected_weapon = get_weapon_in_slot(active_weapon_slot)
	items += "Spacepod Weapon: [active_weapon_slot] ([selected_weapon ? selected_weapon.name : "Empty"])"
	items += ""

/**
 * get_factions
 *
 * Returns a list of all pilot factions.
 */
/obj/spacepod/proc/get_factions()
	var/list/factions = list()
	for(var/mob/living/iterating_pilot as anything in get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT))
		LAZYADD(factions, iterating_pilot.faction)
	return factions
