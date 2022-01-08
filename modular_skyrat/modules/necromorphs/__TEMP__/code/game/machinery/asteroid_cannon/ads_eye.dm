/*
	Eye: Used for offset view on fixed angle turrets
*/
/mob/dead/observer/eye/turret
	var/atom/gun = null
	var/offset = 12
	view_range = 17
	var/turf/offset_turf
	var/vector2/direction_vector	//This uses a non-copied global vector fetched from direction.
	//Do not edit or release it

/mob/dead/observer/eye/turret/possess(var/mob/user, var/atom/newgun)
	gun = newgun

	.=..()
	update_direction()

/mob/dead/observer/eye/turret/proc/update_direction()
	//We do NOT release the old vector here, it is a global value
	direction_vector = Vector2.FromDir(gun.dir)

	//This is temporary, we'll release it in a sec
	var/vector2/offset_vector = direction_vector * offset
	offset_turf = locate(gun.x + offset_vector.x, gun.y + offset_vector.y, gun.z)
	setLoc(offset_turf)

	release_vector(offset_vector)


/mob/dead/observer/eye/turret/EyeMove(direct)
	//Lets see if our target turf is valid
	var/turf/target_turf = get_step(src, direct)

	//To do that, we simply get the delta vector between our offset and the target, then
	var/vector2/difference = Vector2.VectorBetween(offset_turf, target_turf)

	//Cross product with the turret direction
	var/vector2/cross = difference * direction_vector


	var/fail = FALSE
	//Now we check the cross. Any values which are negative, have gone past where they should, and that makes this movement invalid
	if (cross.x < 0 || cross.y < 0)
		fail = TRUE

	//Call parent to allow move to proceed
	if (!fail)
		. = ..()

	//Simply do not call parent to terminate movement
	//Either way we gotta cleanup vectors
	release_vector(cross)
	release_vector(difference)


/mob/dead/observer/eye/turret/Destroy()
	gun = null
	. = ..()