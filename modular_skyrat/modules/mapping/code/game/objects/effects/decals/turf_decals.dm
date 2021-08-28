/obj/effect/turf_decal/skyrat_decals
	icon = 'modular_skyrat/modules/mapping/icons/turf/decals/turf_decals.dmi'
	icon_state = "bad_coder"

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

///Trash///
/obj/effect/decal/cleanable/ash/cig_trash
	name = "cigarette rubbish"
	desc = "Littering is bad for the environment, y'know."
	icon = 'modular_skyrat/modules/mapping/icons/turf/decals/turf_decals.dmi'
	icon_state = "cig_trash"
//Subtype of ash so that you can get ash from scooping it up

/obj/effect/decal/cleanable/wood_trash	//Cleanable because I dont like making messes people can't remove
	name = "wood scraps"
	desc = "I hope that whatever this was part of is doing fine without it..."
	icon = 'modular_skyrat/modules/mapping/icons/turf/decals/turf_decals.dmi'
	icon_state = "wood_trash"

/obj/effect/decal/cleanable/wood_trash/Initialize()
	. = ..()
	icon_state += pick("_a", "_b", "_c", "_d")
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

/obj/effect/decal/cleanable/brick_rubble	//Cleanable because I dont like making messes people can't remove
	name = "rubble"
	desc = "No longer part of a happy home."
	icon = 'modular_skyrat/modules/mapping/icons/turf/decals/turf_decals.dmi'
	icon_state = "bricks"

/obj/effect/decal/cleanable/brick_rubble/Initialize()
	. = ..()
	dir = rand(1,8)
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

///Street (Rockplanet fluff)///
/obj/effect/turf_decal/skyrat_decals/street/manhole
	icon_state = "manhole"

/obj/effect/turf_decal/skyrat_decals/street/double
	icon_state = "double_v"

/obj/effect/turf_decal/skyrat_decals/street/double/horizontal
	icon_state = "double_h"
/obj/effect/turf_decal/skyrat_decals/street/double/end
	icon_state = "double_end"

/obj/effect/turf_decal/skyrat_decals/street/full
	icon_state = "full_v"

/obj/effect/turf_decal/skyrat_decals/street/full/horizontal
	icon_state = "full_h"

/obj/effect/turf_decal/skyrat_decals/street/full/end
	icon_state = "full_end"

/obj/effect/turf_decal/skyrat_decals/street/dashed
	icon_state = "dashed_v"

/obj/effect/turf_decal/skyrat_decals/street/dashed/horizontal
	icon_state = "dashed_h"

/obj/effect/turf_decal/skyrat_decals/street/dashed/end
	icon_state = "dashed_end"
