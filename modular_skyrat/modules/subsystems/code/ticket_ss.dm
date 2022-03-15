/// Pings admins every 3 minutes for all open tickets/OPFOR applications
SUBSYSTEM_DEF(ticket_ping)
	name = "Ticket Ping"
	flags = SS_BACKGROUND | SS_NO_INIT
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 3 MINUTES

/datum/controller/subsystem/ambience/fire(resumed)
	if(!length(GLOB.ahelp_tickets.active_tickets) && !length(SSopposing_force.submitted_applications))
		return

	message_admins(span_adminnotice("There are currently [length(GLOB.ahelp_tickets.active_tickets) ? "[length(GLOB.ahelp_tickets.active_tickets)] staff tickets open " : ""][(length(GLOB.ahelp_tickets.active_tickets) && length(SSopposing_force.submitted_applications)) ? "and " ""][length(SSopposing_force.submitted_applications) ? "[length(SSopposing_force.submitted_applications)] Opposing Force applications open" : ""]."))
