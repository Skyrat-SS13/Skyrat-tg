/datum/map_generator/excavations_generator
	var/name = "Excavations Generator"
	///Weighted list of the types that spawns if the turf is open
	var/open_turf_types = list(/turf/open/misc/asteroid = 1)
	///Weighted list of the types that spawns if the turf is closed
	var/closed_turf_types = list(/turf/closed/mineral/random/stationside/asteroid = 1)

	///Weighted list of mobs that can spawn in the area.
	var/list/mob_spawn_list = list(/mob/living/simple_animal/hostile/carp/megacarp = 25, /mob/living/simple_animal/hostile/carp = 50, \
		/mob/living/simple_animal/hostile/asteroid/curseblob = 40, /mob/living/simple_animal/hostile/asteroid/hivelord = 15, \
		/mob/living/simple_animal/hostile/faithless = 10
	)
	// Weighted list of Megafauna that can spawn in the caves
	var/list/megafauna_spawn_list
	///Weighted list of flora that can spawn in the area.
	var/list/flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2, /obj/structure/flora/ash/seraka = 2)
	///Weighted list of extra features that can spawn in the area, such as geysers.
	var/list/feature_spawn_list = list(/obj/structure/strange_rocks = 300, /obj/structure/geyser/random = 10)



	///Base chance of spawning a mob
	var/mob_spawn_chance = 6
	///Base chance of spawning flora
	var/flora_spawn_chance = 2
	///Base chance of spawning features
	var/feature_spawn_chance = 1
	///Unique ID for this spawner
	var/string_gen

	///Chance of cells starting closed
	var/initial_closed_chance = 45
	///Amount of smoothing iterations
	var/smoothing_iterations = 20
	///How much neighbours does a dead cell need to become alive
	var/birth_limit = 4
	///How little neighbours does a alive cell need to die
	var/death_limit = 3

/datum/map_generator/excavations_generator/New()
	. = ..()
	if(!mob_spawn_list)
		mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goldgrub = 1, /mob/living/simple_animal/hostile/asteroid/goliath = 5, /mob/living/simple_animal/hostile/asteroid/basilisk = 4, /mob/living/simple_animal/hostile/asteroid/hivelord = 3)
	if(!megafauna_spawn_list)
		megafauna_spawn_list = GLOB.megafauna_spawn_list
	if(!flora_spawn_list)
		flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2, /obj/structure/flora/ash/seraka = 2)
	if(!feature_spawn_list)
		feature_spawn_list = list(/obj/structure/geyser/random = 1)

/datum/map_generator/excavations_generator/generate_terrain(list/turfs)
	. = ..()
	var/start_time = REALTIMEOFDAY
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data

	for(var/i in turfs) //Go through all the turfs and generate them
		var/turf/gen_turf = i
		//SKYRAT EDIT ADDITION
		if(istype(gen_turf, /turf/open/space/mirage))
			continue
		//SKYRAT EDIT END

		var/area/A = gen_turf.loc
		if(!(A.area_flags & CAVES_ALLOWED))
			continue

		var/closed = text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x])

		var/stored_flags
		if(gen_turf.turf_flags & NO_RUINS)
			stored_flags |= NO_RUINS

		var/turf/new_turf = pick_weight(closed ? closed_turf_types : open_turf_types)

		new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), CHANGETURF_DEFER_CHANGE)

		new_turf.flags_1 |= stored_flags

		if(!closed)//Open turfs have some special behavior related to spawning flora and mobs.

			var/turf/open/new_open_turf = new_turf

			///Spawning isn't done in procs to save on overhead on the 60k turfs we're going through.

			//FLORA SPAWNING HERE
			var/atom/spawned_flora
			if(flora_spawn_list && prob(flora_spawn_chance))
				var/can_spawn = TRUE

				if(!(A.area_flags & FLORA_ALLOWED))
					can_spawn = FALSE
				if(can_spawn)
					spawned_flora = pick_weight(flora_spawn_list)
					spawned_flora = new spawned_flora(new_open_turf)

			//FEATURE SPAWNING HERE
			var/atom/spawned_feature
			if(feature_spawn_list && prob(feature_spawn_chance))
				var/can_spawn = TRUE

				if(!(A.area_flags & FLORA_ALLOWED)) //checks the same flag because lol dunno
					can_spawn = FALSE

				var/atom/picked_feature = pick_weight(feature_spawn_list)

				for(var/obj/structure/F in range(7, new_open_turf))
					if(istype(F, picked_feature))
						can_spawn = FALSE

				if(can_spawn)
					spawned_feature = new picked_feature(new_open_turf)

			//MOB SPAWNING HERE

			if(mob_spawn_list && !spawned_flora && !spawned_feature && prob(mob_spawn_chance))
				var/can_spawn = TRUE

				if(!(A.area_flags & MOB_SPAWN_ALLOWED))
					can_spawn = FALSE

				var/atom/picked_mob = pick_weight(mob_spawn_list)

				if(picked_mob == SPAWN_MEGAFAUNA) //
					if((A.area_flags & MEGAFAUNA_SPAWN_ALLOWED) && megafauna_spawn_list?.len) //this is danger. it's boss time.
						picked_mob = pick_weight(megafauna_spawn_list)
					else //this is not danger, don't spawn a boss, spawn something else
						picked_mob = pick_weight(mob_spawn_list - SPAWN_MEGAFAUNA) //What if we used 100% of the brain...and did something (slightly) less shit than a while loop?

				for(var/thing in urange(12, new_open_turf)) //prevents mob clumps
					if(!ishostile(thing) && !istype(thing, /obj/structure/spawner))
						continue
					if((ispath(picked_mob, /mob/living/simple_animal/hostile/megafauna) || ismegafauna(thing)) && get_dist(new_open_turf, thing) <= 7)
						can_spawn = FALSE //if there's a megafauna within standard view don't spawn anything at all
						break
					if(ispath(picked_mob, /mob/living/simple_animal/hostile/asteroid) || istype(thing, /mob/living/simple_animal/hostile/asteroid))
						can_spawn = FALSE //if the random is a standard mob, avoid spawning if there's another one within 12 tiles
						break
					if((ispath(picked_mob, /obj/structure/spawner/lavaland) || istype(thing, /obj/structure/spawner/lavaland)) && get_dist(new_open_turf, thing) <= 2)
						can_spawn = FALSE //prevents tendrils spawning in each other's collapse range
						break

				if(can_spawn)
					if(ispath(picked_mob, /mob/living/simple_animal/hostile/megafauna/bubblegum)) //there can be only one bubblegum, so don't waste spawns on it
						megafauna_spawn_list.Remove(picked_mob)

					new picked_mob(new_open_turf)
		CHECK_TICK

	var/message = "[name] finished in [(REALTIMEOFDAY - start_time)/10]s!"
	to_chat(world, span_boldannounce("[message]"))
	log_world(message)

/area/shuttle/expedition_shuttle
	name = "Expedition Shuttle"

/area/ruin/space/has_grav/skyrat/expeditionary_post/hall
	name = "Expeditionary Post Hall"
	icon_state = "hallC"

/area/ruin/space/has_grav/skyrat/expeditionary_post/command_room
	name = "Expeditionary Post Command Room"
	icon_state = "captain"

/area/ruin/space/has_grav/skyrat/expeditionary_post/security_room
	name = "Expeditionary Post Security Room"
	icon_state = "security"

/area/ruin/space/has_grav/skyrat/expeditionary_post/paramedics_room
	name = "Expeditionary Post Paramedic's Room"
	icon_state = "paramedic"

/area/ruin/space/has_grav/skyrat/expeditionary_post/engineers_room
	name = "Expeditionary Post Engineer's Room"
	icon_state = "engine"

/area/ruin/space/has_grav/skyrat/expeditionary_post/explorers_room
	name = "Expeditionary Post Explorer's Room"
	icon_state = "science"

/area/ruin/space/has_grav/skyrat/expeditionary_post/storage_room
	name = "Expeditionary Post Storage Room"
	icon_state = "storage"

/area/ruin/space/has_grav/skyrat/expeditionary_post/atmosphere_room
	name = "Expeditionary Post Atmosphere Room"
	icon_state = "maint_atmos"

/area/ruin/space/has_grav/skyrat/expeditionary_post/telecommunications_room
	name = "Expeditionary Post Telecommunications Room"
	icon_state = "tcomsatcham"

/area/ruin/space/has_grav/skyrat/expeditionary_post/battery_room
	name = "Expeditionary Post Battery Room"
	icon_state = "engine_smes"

/area/ruin/space/has_grav/skyrat/expeditionary_post/restroom
	name = "Expeditionary Post Restroom"
	icon_state = "toilet"

/area/ruin/space/has_grav/skyrat/expeditionary_post/dormitories
	name = "Expeditionary Post Dormitories"
	icon_state = "dorms"

/area/ruin/space/has_grav/skyrat/expeditionary_post/backroom
	name = "Expeditionary Post Backroom"
	icon_state = "storage_wing"

/area/ruin/space/has_grav/skyrat/expeditionary_post/technical_room
	name = "Technical Room"
	icon_state = "aftmaint"

/area/expedition_excavations/explored
	name = "Expedition Excavations"
	has_gravity = STANDARD_GRAVITY
	icon_state = "explored"
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	flags_1 = NONE
	ambience_index = AMBIENCE_MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NO_ALERTS | CAVES_ALLOWED | FLORA_ALLOWED
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/expedition_excavations/unexplored
	name = "Expedition Excavations"
	has_gravity = STANDARD_GRAVITY
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	flags_1 = NONE
	ambience_index = AMBIENCE_MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NO_ALERTS | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/excavations_generator
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
