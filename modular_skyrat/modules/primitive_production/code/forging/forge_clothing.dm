// Vests
/obj/item/clothing/suit/armor/forging_plate_armor
	name = "reagent plate vest"
	desc = "An armor vest made of hammered, interlocking plates."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_teshari.dmi'
	icon_state = "plate_vest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 10)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/clothing/suit/armor/forging_plate_armor/Initialize(mapload)
	. = ..()

	allowed += /obj/item/melee/forging_weapon

// Gloves

/obj/item/clothing/gloves/forging_plate_gloves
	name = "reagent plate gloves"
	desc = "A set of leather gloves with protective armor plates connected to the wrists."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_teshari.dmi'
	icon_state = "plate_gloves"
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 10)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

// Helmets

/obj/item/clothing/head/helmet/forging_plate_helmet
	name = "reagent plate helmet"
	desc = "A helmet out of hammered plates with a leather neck guard and chin strap."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_teshari.dmi'
	icon_state = "plate_helmet"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	flags_inv = null
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 10)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

// Boots
/obj/item/clothing/shoes/forging_plate_boots
	name = "reagent plate boots"
	desc = "A pair of leather boots with protective armor plates over the shins and toes."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing.dmi'
	worn_icon_digi = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_digi.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/primitive_production/icons/clothing/clothing_teshari.dmi'
	icon_state = "plate_boots"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 10)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	resistance_flags = FIRE_PROOF
	can_be_tied = TRUE
