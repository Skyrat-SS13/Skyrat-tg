/obj/item/clothing/head/helmet/rus_helmet
	name = "\improper M-42 helmet"
	desc = "A lightweight M-42 helmet, previously used by the NRI military. This helmet performed well in the Border War against SolFed, but NRI required significant design changes due to the enemy's new and improved weaponry. These models were recently phased out and then quickly found their way onto the black market, now commonly seen in the hands (or on the heads) of insurgents."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "russian_green_helmet"
	armor = list(MELEE = 30, BULLET = 40, LASER = 20, ENERGY = 30, BOMB = 35, BIO = 0, FIRE = 50, ACID = 50, WOUND = 15)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/rus_helmet/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

/obj/item/clothing/head/beret/sec/nri
	name = "commander's beret"
	desc = "Za rodinu!!"
	armor = list(MELEE = 40, BULLET = 35, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 20, ACID = 50, WOUND = 20)

/obj/item/clothing/head/helmet/nri_heavy
	name = "\improper Cordun-M helmet"
	desc = "A heavy Russian combat helmet with a strong ballistic visor. Alt+click to adjust."
	icon_state = "russian_heavy_helmet"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	armor = list(MELEE = 60, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 100, BIO = 100, FIRE = 70, ACID = 70, WOUND = 35)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT|BLOCK_GAS_SMOKE_EFFECT|THICKMATERIAL
	/// What position the helmet is in, TRUE = DOWN, FALSE = UP
	var/helmet_position = TRUE

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

/obj/item/clothing/head/helmet/nri_heavy/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

/obj/item/clothing/head/helmet/nri_heavy/old
	name = "\improper REDUT helmet"
	desc = "A heavy Russian combat helmet with a strong ballistic visor. Alt+click to adjust."
	icon_state = "russian_heavy_helmet_old"
	armor = list(MELEE = 50, BULLET = 50, LASER = 40, ENERGY = 50, BOMB = 75, BIO = 60, FIRE = 45, ACID = 45, WOUND = 20)
	resistance_flags = FIRE_PROOF|ACID_PROOF|FREEZE_PROOF
	clothing_flags = SNUG_FIT|THICKMATERIAL

/obj/item/clothing/head/helmet/space/hev_suit/nri
	name = "\improper VOSKHOD powered combat armor helmet"
	desc = "A composite graphene-plasteel helmet with a ballistic nylon inner padding, complete with a deployable airtight polycarbonate visor and respirator system. 'НРИ - Оборонная Коллегия' is imprinted on the back."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "nri_soldier"
	inhand_icon_state = "sec_helm"
	armor = list(MELEE = 25, BULLET = 25, LASER = 25, ENERGY = 25, BOMB = 25, BIO = 20, FIRE = 20, ACID = 20, WOUND = 10)
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

/obj/item/clothing/head/helmet/space/hev_suit/nri/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

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
