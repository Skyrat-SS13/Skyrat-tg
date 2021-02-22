#define NEIGHBOR_REFRESH_TIME 100

/*
	Tile monitoring
*/
/obj/effect/vine
	var/list/watched_tiles = list()	//What tiles are we watching for clarity updates?


//This is called when we find a blocking obstacle, like a wall/window/door.
//We set an observation on it so that, at some point, if it ever changes, we will wake up and try to spread into it again
/obj/effect/vine/proc/watch_tile(var/turf/T)
	if ((T in watched_tiles))
		return	//Don't watch the same tile twice

	GLOB.clarity_set_event.register(T, src, /obj/effect/vine/proc/watched_tile_updated)
	watched_tiles += T

//Remove the observations from tiles we're watching
/obj/effect/vine/proc/unwatch_tiles()
	for (var/turf/T in watched_tiles)
		GLOB.clarity_set_event.unregister(T, src, /obj/effect/vine/proc/watched_tile_updated)

	watched_tiles = list()

//If a watched tile changes, lets wake up. This will wipe watched tiles, and start checks anew
/obj/effect/vine/proc/watched_tile_updated(var/turf/T)
	wake_up()





/obj/effect/vine/proc/get_cardinal_neighbors()
	var/list/cardinal_neighbors = list()
	for(var/check_dir in GLOB.cardinal)
		var/turf/simulated/T = get_step(get_turf(src), check_dir)
		if(istype(T))
			cardinal_neighbors |= T
	return cardinal_neighbors

/obj/effect/vine/proc/get_zlevel_neighbors()
	var/list/zlevel_neighbors = list()

	var/turf/start = loc
	var/turf/up = GetAbove(loc)
	var/turf/down = GetBelow(loc)

	if(down && start && start.CanZPass(src, DOWN))
		zlevel_neighbors += down

	if(up && up.CanZPass(src, UP))
		zlevel_neighbors += up

	return zlevel_neighbors

/obj/effect/vine/proc/update_neighbors()
	neighbors = list()
	neighbors = get_neighbors(TRUE, TRUE)

/obj/effect/vine/proc/get_neighbors(var/zcheck = TRUE, var/bounds = TRUE)
	var/list/newneighbors = list()
	var/list/candidates = get_cardinal_neighbors()
	if (zcheck)
		candidates |= get_zlevel_neighbors()

	for(var/turf/T as anything in candidates)
		var/result = can_spread_to(T, bounds)
		//The special result of -1 is returned when we can't spread there yet, but maybe we can in future
		if (result == -1)
			watch_tile(T)
			continue
		else if (result == FALSE)
			continue


		newneighbors |= T


	return newneighbors


/obj/effect/vine/proc/can_spread_to(var/turf/floor, var/bounds)
	if(bounds && !can_reach(floor))
		return FALSE

	var/blocked = 0
	for(var/obj/effect/vine/other in floor.contents)
		if(other.seed == src.seed && !QDELETED(other))
			blocked = 1
			break
	if(blocked)
		return FALSE

	if(!floor.Enter(src))
		watch_tile(floor)
		return -1	//Special result

	return TRUE


/obj/effect/vine/Process()
	var/turf/simulated/T = get_turf(src)
	if(!istype(T))
		return

	//Take damage from bad environment if any
	adjust_health(-seed.handle_environment(T,T.return_air(),null,1))
	if(health <= 0)
		return

	//Vine fight!
	for(var/obj/effect/vine/other in T)
		if(other.seed != seed)
			other.vine_overrun(seed, src)

	//Growing up
	if(can_regen())
		adjust_health(max_health / (mature_time * (1 / SSplants.wait)))//Adjust for plant subsystem delay to keep the healing over time consistent
		if(growth_threshold && !(health % growth_threshold))
			update_icon()

	if(is_mature())
		//Find a victim
		if(!buckled_mob)
			var/mob/living/list/targets = targets_in_range()
			if(targets && targets.len && prob(round(seed.get_trait(TRAIT_POTENCY)/4)))
				entangle(pick(targets))

		//Handle the victim
		if(buckled_mob)
			seed.do_sting(buckled_mob,src)
			if(seed.get_trait(TRAIT_CARNIVOROUS))
				seed.do_thorns(buckled_mob,src)

		//Try to spread
		if(can_spread() && prob(spread_chance))
			update_neighbors()//This is a bit of a dirty fix, i couldn't make it work right in the available time
			if(neighbors.len)
				spread_to(pick(neighbors))

	//Try to settle down
	if(can_spawn_plant())
		spawn_plant(T)


	if(should_sleep())
		STOP_PROCESSING(SSvines, src)

/obj/effect/vine/proc/can_regen()
	if(health < max_health)
		return TRUE

/obj/effect/vine/proc/can_spawn_plant()
	if (!is_mature())
		return FALSE
	var/turf/simulated/T = get_turf(src)
	return parent == src && health == max_health && !plant && istype(T) && !T.CanZPass(src, DOWN)

/obj/effect/vine/proc/spawn_plant(var/turf/T)
	plant = new(T,seed)
	plant.dir = src.dir
	plant.transform = src.transform
	plant.age = seed.get_trait(TRAIT_MATURATION)-1
	plant.update_icon()
	if(growth_type==0) //Vines do not become invisible.
		set_invisibility(INVISIBILITY_MAXIMUM)
	else
		plant.layer = layer + 0.1
	return plant

/obj/effect/vine/proc/should_sleep()
	if(buckled_mob) //got a victim to fondle
		return FALSE
	if(neighbors.len) //got places to spread to
		return FALSE
	if(health < max_health) //got some growth to do
		return FALSE
	if(targets_in_range()) //got someone to grab
		return FALSE
	if(can_spawn_plant()) //should settle down and spawn a tray
		return FALSE
	return TRUE


/obj/effect/vine/proc/can_spread()
	if (parent && parent.possible_children)
		if(neighbors && neighbors.len)
			return TRUE
	return FALSE

/obj/effect/vine/proc/can_reach(var/turf/floor)
	if (get_dist_3D(parent, floor) <= spread_distance)
		return TRUE
	return FALSE


//spreading vines aren't created on their final turf.
//Instead, they are created at their parent and then move to their destination.
/obj/effect/vine/proc/spread_to(turf/target_turf)
	var/obj/effect/vine/child = new type(get_turf(src),seed,parent) // This should do a little bit of animation.
	//move out to the destination
	if(child.forceMove(target_turf))
		child.update_icon()
		child.set_dir(child.calc_dir())
		child.wake_neighbors() //Update surrounding tiles to handle edges
		update_icon()	//We don't need one of our edges now, update to get rid of it
		// Some plants eat through plating.
		if(islist(seed.chems) && !isnull(seed.chems[/datum/reagent/acid/triflicacid]))
			target_turf.ex_act(prob(80) ? 3 : 2)

		//Update our neighbors list
		update_neighbors()
		return child
	else
		qdel(child)

/obj/effect/vine/proc/wake_up(var/wake_adjacent = TRUE)
	unwatch_tiles()	//Wipe our watched tiles so we can re-watch them, possibly less of them
	update_neighbors()
	update_icon()
	START_PROCESSING(SSvines, src)
	if (wake_adjacent)
		wake_neighbors()

/obj/effect/vine/proc/wake_neighbors()
	// This turf is clear now, let our buddies know.
	for(var/turf/simulated/check_turf in (get_cardinal_neighbors() | get_zlevel_neighbors()))
		if(!istype(check_turf))
			continue
		for(var/obj/effect/vine/neighbor in check_turf.contents)
			neighbor.wake_up(FALSE)

/obj/effect/vine/proc/wake_list(var/list/things)
	set waitfor = FALSE
	sleep()
	for(var/turf/T in things)
		for (var/obj/effect/vine/neighbor in T)
			neighbor.wake_up(FALSE)
			sleep()


/obj/effect/vine/proc/targets_in_range()
	var/mob/list/targets = list()
	for(var/turf/simulated/check_turf in (get_cardinal_neighbors() | get_zlevel_neighbors() | list(loc)))
		if(!istype(check_turf))
			continue
		for(var/mob/living/M in check_turf.contents)
			targets |= M
	if(targets.len)
		return targets

/obj/effect/vine/proc/die_off()

	qdel(src)

#undef NEIGHBOR_REFRESH_TIME