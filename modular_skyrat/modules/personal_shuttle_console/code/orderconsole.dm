/obj/item/circuitboard/computer/personal_shuttle_order
	name = "Supply Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/personal_shuttle_order

/obj/machinery/computer/personal_shuttle_order
	name = "personal shuttle order console"
	desc = "A console giving you access to only the sleaziest of shuttle sales services. \
		Allows you to spend your hard earned money on ships of questionable quality. \
		This one should link to the station's auxilary shuttle dock, and will not \
		if it is too far away to link to it."
	icon_screen = "supply"
	circuit = /obj/item/circuitboard/computer/personal_shuttle_order
	light_color = COLOR_BRIGHT_ORANGE

	/// Are we currently spawning a shuttle? Prevents multiple shuttles trying to spawn and land on each other at once
	var/spawning_shuttle = FALSE
	/// The ID of the stationary docking port we look for to link up with
	var/docking_port_id = "whiteship_home"
	/// Reference to the docking port we should send ships to
	var/obj/docking_port/stationary/our_docking_port
	/// How far away we should check for the docking port?
	var/docking_port_check_distance = 10
	/// The types of shuttle templates we can sell from here
	var/list/valid_shuttle_templates = list(
		/datum/map_template/shuttle/personal_buyable/ferries,
	)
	/// List of the subtypes for map templates we can buy, DO NOT SET DIRECTLY, USE VALID SHUTTLE TEMPLATES FOR DIFFERENT SELECTIONS
	var/list/valid_shuttle_templates_subtypes = list()
	/// The currently selected shuttle map template
	var/datum/map_template/shuttle/personal_buyable/selected

/obj/machinery/computer/personal_shuttle_order/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/payment, 0, SSeconomy.get_dep_account(ACCOUNT_CMD), PAYMENT_CLINICAL)
	try_and_find_a_dock()
	if(length(valid_shuttle_templates && !length(valid_shuttle_templates_subtypes)))
		for(var/datum/template in valid_shuttle_templates)
			valid_shuttle_templates_subtypes += subtypesof(template)

/// Asks SSshuttle if our set docking port id is around and in range
/obj/machinery/computer/personal_shuttle_order/proc/try_and_find_a_dock()
	if(our_docking_port)
		return
	var/obj/docking_port/stationary/potential_port = SSshuttle.getDock(docking_port_id)
	if(!potential_port || (get_dist(src, potential_port) > docking_port_check_distance))
		balloon_alert_to_viewers("no suitable dock in range")
		return
	our_docking_port = potential_port

/obj/machinery/computer/personal_shuttle_order/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(!our_docking_port)
		balloon_alert_to_viewers("no linked docking port")
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PersonalShuttlePurchase", name)
		ui.open()

/obj/machinery/computer/personal_shuttle_order/ui_data(mob/user)
	var/list/data = list()
	data["tabs"] = list("Catalouge", "Information")

	// Templates panel
	data["templates"] = list()
	var/list/templates = data["templates"]
	data["templates_tabs"] = list()
	data["selected"] = list()

	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/personal_buyable/shuttle_template = SSmapping.shuttle_templates[shuttle_id]
		if(!istype(shuttle_template) || !is_type_in_list(shuttle_template, valid_shuttle_templates_subtypes))
			continue

		if(!templates[shuttle_template.port_id])
			data["templates_tabs"] += shuttle_template.port_id
			templates[shuttle_template.port_id] = list(
				"port_id" = shuttle_template.port_id,
				"templates" = list())

		var/list/L = list()
		L["name"] = shuttle_template.name
		L["shuttle_id"] = shuttle_template.shuttle_id
		L["port_id"] = shuttle_template.port_id
		L["description"] = shuttle_template.description
		L["cost"] = shuttle_template.credit_cost

		if(selected == shuttle_template)
			data["selected"] = L

		templates[shuttle_template.port_id]["templates"] += list(L)

	data["templates_tabs"] = sort_list(data["templates_tabs"])

	return data

/obj/machinery/computer/personal_shuttle_order/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = usr

	// Preload some common parameters
	var/shuttle_id = params["shuttle_id"]
	var/datum/map_template/shuttle/personal_buyable/selected_template = SSmapping.shuttle_templates[shuttle_id]

	switch(action)
		if("select_template")
			if(selected_template)
				selected = selected_template
				. = TRUE
		if("purchase_shuttle")
			if(!our_docking_port)
				balloon_alert_to_viewers("no linked docking port")
				return
			if(our_docking_port.get_docked())
				balloon_alert_to_viewers("docking port blocked")
				return
			if(spawning_shuttle)
				balloon_alert_to_viewers("shuttle en route")
				return
			if(attempt_charge(src, user, selected_template.credit_cost) & COMPONENT_OBJ_CANCEL_CHARGE)
				return
			. = TRUE
			spawning_shuttle = TRUE
			// If successful, returns the mobile docking port
			var/obj/docking_port/mobile/loaded_port = SSshuttle.action_load(selected_template, our_docking_port, FALSE)
			if(loaded_port)
				message_admins("[user] loaded [loaded_port] with a shuttle order console.")
			spawning_shuttle = FALSE
			return
