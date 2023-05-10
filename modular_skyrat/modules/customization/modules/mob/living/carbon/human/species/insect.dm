/datum/species/insect
	name = "Anthromorphic Insect"
	id = SPECIES_INSECT
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"horns" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"taur" = "None",
		"fluff" = "None",
		"wings" = "Bee",
		"moth_antennae" = "None"
	)
	mutanttongue = /obj/item/organ/internal/tongue/insect
	liked_food = GROSS | RAW | TOXIC | GORE
	disliked_food = CLOTH | GRAIN | FRIED
	toxic_food = DAIRY
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_INSECT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/insect,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/insect,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/insect,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/insect,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/insect,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/insect,
	)
	eyes_icon = 'modular_skyrat/modules/organs/icons/insect_eyes.dmi'

/datum/species/insect/get_species_description()
	return placeholder_description

/datum/species/insect/get_species_lore()
	return list(placeholder_lore)

/datum/species/insect/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#644b07"
	var/secondary_color = "#9b9b9b"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)
