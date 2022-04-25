// list('ckey' = handled_ticket_count)
GLOBAL_LIST_INIT(ticket_counter, list())

/proc/ticket_counter_add_handled(ckey, number)
	if(isnull(GLOB.ticket_counter[ckey]))
		GLOB.ticket_counter[ckey] = 0
	GLOB.ticket_counter[ckey]+= number
	sortTim(GLOB.ticket_counter, cmp=/proc/cmp_numeric_dsc, associative = TRUE)

/datum/admin_help_tickets
	var/obj/effect/statclick/opfor_list/opforstat = new()

/datum/admin_help_tickets/stat_entry()
	var/list/L = ..()
	L[++L.len] = list(null, null, null, null)
	L[++L.len] = list("Ticket/OPFOR statistics", null, null, null)
	L[++L.len] = list("Admin:", "Tickets/OPFOR handled:", null, null)

	for(var/ckey in GLOB.ticket_counter)
		//assumption, that there's no keys with empty values
		L[++L.len] = list("[ckey]", "[GLOB.ticket_counter[ckey]]", null, null)

	L[++L.len] = list("[opforstat.update("OPFOR:")]", "UNSUB: [LAZYLEN(SSopposing_force.unsubmitted_applications)] | SUB: [LAZYLEN(SSopposing_force.submitted_applications)] | APPR: [LAZYLEN(SSopposing_force.approved_applications)]", null, REF(opforstat))

	return L

/datum/admin_help
	var/previously_closed = FALSE

/datum/admin_help/Close(key_name = key_name_admin(usr), silent = FALSE)
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/datum/admin_help/Resolve(key_name = key_name_admin(usr), silent = FALSE)
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/datum/admin_help/Reject(key_name = key_name_admin(usr))
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/datum/admin_help/ICIssue(key_name = key_name_admin(usr))
	. = ..()
	if(!previously_closed)
		ticket_counter_add_handled(usr.key, 1)
		previously_closed = TRUE

/obj/effect/statclick/opfor_list

/obj/effect/statclick/opfor_list/Click()
	if (!usr.client?.holder)
		message_admins("[key_name_admin(usr)] non-holder clicked on an OPFOR list statclick! ([src])")
		log_game("[key_name(usr)] non-holder clicked on an OPFOR list statclick! ([src])")
		return

	usr.client.view_opfors()

//called by admin topic
/obj/effect/statclick/opfor_list/proc/Action()
	Click()
