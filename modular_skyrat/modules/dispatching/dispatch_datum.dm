/datum/dispatch_ticket
	var/creator
	var/creator_spoofed
	var/priority
	var/ticket_type
	var/location
	var/location_spoofed
	var/title
	var/extra
	var/status
	var/key
	var/created
	var/image
	var/has_image
	var/suspect
	var/suspect_name
	var/suspect_desc
	var/mob/handler
	var/mob/origin
	var/list/mob/handler_past = list()

/datum/dispatch_ticket/New(mob/user, list/tdata)
	origin = user
	if(tdata["creator-spoofed"])
		creator = tdata["creator"]
	else creator = "[user]"
	if(tdata["location-spoofed"])
		location = tdata["location"]
	else location = "[get_area(user)]"
	priority = tdata["priority"]
	ticket_type = tdata["type"]
	title = tdata["title"]
	extra = tdata["extra"]
	has_image = tdata["imageAttached"]
	image = tdata["image"]
	suspect = tdata["suspect"]
	suspect_name = tdata["suspectName"]
	suspect_desc = tdata["suspectDesc"]
	status = SSDISPATCH_TICKET_STATUS_OPEN

/datum/dispatch_ticket/proc/handle(mob/user, alert = TRUE)
	status = SSDISPATCH_TICKET_STATUS_ACTIVE
	if(handler)
		handler_past += handler
	handler = user
	if(handler && alert)
		message_creator("Your ticket is being handled by [handler]")

/datum/dispatch_ticket/proc/message_creator(message)
	to_chat(origin, "<span class='boldnotice'>Ticket Message: [message]</span>")
	origin.balloon_alert(origin, message)
