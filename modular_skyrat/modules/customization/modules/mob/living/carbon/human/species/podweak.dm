/datum/species/pod
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	learnable_languages = list(/datum/language/common, /datum/language/sylvan) //I guess plants are smart and they can speak common
	payday_modifier = 0.75

/datum/species/pod/podweak
	name = "Podperson"
	id = SPECIES_PODPERSON_WEAK
	limbs_id = SPECIES_PODPERSON
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list()

	learnable_languages = list(/datum/language/common, /datum/language/sylvan)
	always_customizable = FALSE
