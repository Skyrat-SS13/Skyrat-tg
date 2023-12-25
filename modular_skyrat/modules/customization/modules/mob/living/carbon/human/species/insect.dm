/datum/species/insect
	name = "Anthromorphic Insect"
	id = SPECIES_INSECT
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/internal/tongue/insect
	payday_modifier = 1.0
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

/datum/species/insect/get_default_mutant_bodyparts()
	return list(
		"tail" = list("None", FALSE),
		"snout" = list("None", FALSE),
		"horns" = list("None", FALSE),
		"ears" = list("None", FALSE),
		"legs" = list("Normal Legs", FALSE),
		"taur" = list("None", FALSE),
		"fluff" = list("None", FALSE),
		"wings" = list("Bee", FALSE),
		"moth_antennae" = list("None", FALSE),
	)

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
