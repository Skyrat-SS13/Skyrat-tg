/*
	Necrohelp just opens a window containing text extracted from the necromorph species the player is playing
*/
/datum/extension/interactive/necrohelp
	name = "Help"
	base_type = /datum/extension/interactive/necrohelp
	expected_type = /mob
	flags = EXTENSION_FLAG_IMMEDIATE
	template = "necrohelp.tmpl"
	dimensions = new /vector2(800, 500)

/datum/extension/interactive/necrohelp/generate_content_data()
	content_data = list()
	if (ishuman(holder))
		var/mob/living/carbon/human/H = holder
		var/datum/species/necromorph/N = H.get_species_datum()
		content_data["name"] = N.name
		content_data["desc"] = N.get_long_description()
		title = N.name



/datum/proc/help()
	set name = "Help"
	set category = "Abilities"
	set desc = "Opens a window explaining your abilities"

	var/datum/extension/interactive/necrohelp/NH = get_or_create_extension(src, /datum/extension/interactive/necrohelp)
	NH.ui_interact(src)