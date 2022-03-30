/datum/planet_template/volcanic_planet
	name = "Volcanic Planet"
	area_type = /area/planet/volcanic
	generator_type = /datum/map_generator/planet_gen/volcanic

	default_traits_input = list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = /turf/open/floor/planetary/rock)
	overmap_type = /datum/overmap_object/shuttle/planet/volcanic
	atmosphere_type = /datum/atmosphere/volcanic
	weather_controller_type = /datum/weather_controller/lavaland
	day_night_controller_type = null //Ash blocks off the sky

	rock_color = list(COLOR_DARK_GRAY)
	plant_color = list("#a23c05","#662929","#ba6222","#7a5b3a")
	plant_color_as_grass = TRUE
	planet_flags = PLANET_VOLCANIC|PLANET_WRECKAGES

/datum/overmap_object/shuttle/planet/volcanic
	name = "Volcanic Planet"
	planet_color = COLOR_RED

/area/planet/volcanic
	name = "Volcanic Planet Surface"
	ambientsounds = list('modular_skyrat/master_files/sound/ambience/magma.ogg')
	min_ambience_cooldown = 2 MINUTES
	max_ambience_cooldown = 4 MINUTES

/datum/map_generator/planet_gen/volcanic
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/mountain,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mountain,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/basalt,
		BIOME_HIGH_HUMIDITY = /datum/biome/basalt,
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/basalt,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/basalt,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/basalt,
		BIOME_HIGH_HUMIDITY = /datum/biome/basalt,
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/basalt,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/basalt,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/basalt,
		BIOME_HIGH_HUMIDITY = /datum/biome/lava,
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/basalt,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/basalt,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/lava,
		BIOME_HIGH_HUMIDITY = /datum/biome/lava,
		),
	)
	high_height_biome = /datum/biome/mountain
	perlin_zoom = 30

/datum/biome/basalt
	turf_type = /turf/open/misc/asteroid/basalt/lava_land_surface
	flora_types = list(
		/obj/structure/flora/rock,
		/obj/structure/flora/rock/pile,
		/obj/structure/flora/ash/tall_shroom,
		/obj/structure/flora/ash/leaf_shroom,
		/obj/structure/flora/ash/cap_shroom,
		/obj/structure/flora/ash/stem_shroom,
		/obj/structure/flora/ash/cacti,
	)
	flora_density = 7
	fauna_density = 0.5
	fauna_weight_types = list(
		/mob/living/simple_animal/hostile/megafauna/dragon = 4,
		/mob/living/simple_animal/hostile/planet/charbaby = 100,
		/mob/living/simple_animal/hostile/planet/shantak/lava = 100,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast = 100,
		/mob/living/simple_animal/thinbug = 50,
	)

/datum/biome/lava
	turf_type = /turf/open/lava/smooth/lava_land_surface

/datum/atmosphere/volcanic
	base_gases = list(
		/datum/gas/nitrogen=2.5,
		/datum/gas/pluoxium=0.5,
	)
	normal_gases = list(
		/datum/gas/bz=1,
		/datum/gas/nitrogen=0.5,
		/datum/gas/carbon_dioxide=0.5,
	)
	restricted_gases = list(
		/datum/gas/plasma=0.5,
		/datum/gas/helium=0.5,
	)
	restricted_chance = 10

	minimum_pressure = HAZARD_LOW_PRESSURE + 10
	maximum_pressure = LAVALAND_EQUIPMENT_EFFECT_PRESSURE - 10

	minimum_temp = BODYTEMP_HEAT_WOUND_LIMIT + 10
	maximum_temp = BODYTEMP_HEAT_WOUND_LIMIT + 200
