/datum/planet_template/chlorine_planet
	name = "Chlorine Planet"
	area_type = /area/planet/chlorine
	generator_type = /datum/map_generator/planet_gen/chlorine

	default_traits_input = list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = /turf/open/floor/planetary/rock)
	overmap_type = /datum/overmap_object/shuttle/planet/chlorine
	atmosphere_type = /datum/atmosphere/chlorine
	weather_controller_type = /datum/weather_controller/chlorine
	day_night_controller_type = /datum/day_night_controller/chlorine

	rock_color = list(COLOR_GRAY, COLOR_PALE_GREEN_GRAY, COLOR_PALE_BTL_GREEN)
	planet_flags = PLANET_WATER|PLANET_WRECKAGES|PLANET_REMOTE

/datum/weather_controller/chlorine
	possible_weathers = list(/datum/weather/acid_rain = 100)

/datum/day_night_controller/chlorine
	midnight_color = COLOR_BLACK
	midnight_light = 0

	morning_color = "#c4faff"
	morning_light = 0.4

	noon_color = "#fff79c"
	noon_light = 0.7

	midday_color = "#fff79c"
	midday_light = 0.7

	evening_color = "#c43f3f"
	evening_light = 0.4

	night_color = "#0000a6"
	night_light = 0.1

/datum/overmap_object/shuttle/planet/chlorine
	name = "Chlorine Planet"
	planet_color = COLOR_PALE_BTL_GREEN

/area/planet/chlorine
	name = "Chlorine Planet Surface"
	ambientsounds = list(
		'sound/effects/wind/desert0.ogg',
		'sound/effects/wind/desert1.ogg',
		'sound/effects/wind/desert2.ogg',
		'sound/effects/wind/desert3.ogg',
		'sound/effects/wind/desert4.ogg',
		'sound/effects/wind/desert5.ogg',
	)

/datum/map_generator/planet_gen/chlorine
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/chlorine_water,
		BIOME_HIGH_HUMIDITY = /datum/biome/chlorine_water,
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/chlorine_water,
		BIOME_HIGH_HUMIDITY = /datum/biome/chlorine_water,
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_HIGH_HUMIDITY = /datum/biome/chlorine_water,
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/chlorine_desert,
		BIOME_HIGH_HUMIDITY = /datum/biome/chlorine_desert,
		),
	)
	high_height_biome = /datum/biome/mountain
	perlin_zoom = 65

/datum/biome/chlorine_desert
	turf_type = /turf/open/floor/planetary/chlorine_sand
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/hostile/planet/jelly = 100,
		/mob/living/simple_animal/tindalos = 50,
		/mob/living/simple_animal/thinbug = 50,
		/mob/living/simple_animal/yithian = 50,
		/mob/living/simple_animal/hostile/planet/samak/alt = 100,
		/mob/living/simple_animal/hostile/planet/jelly/mega = 5,
	)

/datum/biome/chlorine_water
	turf_type = /turf/open/floor/planetary/water/chlorine

/datum/atmosphere/chlorine
	base_gases = list(
		/datum/gas/nitrogen=80,
		/datum/gas/carbon_dioxide=20
	) //CO2 because chlorine gas isn't a thing now
	normal_gases = list(
		/datum/gas/oxygen=5,
		/datum/gas/nitrogen=5
	)
	restricted_chance = 0

	minimum_pressure = ONE_ATMOSPHERE - 30
	maximum_pressure = ONE_ATMOSPHERE

	minimum_temp = T20C - 100
	maximum_temp = T20C

/turf/open/floor/planetary/chlorine_sand
	gender = PLURAL
	name = "chlorinated sand"
	desc = "Sand that has been heavily contaminated by chlorine."
	baseturfs = /turf/open/floor/planetary/chlorine_sand
	icon = 'icons/planet/chlorine/chlorine_floor.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/chlorine_sand/Initialize()
	. = ..()
	if(prob(20))
		icon_state = "[base_icon_state][rand(1,11)]"

/turf/open/floor/planetary/water/chlorine
	name = "chlorine marsh"
	desc = "A pool of noxious liquid chlorine. It's full of silt and plant matter."
	color = "#d2e0b7"
	baseturfs = /turf/open/floor/planetary/water/chlorine
