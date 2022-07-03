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

/datum/species/akula/get_random_features()
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

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/name = "Shark"
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/akula/get_species_description()
	return {The Azuleans, also widely known as Akula, are one of several sapient species of humanoids and make up one of four primary "nations" in current-day charted space. Their physiology is closely shark-like, yet posesses mammalian features that allow them to exist in both water and land without complication.
	They have a semi-rigid skeleton composed of tough and flexible cartilage and a nearly-identical organ structure to that of humans with the addition of gills and a buoyant liver.
	Among their most noticeable features is the abundant presence of small hydrodynamic feathers on their heads, looking exactly like hair at a first glance - and their webbed toes and fingers.
	All of these are often not completely granted, as Akula are close with genetical modification.

/datum/species/akula/get_species_lore()
	return list(placeholder_lore)
