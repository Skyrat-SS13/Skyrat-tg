/datum/species/skrell
	name = "Skrell"
	id = SPECIES_SKRELL
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	exotic_blood = /datum/reagent/copper
	bodytemp_normal = (BODYTEMP_NORMAL + 70)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	bodytemp_cold_damage_limit = (T20C - 10)
	species_language_holder = /datum/language_holder/skrell
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/internal/tongue/skrell
	payday_modifier = 1.0
	default_mutant_bodyparts = list("skrell_hair" = ACC_RANDOM)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	eyes_icon = 'modular_skyrat/modules/organs/icons/skrell_eyes.dmi'
	mutantbrain = /obj/item/organ/internal/brain/skrell
	mutanteyes = /obj/item/organ/internal/eyes/skrell
	mutantlungs = /obj/item/organ/internal/lungs/skrell
	mutantheart = /obj/item/organ/internal/heart/skrell
	mutantliver = /obj/item/organ/internal/liver/skrell
	mutanttongue = /obj/item/organ/internal/tongue/skrell
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/skrell,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/skrell,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/skrell,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/skrell,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/skrell,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/skrell,
	)

/datum/species/skrell/get_default_mutant_bodyparts()
	return list(
		"skrell_hair" = list("Male", TRUE),
	)

/datum/species/skrell/get_species_description()
	return placeholder_description

/datum/species/skrell/get_species_lore()
	return list(placeholder_lore)

/datum/species/skrell/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/random = rand(1,6)
	//Choose from a range of green-blue colors
	switch(random)
		if(1)
			main_color = "#44FF77"
		if(2)
			main_color = "#22FF88"
		if(3)
			main_color = "#22FFBB"
		if(4)
			main_color = "#22FFFF"
		if(5)
			main_color = "#22BBFF"
		if(6)
			main_color = "#2266FF"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = main_color
	human_mob.dna.features["mcolor3"] = main_color

/datum/species/skrell/prepare_human_for_preview(mob/living/carbon/human/skrell)
	var/skrell_color = "#22BBFF"
	skrell.dna.features["mcolor"] = skrell_color
	skrell.dna.features["mcolor2"] = skrell_color
	skrell.dna.features["mcolor3"] = skrell_color
	skrell.dna.mutant_bodyparts["skrell_hair"] = list(MUTANT_INDEX_NAME = "Female", MUTANT_INDEX_COLOR_LIST = list(skrell_color, skrell_color, skrell_color))
	regenerate_organs(skrell, src, visual_only = TRUE)
	skrell.update_body(TRUE)


/obj/item/organ/internal/tongue/skrell
	name = "internal vocal sacs"
	desc = "An Strange looking sac."
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "tongue"
	taste_sensitivity = 5
	var/static/list/languages_possible_skrell = typecacheof(list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/machine,
		/datum/language/slime,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/vox,
		/datum/language/nekomimetic,
		/datum/language/skrell,
	))
	liked_foodtypes = TOXIC | FRUIT | VEGETABLES
	disliked_foodtypes = RAW | CLOTH
	toxic_foodtypes = DAIRY | MEAT

/obj/item/organ/internal/tongue/skrell/get_possible_languages()
	return languages_possible_skrell

/obj/item/organ/internal/heart/skrell
	name = "skrellian heart"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "heart"

/obj/item/organ/internal/brain/skrell
	name = "spongy brain"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "brain2"

/obj/item/organ/internal/eyes/skrell
	name = "amphibian eyes"
	desc = "Large black orbs."
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/internal/lungs/skrell
	name = "skrell lungs"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	icon_state = "lungs"
	safe_plasma_max = 40
	safe_co2_max = 40

	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BRUTE


	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/internal/liver/skrell
	name = "skrell liver"
	icon_state = "liver"
	icon = 'modular_skyrat/modules/organs/icons/skrell_organ.dmi'
	alcohol_tolerance = 5
	toxTolerance = 10 //can shrug off up to 10u of toxins.
	liver_resistance = 1.2 * LIVER_DEFAULT_TOX_RESISTANCE // +20%
