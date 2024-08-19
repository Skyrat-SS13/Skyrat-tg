/datum/species/mammal
	name = "Anthromorph" //Called so because the species is so much more universal than just mammals
	id = SPECIES_MAMMAL
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/internal/tongue/mammal
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant,
	)

/datum/species/mammal/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Husky", TRUE),
		"snout" = list("Husky", TRUE),
		"horns" = list("None", FALSE),
		"ears" = list("Husky", TRUE),
		"legs" = list("Normal Legs", TRUE),
		"taur" = list("None", FALSE),
		"fluff" = list("None", FALSE),
		"wings" = list("None", FALSE),
		"head_acc" = list("None", FALSE),
		"neck_acc" = list("None", FALSE),
	)

/obj/item/organ/internal/tongue/mammal
	liked_foodtypes = GRAIN | MEAT
	disliked_foodtypes = CLOTH | GROSS | GORE
	toxic_foodtypes = TOXIC


/datum/species/mammal/randomize_features()
	var/list/features = ..()
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "#FFFFFF"
			second_color = "#333333"
			third_color = "#333333"
		if(2)
			main_color = "#FFFFDD"
			second_color = "#DD6611"
			third_color = "#AA5522"
		if(3)
			main_color = "#DD6611"
			second_color = "#FFFFFF"
			third_color = "#DD6611"
		if(4)
			main_color = "#CCCCCC"
			second_color = "#FFFFFF"
			third_color = "#FFFFFF"
		if(5)
			main_color = "#AA5522"
			second_color = "#CC8833"
			third_color = "#FFFFFF"
		if(6)
			main_color = "#FFFFDD"
			second_color = "#FFEECC"
			third_color = "#FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = "#[random_color()]"
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = third_color
	return features

/datum/species/mammal/get_random_body_markings(list/passed_features)
	var/name = SPRITE_ACCESSORY_NONE
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/mammal/get_species_description()
	return "This is a template species for your own creations!"


/datum/species/mammal/get_species_lore()
	return list("Make sure you fill out your own custom species lore!")

/datum/species/mammal/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#333333"
	var/secondary_color = "#b8b8b8"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	human.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Husky", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Husky", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, secondary_color))
	human.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Husky", MUTANT_INDEX_COLOR_LIST = list(main_color, "#4D4D4D", secondary_color))
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)
