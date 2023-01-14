#define BIOME_WATERY_CAVE ( /datum/biome/deep_rock/water_cave )
#define BIOME_UNDERGROUND_JUNGLE ( /datum/biome/deep_rock/underground_jungle )
#define BIOME_DEVOID_OF_LIFE ( /datum/biome/deep_rock/lifeless_cave )
#define BIOME_MINERAL_RICH_ZONE ( /datum/biome/deep_rock/mineral_rich_cave )
#define BIOME_HELLSCAPE ( /datum/biome/deep_rock/tg_station_terry )

/datum/map_generator/deep_rock_cave_generator
	var/name = "Deep Rock Cave Generator"

	/// Unique ID for this spawner
	var/string_gen

	/// Chance of cells starting closed
	var/initial_closed_chance = 45
	/// Amount of smoothing iterations
	var/smoothing_iterations = 20
	/// How much neighbours does a dead cell need to become alive
	var/birth_limit = 4
	/// How little neighbours does a alive cell need to die
	var/death_limit = 3

	/// Used to select "zoom" level into the perlin noise, higher numbers result in slower transitions
	var/perlin_zoom = 65

	/// Weighted list of what types of turf to use for random rivers
	var/list/weighted_river_turf_list = list(
		/turf/open/water/overlay/hotspring/planet/outdoors = 1,
	)
	/// Expanded list of what types of turfs to use for random rivers
	var/list/river_turf_list = list()

	/// What openspace turf we should be using
	var/openspace_turf_type = /turf/open/openspace/planetary

/datum/map_generator/deep_rock_cave_generator/New()
	. = ..()

	river_turf_list = expand_weights(weighted_river_turf_list)

/datum/map_generator/deep_rock_cave_generator/generate_terrain(list/turfs, area/generate_in)
	. = ..()

	var/list/levels_to_make_rivers_at = list()

	var/mobs_allowed = (generate_in.area_flags & MOB_SPAWN_ALLOWED)

	var/biome_seed = rand(0, 50000)

	var/start_time = REALTIMEOFDAY
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data

	for(var/iterated_turf in turfs) //Go through all the turfs and generate them

		var/turf/gen_turf = iterated_turf

		var/closed = string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x] != "0"

		if(!closed)
			var/turf/open/turf_below = gen_turf.below()
			if(turf_below && istype(turf_below))
				gen_turf = new openspace_turf_type(gen_turf)
				continue

		var/biome_type = text2num(rustg_noise_get_at_coordinates("[biome_seed]", "[gen_turf.x]", "[gen_turf.y]"))

		var/datum/biome/deep_rock/selected_biome

		switch(biome_type)
			if(0 to 0.2)
				selected_biome = BIOME_WATERY_CAVE
			if(0.2 to 0.4)
				selected_biome = BIOME_UNDERGROUND_JUNGLE
			if(0.4 to 0.6)
				selected_biome = BIOME_DEVOID_OF_LIFE
			if(0.6 to 0.8)
				selected_biome = BIOME_MINERAL_RICH_ZONE
			if(0.8 to 1)
				selected_biome = BIOME_HELLSCAPE

		selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping
		selected_biome.generate_turf(gen_turf, closed, generate_in, mobs_allowed)

		if(!(gen_turf.z in levels_to_make_rivers_at))
			levels_to_make_rivers_at += gen_turf.z

		CHECK_TICK

	if(length(levels_to_make_rivers_at))
		for(var/zlevel as anything in levels_to_make_rivers_at)
			generate_random_river_type(zlevel)

	var/message = "[name] finished in [(REALTIMEOFDAY - start_time)/10]s!"

	add_startup_message(message)
	log_world(message)

/datum/map_generator/deep_rock_cave_generator/proc/generate_random_river_type(z_level_to_do_it_at)
	var/number_of_rivers = rand(1,5)

	var/river_turf_type = pick(river_turf_list)

	spawn_rivers(z_level_to_do_it_at, number_of_rivers, river_turf_type)

// Areas to use for generation

/area/deep_rock_caves
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/magma.ogg'

/area/deep_rock_caves/caves
	name = "Deep Caves"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_MINING
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/deep_rock_caves/caves/actually_generates
	icon_state = "unexplored"
	area_flags = UNIQUE_AREA | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/deep_rock_cave_generator

/area/deep_rock_caves/caves/actually_generates/mobless
	area_flags = UNIQUE_AREA
