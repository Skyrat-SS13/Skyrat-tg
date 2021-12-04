// MODULAR ARMOUR

// SECURITY OFFICER

/obj/item/clothing/suit/armor/navyblue
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer isn't required to wear their armor."
	icon_state = "officerbluejacket"
	body_parts_covered = CHEST|ARMS
	mutant_variants = NONE

// HEAD OF SECURITY

/obj/item/clothing/suit/armor/hos/navyblue
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosbluejacket"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/cloak
	name = "armored trenchcloak"
	desc = "A trenchcoat enchanced with a special lightweight kevlar. This one appears to be designed to be draped over one's shoulders rather than worn normally.."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "trenchcloak"
	mutant_variants = NONE
	body_parts_covered = CHEST|ARMS|LEGS

/obj/item/clothing/suit/armor/hos/parade/female
	name = "head of security's female parade jacket"
	desc = "A luxurious jacket for the head of security, woven in a deep red. This one comes with white trousers. On the lapel is a small pin in the shape of a deer's head."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hos_parade_fem"
	inhand_icon_state = "hos_parade_fem"

// WARDEN

/obj/item/clothing/suit/armor/vest/warden/navyblue
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardenbluejacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/warden/syndicate
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "master at arms's vest"
	desc = "Stunning. Menacing. Perfect for the man who gets bullied for leaving the brig."
	icon_state = "warden_syndie"

// HEAD OF PERSONNEL
/obj/item/clothing/suit/toggle/hop_parade
	name = "head of personnel's parade jacket"
	desc = "A luxurious deep blue jacket for the Head of Personnel, woven with a red trim. It smells of bureaucracy."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hopformal"
	inhand_icon_state = "capspacesuit"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

/obj/item/clothing/suit/hooded/wintercoat/hop
	name = "head of personnel's winter coat"
	desc = "A long cozy winter coat, covered in thick fur. The breast features a proud yellow chevron, reminding everyone that you're the second banana. Someone at CC most really like you, huh?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Formal" = "coathop_formal",
						"Classic" = "coathop_classic"
						)

/obj/item/clothing/head/hooded/winterhood/hop
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_hop"
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Formal" = "winterhood_hop",
						"Classic" = "hood_hop"
						)

// CAPTAIN
/obj/item/clothing/suit/armor/vest/capcarapace/jacket
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "captain's jacket"
	desc = "A lightweight armored jacket in the Captain's colors. For when you want something sleeker."
	icon_state = "capjacket"
	body_parts_covered = CHEST|ARMS
