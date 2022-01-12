/*
	An impulse is a burst of force applied to an atom, in order to move it.

	Since SS13 has no real physics engine, this code has a lot of fudging to roughly approximate physics
	Effects is probably not the correct place for this. Impulse is a functional, not visual effect
*/


//Multiplier applied to mass for the purposes of calculating whether a force is strong enough to make us move to another tile
//Generally, sub-1 values indicate wheels, low friction, etc
/atom/movable/var/push_threshold_factor = 1

/*
	Actual impulse handling

	Direction: 2D vector of where the force is trying to push us
	Strength: Intensity of force in Newton-seconds
*/
/atom/proc/apply_impulse(var/direction, var/strength)
	//Non movable atoms cant be moved, but this is defined here for use on mining turfs later

/atom/movable/apply_impulse(var/direction, var/strength)
	if (anchored || QDELETED(src))
		return	//Anchored things never move

	if (!isturf(loc))
		return	//Things that are inside other objects can't be pushed

	var/pushmass = mass * push_threshold_factor

	if (strength < pushmass)
		//If the strength of the force is less than our mass, it's not enough to move us.
		//Possibly do shake animation here to indicate that it tried.
		return


	//Alright, the force is strong enough to push us, lets see how far!
	var/pushdist = strength / pushmass


	//And to avoid small objects being launched crazy distances, lets softcap this to roughly simulate drag
	pushdist = soft_cap(pushdist, 1, 1, 0.92)


	var/turf/pushtarget = get_turf_in_direction(src, direction, pushdist)

	spawn()
		throw_at(pushtarget, pushdist, pushdist, null)
	return TRUE

/mob/living/var/knockdown_threshold_factor = 1.5	//Requires a force at least this * mass to knock down this mob
/mob/living/var/stagger_threshold_factor = 0.1	//

/mob/living/apply_impulse(var/direction, var/strength)
	//First of all since living creatures are unpredictable, strength gets some random variance
	strength *= rand_between(0.85, 1.15)

	.=..()	//Call parent to push us


	//We may be knocked off our feet by the force
	var/knockdown_time = Floor(strength / (mass * knockdown_threshold_factor))
	if (knockdown_time >= 1)
		Weaken(knockdown_time)
	else if (!. && strength >= (mass*stagger_threshold_factor))
		//If the force wasn't strong enough to send us flying, or to knock us over
		//Maybe its just enough to make us stagger one tile
		var/turf/target_turf = random_tile_in_cone(get_turf(src), direction,2, 180)
		//No point randomising it twice or it'd just weight towards the low end
		throw_at(target_turf,1,5)
		return TRUE

/*---------------------------------------------------------
	Helper Procs
----------------------------------------------------------*/
/*
	Applies an impulse to this atom, originating from origin, to push it away from origin
	Distance is optional, it will be calculated. But if specified, calculations
*/
/atom/proc/apply_push_impulse_from(var/atom/origin, var/strength, var/falloff_factor = 1)
	var/list/data = Vector2.DirMagBetween(origin, src)
	var/vector2/direction = data["direction"]
	var/distance = data["magnitude"]

	strength = force_falloff(strength, distance, falloff_factor)

	apply_impulse(direction, strength)




//Strength falloff over distance
/proc/force_falloff(var/strength, var/distance, var/falloff_factor)
	return (strength / (1 + (distance * falloff_factor)))




/proc/get_turf_in_direction(var/atom/origin, var/vector2/direction, var/distance)
	var/vector2/delta = direction * distance

	var/turf/target = locate(origin.x + delta.x, origin.y + delta.y, origin.z)

	//TODO: Figure out some fallback method to cope for cases where this overshoots world bounds

	return target

/*
/client/verb/impulse_test()
	set category = "Debug"
	set name = "Impulse Test"

	for (var/atom/movable/AM in view(mob, 5))
		AM.apply_push_impulse_from(mob, 50)

/client/verb/cone_test()
	set category = "Debug"
	set name = "Cone Test"

	var/list/turfs = get_cone(mob, mob.dir,5, 90)
	for (var/turf/T as anything in turfs)
		debug_mark_turf(T)
		*/