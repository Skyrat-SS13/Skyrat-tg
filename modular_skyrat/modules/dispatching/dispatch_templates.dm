/datum/dispatch_ticket_template
	var/abstract = /datum/dispatch_ticket_template
	var/name = "Broken Template"
	var/desc = ""
	var/title = ""
	var/extra = ""
	var/template_type
	var/template_priority_default = SSDISPATCH_TICKET_PRIORITY_NORMAL

/datum/dispatch_ticket_template/security
	abstract = /datum/dispatch_ticket_template/security
	template_type = SSDISPATCH_TICKET_TYPE_SECURITY

/datum/dispatch_ticket_template/engine
	abstract = /datum/dispatch_ticket_template/engine
	template_type = SSDISPATCH_TICKET_TYPE_ENGINEERING

/datum/dispatch_ticket_template/medical
	abstract = /datum/dispatch_ticket_template/medical
	template_type = SSDISPATCH_TICKET_TYPE_MEDICAL

/datum/dispatch_ticket_template/medical/dead
	name = "Death"
	desc = "Someone is dead!"
	title = "Death"
	extra = "Someone has died!"
	template_priority_default = SSDISPATCH_TICKET_PRIORITY_HIGH

/datum/dispatch_ticket_template/medical/dying
	name = "Near Death"
	desc = "Someone is dying!"
	title = "Dying"
	extra = "Someone is dying!"
	template_priority_default = SSDISPATCH_TICKET_PRIORITY_CRITICAL
