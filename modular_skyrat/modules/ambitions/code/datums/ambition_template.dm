GLOBAL_LIST_INIT_TYPED(ambition_templates, /datum/ambition_template, setup_ambition_templates())
GLOBAL_PROTECT(ambition_templates)

/proc/setup_ambition_templates()
	. = list()
	for(var/stype in subtypesof(/datum/ambition_template))
		. += new stype()

/datum/ambition_template
	var/name
	var/desc
	var/intensity
	var/list/allowed_roles
	var/list/allowed_antags
