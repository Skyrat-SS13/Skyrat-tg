/datum/background_info
	/// Name of the cultural thing, be it place, faction, or culture
	var/name
	/// It's description
	var/description
	/// Economic power, this impacts the initial paychecks by a bit
	var/economic_power = 1
	/// It'll force people to know this language if they've picked this cultural thing
	var/datum/language/required_lang
	/// This will allow people to pick extra languages
	var/list/additional_langs = list()
	/// The gameplay features of this background.
	var/list/features = list()
	/// Groups the culture belongs to.
	var/groups = CULTURE_ALL
