/datum/planet_template/lush_planet
	name = "Lush Planet"
	area_type = /area/planet/lush
	generator_type = /datum/map_generator/planet_gen/lush

	default_traits_input = list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = /turf/open/floor/planetary/rock)
	overmap_type = /datum/overmap_object/shuttle/planet/lush
	atmosphere_type = /datum/atmosphere/lush
	weather_controller_type = /datum/weather_controller/lush

	rock_color = list(COLOR_ASTEROID_ROCK, COLOR_GRAY, COLOR_BROWN)
	plant_color = list("#215a00","#195a47","#5a7467","#9eab88","#6e7248")
	plant_color_as_grass = TRUE

/datum/weather_controller/lush
	possible_weathers = list(
		/datum/weather/rain = 30,
		/datum/weather/rain/heavy = 30,
		/datum/weather/rain/heavy/storm = 30,
	)

/datum/overmap_object/shuttle/planet/lush
	name = "Lush Planet"
	planet_color = COLOR_GREEN

/area/planet/lush
	name = "Lush Planet Surface"
	ambientsounds = list(
		'sound/effects/wind/wind1.ogg',
		'sound/effects/wind/wind2.ogg',
		'sound/effects/wind/wind3.ogg',
		'sound/effects/wind/wind4.ogg',
		'sound/effects/wind/wind5.ogg',
		'sound/effects/wind/wind6.ogg',
	)
	min_ambience_cooldown = 12 SECONDS
	max_ambience_cooldown = 30 SECONDS

/datum/map_generator/planet_gen/lush
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/grass,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/heavy_mud,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/grass,
		BIOME_HIGH_HUMIDITY = /datum/biome/grass,
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/grass,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/grass,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/coast,
		BIOME_HIGH_HUMIDITY = /datum/biome/water,
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/grass,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/grass,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/coast,
		BIOME_HIGH_HUMIDITY = /datum/biome/water,
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/wasteland,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/grass,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/coast,
		BIOME_HIGH_HUMIDITY = /datum/biome/water,
		),
	)
	high_height_biome = /datum/biome/mountain
	perlin_zoom = 65

/datum/biome/grass
	turf_type = /turf/open/floor/planetary/grass
	flora_types = list(
		/obj/structure/flora/tree/jungle,
		/obj/structure/flora/planetary/palebush,
		/obj/structure/flora/rock/pile,
		/obj/structure/flora/ausbushes/ywflowers,
		/obj/structure/flora/ausbushes/brflowers,
		/obj/structure/flora/ausbushes/brflowers,
		/obj/structure/flora/ausbushes/lavendergrass,
		/obj/structure/flora/ausbushes/goldenbush,
		/obj/structure/flora/planetary/leafybush,
		/obj/structure/flora/planetary/grassybush,
		/obj/structure/flora/planetary/fernybush,
		/obj/structure/flora/planetary/sunnybush,
		/obj/structure/flora/planetary_grass/sparsegrass,
		/obj/structure/flora/planetary_grass/fullgrass,
	)
	flora_density = 10
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/tindalos = 1,
		/mob/living/simple_animal/yithian = 1,
		/mob/living/simple_animal/hostile/planet/jelly = 1,
	)

/datum/biome/coast
	turf_type = /turf/open/floor/planetary/sand

/datum/biome/heavy_mud
	turf_type = /turf/open/floor/planetary/mud

/datum/biome/wasteland
	turf_type = /turf/open/floor/planetary/wasteland

/datum/atmosphere/lush
	base_gases = list(
		/datum/gas/nitrogen=80,
		/datum/gas/oxygen=20,
	)
	normal_gases = list(
		/datum/gas/oxygen=5,
		/datum/gas/nitrogen=5,
	)
	restricted_chance = 0

	minimum_pressure = ONE_ATMOSPHERE - 10
	maximum_pressure = ONE_ATMOSPHERE + 20

	minimum_temp = T20C - 10
	maximum_temp = T20C + 20
