/*

Demonstration setup for Security clothing overrides.

This method allows us to redo a job's starting equipment without dirty edits to core /tg/ code.

Uncomment the below lines to enable the example Eris Security "Ironhammer" override.

*/
/*
/datum/job/security_officer
	outfit = /datum/outfit/job/security/ironhammer

/datum/job/warden
	outfit = /datum/outfit/job/warden/ironhammer

/datum/job/head_of_security
	outfit = /datum/outfit/job/hos/ironhammer

/datum/job/security_medic // this one actually doesn't work because of byond and the compile order of the DME, security_medic.dm is defined way after this file.
	outfit = /datum/outfit/job/security_medic/ironhammer
*/
/datum/outfit/job/security_medic/ironhammer
	name = "Security Medic (Ironhammer)"

	uniform = /obj/item/clothing/under/rank/security/peacekeeper/security_medic/ironhammer
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/ironhammer
	shoes = /obj/item/clothing/shoes/jackboots/ironhammer
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/toggle/labcoat/security_medic/ironhammer

	backpack = /obj/item/storage/backpack/security/ironhammer
	satchel = /obj/item/storage/backpack/satchel/sec/ironhammer
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/ironhammer

	box = /obj/item/storage/box/survival/security/ironhammer

/datum/outfit/job/security/ironhammer
	name = "Security Officer (Ironhammer)"

	uniform = /obj/item/clothing/under/rank/security/officer/ironhammer
	suit = /obj/item/clothing/suit/armor/vest/ironhammer
	gloves = /obj/item/clothing/gloves/color/black/ironhammer
	head = /obj/item/clothing/head/helmet/sec/ironhammer
	shoes = /obj/item/clothing/shoes/jackboots/ironhammer

	backpack = /obj/item/storage/backpack/security/ironhammer
	satchel = /obj/item/storage/backpack/satchel/sec/ironhammer
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/ironhammer

	box = /obj/item/storage/box/survival/security/ironhammer
	chameleon_extras = list(
		/obj/item/clothing/glasses/hud/security/sunglasses/ironhammer,
		/obj/item/clothing/head/helmet/sec/ironhammer,
		/obj/item/gun/energy/disabler,
	)

/datum/outfit/job/warden/ironhammer
	name = "Warden (Ironhammer)"
	uniform = /obj/item/clothing/under/rank/security/warden/ironhammer
	suit = /obj/item/clothing/suit/armor/vest/warden/ironhammer
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ironhammer
	gloves = /obj/item/clothing/gloves/color/black/ironhammer
	head = /obj/item/clothing/head/warden/ironhammer
	shoes = /obj/item/clothing/shoes/jackboots/ironhammer

	backpack = /obj/item/storage/backpack/security/ironhammer
	satchel = /obj/item/storage/backpack/satchel/sec/ironhammer
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/ironhammer

	box = /obj/item/storage/box/survival/security/ironhammer

/datum/outfit/job/hos/ironhammer
	name = "Head of Security (Ironhammer)"
	uniform = /obj/item/clothing/under/rank/security/head_of_security/ironhammer
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat/ironhammer
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ironhammer
	gloves = /obj/item/clothing/gloves/color/black/ironhammer
	head = /obj/item/clothing/head/hos/ironhammer
	shoes = /obj/item/clothing/shoes/jackboots/ironhammer

	backpack = /obj/item/storage/backpack/security/ironhammer
	satchel = /obj/item/storage/backpack/satchel/sec/ironhammer
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/ironhammer

	box = /obj/item/storage/box/survival/security/ironhammer

/obj/item/clothing/head/warden/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/head.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/head_worn.dmi'
	worn_icon_state = "beret_navy_warden"
	icon_state = "beret_navy_warden"

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/under.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/under_worn.dmi'
	worn_icon_state = "medspec"
	icon_state = "medspec"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/under.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/under_worn.dmi'
	worn_icon_state = "security"
	icon_state = "security"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/warden/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/under.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/under_worn.dmi'
	worn_icon_state = "warden"
	icon_state = "warden"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/under.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/under_worn.dmi'
	worn_icon_state = "hos"
	icon_state = "hos"
	can_adjust = FALSE

/obj/item/clothing/suit/armor/vest/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit_worn.dmi'
	worn_icon_state = "armor_ironhammer"
	icon_state = "armor_ironhammer"

/obj/item/clothing/suit/armor/vest/warden/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit_worn.dmi'
	worn_icon_state = "armor_ironhammer_fullbody"
	icon_state = "armor_ironhammer_fullbody"

/obj/item/clothing/suit/armor/hos/trenchcoat/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit_worn.dmi'
	worn_icon_state = "greatcoat_ironhammer"
	icon_state = "greatcoat_ironhammer"

/obj/item/clothing/suit/toggle/labcoat/security_medic/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/suit_worn.dmi'
	worn_icon_state = "labcoat_medspec"
	icon_state = "labcoat_medspec"

/obj/item/clothing/gloves/color/latex/nitrile/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/hands.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/hands_worn.dmi'
	worn_icon_state = "security_ironhammer"
	icon_state = "security_ironhammer"

/obj/item/clothing/gloves/color/black/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/hands.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/hands_worn.dmi'
	worn_icon_state = "security_ironhammer"
	icon_state = "security_ironhammer"

/obj/item/clothing/head/helmet/sec/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/head.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/head_worn.dmi'
	worn_icon_state = "helmet_ironhammer"
	icon_state = "helmet_ironhammer"

/obj/item/clothing/head/hos/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/head.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/head_worn.dmi'
	worn_icon_state = "hoshat"
	icon_state = "hoshat"

/obj/item/clothing/shoes/jackboots/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/shoes_worn.dmi'
	worn_icon_state = "jackboots_ironhammer"
	icon_state = "jackboots_ironhammer"

/obj/item/storage/backpack/security/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/back.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/back_worn.dmi'
	worn_icon_state = "backsport_ironhammer"
	icon_state = "backsport_ironhammer"

/obj/item/storage/backpack/satchel/sec/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/back.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/back_worn.dmi'
	worn_icon_state = "satchel_ironhammer"
	icon_state = "satchel_ironhammer"

/obj/item/storage/backpack/duffelbag/sec/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/back.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/back_worn.dmi'
	worn_icon_state = "backpack_ironhammer"
	icon_state = "backpack_ironhammer"

/obj/item/clothing/glasses/hud/security/sunglasses/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/eyes.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/eyes_worn.dmi'
	worn_icon_state = "swatgoggles"
	icon_state = "swatgoggles"

/obj/item/clothing/mask/gas/sechailer/ironhammer
	icon = 'modular_skyrat/modules/goofsec/icons/clothing/mask.dmi'
	worn_icon = 'modular_skyrat/modules/goofsec/icons/clothing/mask_worn.dmi'
	worn_icon_state = "IHSgasmask"
	icon_state = "IHSgasmask"
	actions_types = list(/datum/action/item_action/halt)

/obj/item/storage/box/survival/security/ironhammer
	mask_type = /obj/item/clothing/mask/gas/sechailer/ironhammer
