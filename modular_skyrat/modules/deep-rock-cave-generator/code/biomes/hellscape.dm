/datum/biome/deep_rock/tg_station_terry
	weighted_open_turf_types = list(
		/turf/open/misc/asteroid/snow/icemoon/openspace_baseturf = 5,
		/turf/open/misc/ashplanet/rocky/openspace_baseturf = 2,
	)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/snow/openspace_baseturf = 1,
	)

	weighted_mob_spawn_list = list(
		/obj/item/fish/chasm_crab = 1,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity = 3,
		/mob/living/simple_animal/hostile/asteroid/wolf = 2,
		/mob/living/basic/sheep = 5,
	)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/bush/lavendergrass/style_random = 3,
		/obj/structure/flora/bush/sparsegrass/style_random = 3,
		/obj/structure/flora/grass/both/style_random = 5,
		/obj/structure/flora/grass/brown/style_random = 5,
		/obj/structure/flora/grass/green/style_random = 5,
		/obj/structure/flora/bush/snow/style_random = 3,
		/obj/structure/flora/tree/pine/style_random = 1,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/flora/rock/pile/icy/style_random = 5,
		/obj/structure/ore_vein/silver = 3,
	)

/turf/closed/mineral/random/snow/openspace_baseturf
	turf_type = /turf/open/misc/dirt/planet/openspace_baseturf
	baseturfs = /turf/open/misc/dirt/planet/openspace_baseturf
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/asteroid/snow/icemoon/openspace_baseturf
	baseturfs = /turf/open/openspace/planetary
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
