/datum/species/humanoid
	name = "Humanoid"
	id = SPECIES_HUMANOID
	species_traits = list(MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 0.75
	examine_limb_id = SPECIES_HUMAN

/datum/species/humanoid/get_species_description()
	return {"In the current day, Humanoid is a catch-all term for any sapient being that is not anthropomorphic in nature but rather closely resembles a regular Human being. They may also be called different terms, like \"Demi-Human\" or \"Kemonomimi\"."}

/datum/species/humanoid/get_species_lore()
	return list({"The idea of Humans with traditionally non-human characteristics has been a thing since the moment civilization was born in Sol-3. Various types of folklore and religion, such as creatures the likes of Sirens, Satyrs, Lamias, Ogres, and Orcs or Ancient Egyptian gods like Sobek and Anubis have been presented as different types of \"Humanoids\".
	
	For over five-hundred years, the concept Humanoids has consistently found itself represented in pop culture, most notably Asian entertainment.
	
	It should come off as no surprise that when aesthetic genetical modification was readily available, the first distinct group of users were closely knit with previously mentioned tales of folklore and pop culture.
	
	In modern space-states like the Sol Federation, one may find that Humanoids are an extremely common sight - sometimes even surpassing regular Humans in numbers. Nonetheless, they may still encounter discrimination from puritan groups."})
