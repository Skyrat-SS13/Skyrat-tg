
/obj/effect/mapping_helpers/airlock/access/all/tarkon
	icon_state = "access_helper_syn"

/obj/effect/mapping_helpers/airlock/access/all/tarkon/general/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_TARKON
	return access_list
