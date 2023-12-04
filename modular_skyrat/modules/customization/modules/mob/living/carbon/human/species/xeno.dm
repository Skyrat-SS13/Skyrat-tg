/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = SPECIES_XENO
	family_heirlooms = list(/obj/item/toy/plush/rouny, /obj/item/clothing/mask/facehugger/toy)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutanttongue = /obj/item/organ/internal/tongue/xeno_hybrid
	mutant_organs = list(/obj/item/organ/internal/alien/plasmavessel/roundstart, /obj/item/organ/internal/alien/resinspinner, /obj/item/organ/internal/alien/hivenode)
	coldmod = 0.8
	heatmod = 2.5
	mutant_bodyparts = list()
	external_organs = list()
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/xenohybrid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/xenohybrid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/xenohybrid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/xenohybrid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/xenohybrid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/xenohybrid,
	)

	meat = /obj/item/food/meat/slab/xeno
	skinned_type = /obj/item/stack/sheet/animalhide/xeno

/datum/species/xeno/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Xenomorph Tail", FALSE),
		"xenodorsal" = list("Standard", TRUE),
		"xenohead" = list("Standard", TRUE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"taur" = list("None", FALSE),
	)

/datum/species/xeno/get_species_description()
	return placeholder_description

/datum/species/xeno/get_species_lore()
	return list(placeholder_lore)

/datum/species/xeno/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "Xenomorphic Biology",
		SPECIES_PERK_DESC = "Xeno-hybrids inherit organs from their primal ascendants."
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "fire",
		SPECIES_PERK_NAME = "High Temperature Weakness",
		SPECIES_PERK_DESC = "A partial silicone structure and acid blood make the xeno-hybrid species extremely weak to heat."
	))

	return to_add

/datum/species/xeno/prepare_human_for_preview(mob/living/carbon/human/xeno)
	var/xeno_color = "#525288"
	xeno.dna.features["mcolor"] = xeno_color
	xeno.eye_color_left = "#30304F"
	xeno.eye_color_right = "#30304F"
	xeno.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Xenomorph Tail", MUTANT_INDEX_COLOR_LIST = list(xeno_color, xeno_color, xeno_color))
	xeno.dna.mutant_bodyparts["xenodorsal"] = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list(xeno_color))
	xeno.dna.mutant_bodyparts["xenohead"] = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list(xeno_color, xeno_color, xeno_color))
	regenerate_organs(xeno, src, visual_only = TRUE)
	xeno.update_body(TRUE)

/obj/item/organ/internal/alien/plasmavessel/roundstart
	stored_plasma = 55
	max_plasma = 55
	plasma_rate = 2
