/obj/item/clothing/under/rank/security/peacekeeper/armadyne
	name = "armadyne corporate uniform"
	desc = "A robust uniform worn by ArmaDyne corporate."
	icon_state = "armadyne"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'

/obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	name = "armadyne corporate beret"
	desc = "A comfy yet robust beret worn by ArmaDyne corporate."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	icon_state = "armadyne_beret"
	mutant_variants = NONE
	armor = list(MELEE = 50, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 0, RAD = 0, FIRE = 90, ACID = 90, WOUND = 30)

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/armadyne
	name = "armored armadyne trenchcoat"
	desc = "An ArmaDyne branded trenchcoat, feels heavy, premium, and pristegious. Worn by ArmaDyne corporate."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	icon_state = "armadyne_trench"
	armor = list(MELEE = 50, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 0, RAD = 0, FIRE = 90, ACID = 90, WOUND = 30)

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	name = "arored armadyne armor jacket"
	desc = "An ArmaDyne branded suit vest, feels heavy, premium, and pristegious. Worn by ArmaDyne corporate."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	icon_state = "armadyne_jacket"
	worn_icon_state = "armadyne_jacket"
	mutant_variants = NONE
	armor = list(MELEE = 50, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 0, RAD = 0, FIRE = 90, ACID = 90, WOUND = 30)

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	name = "armadyne hud glasses"
	icon_state = "armadyne_glasses"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'

/obj/item/clothing/gloves/combat/peacekeeper/armadyne
	name = "armadyne combat gloves"
	desc = "Tactical and sleek. Worn by ArmaDyne representatives."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	icon_state = "armadyne_gloves"
	worn_icon_state = "armadyne_gloves"
	cut_type = null

/obj/item/clothing/shoes/combat/peacekeeper/armadyne
	name = "armadyne combat boots"
	desc = "Tactical and sleek. Worn by ArmaDyne representatives."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armadyne/armadyne_clothing.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_boots_digi.dmi'
	icon_state = "armadyne_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "armadyne_boots"


/obj/item/storage/belt/holster/detective/armadyne
	name = "armadyne shoulder holster"
	desc = "A sleek ArmaDyne shoudler holster"
	icon_state = "holster"
	inhand_icon_state = "holster"
	worn_icon_state = "holster"
	alternate_worn_layer = UNDER_SUIT_LAYER

/datum/outfit/armadyne_rep
	name = "ArmaDyne Corporate Representative"

	suit_store = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne
	gloves = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	head =  /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	shoes = /obj/item/clothing/shoes/combat/peacekeeper/armadyne
	belt = /obj/item/storage/belt/holster/detective/armadyne
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic, /obj/item/storage/box/gunset/pdh_captain, /obj/item/card/id/debug, /obj/item/card/id/syndicate/anyone)
	back = /obj/item/storage/backpack/satchel/leather
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)


