/datum/planet_template/snow_planet
	name = "Snow Planet"
	area_type = /area/planet/snow
	generator_type = /datum/map_generator/planet_gen/snow

	default_traits_input = list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = /turf/open/floor/planetary/rock)
	overmap_type = /datum/overmap_object/shuttle/planet/snow
	atmosphere_type = /datum/atmosphere/snow
	weather_controller_type = /datum/weather_controller/snow_planet

	rock_color = list(COLOR_DARK_BLUE_GRAY, COLOR_GUNMETAL, COLOR_GRAY, COLOR_DARK_GRAY)
	plant_color = list("#d0fef5","#93e1d8","#93e1d8", "#b2abbf", "#3590f3", "#4b4e6d")
	grass_color = list("#d0fef5")
	planet_flags = PLANET_HABITABLE|PLANET_WATER|PLANET_WRECKAGES|PLANET_ICE

/datum/weather_controller/snow_planet
	possible_weathers = list(
		/datum/weather/snow_storm = 50,
		/datum/weather/snowfall = 50,
		/datum/weather/snowfall/heavy = 50,
		/datum/weather/hailstorm = 50,
	)

/datum/overmap_object/shuttle/planet/snow
	name = "Snow Planet"
	planet_color = COLOR_WHITE

/area/planet/snow
	name = "Snow Planet Surface"
	ambientsounds = list(
		'sound/effects/wind/tundra0.ogg',
		'sound/effects/wind/tundra1.ogg',
		'sound/effects/wind/tundra2.ogg',
		'sound/effects/wind/spooky0.ogg',
		'sound/effects/wind/spooky1.ogg',
	)

/datum/map_generator/planet_gen/snow
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/snowy_mountainside,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGH_HUMIDITY = /datum/biome/frozen_lake,
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/snow,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGH_HUMIDITY = /datum/biome/frozen_lake,
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/grass_tundra,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGH_HUMIDITY = /datum/biome/snow,
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/grass_tundra,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/snow,
		BIOME_HIGH_HUMIDITY = /datum/biome/snow,
		),
	)
	high_height_biome = /datum/biome/mountain
	perlin_zoom = 65

/datum/biome/grass_tundra
	turf_type = /turf/open/floor/planetary/grass
	flora_types = list(
		/obj/structure/flora/planetary/firstbush,
		/obj/structure/flora/planetary_grass/sparsegrass,
		/obj/structure/flora/planetary/fernybush,
		/obj/structure/flora/planetary_grass/fullgrass,
		/obj/structure/flora/ash/chilly,
		/obj/structure/flora/grass,
		/obj/structure/flora/grass/brown,
		/obj/structure/flora/grass/green,
		/obj/structure/flora/grass/both,
		/obj/structure/flora/bush,
		/obj/structure/flora/tree/pine,
		/obj/structure/flora/rock/pile/icy,
	)
	flora_density = 30
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/hostile/planet/samak = 1,
		/mob/living/simple_animal/hostile/planet/diyaab = 1,
		/mob/living/simple_animal/hostile/planet/shantak = 1,
	)

/datum/biome/snow
	turf_type = /turf/open/floor/planetary/snow
	flora_types = list(
		/obj/structure/flora/planetary_grass/sparsegrass,
		/obj/structure/flora/grass,
		/obj/structure/flora/grass/brown,
		/obj/structure/flora/grass/green,
		/obj/structure/flora/grass/both,
		/obj/structure/flora/bush,
		/obj/structure/flora/tree/pine,
		/obj/structure/flora/rock/pile/icy,
		/obj/structure/flora/rock/icy,
	)
	flora_density = 12
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/hostile/planet/samak = 100,
		/mob/living/simple_animal/hostile/planet/diyaab = 100,
		/mob/living/simple_animal/hostile/planet/shantak = 100,
		/mob/living/simple_animal/hostile/planet/royalcrab/giant = 8,
	)

/datum/biome/frozen_lake
	turf_type = /turf/open/floor/planetary/ice

/datum/biome/snowy_mountainside
	turf_type = /turf/closed/mineral/random/snow

/turf/open/floor/planetary/snow
	gender = PLURAL
	name = "snow"
	desc = "Looks cold."
	icon = 'icons/planet/snow/snow_floor.dmi'
	baseturfs = /turf/open/floor/planetary/snow
	icon_state = "snow"
	base_icon_state = "snow"
	slowdown = 2
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/snow/Initialize()
	. = ..()
	if(prob(15))
		icon_state = "[base_icon_state][rand(1,13)]"

/turf/open/floor/planetary/ice
	name = "ice sheet"
	desc = "A sheet of solid ice. Looks slippery."
	icon = 'icons/turf/floors/ice_turf.dmi'
	icon_state = "ice_turf-0"
	base_icon_state = "ice_turf-0"
	baseturfs = /turf/open/floor/planetary/ice
	slowdown = 1
	can_build_on = FALSE
	bullet_sizzle = TRUE
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/ice/Initialize()
	. = ..()
	MakeSlippery(TURF_WET_PERMAFROST, INFINITY, 0, INFINITY, TRUE)

/turf/open/floor/planetary/ice/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/datum/atmosphere/snow
	base_gases = list(
		/datum/gas/nitrogen=80,
		/datum/gas/oxygen=20,
	)
	normal_gases = list(
		/datum/gas/oxygen=5,
		/datum/gas/nitrogen=5,
		/datum/gas/carbon_dioxide=1,
	)
	restricted_chance = 0

	minimum_pressure = ONE_ATMOSPHERE - 30
	maximum_pressure = ONE_ATMOSPHERE

	minimum_temp = T20C - 100
	maximum_temp = T20C - 10
