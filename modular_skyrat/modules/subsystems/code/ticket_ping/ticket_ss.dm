/// Pings admins every 3 minutes for all open tickets/OPFOR applications
SUBSYSTEM_DEF(ticket_ping)
	name = "Ticket Ping"
	flags = SS_BACKGROUND | SS_NO_INIT
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 3 MINUTES

/datum/controller/subsystem/ticket_ping/fire(resumed)
	var/valid_ahelps
	var/valid_opfors
	for(var/datum/admin_help/ahelp in GLOB.ahelp_tickets.active_tickets)
		if(ahelp.handler || ahelp.ticket_ping_stop || !ahelp.ticket_ping)
			continue
		valid_ahelps++

	for(var/datum/opposing_force/opfor in SSopposing_force.submitted_applications)
		if(opfor.handling_admin || !opfor.ticket_ping)
			continue
		valid_opfors++

	if(!valid_ahelps && !valid_opfors)
		return
	var/is_or_are
	if(!valid_ahelps)
		is_or_are = (valid_opfors > 1 ? "are" : "is")
	else
		is_or_are = (valid_ahelps > 1 ? "are" : "is")
	message_admins(span_adminnotice("There [is_or_are] currently [valid_ahelps ? "[valid_ahelps] unhandled staff ticket[valid_ahelps == 1 ? "" : "s"] open" : ""][(valid_ahelps && valid_opfors) ? " and " : ""][valid_opfors ? "[valid_opfors] unhandled Opposing Force application[valid_opfors == 1 ? "" : "s"] open" : ""]."))
	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs.read_preference(/datum/preference/toggle/admin/ticket_ping))
			SEND_SOUND(staff, sound('modular_skyrat/modules/subsystems/sounds/soft_ping.ogg'))
			window_flash(staff, ignorepref = TRUE)
