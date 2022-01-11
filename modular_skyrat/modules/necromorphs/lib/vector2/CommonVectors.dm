/* Common vectors.
	Make sure you don't modify these vectors.
	You should treat all vectors as immutable in general.
*/
GLOBAL_REAL(Vector2, /Vector2) = new

/Vector2
	var/vector2/Zero
	var/vector2/One
	var/vector2/North
	var/vector2/South
	var/vector2/East
	var/vector2/West
	var/vector2/Northeast
	var/vector2/Northwest
	var/vector2/Southeast
	var/vector2/Southwest

/Vector2/New()
	Zero = new(0, 0)
	One = new(1, 1)
	North = new(0, 1)
	South = new(0, -1)
	East = new(1, 0)
	West = new(-1, 0)
	Northeast = new(sqrt(1/2), sqrt(1/2))
	Northwest = new(-sqrt(1/2), sqrt(1/2))
	Southeast = new(sqrt(1/2), -sqrt(1/2))
	Southwest = new(-sqrt(1/2), -sqrt(1/2))

/Vector2/proc/FromDir(dir)
	switch(dir)
		if(NORTH)
			return North
		if(SOUTH)
			return South
		if(EAST)
			return East
		if(WEST)
			return West
		if(NORTHEAST)
			return Northeast
		if(SOUTHEAST)
			return Southeast
		if(NORTHWEST)
			return Northwest
		if(SOUTHWEST)
			return Southwest
		else
			CRASH("Invalid direction.")


	//Like from dir, but creates a new one which is safe to edit
/Vector2/proc/NewFromDir(dir)
	var/vector2/v
	switch(dir)
		if(NORTH)
			v = North
		if(SOUTH)
			v = South
		if(EAST)
			v = East
		if(WEST)
			v = West
		if(NORTHEAST)
			v = Northeast
		if(SOUTHEAST)
			v = Southeast
		if(NORTHWEST)
			v = Northwest
		if(SOUTHWEST)
			v = Southwest
	return get_new_vector(v.x, v.y)

//Gets a directional vector between two atoms
/Vector2/proc/DirectionBetween(var/atom/A, var/atom/B)
	var/vector2/delta = get_new_vector(B.x - A.x, B.y - A.y)
	delta.SelfToMagnitude(1)
	return delta


		//Returns a directional vector and a magnitude between, handles things on the same tile intelligently
/Vector2/proc/SmartDirectionBetween(var/atom/movable/A, var/atom/movable/B)
	if (get_turf(A) != get_turf(B))
		return Vector2.DirectionBetween(A, B)

	//Alright, they're on the same tile. We're going to try to step either one back to their last move before they overlapped
	if (istype(A) && A.last_move)
		A = get_step(A, GLOB.reverse_dir[A.last_move])
		return Vector2.DirectionBetween(A, B)

	else if (istype(B) && B.last_move)
		B = get_step(B, GLOB.reverse_dir[B.last_move])
		return Vector2.DirectionBetween(A, B)

	return get_new_vector(0, 0)

/Vector2/proc/VectorBetween(var/vector2/A, var/vector2/B)
	var/vector2/delta = get_new_vector(B.x - A.x, B.y - A.y)
	return delta

//Returns a directional vector and a magnitude between
/Vector2/proc/DirMagBetween(var/atom/A, var/atom/B)
	if (get_turf(A) == get_turf(B))
		return list("direction" = SmartDirectionBetween(A, B), "magnitude" = 0)
	var/vector2/delta = get_new_vector(B.x - A.x, B.y - A.y)
	var/list/returnlist = list("direction" = delta.ToMagnitude(1), "magnitude" = delta.Magnitude())
	release_vector(delta)
	return returnlist

//TODO: Rename this, it is misleading. What it actually does is rescales the directional vector to a specified magnitude and returns that
/Vector2/proc/MagnitudeBetween(var/atom/A, var/atom/B, var/magnitude)
	var/vector2/delta = get_new_vector(B.x - A.x, B.y - A.y)
	delta.SelfToMagnitude(magnitude)
	return delta

/Vector2/proc/TurfAtMagnitudeBetween(var/atom/A, var/atom/B, var/magnitude)
	var/vector2/delta = MagnitudeBetween(A, B, magnitude)
	var/turf/T = locate(A.x + delta.x, A.y + delta.y, A.z)
	release_vector(delta)
	return T

/Vector2/proc/RandomDirection()
	var/vector2/delta = get_new_vector(rand(), rand())
	return (delta.SelfToMagnitude(1))

/Vector2/proc/VectorAverage(var/vector2/A)
	if (A)
		return (A.x + A.y) / 2
	return 0
