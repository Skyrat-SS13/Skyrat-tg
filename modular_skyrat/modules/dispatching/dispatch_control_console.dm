/obj/machinery/dispatch_control
	name = "Dispatch and Control Console"
	icon = 'icons/obj/computer.dmi' //TODO: TEMP ICON
	icon_state = "computer" //TODO: TEMP ICON
	use_power = NO_POWER_USE
	idle_power_usage = 200
	active_power_usage = 2000
	var/mob/current_user
	var/dispatch_type

/obj/machinery/dispatch_control/attack_hand(mob/living/user, list/modifiers)
	if(RIGHT_CLICK in modifiers)
		if(use_power == ACTIVE_POWER_USE)
			console_shutdown()
		return

	if(!SSdispatch.ui_data_by_mob[user] || !SSdispatch.ui_data_by_mob[user]["mdata"]["holderActive"])
		to_chat(user, span_boldwarning("You must be Active to use the console!"))
		return

	if(use_power == ACTIVE_POWER_USE)
		if(current_user && user != current_user)
			message_viewers("New user detected. Resetting Console.")
			current_user = null
			SStgui.close_uis(src)
			return

		current_user = user
		dispatch_type = SSdispatch.ui_data_by_mob[user]["mdata"]["holderActiveType"]
		if(!SSdispatch.dispatch_online[dispatch_type])
			SSdispatch.dispatch_online[dispatch_type] = src

		current_user = user
		ui_interact(user)
		return

	if(use_power == NO_POWER_USE && directly_use_power(active_power_usage))
		console_bootup()
		return

/obj/machinery/dispatch_control/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_MACHINERY_POWER_LOST, .proc/console_shutdown)

/obj/machinery/dispatch_control/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MACHINERY_POWER_LOST)
	if(SSdispatch.dispatch_online == src)
		SSdispatch.dispatch_online = null

/obj/machinery/dispatch_control/proc/state_change(state)
	// icon_state = initial(icon_state) + "_[state]"
	update_icon()

/obj/machinery/dispatch_control/proc/message_viewers(message)
	if(use_power == NO_POWER_USE)
		return
	for(var/mob/mob in viewers(world.view, src))
		balloon_alert(mob, message)

/obj/machinery/dispatch_control/proc/console_poweron()
	use_power = ACTIVE_POWER_USE
	state_change("on")
	message_viewers("Welcome to Dispatch and Control V1.5")
	SSdispatch.message_type_holders(dispatch_type, "Dispatch Online")

/obj/machinery/dispatch_control/proc/console_bootup(stage = STAGE_ONE)
	if(stage != STAGE_ONE && use_power == NO_POWER_USE) // We were shutdown in the middle of bootup
		audible_message("makes a loud screeching sound as it's internal transmitter array jerks to a stop")
		return

	use_power = IDLE_POWER_USE
	state_change("boot[stage]")

	switch(stage)
		if(STAGE_ONE)
			message_viewers("Connecting to Database...")
			addtimer(CALLBACK(src, .proc/console_bootup, STAGE_TWO), 0.5 SECONDS)

		if(STAGE_TWO)
			if(SSdispatch.dispatch_online[dispatch_type] && SSdispatch.dispatch_online[dispatch_type] != src)
				message_viewers("Database reports '[dispatch_type]' Dispatch already active")
				console_shutdown()
				return

			message_viewers("Requesting Data...")
			addtimer(CALLBACK(src, .proc/console_bootup, STAGE_THREE), 0.5 SECONDS)

		if(STAGE_THREE)
			message_viewers("Recieving Data...")
			addtimer(CALLBACK(src, .proc/console_bootup, STAGE_FOUR), 0.5 SECONDS)

		if(STAGE_FOUR)
			message_viewers("Preparing...")
			addtimer(CALLBACK(src, .proc/console_poweron), 0.5 SECONDS)

/obj/machinery/dispatch_control/proc/console_shutdown()
	SIGNAL_HANDLER

	if(use_power == NO_POWER_USE) // Already shutdown
		return

	if(SSdispatch.dispatch_online[dispatch_type] == src)
		SSdispatch.dispatch_online[dispatch_type] = null
		SSdispatch.message_type_holders(dispatch_type, "Dispatch Offline")

	current_user = null

	message_viewers("Shuting Down...")
	use_power = NO_POWER_USE
	state_change("off")

/obj/machinery/dispatch_control/proc/get_all_holder_statuses()
	var/list/mob/holders = list()
	for(var/mob/holder as anything in SSdispatch.job_type_holders[dispatch_type])
		holders |= holder
	var/list/holder_status = list()
	for(var/mob/living/carbon/human/holder as anything in holders)
		var/obj/item/clothing/under/uniform = holder.w_uniform
		if(!istype(uniform))
			holder_status[holder] = SENSOR_OFF
			continue
		holder_status[holder] = uniform.sensor_mode
	return holder_status

/obj/machinery/dispatch_control/proc/ui_data_holder_list()
	. = list()
	for(var/holder in get_all_holder_statuses())
		. += REF(holder)

/obj/machinery/dispatch_control/proc/ui_data_holder_status()
	var/list/data = get_all_holder_statuses()
	. = list()
	for(var/mob/living/carbon/human/holder as anything in data)
		.[REF(holder)] = "[data[holder]]"

/obj/machinery/dispatch_control/proc/ui_data_holder_ref_table()
	var/list/data = get_all_holder_statuses()
	. = list()
	for(var/mob/living/carbon/human/holder as anything in data)
		.[REF(holder)] = "[holder.real_name]"

/obj/machinery/dispatch_control/proc/ui_data_holder_activity()
	. = list()
	for(var/holder in get_all_holder_statuses())
		.[REF(holder)] = SSdispatch.ui_data_by_mob[holder]["mdata"]["holderActive"]

/obj/machinery/dispatch_control/proc/ui_data_holder_current_ticket()
	. = list()
	for(var/holder in get_all_holder_statuses())
		if(SSdispatch.ui_data_by_mob[holder])
			.[REF(holder)] = SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketActive"]
		else
			.[REF(holder)] = "None"

/obj/machinery/dispatch_control/proc/ui_data_holder_locs()
	var/list/data = get_all_holder_statuses()
	. = list()
	for(var/holder in data)
		if(data[holder] == SENSOR_COORDS)
			.[REF(holder)] = "[get_area(holder)]"

/obj/machinery/dispatch_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DispatchConsole")
		ui.autoupdate = TRUE
		ui.open()

/obj/machinery/dispatch_control/ui_data(mob/user)
	var/list/data = list()
	data["self_ref"] = REF(user)
	data["holder"] = list(
		"list" = ui_data_holder_list(),
		"lookup" = ui_data_holder_ref_table(),
		"status" = ui_data_holder_status(),
		"activity" = ui_data_holder_activity(),
		"ticket" = ui_data_holder_current_ticket(),
		"location" = ui_data_holder_locs(),
	)
	return data

/obj/machinery/dispatch_control/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/human/user = locate(params["self_ref"])
	var/mob/living/carbon/human/holder = params["holder_ref"] ? locate(params["holder_ref"]) : null
	if(!istype(user))
		CRASH("invalid self_ref. must be a human reference")

	switch(action)
		if("refresh")
			SSdispatch.holder_update()
			return TRUE

		if("assign-ticket")
			var/list/valid_tickets = SSdispatch.get_ticket_list_for_type(SSdispatch.ui_data_by_mob[holder]["mdata"]["holderActiveType"])
			if(!valid_tickets.len)
				tgui_alert(user, "No Tickets Available", "Notice", list("Ok"))
				return
			var/resp = tgui_input_list(user, "Select Ticket", "Assign Ticket", valid_tickets)
			if(tgui_alert(user, "Are you sure you want to assign '[resp]' to '[holder]'?", "Confirmation", list("Yes", "No")) != "Yes")
				return TRUE
			SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketActive"] = resp
			var/datum/dispatch_ticket/ticket_i = SSdispatch.tickets[resp]
			ticket_i.handle(holder)
			SSdispatch.load_ticket_data_into_mdata(holder, ticket_i)
			SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketData"]["handler"] = "[ticket_i.handler]"
			SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketData"]["status"] = ticket_i.status
			SSdispatch.ui_data_by_mob[holder]["ticket"] = ticket_i
			holder.balloon_alert(holder, "You have been assigned a ticket. Open your ticket browser.")
			return TRUE

		if("eject-ticket")
			if(tgui_alert(user, "Are you sure you want to remove '[holder]' from their active ticket?", "Confirmation", list("Yes", "No")) != "Yes")
				return
			var/ticket = SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketActive"]
			var/datum/dispatch_ticket/ticket_i = SSdispatch.tickets[ticket]
			ticket_i.message_creator("Your ticket has been cleared. Please wait for a new handler.")
			ticket_i.handle(null)
			ticket_i.status = SSDISPATCH_TICKET_STATUS_OPEN
			SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketActive"] = "None"
			return TRUE

