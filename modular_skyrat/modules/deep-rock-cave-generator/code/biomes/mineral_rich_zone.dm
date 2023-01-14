/datum/biome/deep_rock/mineral_rich_cave
	weighted_open_turf_types = list(
		/turf/open/misc/dirt/planet/openspace_baseturf = 1,
		/turf/open/misc/ashplanet/rocky/openspace_baseturf = 4,
	)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/ash_rock/underground_jungle = 1,
		/turf/closed/mineral/random/high_chance/mineral_rich_zone = 4,
	)

	weighted_mob_spawn_list = list(
		/obj/item/fish/chasm_crab = 1,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 2,
		/mob/living/simple_animal/hostile/asteroid/gutlunch = 2,
	)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/tall_shroom = 3,
		/obj/structure/flora/ash/seraka = 3,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/flora/rock/pile/style_random = 5,
		/obj/structure/flora/rock/style_random = 5,
		/obj/structure/ore_vein/stone = 5,
		/obj/structure/ore_vein/iron = 3,
		/obj/structure/ore_vein/silver = 2,
		/obj/structure/ore_vein/gold = 2,
	)

/turf/closed/mineral/random/high_chance/mineral_rich_zone
	color = "#bd654b"
	baseturfs = /turf/open/misc/sandy_dirt/planet/openspace_baseturf
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/ashplanet/rocky/openspace_baseturf
	baseturfs = /turf/open/openspace/planetary
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
