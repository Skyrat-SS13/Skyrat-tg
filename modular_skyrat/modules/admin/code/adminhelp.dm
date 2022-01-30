// File for more general procs, admin_help.dm is focused on the datum/admin_help/
/client/verb/viewlatestticket()
	set category = "Admin"
	set name = "View Latest Ticket"

	if(!current_ticket)
		// Check if the client had previous tickets, and show the latest one
		var/list/prev_tickets = list()
		var/datum/admin_help/last_ticket
		// Check all resolved tickets for this player
		for(var/datum/admin_help/resolved_ticket in GLOB.ahelp_tickets.resolved_tickets)
			if(resolved_ticket.initiator_ckey == ckey) // Initiator is a misnomer, it's always the non-admin player even if an admin bwoinks first
				prev_tickets += resolved_ticket
		// Check all closed tickets for this player
		for(var/datum/admin_help/closed_ticket in GLOB.ahelp_tickets.closed_tickets)
			if(closed_ticket.initiator_ckey == ckey)
				prev_tickets += closed_ticket
		// Take the most recent entry of prev_tickets and open the panel on it
		if(LAZYLEN(prev_tickets))
			last_ticket = pop(prev_tickets)
			last_ticket.PlayerTicketPanel()
			return

		// client had no tickets this round
		to_chat(src, span_warning("You have not had an ahelp ticket this round."))
		return

	current_ticket.PlayerTicketPanel()
