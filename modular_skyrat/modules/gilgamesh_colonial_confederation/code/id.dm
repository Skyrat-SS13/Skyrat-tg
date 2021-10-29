/obj/item/card/id/advanced/centcom/ert/gcc
	name = "\improper GCC ID"
	desc = "An ID straight from the GCC."
	icon_state = "card_black"
	worn_icon_state = "card_black"
	assigned_icon_state = "assigned_centcom"

/datum/id_trim/gcc
	assignment = "Gilgamesh Colonial Confederation Soldier"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_gcc"

/datum/id_trim/gcc/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))


/datum/id_trim/gcc/commander
	assignment = "Gilgamesh Colonial Confederation Platoon Commander"
	trim_state = "trim_gcc_commander"

/datum/id_trim/gcc/heavy
	assignment = "Gilgamesh Colonial Confederation Heavy Soldier"
	trim_state = "trim_gcc"
