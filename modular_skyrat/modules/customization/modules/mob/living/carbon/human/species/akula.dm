/datum/species/akula
	name = "Akula"
	id = SPECIES_AKULA
	offset_features = list(
		OFFSET_GLASSES = list(0,1),
		OFFSET_EARS = list(0,2),
		OFFSET_FACEMASK = list(0,2),
		OFFSET_HEAD = list(0,1),
		OFFSET_HAIR = list(0,1),
	)
	eyes_icon = 'modular_skyrat/modules/organs/icons/akula_eyes.dmi'
	mutanteyes = /obj/item/organ/internal/eyes/akula
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
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
		"legs" = "Normal Legs"
	)
	payday_modifier = 0.75
	liked_food = SEAFOOD | RAW
	disliked_food = CLOTH | DAIRY
	toxic_food = TOXIC
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)

/datum/species/akula/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color = "#296786"
	var/secondary_color = "#8ce0bd"
	var/tertiary_color = "#ccf6e2"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = secondary_color
	human_mob.dna.features["mcolor3"] = tertiary_color

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#296786"
	var/secondary_color = "#8ce0bd"
	var/tertiary_color = "#ccf6e2"
	akula.dna.features["mcolor"] = main_color
	akula.dna.features["mcolor2"] = secondary_color
	akula.dna.features["mcolor3"] = tertiary_color
	akula.update_mutant_bodyparts(TRUE)
	akula.update_body(TRUE)

/obj/item/organ/internal/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = (HAIR_LAYER - 0.5)

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/akula/get_species_description()
	return placeholder_description

/datum/species/akula/get_species_lore()
	return list(placeholder_lore)
