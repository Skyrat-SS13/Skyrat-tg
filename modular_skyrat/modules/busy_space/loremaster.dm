var/datum/lore/loremaster/loremaster = new/datum/lore/loremaster

/datum/lore/loremaster
	var/list/organizations = list()

/datum/lore/loremaster/New()

	var/list/paths = typesof(/datum/lore/organization) - /datum/lore/organization
	for(var/path in paths)
		var/datum/lore/organization/instance = new path()
		organizations[path] = instance
