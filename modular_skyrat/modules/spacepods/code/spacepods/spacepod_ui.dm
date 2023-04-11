// UI CONTROL

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

	if(!isliving(usr))
		return
	var/mob/living/user = usr
	if(check_occupant(user) != SPACEPOD_RIDER_TYPE_PILOT)
		to_chat(user, span_warning("You are not in a pod."))
		return
	else if(user.incapacitated())
		to_chat(user, span_warning("You are incapacitated."))
	else
		ui_interact(user)

/obj/spacepod/proc/check_interact(mob/living/user, require_pilot = TRUE)
	if(require_pilot && check_occupant(user) != SPACEPOD_RIDER_TYPE_PILOT)
		to_chat(user, span_notice("You can't reach the controls from your chair"))
		return FALSE
	return !user.incapacitated() && isliving(user) && user.loc == src


/obj/spacepod/ui_interact(mob/user, datum/tgui/ui)
	if(check_occupant(user) != SPACEPOD_RIDER_TYPE_PILOT)
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

	data["has_pilots"] = FALSE
	var/list/pilots = get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PILOT)
	if(LAZYLEN(pilots))
		data["pilots"] = list()
		for(var/mob/iterating_mob as anything in pilots)
			data["pilots"] += list(list(
				"name" = uppertext(iterating_mob.name),
				"ref" = REF(iterating_mob),
			))
		data["has_passengers"] = TRUE

	data["has_passengers"] = FALSE
	var/list/passengers = get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PASSENGER)
	if(LAZYLEN(passengers))
		data["passengers"] = list()
		for(var/mob/iterating_mob as anything in passengers)
			data["passengers"] += list(list(
				"name" = uppertext(iterating_mob.name),
				"ref" = REF(iterating_mob),
			))
		data["has_passengers"] = TRUE


	data["integrity"] = round(get_integrity(), 0.1)
	data["max_integrity"] = max_integrity

	data["velocity"] = round(sqrt(component_velocity_x * component_velocity_x + component_velocity_y * component_velocity_y), 0.1)

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

	data["has_weapons"] = FALSE
	data["weapons"] = list()

	data["selected_weapon_slot"] = active_weapon_slot

	if(LAZYLEN(weapon_slots))
		data["has_weapons"] = TRUE
		for(var/slot in weapon_slots)
			var/obj/item/spacepod_equipment/weaponry/weapon_in_slot = get_weapon_in_slot(slot)
			if(!weapon_in_slot)
				data["weapons"] += list(list(
					"type" = "empty",
					"desc" = "empty",
					"slot" = slot,
				))
				continue
			data["weapons"] += list(list(
				"type" = capitalize(weapon_in_slot.name),
				"desc" = weapon_in_slot.desc,
				"slot" = slot,
			))

	data["has_equipment"] = FALSE
	if(LAZYLEN(equipment))
		data["has_equipment"] = TRUE
		data["equipment"] = list()
		for(var/obj/item/spacepod_equipment/spacepod_equipment as anything in get_all_equipment())
			data["equipment"] += list(list(
				"name" = uppertext(spacepod_equipment.name),
				"desc" = spacepod_equipment.desc,
				"slot" = capitalize(spacepod_equipment.slot) + " Slot",
				"can_uninstall" = spacepod_equipment.can_uninstall(src),
				"ref" = REF(spacepod_equipment),
			))

	data["has_bays"] = FALSE
	if(LAZYLEN(cargo_bays))
		data["has_bays"] = TRUE
		data["cargo_bays"] = list()
		for(var/obj/item/spacepod_equipment/cargo/large/cargo_bay as anything in cargo_bays)
			data["cargo_bays"] += list(list(
				"name" = uppertext(cargo_bay.name),
				"ref" = REF(cargo_bay),
				"storage" = cargo_bay.storage ? cargo_bay.storage.name : "none",
			))

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
			detach_equipment(equipment_to_remove, usr)
		if("mute_alarm")
			mute_alarm(usr)
		if("switch_weapon_slot")
			set_active_weapon_slot(params["selected_slot"], usr)
		if("eject_passenger")
			var/mob/living/passenger_to_eject = locate(params["passenger_ref"]) in src
			if(remove_rider(passenger_to_eject))
				to_chat(usr, span_notice("Passenger ejected!"))
			else
				to_chat(usr, span_warning("Unable to eject!"))

// LEGACY CONTROL - Important that this works at all times as we don't want to brick people.
/obj/spacepod/proc/verb_check(require_pilot = TRUE, mob/user = null)
	if(!user)
		user = usr
	if(require_pilot && check_occupant(user) != SPACEPOD_RIDER_TYPE_PILOT)
		to_chat(user, span_notice("You can't reach the controls from your chair"))
		return FALSE
	return !user.incapacitated() && isliving(user)
