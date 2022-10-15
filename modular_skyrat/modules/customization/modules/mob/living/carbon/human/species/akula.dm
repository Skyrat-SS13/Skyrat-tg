/datum/species/akula
	name = "Akula"
	id = SPECIES_AKULA
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	payday_modifier = 0.75
	liked_food = SEAFOOD | RAW
	disliked_food = CLOTH | DAIRY
	toxic_food = TOXIC
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/akula,
	)

/datum/species/akula/randomize_features(mob/living/carbon/human/human_mob)
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
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = second_color
	human_mob.dna.features["mcolor3"] = second_color

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/name = "Shark"
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/akula/get_species_description()
	return placeholder_description

/datum/species/akula/get_species_lore()
	return list(placeholder_lore)

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#394b66"
	var/secondary_color = "#818b9b"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	human.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Shark", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, secondary_color))
	human.dna.species.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "hShark", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, secondary_color))
	human.dna.species.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Sergal", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, secondary_color))
	human.update_mutant_bodyparts(TRUE)
	human.update_body(TRUE)
