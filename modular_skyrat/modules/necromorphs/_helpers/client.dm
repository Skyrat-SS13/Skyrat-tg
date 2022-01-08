/client/proc/is_on_screen(var/atom/A)
	.=FALSE
	if (!A)
		return FALSE

	if (!isturf(A.loc))
		A = get_turf(A) //If its hidden inside an object, we move to its tile

	//Ok, now lets see if the target is onscreen,
	//First we've got to figure out what onscreen is
	var/atom/origin = get_view_centre()

	//If we fail to get a view centre, something's gone wrong, we definitely cant see anything
	if (!origin)
		return

	//Lets get how far the screen extends around the origin
	var/list/bound_offsets = get_tile_bounds(FALSE) //Cut off partial tiles or they might stretch the screen
	var/vector2/delta = get_new_vector(A.x - origin.x, A.y - origin.y)	//Lets get the position delta from origin to target
	//Now check whether or not that would put it onscreen
	//Bottomleft first
	var/vector2/BL = bound_offsets["BL"]
	if (delta.x < BL.x || delta.y < BL.y)
		//Its offscreen
		release_vector(delta)
		release_vector_assoc_list(bound_offsets)
		return


	//Then topright
	var/vector2/TR = bound_offsets["TR"]
	if (delta.x > TR.x || delta.y > TR.y)
		//Its offscreen
		release_vector(delta)
		release_vector_assoc_list(bound_offsets)
		return



	release_vector(delta)
	release_vector_assoc_list(bound_offsets)
	//If we get here, the target is on our screen!
	return TRUE
