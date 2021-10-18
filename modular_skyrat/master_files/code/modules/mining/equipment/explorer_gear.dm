/****************Explorer's Suit and Mask****************/
/obj/item/clothing/suit/hooded/explorer
	name = "explorer suit"
	desc = "An armoured suit for exploring harsh environments."
	icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'  //To keep the old version.
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi' //To keep the old version.
	icon_state = "explorer"
	inhand_icon_state = "explorer"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/explorer
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/hooded/explorer
	name = "explorer hood"
	desc = "An armoured hood for exploring harsh environments."
	icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi' //To keep the old version before #8911
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi' //To keep the old version before #8911
	icon_state = "explorer"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	cold_protection = HEAD
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF
