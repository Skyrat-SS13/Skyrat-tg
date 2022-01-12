//Returns the direction from A to B, rounded to the nearest cardinal
//Doing this repeatedly can be used to trace a stair-pattern path towards diagonal objects
/proc/get_cardinal_dir(atom/A, atom/B)
	var/vector2/direction = get_new_vector(B.x - A.x, B.y - A.y)
	if (!direction.NonZero())	//Error!
		return SOUTH	//Default value in case of emergencies
	direction.SelfNormalize()
	var/angle = direction.AngleFrom(Vector2.North)
	angle = round(angle, 90)
	release_vector(direction)
	return turn(NORTH, angle)

//duplicated code for speed
/proc/get_cardinal_step_towards(atom/A, atom/B)
	var/vector2/direction = get_new_vector(B.x - A.x, B.y - A.y)
	if (!direction.NonZero())	//Error!
		return get_step(A, SOUTH)	//Default value in case of emergencies
	direction.SelfNormalize()
	var/angle = direction.AngleFrom(Vector2.North)
	angle = round(angle, 90)
	var/stepdir = turn(NORTH, -angle)	//Minus angle because turn rotates counterclockwise
	release_vector(direction)
	return get_step(A, stepdir)