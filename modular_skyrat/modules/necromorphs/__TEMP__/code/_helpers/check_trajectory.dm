//Procs to check if a target atom can be reached from the current. Essentially raytracing

//Helper proc to check if you can hit them or not.
/proc/check_trajectory(atom/target as mob|obj, atom/firer as mob|obj, var/pass_flags=PASS_FLAG_TABLE|PASS_FLAG_GLASS|PASS_FLAG_GRILLE|PASS_FLAG_FLYING, item_flags = null, obj_flags = null)
	if(!istype(target) || !istype(firer))
		return 0

	//If its in the same turf, just say yes
	if (get_turf(target) == get_turf(firer))
		return TRUE




	var/obj/item/projectile/test/trace = new /obj/item/projectile/test(get_turf(firer)) //Making the test....
	//Set the flags and pass flags to that of the real projectile...
	if(!isnull(item_flags))
		trace.item_flags = item_flags
	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	var/output = trace.launch(target) //Test it!
	QDEL_NULL(trace) //No need for it anymore
	return output //Send it back to the gun!





//Version optimised for mass testing
//Takes a list of target atoms to test
//Returns back the same list as an associative, with target as key, and true/false as value telling us whether we succeeded or failed in hitting
/proc/check_trajectory_mass(var/list/targets, atom/firer as mob|obj, var/pass_flags=PASS_FLAG_TABLE|PASS_FLAG_GLASS|PASS_FLAG_GRILLE|PASS_FLAG_FLYING, item_flags = null, obj_flags = null, var/allow_sleep = FALSE)
	if(!istype(firer))
		return 0

	var/turf/origin = get_turf(firer)
	var/obj/item/projectile/test/trace = new /obj/item/projectile/test(origin) //Making the test....

	//Set the flags and pass flags to that of the real projectile...
	if(!isnull(item_flags))
		trace.item_flags = item_flags
	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	for (var/atom/A as anything in targets)
		if (allow_sleep)
			CHECK_TICK
		trace.result = null
		trace.loc = origin
		targets[A] = trace.launch(A) //Test it!
	QDEL_NULL(trace) //No need for it anymore
	return targets //Send it back to the gun!


//More verbose version that returns more info.
//Returns the following: list(success,	//true/false, whether we successfully reached the target
//last_loc,	//The turf we managed to reach. Will be the target's turf if we got there. If something blocked us, it'll be the turf just before that thing
//last_obstacle)	//What we hit/got blocked by. Will be a dense object if one got in the way. Will be the target if we reached it, regardless of density

/proc/check_trajectory_verbose(atom/target as mob|obj, atom/firer as mob|obj, var/pass_flags=PASS_FLAG_TABLE|PASS_FLAG_GLASS|PASS_FLAG_GRILLE|PASS_FLAG_FLYING, item_flags = null, obj_flags = null)
	if(!istype(target) || !istype(firer))
		return 0

	//If its in the same turf, just say yes
	if (get_turf(target) == get_turf(firer))
		return TRUE




	var/obj/item/projectile/test/trace = new /obj/item/projectile/test(get_turf(firer)) //Making the test....
	//Set the flags and pass flags to that of the real projectile...
	if(!isnull(item_flags))
		trace.item_flags = item_flags
	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	var/output = trace.launch(target) //Test it!
	var/list/results = list(output, get_turf(trace), trace.obstacle)
	QDEL_NULL(trace) //No need for it anymore
	return results //Send it back to the gun!


//Version optimised for mass testing, and verbose
//Takes a list of target atoms to test
//Returns back an associative list of key value pairs in the format:
/*
	target = list(success, last_loc, last_obstacle)
*/
/proc/check_trajectory_mass_verbose(var/list/targets, atom/firer as mob|obj, var/pass_flags=PASS_FLAG_TABLE|PASS_FLAG_GLASS|PASS_FLAG_GRILLE|PASS_FLAG_FLYING, item_flags = null, obj_flags = null, var/allow_sleep = FALSE)
	if(!istype(firer))
		return 0

	var/turf/origin = get_turf(firer)
	var/obj/item/projectile/test/trace = new /obj/item/projectile/test(origin) //Making the test....

	//Set the flags and pass flags to that of the real projectile...
	if(!isnull(item_flags))
		trace.item_flags = item_flags
	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	for (var/atom/A as anything in targets)
		if (allow_sleep)
			CHECK_TICK
		trace.result = null
		trace.loc = origin
		var/output = trace.launch(A) //Test it!
		targets[A] = list(output, get_turf(trace), trace.obstacle)
	QDEL_NULL(trace) //No need for it anymore
	return targets //Send it back to the gun!





//"Tracing" projectile
/obj/item/projectile/test //Used to see if you can hit them.
	invisibility = 101 //Nope!  Can't see me!
	yo = null
	xo = null
	var/obstacle = null
	var/result = null //To pass the message back to the gun.
	vacuum_traversal = TRUE


//This shouldn't be called on a test projectile
/obj/item/projectile/test/expire()
	return

/obj/item/projectile/test/Bump(atom/A as mob|obj|turf|area, forced = 0)
	if(A == firer)
		last_loc = loc
		loc = A.loc
		return //cannot shoot yourself
	if(istype(A, /obj/item/projectile))
		return

	obstacle = A
	if(A == original)

		result = TRUE
		return
	result = FALSE
	return

/obj/item/projectile/test/launch(atom/target)
	var/turf/curloc = get_turf(src)
	var/turf/targloc = get_turf(target)
	if(!curloc || !targloc)
		return FALSE

	if (curloc == targloc)
		return TRUE

	original = target

	//plot the initial trajectory
	setup_trajectory(curloc, targloc)
	return Process(targloc)

/obj/item/projectile/test/Process(var/turf/targloc)

	//Every step along the trajectory, we may populate this list with sub-steps.
	//If populated we follow it
	var/list/steps = list()
	while(!QDELETED(src)) //Loop on through!
		if((!( targloc ) || loc == targloc))
			targloc = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z) //Finding the target turf at map edge

		var/turf/newloc
		if (!length(steps))
			trajectory.increment()	// increment the current location
			location = trajectory.return_location(location)		// update the locally stored location data

			//TODO: Figure out why this happens
			if (!location)
				return FALSE

			newloc = location.return_turf()

			//If we're moving diagonally, then we need some more complex resolution
			if (!loc.cardinally_adjacent(newloc))
				steps = get_line_between(loc, newloc, FALSE, FALSE)

				newloc = antipop(steps)


		else
			newloc = antipop(steps)


		Move(newloc)


		//Check this again, our attempted move may have just set it
		if(!isnull(result))
			return result

		var/turf/T = get_turf(src)
		if (T == original)
			obstacle = original
			return TRUE

		var/atom/A = locate(original) in T
		if(A) //We are on our target's turf, we can hit them
			obstacle = A
			return TRUE

		//If we get here, lets set our location to the newloc and ignore blockers
		loc = newloc


/obj/item/projectile/test/Destroy()
	obstacle = null
	result = null
	.=..()



