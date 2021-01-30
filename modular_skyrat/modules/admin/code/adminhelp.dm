// File for more general procs, admin_help.dm is focused on the datum
/client/verb/viewtickets()
	set category = "Admin"
	set name = "View Latest Ticket"

	if(!current_ticket)
		// Check if the client had previous tickets, and show the latest one
		var/list/prev_tickets
		var/datum/admin_help/last_AH
		for(var/datum/admin_help/AH in GLOB.ahelp_tickets)
			if(AH.initiator_ckey == ckey)
				prev_tickets += AH
		if(LAZYLEN(prev_tickets)) // Take the last entry of prev_tickets and open the panel on it
			last_AH = pop(prev_tickets)
			last_AH.PlayerTicketPanel()
			return
		
		// client had no tickets this round
		to_chat(src, "<span class='warning'>You have not had an ahelp ticket this round.</span>")
		return

	current_ticket.PlayerTicketPanel()
