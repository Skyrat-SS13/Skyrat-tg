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

	if(LAZYLEN(equipment))
		data["has_equipment"] = TRUE
		data["equipment"] = list()
		for(var/obj/item/spacepod_equipment/spacepod_equipment as anything in get_all_equipment())
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
			detach_equipment(equipment_to_remove, usr)
		if("mute_alarm")
			mute_alarm(usr)
		if("switch_weapon_slot")
			set_active_weapon_slot(params["selected_slot"], usr)

// LEGACY CONTROL - Important that this works at all times as we don't want to brick people.
/obj/spacepod/proc/verb_check(require_pilot = TRUE, mob/user = null)
	if(!user)
		user = usr
	if(require_pilot && user != pilot)
		to_chat(user, span_notice("You can't reach the controls from your chair"))
		return FALSE
	return !user.incapacitated() && isliving(user)
