/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = 30

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/snail)
	snail.dna.features["mcolor"] = "#adaba7"
	snail.update_body(TRUE)

/datum/species/snail/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "home",
			SPECIES_PERK_NAME = "Shellback",
			SPECIES_PERK_DESC = "Snails have a shell fused to their back. While it doesn't offer any protection, it offers great storage. Alt click to change the sprite!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wine-glass",
			SPECIES_PERK_NAME = "Poison Resistance",
			SPECIES_PERK_DESC = "Snails have a higher tolerance for poison owing to their robust livers.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "water",
			SPECIES_PERK_NAME = "Water Breathing",
			SPECIES_PERK_DESC = "Snails can breathe underwater.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Boneless",
			SPECIES_PERK_DESC = "Snails are invertebrates.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "crutch",
			SPECIES_PERK_NAME = "Sheer Mollusk Speed",
			SPECIES_PERK_DESC = "Snails move incredibly slow while standing. They move much faster while crawling.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "frown",
			SPECIES_PERK_NAME = "Weak Fighter",
			SPECIES_PERK_DESC = "Snails punch half as hard as a human.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "skull",
			SPECIES_PERK_NAME = "Salt Weakness",
			SPECIES_PERK_DESC = "Salt burns snails, and salt piles will block their path.",
		),
	)

	return to_add
