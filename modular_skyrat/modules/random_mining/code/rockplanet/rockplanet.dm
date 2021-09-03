////////////////////////MAP GENERATOR////////////////////////////////

/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/lowpressure = 1)
	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 1)

	mob_spawn_chance = 3

	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 20,
		/mob/living/simple_animal/hostile/asteroid/fugu = 30,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/LV669_weaver = 20,
		/mob/living/simple_animal/hostile/LV669_slider= 15,
		SPAWN_MEGAFAUNA = 3,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10
		)
		/*TODO:
		[Change goliath?]
		[Change fugu?]
		[Change basilisk?]
		[Reskin weaver/its spawn]
		[Implement /mob/living/simple_animal/hostile/zombie/LV669_lost]
		[Code Slider to random teleport]
		*/
	flora_spawn_list = list(
		/obj/effect/decal/cleanable/ash/cig_trash = 2,
		/obj/effect/decal/cleanable/wood_trash = 2,
		/obj/effect/decal/cleanable/brick_rubble = 3,
		/obj/structure/flora/rock/jungle = 2,
		/obj/structure/fluff/abandoned/tire = 1,
		/obj/structure/flora/ash/rockplanet/coyote = 2,
		/obj/structure/flora/ash/rockplanet/yucca = 2,
		/obj/structure/flora/ash/rockplanet/agaricus = 2,
		/obj/structure/flora/ash/seraka= 1
		)
	feature_spawn_list = list(
		/obj/structure/geyser/wittel = 8,
		/obj/structure/geyser/random = 3,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/hollowwater = 10,
		/obj/effect/mine/shrapnel/human_only = 2
		)

	initial_closed_chance = 45
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3
