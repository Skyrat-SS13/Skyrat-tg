/obj/item/clothing/under/rank/security/peacekeeper/armatek
	name = "armatek corporate uniform"
	desc = "A robust uniform worn by ArmaTek corporate."
	icon_state = "armatek"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing_digi.dmi'

/obj/item/clothing/head/beret/sec/peacekeeper/armatek
	name = "armatek corporate beret"
	desc = "A comfy yet robust beret worn by ArmaTek corporate."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	icon_state = "armatek_beret"
	mutant_variants = NONE
	armor = list(MELEE = 50, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 0, RAD = 0, FIRE = 90, ACID = 90, WOUND = 30)

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/armatek
	name = "armored armatek trenchcoat"
	desc = "An ArmaTek branded trenchcoat, feels heavy, premium, and pristegious. Worn by ArmaTek corporate."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	icon_state = "armatek_trench"
	armor = list(MELEE = 50, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 0, RAD = 0, FIRE = 90, ACID = 90, WOUND = 30)

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armatek
	name = "armatek hud glasses"
	icon_state = "armatek_glasses"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'

/obj/item/clothing/gloves/combat/peacekeeper/armatek
	name = "armatek gloves"
	desc = "Tactical and sleek. Worn by ArmaTek representatives."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/armatek/armatek_clothing.dmi'
	icon_state = "armatek_gloves"
	worn_icon_state = "armatek_gloves"
	cut_type = null


/datum/outfit/armatek_rep
	name = "ArmaTek Corporate Representative"

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armatek
	gloves = /obj/item/clothing/gloves/combat/peacekeeper/armatek
	head =  /obj/item/clothing/head/beret/sec/peacekeeper/armatek
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armatek
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/armatek
	shoes = /obj/item/clothing/shoes/combat
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic, /obj/item/storage/box/gunset/pdh_captain, /obj/item/card/id/debug, /obj/item/card/id/syndicate/anyone)
	backpack = /obj/item/storage/backpack/satchel/leather
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)


