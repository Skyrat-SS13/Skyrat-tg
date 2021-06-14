#define SSDISPATCH_TICKET_TYPE_SECURITY "Security"
#define SSDISPATCH_TICKET_TYPE_ENGINEERING "Engineering"
#define SSDISPATCH_TICKET_TYPE_MEDICAL "Medical"
#define SSDISPATCH_TICKET_TYPES list( \
	SSDISPATCH_TICKET_TYPE_SECURITY,\
	SSDISPATCH_TICKET_TYPE_ENGINEERING,\
	SSDISPATCH_TICKET_TYPE_MEDICAL)
#define SSDISPATCH_TICKET_TYPES_DEPT list( \
	SSDISPATCH_TICKET_TYPE_SECURITY = DEPARTMENT_SECURITY,\
	SSDISPATCH_TICKET_TYPE_MEDICAL = DEPARTMENT_MEDICAL,\
	SSDISPATCH_TICKET_TYPE_ENGINEERING = DEPARTMENT_ENGINEERING)

#define SSDISPATCH_TICKET_PRIORITY_MINIMAL "Minimal"
#define SSDISPATCH_TICKET_PRIORITY_LOW "Low"
#define SSDISPATCH_TICKET_PRIORITY_NORMAL "Normal"
#define SSDISPATCH_TICKET_PRIORITY_HIGH "High"
#define SSDISPATCH_TICKET_PRIORITY_CRITICAL "Critical"
#define SSDISPATCH_TICKET_PRIORITIES list( \
	SSDISPATCH_TICKET_PRIORITY_MINIMAL,\
	SSDISPATCH_TICKET_PRIORITY_LOW,\
	SSDISPATCH_TICKET_PRIORITY_NORMAL,\
	SSDISPATCH_TICKET_PRIORITY_HIGH,\
	SSDISPATCH_TICKET_PRIORITY_CRITICAL)

#define SSDISPATCH_TICKET_STATUS_OPEN "Open"
#define SSDISPATCH_TICKET_STATUS_RESOLVED "Resolved"
#define SSDISPATCH_TICKET_STATUS_REJECTED "Rejected"
#define SSDISPATCH_TICKET_STATUS_ACTIVE "Active"
#define SSDISPATCH_TICKET_STATUSES list( \
	SSDISPATCH_TICKET_STATUS_OPEN,\
	SSDISPATCH_TICKET_STATUS_RESOLVED,\
	SSDISPATCH_TICKET_STATUS_REJECTED,\
	SSDISPATCH_TICKET_STATUS_ACTIVE)

SUBSYSTEM_DEF(dispatch)
	name = "Dispatch"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_JOBS - 1 // SHOULD ALWAYS BE RIGHT AFTER JOBS
	///Stores an assosciative list of what job is allowed to claim/respond to tickets
	var/list/job_cache_roles
	var/list/job_cache_holder

	var/list/job_type_holders
	var/list/type_holders_active
	var/list/datum/dispatch_ticket/tickets
	var/list/datum/dispatch_ticket_template/templates

	var/list/ui_data_by_mob

/datum/controller/subsystem/dispatch/Initialize()
	. = ..()
	load_job_cache()
	holder_update()
	tickets = list()
	ui_data_by_mob = list()
	templates = load_template_instances()

///Creates and stores an instance of every template type; given its not abstract
/datum/controller/subsystem/dispatch/proc/load_template_instances()
	var/list/datum/dispatch_ticket_template/temps = list()
	for(var/stype in subtypesof(/datum/dispatch_ticket_template))
		var/datum/dispatch_ticket_template/template = stype
		if(initial(template.abstract) == stype)
			continue
		temps[initial(template.name)] = new template()
	return temps

/datum/controller/subsystem/dispatch/proc/apply_template(mob/user, datum/dispatch_ticket_template/template)
	ui_data_by_mob[user]["tdata"]["title"] = template.title
	ui_data_by_mob[user]["tdata"]["extra"] = template.extra
	ui_data_by_mob[user]["tdata"]["type"] = template.template_type
	ui_data_by_mob[user]["tdata"]["priority"] = template.template_priority_default
	ui_data_by_mob[user]["tdata"]["templateName"] = template.name

///Interates through all loaded jobs and assigns them to one or more type caches
/datum/controller/subsystem/dispatch/proc/load_job_cache()
	job_cache_roles = list()
	job_cache_holder = list()
	for(var/job in SSjob.occupations)
		if(job in job_cache_roles)
			continue
		var/list/roles = list()
		var/datum/job/job_real = job
		for(var/ttype in SSDISPATCH_TICKET_TYPES)
			if(job_real.departments & SSDISPATCH_TICKET_TYPES_DEPT[ttype])
				roles += ttype
		job_cache_roles[job_real.title] = roles
		job_cache_holder[job_real.title] = list()

///Iterates through all joined players and assigns them to their jobs holder cache
/datum/controller/subsystem/dispatch/proc/load_job_holders()
	if(!job_cache_roles)
		CRASH("load_job_holders called before job_cache_roles initialized!")

	for(var/job in job_cache_holder)
		job_cache_holder[job] = list()

	for(var/key in GLOB.joined_player_list)
		var/mob/key_mob = get_mob_by_ckey(key)
		if(!key_mob) continue
		if(!ishuman(key_mob)) continue
		if(key_mob.job in job_cache_holder)
			job_cache_holder[key_mob.job] += key_mob

///Iterates through all job caches and all their holders and assigns them to all applicable type holders
/datum/controller/subsystem/dispatch/proc/load_type_holders()
	if(!job_cache_holder)
		CRASH("load_type_holders called before load_job_holders!")

	job_type_holders = list()
	for(var/ttype in SSDISPATCH_TICKET_TYPES)
		job_type_holders[ttype] = list()

	//HOLY FUCK THIS IS UGLY; IF SOMETHING DOESNT WORK CHECK THIS SHIT FIRST
	for(var/job in job_cache_holder)
		for(var/mob in job_cache_holder[job])
			for(var/ttype in SSDISPATCH_TICKET_TYPES)
				if(ttype in job_cache_roles[job])
					job_type_holders[ttype] += mob

/// TODO AUTODOC
/datum/controller/subsystem/dispatch/proc/message_type_holders(ticket_type, message, ignore_active=FALSE)
	for(var/mob/mob in job_type_holders[ticket_type])
		if((ui_data_by_mob[mob] && ui_data_by_mob[mob]["mdata"]["holderActive"]) || ignore_active)
			message_holder(mob, message)

/// TODO AUTODOC
/datum/controller/subsystem/dispatch/proc/ticket_create(mob/user, list/tdata)
	holder_update()
	var/datum/dispatch_ticket/ticket = new(user, tdata)
	var/key = "[ticket.title]-[ticket.creator]-[uppertext(random_string(4, GLOB.hex_characters))]"
	tickets[key] = ticket
	ticket.key = key
	var/msg = "Open your Ticket Queue! [ticket.priority] Priority Ticket submitted!"
	message_type_holders(ticket.ticket_type, msg, ticket.priority == SSDISPATCH_TICKET_PRIORITY_CRITICAL)

/datum/controller/subsystem/dispatch/proc/message_holder(mob/holder, message, balloon = TRUE)
	if(!holder || !message)
		return

	if(balloon)
		holder.balloon_alert(holder, message)

	to_chat(holder, "<span class='notice'>[message]</span>")

/// TODO AUTODOC(? should never be called externally)
/datum/controller/subsystem/dispatch/proc/holder_update()
	load_job_holders()
	load_type_holders()

/datum/controller/subsystem/dispatch/ui_status(mob/user, datum/ui_state/state)
	if(!ishuman(user)) return UI_CLOSE
	if(ui_data_by_mob[user] && ui_data_by_mob[user]["should_close"])
		ui_data_by_mob[user]["should_close"] = FALSE
		return UI_CLOSE
	var/mob/living/carbon/human/user_human = user
	if(!user_human.ears || !istype(user_human.ears, /obj/item/radio/headset)) return UI_CLOSE
	if(user_human.canUseTopic(user_human.ears, be_close = TRUE, no_tk = NO_TK, need_hands = TRUE))
		return UI_INTERACTIVE
	return UI_DISABLED

/datum/controller/subsystem/dispatch/ui_interact(mob/user, datum/tgui/ui_o, type)
	if(!ui_data_by_mob[user])
		ui_data_by_mob[user] = list(
			"ui-tnew" = null,
			"ui-tmanage" = null,
			"should_close" = FALSE,
			"tdata" = list("should_clear" = TRUE), // Set to TRUE to force initilization of tdata; this is hacky TODO MAKE THIS A PROC
			"mdata" = list("should_clear" = TRUE),
		)

	if(ui_data_by_mob[user]["tdata"]["should_clear"])
		ui_data_by_mob[user]["tdata"] = list(
				"creator" = "",
				"creator-spoofed" = FALSE,
				"priority" = "",
				"type" = "",
				"location" = "",
				"location-spoofed" = FALSE,
				"templateName" = "None",
				"templateUse" = FALSE,
				"title" = "",
				"extra" = "",
				"should_clear" = FALSE)

	if(ui_data_by_mob[user]["mdata"]["should_clear"])
		if(!ui_data_by_mob[user]["ticket"])
			ui_data_by_mob[user]["mdata"] = list(
				"holderName" = "[user]",
				"holderActive" = FALSE,
				"holderActiveType" = "",
				"holderClocked" = FALSE,
				"should_clear" = FALSE,
				"ticketActive" = "None",
				"ticketData" = list())
		else load_ticket_data_into_mdata(user, tickets[ui_data_by_mob[user]["ticket"]])

	if(!type && ui_o)
		SStgui.try_update_ui(user, src, ui_o)
		return

	if(type == "ticket-new")
		var/datum/tgui/ui = SStgui.try_update_ui(user, src, ui_data_by_mob["ui-tnew"])
		if(!ui)
			ui = new(user, src, "DispatchTicket")
			ui.autoupdate = FALSE
			ui.open()
		ui_data_by_mob[user]["ui-tnew"] = ui
		return

	if(type == "ticket-manage")
		var/datum/tgui/ui = SStgui.try_update_ui(user, src, ui_data_by_mob["ui-tmanage"])
		if(!ui)
			ui = new(user, src, "TicketBrowser")
			ui.autoupdate = FALSE
			ui.open()
		ui_data_by_mob[user]["ui-tmanage"] = ui
		return

#ifdef DEBUG // HEY IDIOT DONT FORGET TO REMOVE THIS SHIT BEFORE MAKING THE PR. YES YOU. TODO TODO TODO
/proc/p_list(list/list, recurse_level = 0)
	if(!recurse_level)
		p_str("Printing List '[list]'")
	for(var/item in list)
		var/pre = repeat_string(recurse_level, "-")
		if(list[item])
			p_str("[pre][list[item]]")
		else
			p_str("[pre][item]")
		if(islist(item))
			p_list(item, recurse_level + 1)

/proc/p_str(str)
	world.log << "DEBUG: [str]"
#endif

/datum/controller/subsystem/dispatch/ui_data(mob/user)
	var/list/data = list(
		"priorities" = SSDISPATCH_TICKET_PRIORITIES,
		"types" = SSDISPATCH_TICKET_TYPES,
		"self_ref" = REF(user),
		"submit_allow" = ui_data_by_mob[user]["tdata"]["type"] != "" && ui_data_by_mob[user]["tdata"]["priority"] != "",
		"tdata" = ui_data_by_mob[user]["tdata"],
		"mdata" = ui_data_by_mob[user]["mdata"],
		"emagged" = FALSE,
	)
	if(ishuman(user))
		var/mob/living/carbon/human/user_h = user
		data["emagged"] = user_h.ears.obj_flags & EMAGGED
	return data

/datum/controller/subsystem/dispatch/proc/get_holder_roles(mob/user)
	holder_update()
	var/list/ret = list()
	for(var/ttype in SSDISPATCH_TICKET_TYPES)
		if(user in job_type_holders[ttype])
			ret += ttype
	return ret

/datum/controller/subsystem/dispatch/proc/get_ticket_list_for_type(type, only_open=TRUE)
	var/list/ret = list()
	for(var/ticket in tickets)
		if(tickets[ticket].ticket_type == type)
			if(only_open && tickets[ticket].status != SSDISPATCH_TICKET_STATUS_OPEN)
				continue
			ret += tickets[ticket]
	var/sorted = sortList(ret, /proc/cmp_by_dispatch_priority)
	ret = list()
	for(var/datum/dispatch_ticket/item in sorted)
		ret += item.key
	return ret

/datum/controller/subsystem/dispatch/proc/make_testing_instances()
	var/list/tdata = list(
		"type" = SSDISPATCH_TICKET_TYPE_SECURITY,
		"extra" = ""
	)
	tdata["priority"] = SSDISPATCH_TICKET_PRIORITY_MINIMAL
	tdata["title"] = "Minimal"
	ticket_create(pick(GLOB.mob_living_list), tdata)
	tdata["priority"] = SSDISPATCH_TICKET_PRIORITY_LOW
	tdata["title"] = "Low"
	ticket_create(pick(GLOB.mob_living_list), tdata)
	tdata["priority"] = SSDISPATCH_TICKET_PRIORITY_NORMAL
	tdata["title"] = "Normal"
	ticket_create(pick(GLOB.mob_living_list), tdata)
	tdata["priority"] = SSDISPATCH_TICKET_PRIORITY_HIGH
	tdata["title"] = "High"
	ticket_create(pick(GLOB.mob_living_list), tdata)
	tdata["priority"] = SSDISPATCH_TICKET_PRIORITY_CRITICAL
	tdata["title"] = "Critical"
	ticket_create(pick(GLOB.mob_living_list), tdata)

/proc/get_dispatch_priority_value(priority)
	switch(priority)
		if(SSDISPATCH_TICKET_PRIORITY_MINIMAL)
			return -2
		if(SSDISPATCH_TICKET_PRIORITY_LOW)
			return -1
		if(SSDISPATCH_TICKET_PRIORITY_NORMAL)
			return 0
		if(SSDISPATCH_TICKET_PRIORITY_HIGH)
			return 1
		if(SSDISPATCH_TICKET_PRIORITY_CRITICAL)
			return 2
	CRASH("illegal priority")

/proc/cmp_by_dispatch_priority(atom/a, atom/b)
	var/datum/dispatch_ticket/t1 = a
	var/datum/dispatch_ticket/t2 = b
	var/v1 = get_dispatch_priority_value(t1.priority)
	var/v2 = get_dispatch_priority_value(t2.priority)
	message_admins(v1)
	message_admins(v2)
	if(v1 > v2) return -1
	if(v2 > v1) return 1
	return 0

/datum/controller/subsystem/dispatch/proc/load_ticket_data_into_mdata(mob/user, datum/dispatch_ticket/ticket)
	ui_data_by_mob[user]["mdata"]["ticketData"]["creator"] = ticket.creator
	ui_data_by_mob[user]["mdata"]["ticketData"]["location"] = ticket.location
	ui_data_by_mob[user]["mdata"]["ticketData"]["status"] = ticket.status
	ui_data_by_mob[user]["mdata"]["ticketData"]["priority"] = ticket.priority
	ui_data_by_mob[user]["mdata"]["ticketData"]["type"] = ticket.ticket_type
	ui_data_by_mob[user]["mdata"]["ticketData"]["title"] = ticket.title
	ui_data_by_mob[user]["mdata"]["ticketData"]["extra"] = ticket.extra
	ui_data_by_mob[user]["mdata"]["ticketData"]["handler"] = ticket.handler ? "[ticket.handler]" : "None"

/obj/item/radio/headset/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	obj_flags |= EMAGGED
	to_chat(user, "<span class='warning'>You short out the automatic sensor array!</span>")

/datum/controller/subsystem/dispatch/ui_act(action, list/params)
	. = ..()
	if(.) // ABORT ABORT ABORT
		return

	var/mob/user = locate(params["self_ref"])
	if(!user)
		CRASH("ui_act called without valid self_ref")

	switch(action)
		///*** TICKET CREATION ACTIONS ***///
		if("set-ticket-type")
			ui_data_by_mob[user]["tdata"]["type"] = params["type"]
			return TRUE

		if("set-ticket-priority")
			ui_data_by_mob[user]["tdata"]["priority"] = params["priority"]
			return TRUE

		if("toggle-template-use")
			ui_data_by_mob[user]["tdata"]["templateUse"] = !ui_data_by_mob[user]["tdata"]["templateUse"]
			if(!ui_data_by_mob[user]["tdata"]["templateUse"])
				ui_data_by_mob[user]["tdata"]["templateName"] = "None"
				return TRUE
			var/resp = tgui_input_list(user, "Select Template", "Template", templates)
			if(!resp)
				ui_data_by_mob[user]["tdata"]["templateUse"] = FALSE
				return TRUE
			apply_template(user, templates[resp])
			return TRUE

		if("template-set")
			var/resp = tgui_input_list(user, "Select Template", "Template", templates)
			if(!resp)
				return TRUE
			apply_template(user, templates[resp])

		if("spoof-location") // Comms Agents
			if(!ishuman(user))
				return FALSE

			var/mob/living/carbon/human/user_human = user
			if(!(user_human.ears.obj_flags & EMAGGED))
				return FALSE

			ui_data_by_mob[user]["tdata"]["location"] = "[input(user, "Enter Fake Location", "Location Spoof", "")]"
			ui_data_by_mob[user]["tdata"]["location-spoofed"] = TRUE
			return TRUE

		if("spoof-creator") // Comms Agents
			if(!ishuman(user))
				return FALSE

			var/mob/living/carbon/human/user_human = user
			if(!(user_human.ears.obj_flags & EMAGGED))
				return FALSE

			ui_data_by_mob[user]["tdata"]["creator"] = "[input(user, "Enter Fake Creator", "Creator Spoof", "")]"
			ui_data_by_mob[user]["tdata"]["creator-spoofed"] = TRUE

			return TRUE

		if("set-ticket-title")
			ui_data_by_mob[user]["tdata"]["title"] = params["title"]
			return TRUE

		if("set-ticket-extra")
			ui_data_by_mob[user]["tdata"]["extra"] = params["extra"]
			return TRUE

		if("ticket-submit")
			ticket_create(user, ui_data_by_mob[user]["tdata"])
			ui_data_by_mob[user]["tdata"]["should_clear"] = TRUE
			ui_data_by_mob[user]["should_close"] = TRUE
			qdel(ui_data_by_mob[user]["tdata"]["ui-tnew"])
			return TRUE

		 /*** TICKET MANAGER ACTIONS ***/
		if("toggle-active")
			ui_data_by_mob[user]["mdata"]["holderActive"] = !ui_data_by_mob[user]["mdata"]["holderActive"]
			var/list/holder_types = get_holder_roles(user)
			if(!holder_types.len)
				ui_data_by_mob[user]["mdata"]["holderActive"] = FALSE
				return TRUE
			if(holder_types.len == 1)
				ui_data_by_mob[user]["mdata"]["holderActiveType"] = holder_types[1]
			else
				ui_data_by_mob[user]["mdata"]["holderActiveType"] = tgui_alert(user, "Select Role", "Go Active", holder_types)
			return TRUE

		if("toggle-clocked")
			ui_data_by_mob[user]["mdata"]["holderClocked"] = !ui_data_by_mob[user]["mdata"]["holderClocked"]
			if(!ui_data_by_mob[user]["mdata"]["holderClocked"])
				ui_data_by_mob[user]["mdata"]["holderActive"] = FALSE
			return TRUE

		if("ticket-select")
			var/resp = tgui_input_list(user, "Select Ticket", "Ticket Select", get_ticket_list_for_type(ui_data_by_mob[user]["mdata"]["holderActiveType"]))

			if(!resp)
				return TRUE

			ui_data_by_mob[user]["mdata"]["ticketActive"] = resp
			load_ticket_data_into_mdata(user, tickets[resp])

			return TRUE

		if("ticket-select-all")
			var/resp = tgui_input_list(user, "Select Ticket", "Ticket Select", get_ticket_list_for_type(ui_data_by_mob[user]["mdata"]["holderActiveType"], FALSE))

			if(!resp)
				return TRUE

			ui_data_by_mob[user]["mdata"]["ticketActive"] = resp
			load_ticket_data_into_mdata(user, tickets[resp])

			return TRUE

		if("ticket-handle")
			var/resp = tgui_alert(user, "Are you sure you want to handle this ticket?", "Ticket Handle", list("Yes", "No"))

			if(resp!="Yes")
				return TRUE

			var/ticket = ui_data_by_mob[user]["mdata"]["ticketActive"]
			var/datum/dispatch_ticket/ticket_i = tickets[ticket]

			if(!ticket_i)
				CRASH("invalid ticket identifier '[ticket]'")

			ticket_i.handle(user)

			ticket_i.message_creator("Your ticket is being handled by [user]!")

			ui_data_by_mob[user]["mdata"]["ticketData"]["handler"] = "[ticket_i.handler]"
			ui_data_by_mob[user]["mdata"]["ticketData"]["status"] = ticket_i.status
			ui_data_by_mob[user]["ticket"] = ticket

			return TRUE

		if("ticket-reject")
			var/resp = tgui_alert(user, "Are you sure you want to reject this ticket?", "Ticket Reject", list("Yes", "No"))

			if(resp!="Yes")
				return TRUE

			var/ticket = ui_data_by_mob[user]["mdata"]["ticketActive"]
			var/datum/dispatch_ticket/ticket_i = tickets[ticket]

			if(!ticket_i)
				CRASH("invalid ticket identifier '[ticket]'")

			ticket_i.status = SSDISPATCH_TICKET_STATUS_REJECTED

			ticket_i.message_creator("Your ticket has been rejected!")

			ui_data_by_mob[user]["mdata"]["ticketData"]["status"] = ticket_i.status

			return TRUE

		if("ticket-resolve")
			var/resp = tgui_alert(user, "Are you sure you want to resolve this ticket?", "Ticket Resolve", list("Yes", "No"))

			if(resp!="Yes")
				return TRUE

			var/ticket = ui_data_by_mob[user]["mdata"]["ticketActive"]
			var/datum/dispatch_ticket/ticket_i = tickets[ticket]

			if(!ticket_i)
				CRASH("invalid ticket identifier '[ticket]'")

			ticket_i.status = SSDISPATCH_TICKET_STATUS_RESOLVED

			ticket_i.message_creator("Your ticket has been resolved!")

			ui_data_by_mob[user]["mdata"]["ticketData"]["status"] = ticket_i.status

			return TRUE

		if("ticket-clear")
			var/resp = tgui_alert(user, "Are you sure you want to reset this ticket? This will also clear the handler flag!", "Ticket Clear", list("Yes", "No"))

			if(resp!="Yes")
				return TRUE

			var/ticket = ui_data_by_mob[user]["mdata"]["ticketActive"]
			var/datum/dispatch_ticket/ticket_i = tickets[ticket]

			ticket_i.message_creator("Your ticket has been cleared. Please wait for a new handler.")

			ticket_i.handle(null)
			ticket_i.status = SSDISPATCH_TICKET_STATUS_OPEN
			ui_data_by_mob[user]["mdata"]["ticketActive"] = "None"

			return TRUE

		else
			CRASH("invalid action '[action]'")
	CRASH("action did not return? '[action]'")
