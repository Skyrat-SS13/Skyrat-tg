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
		for(var/thing in equipment[slot])
			detachable_equipment += thing

	if(cell)
		detachable_equipment += cell

	if(internal_tank)
		detachable_equipment += internal_tank

	if(!LAZYLEN(detachable_equipment))
		return

	var/obj/thing_to_remove = tgui_input_list(user, "Please select an item to remove:", "Equipment Removal", detachable_equipment)

	if(!thing_to_remove) // User cancelled out
		return

	detach_equipment(thing_to_remove, user)

/**
 * remove all equipment
 *
 * Removes all spacepod equipment
 */
/obj/spacepod/proc/detach_all_equipment()
	for(var/slot in equipment)
		for(var/obj/item/spacepod_equipment/iterating_equipment as anything in equipment[slot])
			detach_equipment(iterating_equipment, forced = TRUE)

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

	// Weapon handling
	if(istype(equipment_to_attach, /obj/item/spacepod_equipment/weaponry))
		if(user)
			INVOKE_ASYNC(src, PROC_REF(async_weapon_slot_selection), equipment_to_attach, user)
			return

	if(!islist(equipment[equipment_to_attach.slot]))
		equipment[equipment_to_attach.slot] = list()

	equipment[equipment_to_attach.slot] += equipment_to_attach
	equipment_to_attach.forceMove(src)
	equipment_to_attach.on_install(src)
	return TRUE

/**
 * async weapon slot selection
 *
 * Asynchronously asks the user what weapon slot they want to put the weapon in.
 */
/obj/spacepod/proc/async_weapon_slot_selection(obj/item/spacepod_equipment/weaponry/weaponry_to_attach, mob/user)
	var/list/available_slots = get_free_weapon_slots()
	var/weapon_slot_to_apply
	weapon_slot_to_apply = tgui_input_list(user, "Please select a weapon slot to put the weapon into:", "Weapon Slot", available_slots)

	if(!weapon_slot_to_apply)
		weapon_slot_to_apply = pick(available_slots)

	if(!islist(equipment[weaponry_to_attach.slot]))
		equipment[weaponry_to_attach.slot] = list()

	equipment[weaponry_to_attach.slot] += weaponry_to_attach
	weaponry_to_attach.forceMove(src)
	weaponry_to_attach.on_install(src, weapon_slot_to_apply)

/**
 * Basic proc to detatch a piece of equipment from the shuttle.
 *
 * Also performs checks to see if its equipment or not.
 */
/obj/spacepod/proc/detach_equipment(obj/equipment_to_detach, mob/user, forced)
	if(isspacepodequipment(equipment_to_detach)) // If it is equipment, handle it
		var/obj/item/spacepod_equipment/spacepod_equipment = equipment_to_detach
		if(!spacepod_equipment.can_uninstall(src, user, forced))
			return FALSE

		equipment[spacepod_equipment.slot] -= spacepod_equipment

		spacepod_equipment.on_uninstall(src, forced)

	if(cell == equipment_to_detach)
		cell = null

	if(internal_tank == equipment_to_detach)
		internal_tank = null

	equipment_to_detach.forceMove(get_turf(src))

	if(user && isitem(equipment_to_detach))
		user.put_in_hands(equipment_to_detach)

	return TRUE

/obj/spacepod/proc/check_has_equipment(type_to_check)
	var/list/equipment_list = get_all_equipment()

	for(var/thing in equipment_list)
		if(istype(thing, type_to_check))
			return TRUE

	return FALSE

// ARMOR PROCS

/**
 * Add Armor
 *
 * Adds armor to the spacepod and updates it accordingly.
 */
/obj/spacepod/proc/add_armor(obj/item/pod_parts/armor/armor)
	desc = armor.pod_desc
	equipment_slot_limits = armor.equipment_slot_limits
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
	equipment_slot_limits = SPACEPOD_DEFAULT_EQUIPMENT_LIMITS_LIST
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
	if(check_occupant(source.mob) != SPACEPOD_RIDER_TYPE_PILOT)
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
