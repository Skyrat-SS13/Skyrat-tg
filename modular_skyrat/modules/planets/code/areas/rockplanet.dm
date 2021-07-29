/**********************Rock Planet Areas**************************/

/area/rockplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_ASTEROID

/area/rockplanet/surface
	name = "Rockplanet"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_CREEPY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | NO_ALERTS
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/rockplanet/underground
	name = "Rockplanet Caves"
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambience_index = AMBIENCE_CREEPY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | NO_ALERTS
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/rockplanet/surface/outdoors
	name = "Rockplanet Wastes"
	outdoors = TRUE

/area/rockplanet/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | NO_ALERTS
	map_generator = /datum/map_generator/cave_generator/rockplanet

/area/rockplanet/surface/outdoors/unexplored/danger //megafauna will also spawn here
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS

/area/rockplanet/surface/outdoors/explored
	name = "Rockplanet Labor Camp"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NO_ALERTS


////////////////////////MAP GENERATOR////////////////////////////////

/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid = 1)
	closed_turf_types =  list(/turf/closed/mineral/random/stationside/asteroid/rockplanet = 1)

	mob_spawn_chance = 3

	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath = 20,
		/mob/living/simple_animal/hostile/netherworld/asteroid = 10,
		/mob/living/simple_animal/hostile/ooze/grapes/asteroid = 20,
		/mob/living/simple_animal/hostile/asteroid/fugu = 30,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 50,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 10,
		/mob/living/simple_animal/hostile/alien/asteroid = 20,
		SPAWN_MEGAFAUNA = 3,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
	flora_spawn_list = list(
		/obj/structure/flora/rock/jungle = 2,
		/obj/structure/flora/junglebush = 2,
		/obj/structure/flora/ash/leaf_shroom = 2,
		/obj/structure/flora/ash/cap_shroom = 2,
		/obj/structure/flora/ash/stem_shroom = 2,
		/obj/structure/flora/ash/cacti = 1,
		/obj/structure/flora/ash/tall_shroom = 2)
	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/effect/mine/shrapnel/human_only = 1)

	initial_closed_chance = 45
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

/area/mine/rockplanet
	name = "Abandoned Syndicate Mining Facility"

/area/mine/rockplanet_nanotrasen
	name = "Abandoned Mining Facility"

/turf/closed/mineral/random/stationside/asteroid/rockplanet
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	turf_type = /turf/open/floor/plating/asteroid
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 11,
		/turf/closed/mineral/gibtonite = 4, /obj/item/stack/ore/bluespace_crystal = 1)
	mineralChance = 30
