/datum/species/unathi
	name = "Unathi"
	id = SPECIES_UNATHI
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/internal/tongue/unathi
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_LIZARD
	ass_image = 'icons/ass/asslizard.png'

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard,
	)

/datum/species/unathi/get_default_mutant_bodyparts()
	return list(
		"tail" = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_CAN_RANDOMIZE = TRUE),
		"snout" = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_CAN_RANDOMIZE = TRUE),
		"spines" = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_CAN_RANDOMIZE = FALSE),
		"frills" = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_CAN_RANDOMIZE = FALSE),
		"horns" = list(MUTANT_INDEX_NAME = "Curled", MUTANT_INDEX_CAN_RANDOMIZE = TRUE),
		"body_markings" = list(MUTANT_INDEX_NAME = "Smooth Belly", MUTANT_INDEX_CAN_RANDOMIZE = TRUE),
		"legs" = list(MUTANT_INDEX_NAME = "Normal Legs", MUTANT_INDEX_CAN_RANDOMIZE = FALSE),
	)

/obj/item/organ/internal/tongue/unathi
	liked_foodtypes = GORE | MEAT | SEAFOOD | NUTS
	disliked_foodtypes = GRAIN | DAIRY | CLOTH | GROSS
	toxic_foodtypes = TOXIC


/datum/species/unathi/randomize_features()
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of green or brown colors, with a darker secondary and tertiary
	switch(random)
		if(1)
			main_color = "#11CC00"
			second_color = "#118800"
		if(2)
			main_color = "#55CC11"
			second_color = "#55AA11"
		if(3)
			main_color = "#77AA11"
			second_color = "#668811"
		if(4)
			main_color = "#886622"
			second_color = "#774411"
		if(5)
			main_color = "#33BB11"
			second_color = "#339911"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = second_color
	return features

/datum/species/unathi/get_species_description()
	return placeholder_description

/datum/species/unathi/get_species_lore()
	return list(placeholder_lore)
