/** Read the main access_helpers.dm for more information on these mapping tools.
 * TLDR:
 * Any requires EITHER OR access defined on the ID
 * All requires THAT specific access defined on the ID (so don't put more than one on a door at a time UNLESS ITS INTENTIONAL for a job to have all the access(es))
 * For mapping examples, look at /TG/s MetaStation
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

// Dept guards

// Cargo
/obj/effect/mapping_helpers/airlock/access/any/supply/customs/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Engineering
/obj/effect/mapping_helpers/airlock/access/any/engineering/engie_guard/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Medical
/obj/effect/mapping_helpers/airlock/access/any/medical/orderly/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Science
/obj/effect/mapping_helpers/airlock/access/any/science/sci_guard/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Service
/obj/effect/mapping_helpers/airlock/access/any/service/bouncer/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
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

// Dept guards

// Cargo
/obj/effect/mapping_helpers/airlock/access/all/supply/customs/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Engineering
/obj/effect/mapping_helpers/airlock/access/all/engineering/engie_guard/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Medical
/obj/effect/mapping_helpers/airlock/access/all/medical/orderly/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Science
/obj/effect/mapping_helpers/airlock/access/all/science/sci_guard/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list

// Service
/obj/effect/mapping_helpers/airlock/access/all/service/bouncer/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BRIG_ENTRANCE
	return access_list
