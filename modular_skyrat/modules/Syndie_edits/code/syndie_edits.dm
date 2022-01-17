/obj/item/clothing/suit/armor/vest/capcarapace/syndicate_winter
	name = "syndicate captain's winter vest"
	desc = "A sinister yet comfortable looking vest of advanced armor worn over a black and red fireproof jacket. The fur is said to be from genuine wolves on the icemoon!"
	icon = 'modular_skyrat/modules/syndie_edits/icons/syndievest_winter_items.dmi'
	worn_icon = 'modular_skyrat/modules/syndie_edits/icons/syndievest_winter.dmi'
	icon_state = "syndievest_winter"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list(MELEE = 50, BULLET = 40, LASER = 50, ENERGY = 50, BOMB = 25, BIO = 0, FIRE = 100, ACID = 90, WOUND = 10)
	dog_fashion = null
	resistance_flags = FIRE_PROOF

//DS2 items

/obj/item/clothing/head/helmet/swat/ds
	name = "SWAT helmet"
	desc = "A robust and spaceworthy helmet with a small cross on it along with 'IP' written across the earpad."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "swat_ds"

/obj/item/clothing/mask/gas/syndicate/ds
	name = "balaclava"
	desc = "A fancy balaclava, while it doesn't muffle your voice, it's fireproof and has a miniature rebreather for internals. Comfy to boot!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclava_ds"
	flags_inv = HIDEHAIR | HIDEFACIALHAIR | HIDEEARS

/obj/item/clothing/shoes/combat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "combat"

/obj/item/clothing/gloves/combat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "combat"

/obj/item/clothing/gloves/tackler/combat/insulated
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "combat"

/obj/item/clothing/gloves/krav_maga/combatglovesplus
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "combat"

/obj/item/storage/belt/security/webbing/ds
	name = "brig officer webbing"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "webbingds"
	worn_icon_state = "webbingds"

/obj/item/clothing/suit/armor/bulletproof/old
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "bulletproof"
