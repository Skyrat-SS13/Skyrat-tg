//armor
/obj/item/clothing/suit/armor/reagent_clothing
	name = "reagent chain armor"
	desc = "A piece of armor made out of chains."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "chain_armor"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing_digi.dmi'
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 30)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/clothing/suit/armor/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_OCLOTHING)

//gloves
/obj/item/clothing/gloves/reagent_clothing
	name = "reagent chain gloves"
	desc = "A set of gloves made out of chains."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "chain_glove"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 30)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/clothing/gloves/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_GLOVES)

/obj/item/clothing/head/helmet/reagent_clothing
	name = "reagent chain helmet"
	desc = "A helmet made out of chains."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "chain_helmet"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 0, WOUND = 30)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/clothing/head/helmet/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 4)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_HEAD)

/obj/item/clothing/shoes/chain_boots
	name = "reagent chain boots"
	desc = "A pair of boots made out of chains."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "chain_boot"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing_digi.dmi'
	armor = list(MELEE = 20, BULLET = 20, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	can_be_tied = FALSE

/obj/item/clothing/shoes/chain_boots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_FEET)

/obj/item/clothing/shoes/plated_boots
	name = "reagent plated boots"
	desc = "A pair of boots made out of plates."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "plate_boot"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing_digi.dmi'
	armor = list(MELEE = 20, BULLET = 20, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	can_be_tied = FALSE

/obj/item/clothing/shoes/plated_boots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_FEET)

/obj/item/clothing/shoes/horseshoe
	name = "reagent horseshoe"
	desc = "A pair of horseshoes made out of chains."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "horseshoe"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list(MELEE = 20, BULLET = 20, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF
	can_be_tied = FALSE

/obj/item/clothing/shoes/horseshoe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2)
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_FEET)

/obj/item/clothing/gloves/ring/reagent_clothing
	name = "reagent ring"
	desc = "A tiny ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	inhand_icon_state = "sring"
	worn_icon_state = "sring"
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

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

/obj/item/clothing/neck/collar/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_NECK)

/obj/item/restraints/handcuffs/reagent_clothing
	name = "reagent handcuffs"
	desc = "A pair of handcuffs that are ready to keep someone captive."
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/restraints/handcuffs/reagent_clothing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_clothing, ITEM_SLOT_HANDCUFFED)
