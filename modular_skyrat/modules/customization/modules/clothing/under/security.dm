// MODULAR SECURITY WEAR

// HEAD OF SECURITY

/obj/item/clothing/under/rank/security/head_of_security/parade
	name = "head of security's male parade uniform"
	desc = "A luxurious uniform for the head of security, woven in a deep red. On the lapel is a small pin in the shape of a deer's head."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_parade_male"
	inhand_icon_state = "hos_parade_male"
	can_adjust = FALSE

/obj/item/clothing/suit/armor/hos/parade
	name = "head of security's parade jacket"
	desc = "A luxurious deep red jacket for the head of security, woven with a golden trim. It smells of gunpowder and authority."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "hos_parade"
	inhand_icon_state = "hos_parade"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

// DETECTIVE

/obj/item/clothing/under/rank/security/detective/undersuit
	name = "detective's undersuit"
	desc = "A cool beige undersuit for the discerning PI."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/under/security.dmi'
	icon_state = "det_undersuit"
	inhand_icon_state = "det_undersuit"
	mutant_variants = NONE
	can_adjust = FALSE

/obj/item/clothing/suit/det_bomber
	name = "detective's bomber jacket"
	desc = "A classic bomber jacket in a deep red. It has a clip on the breast to attach your badge."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "det_bomber"
	inhand_icon_state = "det_bomber"
	body_parts_covered = CHEST|ARMS
	armor = list(MELEE = 25, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 45)
	cold_protection = CHEST|ARMS
	mutant_variants = NONE
	heat_protection = CHEST|ARMS
