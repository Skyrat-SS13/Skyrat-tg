// 1 2 3 4 marine corps marine corps
//parent type already has EMP protection and stuff

/obj/item/storage/backpack/ert/marine
	name = "marine backpack"
	desc = "A spacious backpack with lots of pockets and a magnetic latching mechanism to attach to whatever gear one might wear."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "marine"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/ert/marine/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 30
