/obj/effect/turf_decal/skyrat_decals
	icon = 'modular_skyrat/modules/mapping/icons/turf/turf_decals.dmi'
	icon_state = "bad_coder"

/obj/effect/decal/fakelattice/passthru	//Why the hell did TG make it dense anyways
	density = FALSE

/obj/effect/decal/fakelattice/passthru/NeverShouldHaveComeHere(turf/here_turf)
	return !isclosedturf(here_turf) && ..()

///SYNDICATE EMBLEM///
//Bottom
/obj/effect/turf_decal/skyrat_decals/syndicate/bottom/left
	icon_state = "1,1"

/obj/effect/turf_decal/skyrat_decals/syndicate/bottom/middle
	icon_state = "1,2"

/obj/effect/turf_decal/skyrat_decals/syndicate/bottom/right
	icon_state = "1,3"
//Middle
/obj/effect/turf_decal/skyrat_decals/syndicate/middle/left
	icon_state = "2,1"

/obj/effect/turf_decal/skyrat_decals/syndicate/middle/middle
	icon_state = "2,2"

/obj/effect/turf_decal/skyrat_decals/syndicate/middle/right
	icon_state = "2,3"
//Top
/obj/effect/turf_decal/skyrat_decals/syndicate/top/left
	icon_state = "3,1"

/obj/effect/turf_decal/skyrat_decals/syndicate/top/middle
	icon_state = "3,2"

/obj/effect/turf_decal/skyrat_decals/syndicate/top/right
	icon_state = "3,3"

///ENCLAVE EMBLEM///
/obj/effect/turf_decal/skyrat_decals/enclave
	layer = TURF_PLATING_DECAL_LAYER
	alpha = 110
	color = "#A46106"
//Bottom
/obj/effect/turf_decal/skyrat_decals/enclave/bottom/left
	icon_state = "e1,1"

/obj/effect/turf_decal/skyrat_decals/enclave/bottom/middle
	icon_state = "e1,2"

/obj/effect/turf_decal/skyrat_decals/enclave/bottom/right
	icon_state = "e1,3"
//Middle
/obj/effect/turf_decal/skyrat_decals/enclave/middle/left
	icon_state = "e2,1"

/obj/effect/turf_decal/skyrat_decals/enclave/middle/middle
	icon_state = "e2,2"

/obj/effect/turf_decal/skyrat_decals/enclave/middle/right
	icon_state = "e2,3"
//Top
/obj/effect/turf_decal/skyrat_decals/enclave/top/left
	icon_state = "e3,1"

/obj/effect/turf_decal/skyrat_decals/enclave/top/middle
	icon_state = "e3,2"

/obj/effect/turf_decal/skyrat_decals/enclave/top/right
	icon_state = "e3,3"

///Departments///
/obj/effect/turf_decal/skyrat_decals/departments/bridge
	icon_state = "bridge"

///DS-2 Sign///
/obj/effect/turf_decal/skyrat_decals/ds2/left
	icon_state = "ds1"

/obj/effect/turf_decal/skyrat_decals/ds2/middle
	icon_state = "ds2"

/obj/effect/turf_decal/skyrat_decals/ds2/right
	icon_state = "ds3"

///Misc///
/obj/effect/turf_decal/skyrat_decals/misc/handicapped
	icon_state = "handicapped"
