/obj/item/clothing/head/beret/sec/nri
	name = "commander's beret"
	desc = "Za rodinu!!"
	armor_type = /datum/armor/sec_nri

/datum/armor/sec_nri
	melee = 40
	bullet = 35
	laser = 30
	energy = 40
	bomb = 25
	fire = 20
	acid = 50
	wound = 20

/obj/item/clothing/head/helmet/space/hev_suit/nri
	name = "\improper VOSKHOD powered combat armor helmet"
	desc = "A composite graphene-plasteel helmet with a ballistic nylon inner padding, complete with a deployable airtight polycarbonate visor and respirator system. 'НРИ - Оборонная Коллегия' is imprinted on the back."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/head.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	obj_flags = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT|BLOCK_GAS_SMOKE_EFFECT
	clothing_traits = null
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_WELDER
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	visor_flags = STOPSPRESSUREDAMAGE
	slowdown = 0

/obj/item/clothing/head/helmet/space/hev_suit/nri/captain
	name = "\improper VOSKHOD-2 powered combat armor helmet"
	desc = "A black composite polyurea coated graphene-plastitanium helmet with durathread inner padding, complete with a deployable airtight tinted plasmaglass visor and a kevlar-lined respirator system. 'НРИ - Оборонная Коллегия' is imprinted on the back."
	icon_state = "nri_captain"

/obj/item/clothing/head/helmet/space/hev_suit/nri/medic
	name = "\improper VOSKHOD-KH powered combat armor helmet"
	desc = "A combat medic's composite graphene-titanium helmet with bio-resistant padding, complete with a deployable airtight polycarbonate visor and optimized respirator system. 'НРИ - Оборонная Коллегия' is imprinted on the back."
	icon_state = "nri_medic"

/obj/item/clothing/head/helmet/space/hev_suit/nri/engineer
	name = "\improper VOSKHOD-IN powered combat armor helmet"
	desc = "A composite tungsten-plasteel helmet with a lead-lined ballistic nylon inner padding, complete with a deployable airtight polycarbonate visor and respirator system. 'НРИ - Оборонная Коллегия' is imprinted on the back."
	icon_state = "nri_engineer"
