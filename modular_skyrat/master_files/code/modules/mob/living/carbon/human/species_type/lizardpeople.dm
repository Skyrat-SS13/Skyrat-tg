/*
Lizard subspecies: ASHWALKERS
*/

/datum/species/lizard/ashwalker/
	language_prefs_whitelist = list(/datum/language/ashtongue)

/datum/species/lizard/ashwalker/create_pref_language_perk()
	var/list/to_add = list()
	// Holding these variables so we can grab the exact names for our perk.
	var/datum/language/common_language = /datum/language/ashtongue

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "comment",
		SPECIES_PERK_NAME = "Native Speaker",
		SPECIES_PERK_DESC = "Ashwalkers can only speak [initial(common_language.name)]. \
			It is rare, but not impossible, for an Ashwalker to learn another language."
	))

	return to_add
