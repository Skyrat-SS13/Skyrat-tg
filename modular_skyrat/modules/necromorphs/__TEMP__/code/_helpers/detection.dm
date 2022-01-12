///This file is for procs which find atoms in the world near other atoms. View, range, etc
//I got sick of these being scattered far and wide

/*
	Dview
*/
GLOBAL_DATUM_INIT(dview_mob, /mob/dview, new)


//Version of view() which ignores darkness, because BYOND doesn't have it.
/proc/dview(var/range = world.view, var/center, var/invis_flags = 0)
	if(!center)
		return

	GLOB.dview_mob.loc = get_turf(center)
	GLOB.dview_mob.see_invisible = invis_flags
	. = view(range, GLOB.dview_mob)
	GLOB.dview_mob.loc = null

/mob/dview
	invisibility = 101
	density = 0

	anchored = 1
	simulated = 0

	see_in_dark = 1e6

	virtual_mob = null

/mob/dview/Destroy(force = FALSE)
	crash_with("Prevented attempt to delete dview mob: [log_info_line(src)]")
	if (!force)
		return QDEL_HINT_LETMELIVE
	return ..() // Prevents destruction





//Mob

/atom/proc/atoms_in_view(var/check_range = world.view)
	GLOB.dview_mob.loc = get_turf(src)
	GLOB.dview_mob.see_invisible = 0
	return view(check_range, GLOB.dview_mob)

/mob/atoms_in_view(var/check_range = null)
	var/range = (check_range ? check_range : view_range)
	var/origin
	if (!view_offset)
		origin = get_turf(src)
	else
		origin = get_view_centre()

	GLOB.dview_mob.loc = origin
	GLOB.dview_mob.see_invisible = 0
	return view(range, GLOB.dview_mob)

//Returns a list of all turfs this mob can see, accounting for view radius and offset
/atom/proc/turfs_in_view(var/check_range = world.view)
	var/list/things = list()
	FOR_DVIEW(var/turf/T, check_range, get_turf(src), 0)
		things += T
	END_FOR_DVIEW
	return things

/mob/turfs_in_view(var/check_range = null)
	var/range = (check_range ? check_range : view_range)
	if (!isnum(range) || range < 0)
		range = world.view
	else
		range = Ceiling(range)	//Just incase a noninteger value was passed
	var/origin
	if (!view_offset)
		origin = get_turf(src)
	else
		origin = get_view_centre()

	var/list/things = list()
	FOR_DVIEW(var/turf/T, range, origin, 0)
		things += T
	END_FOR_DVIEW
	return things


/*
	As above, but specifically finds turfs without dense objects blocking them
	Floor only excludes space and openspace, only returning tiles that someone could stand/be placed on
*/
/atom/proc/clear_turfs_in_view(var/check_range = world.view, var/floor_only = TRUE)
	var/list/things = list()
	for (var/turf/T as anything in turfs_in_view(check_range))
		if (floor_only && !istype(T, /turf/simulated/floor))
			continue

		if (turf_clear(T))
			things += T

	return things



//Generic

// Returns a list of mobs and/or objects in range of R from source. Used in radio and say code.

/proc/get_mobs_or_objects_in_view(var/R, var/atom/source, var/include_mobs = 1, var/include_objects = 1)

	var/turf/T = get_turf(source)
	var/list/hear = list()

	if(!T)
		return hear

	var/list/range = hear(R, T)

	for(var/I in range)
		if(ismob(I))
			hear |= recursive_content_check(I, hear, 3, 1, 0, include_mobs, include_objects)
			if(include_mobs)
				var/mob/M = I
				if(M.client)
					hear += M
		else if(istype(I,/obj/))
			hear |= recursive_content_check(I, hear, 3, 1, 0, include_mobs, include_objects)
			if(include_objects)
				hear += I

	return hear


/proc/get_mobs_in_radio_ranges(var/list/obj/item/device/radio/radios)

	set background = 1

	. = list()
	// Returns a list of mobs who can hear any of the radios given in @radios
	var/list/speaker_coverage = list()
	for(var/obj/item/device/radio/R in radios)
		if(R)
			//Cyborg checks. Receiving message uses a bit of cyborg's charge.
			var/obj/item/device/radio/borg/BR = R
			if(istype(BR) && BR.myborg)
				var/mob/living/silicon/robot/borg = BR.myborg
				var/datum/robot_component/CO = borg.get_component("radio")
				if(!CO)
					continue //No radio component (Shouldn't happen)
				if(!borg.is_component_functioning("radio") || !borg.cell_use_power(CO.active_usage))
					continue //No power.

			var/turf/speaker = get_turf(R)
			if(speaker)
				for(var/turf/T in hear(R.canhear_range,speaker))
					speaker_coverage[T] = T


	// Try to find all the players who can hear the message
	for(var/i = 1; i <= GLOB.player_list.len; i++)
		var/mob/M = GLOB.player_list[i]
		if(M)
			var/turf/ear = get_turf(M)
			if(ear)
				// Ghostship is magic: Ghosts can hear radio chatter from anywhere
				if(speaker_coverage[ear] || (isghost(M) && M.get_preference_value(/datum/client_preference/ghost_radio) == GLOB.PREF_ALL_CHATTER))
					. |= M		// Since we're already looping through mobs, why bother using |= ? This only slows things down.
	return .

/proc/get_mobs_and_objs_in_view_fast(var/turf/T, var/range, var/list/mobs, var/list/objs, var/checkghosts = null)

	var/list/hear = dview(range,T,INVISIBILITY_MAXIMUM)
	var/list/hearturfs = list()

	for(var/atom/movable/AM in hear)
		if(ismob(AM))
			mobs += AM
			hearturfs += get_turf(AM)
		else if(isobj(AM))
			objs += AM
			hearturfs += get_turf(AM)

	for(var/mob/M in GLOB.player_list)
		if(checkghosts && M.stat == DEAD && M.get_preference_value(checkghosts) != GLOB.PREF_NEARBY)
			mobs |= M
		else if(get_turf(M) in hearturfs)
			mobs |= M

	for(var/obj/O in GLOB.listening_objects)
		if(get_turf(O) in hearturfs)
			objs |= O






proc/isInSight(var/atom/A, var/atom/B)
	var/turf/Aturf = get_turf(A)
	var/turf/Bturf = get_turf(B)

	if(!Aturf || !Bturf)
		return 0

	if(inLineOfSight(Aturf.x,Aturf.y, Bturf.x,Bturf.y,Aturf.z))
		return 1

	else
		return 0

proc
	inLineOfSight(X1,Y1,X2,Y2,Z=1,PX1=16.5,PY1=16.5,PX2=16.5,PY2=16.5)
		var/turf/T
		if(X1==X2)
			if(Y1==Y2)
				return 1 //Light cannot be blocked on same tile
			else
				var/s = SIGN(Y2-Y1)
				Y1+=s
				while(Y1!=Y2)
					T=locate(X1,Y1,Z)
					if(T.opacity)
						return 0
					Y1+=s
		else
			var/m=(32*(Y2-Y1)+(PY2-PY1))/(32*(X2-X1)+(PX2-PX1))
			var/b=(Y1+PY1/32-0.015625)-m*(X1+PX1/32-0.015625) //In tiles
			var/signX = SIGN(X2-X1)
			var/signY = SIGN(Y2-Y1)
			if(X1<X2)
				b+=m
			while(X1!=X2 || Y1!=Y2)
				if(round(m*X1+b-Y1))
					Y1+=signY //Line exits tile vertically
				else
					X1+=signX //Line exits tile horizontally
				T=locate(X1,Y1,Z)
				if(T.opacity)
					return 0
		return 1



/proc/able_mobs_in_oview(var/origin)
	var/list/mobs = list()
	for(var/mob/living/M in oview(origin)) // Only living mobs are considered able.
		if(!M.is_physically_disabled())
			mobs += M
	return mobs



/proc/circlerange(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/atom/T in range(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T

	//turfs += centerturf
	return turfs

/proc/circleview(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/atoms = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/atom/A in view(radius, centerturf))
		var/dx = A.x - centerturf.x
		var/dy = A.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			atoms += A

	//turfs += centerturf
	return atoms

/proc/trange(rad = 0, turf/centre = null) //alternative to range (ONLY processes turfs and thus less intensive)
	if(!centre)
		return

	var/turf/x1y1 = locate(((centre.x-rad)<1 ? 1 : centre.x-rad),((centre.y-rad)<1 ? 1 : centre.y-rad),centre.z)
	var/turf/x2y2 = locate(((centre.x+rad)>world.maxx ? world.maxx : centre.x+rad),((centre.y+rad)>world.maxy ? world.maxy : centre.y+rad),centre.z)
	return block(x1y1,x2y2)

/proc/get_dist_euclidian(atom/Loc1 as turf|mob|obj,atom/Loc2 as turf|mob|obj)
	var/dx = Loc1.x - Loc2.x
	var/dy = Loc1.y - Loc2.y

	var/dist = sqrt(dx**2 + dy**2)


	return dist

/proc/get_dist_3D(var/atom/A, var/atom/B)
	var/dist = get_dist_euclidian(A, B)

	//If on different zlevels, we do some extra math
	if (A.z != B.z)
		dist = sqrt(dist**2 + ((A.z - B.z)*CELL_HEIGHT)**2)

	return dist

/proc/circlerangeturfs(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/turf/T in range(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T
	return turfs

/proc/circleviewturfs(center=usr,radius=3)		//Is there even a diffrence between this proc and circlerangeturfs()?

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/turf/T in view(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T
	return turfs


/*A complicated proc!
/This attempts to find something meeting a variety of conditions. Vars:
	Origin: Where we start looking. Search around origin
	Radius: How far out to look?
	Valid Types:	A list of various typepaths which are valid
	Allied:	A list. First value contains a mob to compare with, second value must be true or false. An atom is only considered valid if it gets a matching result for is_allied
	Visualnet:	If not null, a qualifying atom must be located on a turf which is seen by this visualnet
	Corruption:	If true, qualifying atom must be, or be on, a corrupted tile
	View:	If true, limit the searching to turfs in view of origin. When false, searches in a range
	LOS Block:	If true, blocked by live crew seeing
	Num:	How many targets to find? We'll keep searching til we get this many or have examined every turf's contents. Any false value counts as infinity, search everything
	Special Check: A callback for additional specific checks
	Error User:	A user to show failure messages to, if we fail
*/
/proc/get_valid_target(var/atom/origin, var/radius, var/list/valid_types = list(/turf), var/list/allied = null, var/datum/visualnet/visualnet = null, var/require_corruption = FALSE, var/view_limit = FALSE, var/LOS_block = FALSE, var/num_required = 1, var/datum/callback/special_check = null, var/mob/error_user)
	var/list/results = list()
	var/list/haystack
	if (view_limit)
		haystack = origin.atoms_in_view(radius)
	else
		haystack = range(radius, origin)

	//Possible future todo: Optimise haystack selection based on valid types

	//In the case of LOS block, a list of mobs that see us. used only to give messages to players
	var/list/viewers = list()


	//Okay now we have our list to search through

	for (var/atom/A as anything in haystack)

		//Check if it matches one of our required types
		var/typematch = FALSE
		for (var/v in valid_types)
			if (istype(A, v))
				typematch = TRUE
				break

		if (!typematch)
			continue	//If not, abort



		//Special check is a callback that can be passed in, to do fancy things
		if (special_check)
			if (special_check.Invoke(A) != TRUE)
				continue

		var/turf/T = get_turf(A)
		if (require_corruption)
			if (!turf_corrupted(T))
				continue

		if (visualnet)
			if (!T.is_in_visualnet(visualnet))
				continue

		if (allied)
			var/mob/user = allied[1]
			if ((user.is_allied(A) != allied[2]))
				continue

		if (LOS_block)
			var/mob/M = T.is_seen_by_crew()
			if (M)
				viewers |= M
				continue


		//If we get here, then the item is valid. Add it to our results list
		results += A

		//If we've set a defined target of results, and now meet or exceed that target, then break out and return
		if (num_required && results.len >= num_required)
			break


	//In the case we failed to find any/enough targets, lets try to explain to the user why
	if (error_user && results.len < num_required)
		if (viewers.len)
			to_chat(error_user, SPAN_WARNING("Casting here is blocked because the tile is seen by [english_list(viewers)]"))


	return results


//These are literally just the same function with slightly different names, for convenience
/atom/proc/get_cardinal()
	.=list()
	for (var/direction in GLOB.cardinal)
		var/turf/T = get_step(src, direction)
		.+=T

/atom/proc/get_cardinal_turfs()
	.=list()
	for (var/direction in GLOB.cardinal)
		var/turf/T = get_step(src, direction)
		.+=T


/atom/proc/get_diagonal_turfs()
	.=list()
	for (var/direction in GLOB.cornerdirs)
		var/turf/T = get_step(src, direction)
		.+=T

//This proc attempts to get all mobs who are able to see this atom
//Set required type to /mob/living to exclude ghosts
/atom/proc/get_viewers(var/maxrange = 20, var/required_type = /mob, var/once_only = FALSE)
	var/list/our_viewers = list()
	//Make this variable but don't generate it yet
	var/list/view_area

	var/turf/origin = get_turf(src)

	//This is a list of all mobs with clients. At any given time it might contain 0-100 things
	//Searching this is much cheaper than searching the contents of a view call, which is often several thousand atoms
	for (var/mob/A as anything in GLOB.player_list)
		//A mob seeing itself doesnt count
		if (A == src)
			continue

		if (!istype(A, required_type))
			continue
		//No support for cross-zlevel viewing yet
		if (A.z != src.z)
			continue

		//Distance checks are simplest
		if (get_dist(src, A) > maxrange)
			continue

		//Alright if we get here, then someone might possibly be able to see this object, here we start the more expensive checks
		var/client/C = A.get_client()
		if (!C)
			continue

		//Lets see if this item falls within the candidate's screen
		if (!C.is_on_screen(src))
			continue

		//TODO HERE: Check if the viewer has xray vision?

		//Aaand finally, the most expensive of all, view calls. We've deferred generating view_area so far incase we didn't need to get this far.
		//now we need it, so generate it
		if (!view_area)
			view_area = dview(maxrange, origin)

		var/turf/T = get_turf(A)
		if (!(T in view_area))
			continue

		//Alright we're done. If we've reached this point, then this guy can see us
		our_viewers |= A

		if (once_only)
			break
	return our_viewers



/atom/proc/get_turf_at_offset(var/vector2/offset)
	return locate(x + offset.x, y + offset.y, z)






/*
	This attempts to figure out what height a mob is aiming at
	User is mandatory, target is optional.

	If no target, we will take the user's aimed zone and grab the height from GLOB.organ_altitudes
	If we're aiming at a human target, we'll take the aimed zone, and use it to read a height from the target's species' has limbs
*/
/proc/get_aiming_height(var/mob/user, var/mob/living/carbon/human/target)
	if (!user)
		return GLOB.organ_altitudes[BP_CHEST]

	var/aiming_zone = get_zone_sel(user)
	if (istype(target))

		//We will do substitutions of course
		//But we won't run find_target_organ, we will allow things to be aimed at already-severed limbs
		if (target.species.organ_substitutions[aiming_zone])
			aiming_zone = target.species.organ_substitutions[aiming_zone]


		//Get the list of data, this contains typepath and height vector
		var/list/organ_data = target.species.has_limbs[aiming_zone]

		//Check that the data exists
		if(organ_data["height"])
			//This is a vector range, we'll average it out
			return Vector2.VectorAverage(organ_data["height"])

	else
		//No human target, get whatever we're aiming towards if it were human
		return GLOB.organ_altitudes[aiming_zone]


//Recursive function to find the atom on a turf which we're nested inside
/atom/proc/get_toplevel_atom()
	var/atom/A = src
	while(A.loc && !(isturf(A.loc)))
		A = A.loc

	return A

/turf/get_toplevel_atom()
	return src

/area/get_toplevel_atom()
	return src