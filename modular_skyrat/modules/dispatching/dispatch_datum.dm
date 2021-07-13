#define MAX_DETAIL_LENGTH 128

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
		creator = truncate(sanitize(tdata["creator"]), MAX_DETAIL_LENGTH)
	else creator = "[user]"
	if(tdata["location-spoofed"])
		location = truncate(sanitize(tdata["location"]), MAX_DETAIL_LENGTH)
	else location = "[get_area(user)]"
	priority = truncate(sanitize(tdata["priority"]), MAX_DETAIL_LENGTH)
	ticket_type = truncate(sanitize(tdata["ticket_type"]), MAX_DETAIL_LENGTH)
	title = truncate(sanitize(tdata["title"]), MAX_DETAIL_LENGTH)
	extra = truncate(sanitize(tdata["extra"]), MAX_DETAIL_LENGTH)
	has_image = truncate(sanitize(tdata["imageAttached"]), MAX_DETAIL_LENGTH)
	image = truncate(sanitize(tdata["image"]), MAX_DETAIL_LENGTH)
	suspect = truncate(sanitize(tdata["suspect"]), MAX_DETAIL_LENGTH)
	suspect_name = truncate(sanitize(tdata["suspectName"]), MAX_DETAIL_LENGTH)
	suspect_desc = truncate(sanitize(tdata["suspectDesc"]), MAX_DETAIL_LENGTH)
	status = SSDISPATCH_TICKET_STATUS_OPEN

/obj/item/radio/headset/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	obj_flags |= EMAGGED
	to_chat(user, "<span class='warning'>You short out the automatic sensor array!</span>")

/datum/dispatch_ticket/proc/handle(mob/user, alert = TRUE)
	status = SSDISPATCH_TICKET_STATUS_ACTIVE
	if(handler)
		handler_past += handler
	handler = user
	if(handler && alert)
		message_creator("Your ticket is being handled by [handler]")

/datum/dispatch_ticket/proc/message_creator(message)
	to_chat(origin, span_boldnotice("Ticket Message: [message]"))
	origin.balloon_alert(origin, message)
