//This proc returns all turfs which fall inside a cone stretching Distance tiles from origin, in direction, and being angle degrees wide
/proc/get_cone(var/turf/origin, var/vector2/direction, var/distance, var/angle)

	if (!istype(direction))
		direction = Vector2.FromDir(direction)	//One of the byond direction constants may be passed in

	angle *= 0.5//We split the angle in two for the arc function

	if (!istype(origin))
		origin = get_turf(origin)

	//First of all, lets find a centre point. Halfway between origin and the edge of the cone
	var/turf/halfpoint = locate(origin.x + (direction.x * distance * 0.5), origin.y + (direction.y * distance * 0.5), origin.z)

	//And from this halfpoint, lets get a square area of turfs which is every possible turf that could be in the cone
	//We use half the distance as radius, +1 to account for any rounding errors. Its not a big deal if we get some unnecessary turfs in here
	var/list/turfs = trange(((distance*0.5) + 1), halfpoint)


	//Alright next up, we loop through the turfs. for each one:

	for (var/turf/T as anything in turfs)
		//1. We check if its distance is less than the requirement. This is cheap. If it is...
		var/dist_delta = get_dist_euclidian(origin, T)
		if (dist_delta > distance)
			turfs -= T
			continue

		//2. We check if it falls within the desired angle
		if (!target_in_arc(origin, T, direction, angle))
			turfs -= T
			continue



	//Alright we've removed all the turfs which aren't in the cone!
	return turfs

/proc/get_view_cone(var/turf/origin, var/vector2/direction, var/distance, var/angle)
	if (!istype(origin))
		origin = get_turf(origin)
	var/list/viewlist = origin.turfs_in_view(distance)
	var/list/conelist = get_cone(origin, direction, distance, angle)

	return (viewlist & conelist)

//This hella complex proc gets a cone, but divided into several smaller cones. Returns a list of lists, each containing the tiles of the subcone
//No overlapping is allowed, each subcone contains a unique list
/proc/get_multistage_cone(var/turf/origin, var/vector2/direction, var/distance, var/angle, var/stages = 5, var/clock_direction = CLOCKWISE)
	var/subcone_angle = angle / stages
	var/vector2/subcone_direction

	//If clockwise, we rotate anticlockwise to the start, by half of the main angle minus half of the subcone angle
	if (clock_direction == CLOCKWISE)
		//And after this we'll add the subcone angle to eacch direction to get the next subcone centre
		subcone_direction = direction.Turn((angle*0.5 - subcone_angle*0.5)*-1)

	//If clockwise, we rotate clockwise to the end, by half of the main angle minus half of the subcone angle
	else if (clock_direction == ANTICLOCKWISE)
		subcone_direction = direction.Turn(angle*0.5 - subcone_angle*0.5)
		subcone_angle *= -1	//And we invert the subcone angle, since we'll still be adding it


	var/list/subcones = list()
	var/list/all_tiles = list()
	for (var/i in 1 to stages)
		//For each stage, we'll get the subcone
		var/list/subcone = get_cone(origin, subcone_direction, distance, abs(subcone_angle))
		subcone -= all_tiles	//Filter out any tiles that are already in another subcone
		//Don't add empty cones to lists
		if (length(subcone) > 0)
			all_tiles += subcone	//Then add ours to the global list
			subcones += list(subcone)	//And add this cone to the list of all the cones


		subcone_direction.SelfTurn(subcone_angle)
	//We only release vectors we created, not those we were given
	release_vector(subcone_direction)
	return subcones

//Runs get cone and then picks a random tile from it
/proc/random_tile_in_cone(var/turf/origin, var/vector2/direction, var/distance, var/angle)
	var/list/tiles = get_cone(origin, direction, distance, angle)
	return pick(tiles)