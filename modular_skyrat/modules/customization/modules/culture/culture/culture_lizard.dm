/datum/cultural_info/culture/lavaland
	name = "Lavaland"
	description = "Born from The Underground of the volcanic planet, Lavaland. \
		You lived a tribal life, scavenging and hunting across the land to ensure the survival of your tribe. \
		Somehow you've wound up on the civilized world."

/datum/cultural_info/culture/lavaland/native
	name = "Lavaland Native"
	description = "Born from The Underground of the volcanic planet, Lavaland. \
		You live a tribal life, scavenging and hunting across the land to ensure the survival of your tribe."
	required_lang = /datum/language/draconic
	economic_power = 0
	features = list(/datum/cultural_feature/lavaland)
	groups = CULTURE_LAVALAND | CULTURE_GROUP_HUMAN


/datum/cultural_info/culture/lavaland/converted
	name = "Lavaland Converted"
	description = "You were once someone else, though whoever that was is unimportant. Their teachings were wrong. \
		You were given the blessing of the Necropolis, a great being, mayhaps a god, that elightened you to the errors of your ways. \
		You live a tribal life, scavenging and hunting across the land to ensure the survival of your tribe."
	required_lang = /datum/language/draconic
	economic_power = 0
	features = list(/datum/cultural_feature/lavaland)
	groups = CULTURE_LAVALAND

/datum/cultural_info/culture/lavaland_exile
	name = "Lavaland Exile"
	description = "You once were of the Necroplis, though you've wandered astray of it's teachings, and have returned to technology and empires, \
	whether forced to, or by choice. Regardless, your ex-tribe severely disapproves of your treachery, as you'd be wise to keep away from them, \
	lest you be re-enlightened of the error of your new ways."
	required_lang = /datum/language/draconic
	economic_power = 0
	features = list(/datum/cultural_feature/lavaland)
	groups = CULTURE_GROUP_SPACE_FARING

