/datum/biome/deep_rock/water_cave
	weighted_open_turf_types = list(
		/turf/open/misc/sandy_dirt/planet = 1,
		/turf/open/water/overlay/hotspring/planet/outdoors = 3,
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
		/obj/structure/flora/bush/fullgrass/style_random = 3,
		/obj/structure/flora/bush/sparsegrass/style_random = 3,
		/obj/structure/flora/bush/stalky/style_random = 3,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/flora/rock/pile/jungle/style_random = 9,
		/obj/structure/ore_vein/gold = 1,
	)

/turf/closed/mineral/random/water_cave
	color = "#856e5a"
	baseturfs = /turf/open/misc/sandy_dirt/planet
