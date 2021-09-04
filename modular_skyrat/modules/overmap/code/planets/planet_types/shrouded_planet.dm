/datum/planet_template/shrouded_planet
	name = "Shrouded Planet"
	area_type = /area/planet/shrouded
	generator_type = /datum/map_generator/planet_gen/shrouded

	default_traits_input = list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = /turf/open/floor/planetary/rock)
	overmap_type = /datum/overmap_object/shuttle/planet/shrouded
	atmosphere_type = /datum/atmosphere/shrouded
	weather_controller_type = /datum/weather_controller/shrouded
	day_night_controller_type = /datum/day_night_controller/shrouded

	rock_color = list(COLOR_INDIGO, COLOR_DARK_BLUE_GRAY, COLOR_NAVY_BLUE)
	plant_color = list("#3c5434", "#2f6655", "#0e703f", "#495139", "#394c66", "#1a3b77", "#3e3166", "#52457c", "#402d56", "#580d6d")
	plant_color_as_grass = TRUE
	water_color = list("#3e3960")
	planet_flags = PLANET_WATER|PLANET_WRECKAGES|PLANET_REMOTE

/datum/day_night_controller/shrouded
	midnight_color = COLOR_BLACK
	midnight_light = 0

	morning_color = "#c4faff"
	morning_light = 0.4

	noon_color = "#bffff2"
	noon_light = 0.7

	midday_color = "#bffff2"
	midday_light = 0.7

	evening_color = "#c43f3f"
	evening_light = 0.4

	night_color = "#0000a6"
	night_light = 0.1

/datum/weather_controller/shrouded
	possible_weathers = list(/datum/weather/shroud_storm = 100)

/datum/overmap_object/shuttle/planet/shrouded
	name = "Shrouded Planet"
	planet_color = COLOR_BLUE

/area/planet/shrouded
	name = "Shrouded Planet Surface"
	ambientsounds = list(
		"sound/ambience/spookyspace1.ogg",
		"sound/ambience/spookyspace2.ogg",
	)
	min_ambience_cooldown = 2 MINUTES
	max_ambience_cooldown = 4 MINUTES

/datum/map_generator/planet_gen/shrouded
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/mountain,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGH_HUMIDITY = /datum/biome/shrouded_sand,
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGH_HUMIDITY = /datum/biome/shrouded_tar,
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGH_HUMIDITY = /datum/biome/shrouded_tar,
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/shrouded_sand,
		BIOME_HIGH_HUMIDITY = /datum/biome/shrouded_tar,
		),
	)
	high_height_biome = /datum/biome/mountain
	perlin_zoom = 65

/datum/biome/shrouded_sand
	turf_type = /turf/open/floor/planetary/shrouded_sand
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/hostile/planet/royalcrab = 100,
		/mob/living/simple_animal/hostile/planet/jelly/alt = 100,
		/mob/living/simple_animal/hostile/planet/shantak/alt = 100,
	)

/datum/biome/shrouded_tar
	turf_type = /turf/open/floor/planetary/water/tar

/turf/open/floor/planetary/shrouded_sand
	gender = PLURAL
	name = "packed sand"
	desc = "Sand that has been packed into solid earth."
	baseturfs = /turf/open/floor/planetary/shrouded_sand
	icon = 'icons/planet/shrouded/shrouded_floor.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_SAND

/turf/open/floor/planetary/shrouded_sand/Initialize()
	. = ..()
	if(prob(20))
		icon_state = "[base_icon_state][rand(1,8)]"

/datum/atmosphere/shrouded
	base_gases = list(
		/datum/gas/nitrogen=80,
		/datum/gas/oxygen=20,
	)
	normal_gases = list(
		/datum/gas/bz=2,
		/datum/gas/carbon_dioxide=2,
	)
	restricted_chance = 0

	minimum_pressure = ONE_ATMOSPHERE - 10
	maximum_pressure = ONE_ATMOSPHERE + 20

	minimum_temp = T20C - 30
	maximum_temp = T20C - 10
