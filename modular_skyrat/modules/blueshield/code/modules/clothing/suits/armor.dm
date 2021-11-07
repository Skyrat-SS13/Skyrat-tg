//blueshield armor
/obj/item/clothing/suit/armor/vest/blueshield
	name = "Blueshield's jacket"
	desc = "An expensive kevlar-lined jacket with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks. There's a tight-fitting vest tucked in underneath."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	//alternate_worn_icon_digi = 'modular_skyrat/icons/mob/suit_digi.dmi'
	icon_state = "blueshield"
	body_parts_covered = CHEST|ARMS
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 30, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/suit/armor/vest/blueshieldarmor
	name = "Blueshield's Armor"
	desc = "A tight-fitting kevlar-lined vest with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "blueshieldarmor"
	body_parts_covered = CHEST
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 30, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/suit/hooded/wintercoat/blueshield
	name = "blueshield's winter coat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "coatblueshield"
	inhand_icon_state = "coatblueshield"
	desc = "A comfy kevlar-lined coat with \"NT\" emblazoned on the back."
	hoodtype = /obj/item/clothing/head/hooded/winterhood/blueshield
	allowed = list(/obj/item/melee/baton/security/loaded)
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 30, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/suit/hooded/wintercoat/blueshield/Initialize()
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/winterhood/blueshield
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_blueshield"
	desc = "A comfy kevlar-lined hood to go with the comfy kevlar-lined coat."
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 15, "bomb" = 25, "bio" = 0, "fire" = 75, "acid" = 75)
