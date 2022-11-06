/obj/item/armament_token
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi'
	icon_state = "token_sidearm"
	w_class = WEIGHT_CLASS_TINY
	var/minimum_sec_level = SEC_LEVEL_GREEN

/obj/item/armament_token/proc/get_available_gunsets()
	return FALSE
