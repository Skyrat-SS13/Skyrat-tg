#define ENGI_IN_BOX_CARGONIA //uncomment this to allow Cargo to purchase the engineering-in-a-box items.

/area/misc/survivalpod/atmosia_box
	name = "\improper Atmosia in a Box"
	icon_state = "away"
	static_lighting = TRUE
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED
	flags_1 = CAN_BE_DIRTY_1

/area/misc/survivalpod/supermatter_box
	name = "\improper Supermatter in a Box"
	icon_state = "away"
	static_lighting = TRUE
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | CULT_PERMITTED
	flags_1 = CAN_BE_DIRTY_1

/datum/map_template/shelter/atmosia
	name = "Atmosia in a Box"
	shelter_id = "atmosia_in_a_box"
	description = "Attach to a busted station or a new outpost for instant operational atmos lines!"
	mappath = "modular_skyrat/modules/engineering_in_a_box/maps/atmosia_in_a_box.dmm"

/datum/map_template/shelter/atmosia/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/supermatter
	name = "Supermatter in a Box"
	shelter_id = "supermatter_in_a_box"
	description = "Attach to a busted station or a new outpost for instant megawatts of power!"
	mappath = "modular_skyrat/modules/engineering_in_a_box/maps/supermatter_in_a_box.dmm"

/datum/map_template/shelter/supermatter/New()
	. = ..()
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

#ifdef ENGI_IN_BOX_CARGONIA
	/datum/supply_pack/engine/atmosia_in_a_box
		name = "Atmosia in a Box"
		desc = "Atmos get plasma flooded?  Plug in a brand new distro center in a Box(tm), courtesy of Dr. Naaka Ko.  Requires CE access to open."
		cost = CARGO_CRATE_VALUE * 15
		access = ACCESS_CE
		contains = list(/obj/item/survivalcapsule/boxed_atmosia)
		crate_name = "atmosia in a box"
		crate_type = /obj/structure/closet/crate/secure/engineering
		dangerous = TRUE

	/datum/supply_pack/engine/supermatter_in_a_box
		name = "Supermatter in a Box"
		desc = "Engine delam'd?  Plug in a brand new passive high-output Supermatter Shard in a Box(tm), courtesy of Dr. Naaka Ko.  Requires CE access to open."
		cost = CARGO_CRATE_VALUE * 30
		access = ACCESS_CE
		contains = list(/obj/item/survivalcapsule/boxed_supermatter)
		crate_name = "supermatter in a box"
		crate_type = /obj/structure/closet/crate/secure/engineering
		dangerous = TRUE
#endif