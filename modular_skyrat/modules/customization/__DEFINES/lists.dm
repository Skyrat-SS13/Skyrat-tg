/// What accessories can a species have as well as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
GLOBAL_LIST_EMPTY(default_mutant_bodyparts)
GLOBAL_LIST_INIT(possible_genitals, list(
	ORGAN_SLOT_VAGINA,
	ORGAN_SLOT_WOMB,
	ORGAN_SLOT_TESTICLES,
	ORGAN_SLOT_BREASTS,
	ORGAN_SLOT_ANUS,
	ORGAN_SLOT_PENIS
))

GLOBAL_LIST_EMPTY(body_markings)
GLOBAL_LIST_EMPTY_TYPED(body_markings_per_limb, /list)
GLOBAL_LIST_EMPTY(body_marking_sets)

GLOBAL_LIST_EMPTY(loadout_items)
GLOBAL_LIST_EMPTY(loadout_category_to_subcategory_to_items)

GLOBAL_LIST_EMPTY(augment_items)
GLOBAL_LIST_EMPTY(augment_categories_to_slots)
GLOBAL_LIST_EMPTY(augment_slot_to_items)

GLOBAL_LIST_EMPTY(dna_body_marking_blocks)

GLOBAL_LIST_EMPTY(species_clothing_fallback_cache)
