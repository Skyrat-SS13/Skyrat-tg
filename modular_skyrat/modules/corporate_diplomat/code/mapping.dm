// Object spawners

/obj/effect/spawner/corporate_diplomat
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/helpers.dmi'
	/// What to spawn for an NT consultant
	var/nt_con_path = /obj/effect/gibspawner/generic
	/// What to spawn for an Armadyne rep
	var/arm_rep_path = /obj/effect/gibspawner/generic
	/// What to spawn for a SolFed liaison
	var/sol_lia_path = /obj/effect/gibspawner/generic

/obj/effect/spawner/corporate_diplomat/Initialize(mapload)
	. = ..()
	if(!SSjob.corporate_diplomat_type)
		return INITIALIZE_HINT_QDEL

	switch(SSjob.corporate_diplomat_type)

		if(/datum/corporate_diplomat_role/nanotrasen_consultant)
			new nt_con_path(get_turf(src))

		if(/datum/corporate_diplomat_role/armadyne_representative)
			new arm_rep_path(get_turf(src))

		if(/datum/corporate_diplomat_role/solfed_liaison)
			new sol_lia_path(get_turf(src))


/obj/effect/spawner/corporate_diplomat/spawn_landmark
	icon_state = "person"
	nt_con_path = /obj/effect/landmark/start/nanotrasen_consultant
	arm_rep_path = /obj/effect/landmark/start/armadyne_rep
	sol_lia_path = /obj/effect/landmark/start/solfed_liaison


/obj/effect/spawner/corporate_diplomat/locker
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "locker_clothing"
	nt_con_path = /obj/structure/closet/secure_closet/nanotrasen_consultant/station
	arm_rep_path = /obj/structure/closet/secure_closet/armadyne_representative
	sol_lia_path = /obj/structure/closet/secure_closet/solfed_liaison


/obj/effect/spawner/corporate_diplomat/stamp
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "stamp"
	nt_con_path = /obj/item/stamp/centcom
	arm_rep_path = /obj/item/stamp/void
	sol_lia_path = /obj/item/stamp/mod/normal //sue me for powercreeping stamps


/obj/effect/spawner/corporate_diplomat/filing_cabinet
	icon_state = "filing_cabinet"
	nt_con_path = /obj/structure/filingcabinet/employment
	arm_rep_path = /obj/structure/filingcabinet // No high-value documents for off-station personnel
	sol_lia_path = /obj/structure/filingcabinet


/obj/effect/spawner/corporate_diplomat/fancy_table
	icon_state = "fancy_table"
	nt_con_path = /obj/structure/table/wood/fancy/green
	arm_rep_path = /obj/structure/table/wood/fancy/red
	sol_lia_path = /obj/structure/table/wood/fancy


/obj/effect/spawner/corporate_diplomat/fax // None of these actually can send to their parent corporations yet
	icon_state = "fax"
	nt_con_path = /obj/machinery/fax/nanotrasen
	arm_rep_path = /obj/machinery/fax/armadyne
	sol_lia_path = /obj/machinery/fax/solfed

// Mapping helpers

/obj/effect/mapping_helpers/airlock/access/all/corp_diplomat
	icon_state = "access_helper_serv"

/obj/effect/mapping_helpers/airlock/access/all/corp_diplomat/get_access()
	var/list/access_list = ..()
	access_list += initial(SSjob?.corporate_diplomat_type.used_access)
	return access_list

/obj/effect/mapping_helpers/corporate_diplomat
	name = "corporate diplomat floor helper"
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/helpers.dmi'
	icon_state = "question_mark"
	late = TRUE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/effect/mapping_helpers/corporate_diplomat/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD


/obj/effect/mapping_helpers/corporate_diplomat/regular_floor
	name = "regular floor"
	icon_state = "regular_floor"

/obj/effect/mapping_helpers/corporate_diplomat/regular_floor/LateInitialize()
	if(!SSjob.corporate_diplomat_type)
		qdel(src)
		return

	var/turf/open/floor/floor = get_turf(src)
	switch(SSjob.corporate_diplomat_type)
		if(/datum/corporate_diplomat_role/nanotrasen_consultant)
			floor.ChangeTurf(/turf/open/floor/wood)
		if(/datum/corporate_diplomat_role/armadyne_representative)
			floor.ChangeTurf(/turf/open/floor/iron/dark/textured)
		if(/datum/corporate_diplomat_role/solfed_liaison)
			floor.ChangeTurf(/turf/open/floor/iron/smooth_large)
	qdel(src)


/obj/effect/mapping_helpers/corporate_diplomat/good_floor
	name = "good floor"
	icon_state = "good_floor"

/obj/effect/mapping_helpers/corporate_diplomat/good_floor/LateInitialize()
	if(!SSjob.corporate_diplomat_type)
		qdel(src)
		return

	var/turf/open/floor/floor = get_turf(src)
	switch(SSjob.corporate_diplomat_type)
		if(/datum/corporate_diplomat_role/nanotrasen_consultant)
			floor.ChangeTurf(/turf/open/floor/carpet/executive)
		if(/datum/corporate_diplomat_role/armadyne_representative)
			floor.ChangeTurf(/turf/open/floor/carpet/red)
		if(/datum/corporate_diplomat_role/solfed_liaison)
			floor.ChangeTurf(/turf/open/floor/carpet)
	qdel(src)


// Actual objects

/obj/machinery/door/airlock/corporate/corp_diplomat
	name = "Corporate Diplomat's Office"

/obj/machinery/door/airlock/corporate/corp_diplomat/Initialize(mapload)
	. = ..()
	name = "[initial(SSjob?.corporate_diplomat_type.title)]'s Office"
