// Vests
/obj/item/clothing/suit/armor/forging_plate_armor
	name = "reagent plate vest"
	desc = "An armor vest made of hammered, interlocking plates."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_vest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	skyrat_obj_flags = ANVIL_REPAIR
	armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 30)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/clothing/suit/armor/forging_plate_armor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_OCLOTHING)

	allowed += /obj/item/forging/reagent_weapon

// Gloves
/obj/item/clothing/gloves/forging_plate_gloves
	name = "reagent plate gloves"
	desc = "A set of leather gloves with protective armor plates connected to the wrists."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_gloves"
	resistance_flags = FIRE_PROOF
	skyrat_obj_flags = ANVIL_REPAIR
	armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 30)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/clothing/gloves/forging_plate_gloves/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_GLOVES)

// Helmets
/obj/item/clothing/head/helmet/forging_plate_helmet
	name = "reagent plate helmet"
	desc = "A helmet out of hammered plates with a leather neck guard and chin strap."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_helmet"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	flags_inv = null
	skyrat_obj_flags = ANVIL_REPAIR
	armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 30)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/clothing/head/helmet/forging_plate_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_HEAD)

// Boots
/obj/item/clothing/shoes/forging_plate_boots
	name = "reagent plate boots"
	desc = "A pair of leather boots with protective armor plates over the shins and toes."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	worn_icon_digi = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_digi.dmi'
	worn_icon_better_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_newvox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_oldvox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing_teshari.dmi'
	icon_state = "plate_boots"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	armor = list(MELEE = 20, BULLET = 20, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	skyrat_obj_flags = ANVIL_REPAIR
	can_be_tied = FALSE

/obj/item/clothing/shoes/forging_plate_boots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_FEET)

/obj/item/clothing/shoes/horseshoe
	name = "reagent horseshoe"
	desc = "A pair of horseshoes made out of chains."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/clothing/forge_clothing.dmi'
	icon_state = "horseshoe"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list(MELEE = 20, BULLET = 20, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	skyrat_obj_flags = ANVIL_REPAIR
	can_be_tied = FALSE

/obj/item/clothing/shoes/horseshoe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_FEET)

// Misc
/obj/item/clothing/gloves/ring/reagent_clothing
	name = "reagent ring"
	desc = "A tiny ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	worn_icon_state = "sring"
	inhand_icon_state = null
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	skyrat_obj_flags = ANVIL_REPAIR

/obj/item/clothing/gloves/ring/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_GLOVES)

/obj/item/clothing/neck/collar/reagent_clothing
	name = "reagent collar"
	desc = "A collar that is ready to be worn for certain individuals."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_cyan"
	inhand_icon_state = null
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	skyrat_obj_flags = ANVIL_REPAIR

/obj/item/clothing/neck/collar/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_NECK)

/obj/item/restraints/handcuffs/reagent_clothing
	name = "reagent handcuffs"
	desc = "A pair of handcuffs that are ready to keep someone captive."
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	skyrat_obj_flags = ANVIL_REPAIR

/obj/item/restraints/handcuffs/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_HANDCUFFED)
