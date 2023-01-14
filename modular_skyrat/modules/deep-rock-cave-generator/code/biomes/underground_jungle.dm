/datum/biome/deep_rock/underground_jungle
	weighted_open_turf_types = list(
		/turf/open/misc/dirt/planet/openspace_baseturf = 2,
		/turf/open/water/overlay/hotspring/planet/outdoors/openspace_baseturf = 1,
		/turf/open/misc/grass/jungle/planet/openspace_baseturf = 5,
	)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/ash_rock/underground_jungle = 2,
		/turf/closed/mineral/random/water_cave = 1
	)

	weighted_mob_spawn_list = list(
		/mob/living/simple_animal/hostile/venus_human_trap = 1,
		/mob/living/simple_animal/hostile/ooze/grapes/mine_mob = 1,
		/mob/living/basic/frog = 3,
	)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/seraka = 2,
		/obj/structure/flora/biolumi/mine/weaklight = 2,
		/obj/structure/flora/bush/fullgrass/style_random = 3,
		/obj/structure/flora/bush/sparsegrass/style_random = 3,
		/obj/structure/flora/bush/jungle/a/style_random = 5,
		/obj/structure/flora/bush/jungle/b/style_random = 5,
		/obj/structure/flora/bush/jungle/c/style_random = 5,
		/obj/structure/flora/tree/jungle/small/style_random = 3
	)
	weighted_feature_spawn_list = list(
		/obj/structure/flora/rock/pile/jungle/style_random = 9,
		/obj/structure/flora/rock/pile/jungle/large/style_random = 3,
		/obj/structure/ore_vein/stone = 3,
		/obj/structure/ore_vein/silver = 3,
	)

/turf/closed/mineral/ash_rock/underground_jungle
	baseturfs = /turf/open/misc/dirt/planet/openspace_baseturf
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/grass/jungle/planet/openspace_baseturf
	baseturfs = /turf/open/openspace/planetary
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/dirt/planet/openspace_baseturf
	baseturfs = /turf/open/openspace/planetary
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
