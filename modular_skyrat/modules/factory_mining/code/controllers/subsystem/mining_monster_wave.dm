SUBSYSTEM_DEF(mining_monster_wave)
	name = "Mining Monster Wave"
	wait = 5 MINUTES

	var/monster_list = list(
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random,
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random,
		/mob/living/simple_animal/hostile/asteroid/hivelord,
		/mob/living/simple_animal/hostile/asteroid/basilisk
	)

/datum/controller/subsystem/mining_monster_wave/fire()
	for(var/obj/machinery/factory/factory_machinery in GLOB.factory_machines)
		var/turf/local_turf = get_turf(factory_machinery)
		if(!is_mining_level(local_turf.z))
			continue
		var/mob/living/simple_animal/hostile/asteroid/chosen_spawn_mob = pick(monster_list)
		var/new_x = rand(-5,5)
		var/new_y = rand(-5,5)
		var/mob/living/simple_animal/hostile/asteroid/spawned_mob = new chosen_spawn_mob(local_turf)
		spawned_mob.x += new_x
		spawned_mob.y += new_y
