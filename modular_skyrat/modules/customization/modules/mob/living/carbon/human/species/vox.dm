/datum/species/vox
	// Bird-like humanoids
	name = "Vox"
	id = SPECIES_VOX
	eyes_icon = 'modular_skyrat/modules/organs/icons/vox_eyes.dmi'
	can_augment = FALSE
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutanttongue = /obj/item/organ/internal/tongue/vox
	mutantlungs = /obj/item/organ/internal/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/internal/brain/vox
	breathid = "n2"
	mutant_bodyparts = list()
	payday_modifier = 1.0
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/vox,
	)
	custom_worn_icons = list(
		OFFSET_HEAD = VOX_HEAD_ICON,
		OFFSET_FACEMASK = VOX_MASK_ICON,
		OFFSET_SUIT = VOX_SUIT_ICON,
		OFFSET_UNIFORM = VOX_UNIFORM_ICON,
		OFFSET_GLOVES =  VOX_HANDS_ICON,
		OFFSET_SHOES = VOX_FEET_ICON,
		OFFSET_GLASSES = VOX_EYES_ICON,
		OFFSET_BELT = VOX_BELT_ICON,
		OFFSET_BACK = VOX_BACK_ICON,
		OFFSET_EARS = VOX_EARS_ICON
	)

	meat = /obj/item/food/meat/slab/chicken/human //item file in teshari module

/datum/species/vox/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Vox Tail", FALSE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"snout" = list("Vox Snout", FALSE),
		"spines" = list("Vox Bands", TRUE),
	)

/datum/species/vox/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.vox_outfit)
		equipping.equipOutfit(job.vox_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/vox/randomize_features()
	var/list/features = ..()
	features["mcolor"] = pick("#77DD88", "#77DDAA", "#77CCDD", "#77DDCC")
	features["mcolor2"] = pick("#EEDD88", "#EECC88")
	features["mcolor3"] = pick("#222222", "#44EEFF", "#44FFBB", "#8844FF", "#332233")
	return features

/datum/species/vox/get_random_body_markings(list/passed_features)
	var/name = pick(list("Vox", "Vox Hive", "Vox Nightling", "Vox Heart", "Vox Tiger"))
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/vox/get_custom_worn_icon(item_slot, obj/item/item)
	// snowflakey but vox legs weird.
	if(item_slot == OFFSET_SHOES)
		var/obj/item/bodypart/leg = bodypart_overrides[BODY_ZONE_L_LEG] || bodypart_overrides[BODY_ZONE_R_LEG]
		if(initial(leg?.limb_id) != "digitigrade")
			// normal legs, use normal human shoes
			return DEFAULT_SHOES_FILE

	return item.worn_icon_vox

/datum/species/vox/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_vox = icon

/datum/species/vox/get_species_description()
	return placeholder_description

/datum/species/vox/get_species_lore()
	return list(placeholder_lore)

/datum/species/vox/prepare_human_for_preview(mob/living/carbon/human/vox)
	vox.dna.features["mcolor"] = "#77DD88"
	vox.dna.features["mcolor2"] = "#EEDD88"
	vox.dna.features["mcolor3"] = "#222222"
	vox.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Vox Snout", MUTANT_INDEX_COLOR_LIST = list("#EEDD88"))
	regenerate_organs(vox, src, visual_only = TRUE)
	vox.update_body(TRUE)
