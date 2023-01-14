/datum/biome/deep_rock/lifeless_cave
	flora_spawn_chance = 20

	weighted_open_turf_types = list(
		/turf/open/misc/dirt/planet/openspace_baseturf = 1,
	)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/ash_rock/underground_jungle = 1,
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/mothroach = 1,
		/mob/living/basic/cockroach = 4,
	)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/bush/fullgrass/style_random = 1,
		/obj/structure/flora/bush/sparsegrass/style_random = 1,
		/obj/structure/flora/grass/jungle/b/style_random = 1,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/flora/rock/pile/style_random = 5,
		/obj/structure/flora/rock/style_random = 5,
		/obj/structure/ore_vein/stone = 1,
		/obj/structure/ore_vein/iron = 3,
	)

