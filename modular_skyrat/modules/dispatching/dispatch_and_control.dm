/datum/action/item_action/dispatch_management
	name = "Dispatch and Control"
	button_icon_state = "round_end"
	var/dispatch_type
	var/current_filter = "Nothing"

/obj/item/radio/headset/Initialize()
	. = ..()
	new /datum/action/item_action/dispatch_management(src)

/datum/action/item_action/dispatch_management/Trigger()
	var/mob/user = usr
	if(!istype(user))
		return
	if(!SSdispatch.ui_data_by_mob[user] || !SSdispatch.ui_data_by_mob[user]["mdata"]["holderActive"])
		to_chat(user, span_boldwarning("You must be Active to sign into Dispatch and Control!"))
		return
	dispatch_type = SSdispatch.ui_data_by_mob[user]["mdata"]["holderActiveType"]
	if(SSdispatch.dispatch_online[dispatch_type] && SSdispatch.dispatch_online[dispatch_type] != src)
		to_chat(user, span_boldwarning("Dispatch for '[dispatch_type]' already active!"))
		return
	SSdispatch.dispatch_online[dispatch_type] = src
	ui_interact(user)

/datum/action/item_action/dispatch_management/proc/get_all_holder_statuses()
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

/datum/action/item_action/dispatch_management/proc/ui_data_holder_list()
	. = list()
	for(var/holder in get_all_holder_statuses())
		. += REF(holder)

/datum/action/item_action/dispatch_management/proc/ui_data_holder_status()
	var/list/data = get_all_holder_statuses()
	. = list()
	for(var/mob/living/carbon/human/holder as anything in data)
		.[REF(holder)] = "[data[holder]]"

/datum/action/item_action/dispatch_management/proc/ui_data_holder_ref_table()
	var/list/data = get_all_holder_statuses()
	. = list()
	for(var/mob/living/carbon/human/holder as anything in data)
		.[REF(holder)] = "[holder.real_name]"

/datum/action/item_action/dispatch_management/proc/ui_data_holder_activity()
	. = list()
	for(var/holder in get_all_holder_statuses())
		.[REF(holder)] = SSdispatch.ui_data_by_mob[holder]["mdata"]["holderActive"]

/datum/action/item_action/dispatch_management/proc/ui_data_holder_current_ticket()
	. = list()
	for(var/holder in get_all_holder_statuses())
		if(SSdispatch.ui_data_by_mob[holder])
			.[REF(holder)] = SSdispatch.ui_data_by_mob[holder]["mdata"]["ticketActive"]
		else
			.[REF(holder)] = "None"

/datum/action/item_action/dispatch_management/proc/ui_data_holder_locs()
	var/list/data = get_all_holder_statuses()
	. = list()
	for(var/holder in data)
		if(data[holder] == SENSOR_COORDS)
			.[REF(holder)] = "[get_area(holder)]"

/datum/action/item_action/dispatch_management/proc/ui_data_tickets()
	. = list()
	for(var/ticket_key in SSdispatch.tickets)
		var/datum/dispatch_ticket/ticket = SSdispatch.tickets[ticket_key]
		if(ticket.ticket_type != dispatch_type)
			continue

		if(current_filter == "Nothing")
			. += ticket
			continue

		if(findtext(current_filter, "Status=") == 1) // Looking for it being the very first text
			var/wanted = splittext(current_filter, "=")[2]
			if(ticket.status == wanted)
				. += ticket
			continue

		if(findtext(current_filter, "Priority=") == 1)
			var/wanted = splittext(current_filter, "=")[2]
			if(ticket.priority == wanted)
				. += ticket
			continue

/datum/action/item_action/dispatch_management/proc/ui_data_ticket_list()
	. = list()
	for(var/datum/dispatch_ticket/ticket as anything in ui_data_tickets())
		. += ticket.key

/datum/action/item_action/dispatch_management/proc/ui_data_ticket_status()
	. = list()
	for(var/datum/dispatch_ticket/ticket as anything in ui_data_tickets())
		.[ticket.key] = "[ticket.status]"

/datum/action/item_action/dispatch_management/proc/ui_data_ticket_priority()
	. = list()
	for(var/datum/dispatch_ticket/ticket as anything in ui_data_tickets())
		.[ticket.key] = "[ticket.priority]"

/datum/action/item_action/dispatch_management/proc/ui_data_ticket_location()
	. = list()
	for(var/datum/dispatch_ticket/ticket as anything in ui_data_tickets())
		.[ticket.key] = "[ticket.location]"

/datum/action/item_action/dispatch_management/proc/ui_data_ticket_title()
	. = list()
	for(var/datum/dispatch_ticket/ticket as anything in ui_data_tickets())
		.[ticket.key] = "[ticket.title]"

/datum/action/item_action/dispatch_management/ui_status(mob/user, datum/ui_state/state)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/user_h = user
	return istype(user_h.ears, /obj/item/radio/headset) ? UI_INTERACTIVE : UI_CLOSE

/datum/action/item_action/dispatch_management/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DispatchConsole")
		ui.autoupdate = TRUE
		ui.open()

/datum/action/item_action/dispatch_management/ui_data(mob/user)
	var/list/data = list()
	data["self_ref"] = REF(user)
	data["filterby"] = current_filter
	data["holder"] = list(
		"list" = ui_data_holder_list(),
		"lookup" = ui_data_holder_ref_table(),
		"status" = ui_data_holder_status(),
		"activity" = ui_data_holder_activity(),
		"ticket" = ui_data_holder_current_ticket(),
		"location" = ui_data_holder_locs(),
	)
	data["ticket"] = list(
		"list" = ui_data_ticket_list(),
		"status" = ui_data_ticket_status(),
		"priority" = ui_data_ticket_priority(),
		"title" = ui_data_ticket_title(),
		"location" = ui_data_ticket_location(),
	)
	return data

/datum/action/item_action/dispatch_management/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/human/user = locate(params["self_ref"])
	var/mob/living/carbon/human/holder = params["holder_ref"] ? locate(params["holder_ref"]) : null
	if(!istype(user))
		CRASH("invalid self_ref. Must be a human reference")

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

		if("ticket-filter")
			if(current_filter != "Nothing")
				current_filter = "Nothing"
				return TRUE
			var/bywhat = tgui_alert(user, "What do you want to filter by", "Filter Menu", list("Status", "Priority", "CANCEL"))
			var/list/possible_values
			switch(bywhat)
				if("CANCEL")
					return FALSE
				if("Status")
					possible_values = SSDISPATCH_TICKET_STATUSES
				if("Priority")
					possible_values = SSDISPATCH_TICKET_PRIORITIES
			possible_values += "CANCEL"
			var/towhat = tgui_alert(user, "What [bywhat] do you want to look for", "Filter Menu", possible_values)
			if(towhat == "CANCEL")
				return TRUE
			current_filter = "[bywhat]=[towhat]"
			return TRUE

		if("ticket-status")
			var/newstatus = tgui_input_list(user, "What is the new Status", "Status Menu", SSDISPATCH_TICKET_STATUSES)
			if(!newstatus)
				return TRUE
			SSdispatch.tickets[params["ticket"]].status = newstatus
			return TRUE

		if("ticket-priority")
			var/newprio = tgui_input_list(user, "What is the new Priority", "Priority Menu", SSDISPATCH_TICKET_PRIORITIES)
			if(!newprio)
				return TRUE
			SSdispatch.tickets[params["ticket"]].priority = newprio
			return TRUE

		if("ticket-details")
			SSdispatch.ui_data_by_mob[user]["mdata"]["ticketActive"] = params["ticket"]
			var/datum/dispatch_ticket/ticket_i = SSdispatch.tickets[params["ticket"]]
			SSdispatch.load_ticket_data_into_mdata(user, ticket_i)
			SSdispatch.ui_interact(user, null, "ticket-manage")
			return TRUE
