/datum/objective_template
	var/name = "BROKEN TEMPLATE"
	var/desc = "BROKEN TEMPLATE"
	var/intensity = INTENSITY_STEALTH
	var/list/allowed_antag_types = list()
	var/abstract = /datum/objective_template

/datum/objective_template/proc/on_select(client/parent)
	return

/datum/objective_template/proc/on_approved(client/parent)
	return

/datum/objective_template/cult
	abstract = /datum/objective_template/cult
