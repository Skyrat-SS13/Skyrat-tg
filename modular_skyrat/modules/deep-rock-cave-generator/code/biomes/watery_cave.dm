/datum/biome/deep_rock/water_cave
	weighted_open_turf_types = list(
		/turf/open/misc/sandy_dirt/planet/openspace_baseturf = 1,
		/turf/open/water/overlay/hotspring/planet/outdoors/openspace_baseturf = 3,
	)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/water_cave = 1,
	)

	weighted_mob_spawn_list = list(
		/obj/item/fish/chasm_crab = 6,
		/mob/living/basic/axolotl = 3,
		/mob/living/basic/carp = 1,
	)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/biolumi/lamp/weaklight = 1,
		/obj/structure/flora/bush/fullgrass/style_random = 5,
		/obj/structure/flora/bush/sparsegrass/style_random = 5,
		/obj/structure/flora/bush/stalky/style_random = 5,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/flora/rock/pile/jungle/style_random = 9,
		/obj/structure/ore_vein/gold = 1,
		/obj/structure/ore_vein/stone = 2,
	)

/turf/closed/mineral/random/water_cave
	color = "#856e5a"
	baseturfs = /turf/open/misc/sandy_dirt/planet/openspace_baseturf
	mineralChance = 15
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/closed/mineral/random/water_cave/mineral_chances()
	return list(
		/obj/item/stack/ore/diamond = 10,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/iron = 50,
		/obj/item/stack/ore/silver = 30,
	)

/turf/open/water/overlay/hotspring/planet/outdoors/openspace_baseturf
	baseturfs = /turf/open/openspace/planetary
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/sandy_dirt/planet/openspace_baseturf
	baseturfs = /turf/open/openspace/planetary
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/openspace/planetary
	planetary_atmos = TRUE
