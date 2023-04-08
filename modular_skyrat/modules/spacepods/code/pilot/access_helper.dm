/obj/effect/mapping_helpers/airlock/access/any/security/spacepod_pilot/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_SPACEPOD_HANGAR
	return access_list
