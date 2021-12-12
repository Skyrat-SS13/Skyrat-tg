/obj/item/clothing/head/helmet/space/hardsuit/ert/marine
	name = "marine helmet"
	desc = "The integrated helmet of an advanced Marine hardsuit, fielded by Nanotrasen's navy."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-marine"
	inhand_icon_state = "hardsuit0-marine" //should never be able to hold it but hey
	hardsuit_type = "marine"
	armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 60, BOMB = 80, BIO = 100, FIRE = 100, ACID = 80)

/obj/item/clothing/suit/space/hardsuit/ert/marine
	name = "marine hardsuit"
	desc = "The standard issue hardsuit of the Nanotrasen Marine Corps, fitted with advanced plasteel composite plating and a nanogel-lined undersuit for maximum protection and minimal slowdown."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "marinesuit"
	inhand_icon_state = "ert_security"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/marine
	armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 60, BOMB = 80, BIO = 100, FIRE = 100, ACID = 80)

// 1 2 3 4 marine corps marine corps
//parent type already has EMP protection and stuff

/obj/item/storage/backpack/ert/marine
	name = "marine backpack"
	desc = "A spacious backpack with lots of pockets and a magnetic latching mechanism to attach to whatever gear one might wear. In this case, preferrably a marine hardsuit."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "marine"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/ert/marine/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 30
