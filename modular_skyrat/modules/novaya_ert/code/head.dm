/obj/item/clothing/head/helmet/rus_helmet/nri
	name = "\improper M-42 helmet"
	desc = "A lightweight M-42 helmet, previously used by the NRI military. This helmet performed well in the Border War against SolFed, but NRI required significant design changes due to the enemy's new and improved weaponry. These models were recently phased out and then quickly found their way onto the black market, now commonly seen in the hands (or on the heads) of insurgents."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/head.dmi'
	icon_state = "russian_green_helmet"
	armor_type = /datum/armor/rus_helmet_nri
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/rus_helmet_nri
	melee = 30
	bullet = 40
	laser = 20
	energy = 30
	bomb = 35
	fire = 50
	acid = 50
	wound = 15

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

/obj/item/clothing/head/helmet/nri_heavy
	name = "\improper Cordun-M helmet"
	desc = "A heavy Russian combat helmet with a strong ballistic visor. Alt+click to adjust."
	icon_state = "russian_heavy_helmet"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	armor_type = /datum/armor/helmet_nri_heavy
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT|BLOCK_GAS_SMOKE_EFFECT|THICKMATERIAL
	/// What position the helmet is in, TRUE = DOWN, FALSE = UP
	var/helmet_position = TRUE

/datum/armor/helmet_nri_heavy
	melee = 60
	bullet = 60
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 70
	acid = 70
	wound = 35

/obj/item/clothing/head/helmet/nri_heavy/AltClick(mob/user)
	. = ..()
	helmet_position = !helmet_position
	to_chat(user, span_notice("You flip [src] [helmet_position ? "down" : "up"] with a heavy clunk!"))
	update_appearance()

/obj/item/clothing/head/helmet/nri_heavy/update_icon_state()
	. = ..()
	var/state = "[initial(icon_state)]"
	if(helmet_position)
		state += "-down"
	else
		state += "-up"
	icon_state = state

/obj/item/clothing/head/helmet/nri_heavy/mob_can_equip(mob/living/M, slot, disable_warning, bypass_equip_delay_self, ignore_equipped)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

/obj/item/clothing/head/helmet/nri_heavy/old
	name = "\improper REDUT helmet"
	desc = "A heavy Russian combat helmet with a strong ballistic visor. Alt+click to adjust."
	armor_type = /datum/armor/nri_heavy_old
	resistance_flags = FIRE_PROOF|ACID_PROOF|FREEZE_PROOF
	clothing_flags = SNUG_FIT|THICKMATERIAL

/datum/armor/nri_heavy_old
	melee = 50
	bullet = 50
	laser = 40
	energy = 50
	bomb = 75
	bio = 60
	fire = 45
	acid = 45
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
