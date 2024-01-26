/datum/species/dwarf
	name = "Dwarf"
	id = SPECIES_DWARF
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_DWARF,TRAIT_SNOB,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_USES_SKINTONES,
	)
	mutanttongue = /obj/item/organ/internal/tongue/dwarven
	skinned_type = /obj/item/stack/sheet/animalhide/human
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	body_size_restricted = TRUE

/datum/species/dwarf/get_species_description()
	return placeholder_description

/datum/species/dwarf/get_species_lore()
	return list(placeholder_lore)

/datum/species/dwarf/prepare_human_for_preview(mob/living/carbon/human/human)
	human.facial_hairstyle = "Beard (Dwarf)"
	human.facial_hair_color = "#a55310"
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)
