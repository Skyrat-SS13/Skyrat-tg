// Object spawners

/obj/effect/corporate_diplomat
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/helpers.dmi'
	/// What to spawn for an NT consultant
	var/nanotrasen_consultant_path = /obj/effect/gibspawner/generic
	/// What to spawn for an Armadyne rep
	var/armadyne_representative_path = /obj/effect/gibspawner/generic
	/// What to spawn for a SolFed liaison
	var/solfed_liaison_path = /obj/effect/gibspawner/generic


/obj/effect/corporate_diplomat/Initialize(mapload)
	. = ..()
	if(!mapload)
		spawn_object()

	else
		RegisterSignal(SSjob, COMSIG_CORPORATE_DIPLOMAT_ROLE_PICKED, PROC_REF(spawn_object))


/// Spawns the spawner's object based on what corporate diplomat is picked, also carrying over varedits to direction and pixelshift.
/obj/effect/corporate_diplomat/proc/spawn_object()
	var/obj/spawned_object

	switch(SSjob.corporate_diplomat_type)

		if(/datum/corporate_diplomat_role/nanotrasen_consultant)
			spawned_object = new nanotrasen_consultant_path(get_turf(src))

		if(/datum/corporate_diplomat_role/armadyne_representative)
			spawned_object = new armadyne_representative_path(get_turf(src))

		if(/datum/corporate_diplomat_role/solfed_liaison)
			spawned_object = new solfed_liaison_path(get_turf(src))

	if (pixel_x != 0)
		spawned_object.pixel_x = pixel_x

	if (pixel_y != 0)
		spawned_object.pixel_y = pixel_y

	spawned_object.dir = dir

	qdel(src)

/obj/effect/corporate_diplomat/locker
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "locker_clothing"
	nanotrasen_consultant_path = /obj/structure/closet/secure_closet/nanotrasen_consultant/station
	armadyne_representative_path = /obj/structure/closet/secure_closet/armadyne_representative
	solfed_liaison_path = /obj/structure/closet/secure_closet/solfed_liaison


/obj/effect/corporate_diplomat/stamp
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "stamp"
	nanotrasen_consultant_path = /obj/item/stamp/centcom
	armadyne_representative_path = /obj/item/stamp/armadyne
	solfed_liaison_path = /obj/item/stamp/solfed


/obj/effect/corporate_diplomat/filing_cabinet
	icon_state = "filing_cabinet"
	nanotrasen_consultant_path = /obj/structure/filingcabinet/employment
	armadyne_representative_path = /obj/structure/filingcabinet // No high-value documents for off-station personnel
	solfed_liaison_path = /obj/structure/filingcabinet


/obj/effect/corporate_diplomat/fancy_table
	icon_state = "fancy_table"
	nanotrasen_consultant_path = /obj/structure/table/wood/fancy/green
	armadyne_representative_path = /obj/structure/table/wood/fancy/red
	solfed_liaison_path = /obj/structure/table/wood/fancy


/obj/effect/corporate_diplomat/fax
	icon_state = "fax"
	nanotrasen_consultant_path = /obj/machinery/fax/nanotrasen
	armadyne_representative_path = /obj/machinery/fax/armadyne
	solfed_liaison_path = /obj/machinery/fax/solfed


/obj/effect/corporate_diplomat/fancychair
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "chair"
	nanotrasen_consultant_path = /obj/structure/chair/comfy/green
	armadyne_representative_path = /obj/structure/chair/comfy/red
	solfed_liaison_path = /obj/structure/chair/comfy/brown


/obj/effect/corporate_diplomat/bedsheet
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "bedsheet"
	nanotrasen_consultant_path = /obj/item/bedsheet/centcom/double
	armadyne_representative_path = /obj/item/bedsheet/red/double
	solfed_liaison_path = /obj/item/bedsheet/yellow/double


/obj/effect/landmark/start/corporate_diplomat
	name = "Corporate Diplomat"
	icon_state = "SolFed Liaison"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'


// Mapping helpers

// - Access Helpers
/obj/effect/mapping_helpers/airlock/access/all/corp_diplomat
	icon_state = "access_helper_serv"

/obj/effect/mapping_helpers/airlock/access/all/corp_diplomat/get_access()
	var/list/access_list = ..()
	RegisterSignal(SSjob, COMSIG_CORPORATE_DIPLOMAT_ROLE_PICKED, PROC_REF(add_access))
	return access_list

/// Will add the appropriate access once a specific signal is sent to SSjob
/obj/effect/mapping_helpers/airlock/access/all/corp_diplomat/proc/add_access()
	req_access += initial(SSjob?.corporate_diplomat_type.used_access)


/obj/effect/mapping_helpers/airlock/access/all/armadyne
	icon_state = "access_helper_sec"

/obj/effect/mapping_helpers/airlock/access/all/armadyne/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_ARMADYNE
	return access_list


/obj/effect/mapping_helpers/airlock/access/all/solfed
	icon_state = "access_helper_sup"

/obj/effect/mapping_helpers/airlock/access/all/solfed/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_SOLFED
	return access_list


// - General Helpers
/obj/effect/mapping_helpers/corporate_diplomat
	name = "corporate diplomat floor helper"
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/helpers.dmi'
	icon_state = "question_mark"
	late = TRUE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/effect/mapping_helpers/corporate_diplomat/Initialize(mapload)
	..()
	if(!mapload)
		if(!SSjob.corporate_diplomat_type)
			return INITIALIZE_HINT_QDEL

		change_tile()

	else
		RegisterSignal(SSjob, COMSIG_CORPORATE_DIPLOMAT_ROLE_PICKED, PROC_REF(change_tile))


/// Upon being created out-of-mapload or hearing the correct signal, this proc will change the tile it is on
/obj/effect/mapping_helpers/corporate_diplomat/proc/change_tile()
	return


/obj/effect/mapping_helpers/corporate_diplomat/regular_floor
	name = "regular floor"
	icon_state = "regular_floor"

/obj/effect/mapping_helpers/corporate_diplomat/regular_floor/change_tile(mapload)
	. = ..()
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

/obj/effect/mapping_helpers/corporate_diplomat/good_floor/change_tile(mapload)
	. = ..()
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
	if(!mapload)
		set_name()

	else
		RegisterSignal(SSjob, COMSIG_CORPORATE_DIPLOMAT_ROLE_PICKED, PROC_REF(set_name))

/// A proc that sets the name of the airlock; either called when the diplomat role is picked, or immediately if out of mapload
/obj/machinery/door/airlock/corporate/corp_diplomat/proc/set_name()
	name = "[initial(SSjob?.corporate_diplomat_type.title)]'s Office"


/obj/structure/chair/comfy/green
	color = "#439C1E"

/obj/structure/chair/comfy/red
	color = "#a6281c"
