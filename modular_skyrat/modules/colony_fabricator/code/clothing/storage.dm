// Backpacks

/obj/item/storage/backpack/industrial/frontier_colonist
	name = "frontier backpack"
	desc = "A rugged backpack often used by settlers and explorers. Holds all of your equipment and then some."

	icon = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing.dmi'
	icon_state = "backpack"

	worn_icon = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "backpack"

	inhand_icon_state = null

	storage_type = /datum/storage/duffel/syndicate

/obj/item/storage/backpack/industrial/frontier_colonist/satchel
	name = "frontier satchel"
	desc = "A rugged satchel often used by settlers and explorers. Holds all of your equipment and then some."

	icon_state = "satchel"
	worn_icon_state = "satchel"

/obj/item/storage/backpack/industrial/frontier_colonist/messenger
	name = "frontier messenger bag"
	desc = "A rugged messenger bag often used by settlers and explorers. Holds all of your equipment and then some."

	icon_state = "messenger"
	worn_icon_state = "messenger"

// Belts

/obj/item/storage/belt/frontier_colonist
	name = "frontier chest rig"
	desc = "A versatile chest rig with pockets to store really whatever you could think of within."

	icon = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing.dmi'
	icon_state = "harness"

	worn_icon = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "harness"

	inhand_icon_state = null

/obj/item/storage/belt/frontier_colonist/Initialize(mapload)
	. = ..()

	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 21 // Surely this will have no consequences

/obj/item/storage/belt/medical/frontier_colonist
	name = "frontier medical belt bag"
	desc = "A bulky medical bag often seen worn by early frontier doctors without a place to work, \
		military medics, and other undesireable individuals."

	icon = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing.dmi'
	icon_state = "IM_DYING_I_NEED_A"

	worn_icon = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/colony_fabricator/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "IM_DYING_I_NEED_A"

	inhand_icon_state = null

/obj/item/storage/belt/medical/frontier_colonist/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 14 // Sometimes you gotta carry the whole medbay on your back
	atom_storage.max_total_storage = 35 // 7 normal items + 7 small items, limited to whatever a med belt can hold
