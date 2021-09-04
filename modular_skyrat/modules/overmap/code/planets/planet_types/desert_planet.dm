/datum/planet_template/desert_planet
	name = "Desert Planet"
	area_type = /area/planet/desert
	generator_type = /datum/map_generator/planet_gen/desert

	default_traits_input = list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = /turf/open/floor/planetary/rock)
	overmap_type = /datum/overmap_object/shuttle/planet/desert
	atmosphere_type = /datum/atmosphere/desert
	weather_controller_type = /datum/weather_controller/desert

	rock_color = list(COLOR_BEIGE, COLOR_PALE_YELLOW, COLOR_GRAY, COLOR_BROWN)
	plant_color = list("#7b4a12","#e49135","#ba6222")
	grass_color = list("#b8701f")

/datum/weather_controller/desert
	possible_weathers = list(/datum/weather/sandstorm = 100)

/datum/overmap_object/shuttle/planet/desert
	name = "Desert Planet"
	planet_color = COLOR_BEIGE

/area/planet/desert
	name = "Desert Planet Surface"
	ambientsounds = list(
		'sound/effects/wind/desert0.ogg',
		'sound/effects/wind/desert1.ogg',
		'sound/effects/wind/desert2.ogg',
		'sound/effects/wind/desert3.ogg',
		'sound/effects/wind/desert4.ogg',
		'sound/effects/wind/desert5.ogg',
	)

/datum/map_generator/planet_gen/desert
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/desert,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/desert,
		BIOME_HIGH_HUMIDITY = /datum/biome/desert,
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/desert,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/desert,
		BIOME_HIGH_HUMIDITY = /datum/biome/desert,
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/dry_seafloor,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/desert,
		BIOME_HIGH_HUMIDITY = /datum/biome/desert,
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/dry_seafloor,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/dry_seafloor,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/dry_seafloor,
		BIOME_HIGH_HUMIDITY = /datum/biome/desert,
		),
	)
	high_height_biome = /datum/biome/mountain
	perlin_zoom = 65

/datum/biome/desert
	turf_type = /turf/open/floor/planetary/sand/desert
	flora_types = list(
		/obj/structure/flora/planetary/palebush,
		/obj/structure/flora/rock/pile,
		/obj/structure/flora/rock,
		/obj/structure/flora/ash/cacti,
	)
	flora_density = 3
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/hostile/planet/antlion = 100,
		/mob/living/simple_animal/tindalos = 60,
		/mob/living/simple_animal/thinbug = 60,
		/mob/living/simple_animal/hostile/lizard = 20,
		/mob/living/simple_animal/hostile/planet/antlion/mega = 10,
	)

/datum/biome/dry_seafloor
	turf_type = /turf/open/floor/planetary/dry_seafloor

/datum/atmosphere/desert
	base_gases = list(
		/datum/gas/nitrogen=80,
		/datum/gas/oxygen=20,
	)
	normal_gases = list(
		/datum/gas/oxygen=5,
		/datum/gas/nitrogen=5,
	)
	restricted_chance = 0

	minimum_pressure = ONE_ATMOSPHERE
	maximum_pressure = ONE_ATMOSPHERE  + 50

	minimum_temp = T20C + 20
	maximum_temp = T20C + 80

/turf/open/floor/planetary/sand/desert
	gender = PLURAL
	name = "desert sand"
	baseturfs = /turf/open/floor/planetary/sand/desert
