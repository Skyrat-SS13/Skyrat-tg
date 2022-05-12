/datum/species/aquatic
	name = "Aquatic"
	id = SPECIES_AQUATIC
	species_traits = list(
		MUTCOLORS,
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
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = "None",
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs",
		"wings" = "None"
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	payday_modifier = 0.75
	liked_food = SEAFOOD | MEAT | FRUIT
	disliked_food = CLOTH | GROSS
	toxic_food = TOXIC
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_AKULA
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/akula,
	)

/datum/species/aquatic/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
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
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = second_color
	return returned

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
