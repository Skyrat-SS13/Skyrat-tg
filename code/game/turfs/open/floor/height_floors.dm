/obj/item/stack/tile/plasteel/elevated
	name = "elevated floor tile"
	singular_name = "elevated floor tile"
	turf_type = /turf/open/floor/plasteel/elevated

/obj/item/stack/tile/plasteel/lowered
	name = "lowered floor tile"
	singular_name = "lowered floor tile"
	turf_type = /turf/open/floor/plasteel/lowered

/obj/item/stack/tile/plasteel/pool
	name = "pool floor tile"
	singular_name = "pool floor tile"
	turf_type = /turf/open/floor/plasteel/pool

/turf/open/floor/plasteel/pool
	name = "pool floor"
	floor_tile = /obj/item/stack/tile/plasteel/pool
	icon = 'icons/horizon/turf/pool_tile.dmi'
	base_icon_state = "pool_tile"
	icon_state = "pool_tile"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plasteel/pool/setup_broken_states()
	return list("pool_tile")

/turf/open/floor/plasteel/pool/setup_burnt_states()
	return list("pool_tile")

/turf/open/floor/plasteel/pool/rust_heretic_act()
	return

/turf/open/floor/plasteel/elevated
	name = "elevated floor"
	floor_tile = /obj/item/stack/tile/plasteel/elevated
	icon = 'icons/horizon/turf/elevated_plasteel.dmi'
	icon_state = "elevated_plasteel-0"
	base_icon_state = "elevated_plasteel"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_ELEVATED_PLASTEEL)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_ELEVATED_PLASTEEL)
	liquid_height = 30
	turf_height = 30

/turf/open/floor/plasteel/elevated/setup_broken_states()
	return list("elevated_plasteel")

/turf/open/floor/plasteel/elevated/setup_burnt_states()
	return list("elevated_plasteel")

/turf/open/floor/plasteel/elevated/rust_heretic_act()
	return

/turf/open/floor/plasteel/lowered
	name = "lowered floor"
	floor_tile = /obj/item/stack/tile/plasteel/lowered
	icon = 'icons/horizon/turf/lowered_plasteel.dmi'
	icon_state = "lowered_plasteel-0"
	base_icon_state = "lowered_plasteel"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOWERED_PLASTEEL)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOWERED_PLASTEEL)
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plasteel/lowered/setup_broken_states()
	return list("lowered_plasteel")

/turf/open/floor/plasteel/lowered/setup_burnt_states()
	return list("lowered_plasteel")

/turf/open/floor/plasteel/lowered/rust_heretic_act()
	return
