/datum/species/aquatic
	name = "Akula (Generic)"
	id = SPECIES_AQUATIC
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/internal/tongue/aquatic
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = "None",
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs",
		"wings" = "None"
	)
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_AKULA
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/aquatic,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/aquatic,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/aquatic,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/aquatic,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/aquatic,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/aquatic,
	)

/obj/item/organ/internal/tongue/aquatic
	liked_foodtypes = SEAFOOD | MEAT | FRUIT | GORE
	disliked_foodtypes = CLOTH | GROSS
	toxic_foodtypes = TOXIC


/datum/species/aquatic/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of sharkish colors, with a whiter secondary and tertiary
	switch(random)
		if(1)
			main_color = "#668899"
			second_color = "#BBCCDD"
		if(2)
			main_color = "#334455"
			second_color = "#DDDDEE"
		if(3)
			main_color = "#445566"
			second_color = "#DDDDEE"
		if(4)
			main_color = "#666655"
			second_color = "#DDDDEE"
		if(5)
			main_color = "#444444"
			second_color = "#DDDDEE"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = second_color
	return features

/datum/species/aquatic/get_random_body_markings(list/passed_features)
	var/name = "Shark"
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/aquatic/get_species_description()
	return placeholder_description

/datum/species/aquatic/get_species_lore()
	return list(placeholder_lore)
