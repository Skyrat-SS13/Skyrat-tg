// Separate due to how it's a unique background, with unique gameplay going on.
/datum/background_info/employment/undocumented_nanotrasen
	name = "Undocumented Nanotrasen Employee"
	description = "You are not only here in Sector 13 illegally, but you're technically not on any Nanotrasen documentation either. You get paid under the table."
	// This is going to have special sealed crates that are delivered to the HoP for distribution.
	// About 1.2x more money than what they'd normally get. Not precise, to allow for skimming.
	// Obvious risks apply.
	economic_power = 0
	features = list(/datum/cultural_feature/undocumented)

// Nanotrasen cares not for your origin, unless you're in a special job:tm:
/datum/background_info/employment/nanotrasen
	name = "Nanotrasen Contractor"
	description = "You are one of the many Nanotrasen contractors working in Sector 13, you've been sent here under the guise of good pay and a decent job, \
	of which, only one of those are accurate."
	features = list(/datum/cultural_feature/average)

/datum/background_info/employment/nanotrasen/intern
	name = "Nanotrasen Intern"
	description = "We pay in experience."
	economic_power = 0.6
	features = list(/datum/cultural_feature/poor)

/datum/background_info/employment/nanotrasen/immigrant
	name = "Immigrant Nanotrasen Employee"
	description = "While you could technically be called an expat, you are not from the right country. You also get paid somewhat less than your counterparts. Oof."
	economic_power = 0.9
	groups = CULTURE_GROUP_ALIEN

/datum/background_info/employment/nanotrasen/expat
	name = "Expat Nanotrasen Employee"
	description = "While you are technically an immigrant worker, you have a fancy name that indicates your higher status compared to other immigrant workers."
	groups = CULTURE_GROUP_HUMAN
