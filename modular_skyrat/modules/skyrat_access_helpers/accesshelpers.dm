/* Read the main access_helpers.dm for more information on these mapping tools.
TLDR:
Any requires only ONE of the accesses for the door to be opened
All requires ALL of the accesses for the door to be opened
*/

// Any

// Central Command
/obj/effect/mapping_helpers/airlock/access/any/cent_com
	icon_state = "access_helper_serv"

// NT Consultant
/obj/effect/mapping_helpers/airlock/access/any/cent_com/rep_door/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_CENT_GENERAL
	return access_list

// All

// Central Command
/obj/effect/mapping_helpers/airlock/access/all/cent_com
	icon_state = "access_helper_serv"

// NT Consultant
/obj/effect/mapping_helpers/airlock/access/all/cent_com/rep_door/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_CENT_GENERAL
	return access_list
