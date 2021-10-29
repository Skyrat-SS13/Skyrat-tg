/obj/item/card/id/advanced/centcom/ert/gcc
	name = "\improper GCC ID"
	desc = "An ID straight from the GCC."
	icon_state = "card_black"
	worn_icon_state = "card_black"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/gcc

/datum/id_trim/gcc
	assignment = "Gilgamesh Colonial Federation Soldier"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_gcc"

/datum/id_trim/gcc/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/obj/item/card/id/advanced/centcom/ert/gcc/commander
	trim = /datum/id_trim/gcc/commander

/datum/id_trim/gcc/commander
	assignment = "Gilgamesh Colonial Federation Platoon Commander"
	trim_state = "trim_gcc_commander"
