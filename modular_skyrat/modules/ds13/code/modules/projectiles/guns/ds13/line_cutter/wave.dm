/*
	A wave is a special kind of multi-part projectile, made of several smaller projectiles

	By default, a target can only be damaged once by the whole wave. The additional projectiles provide coverage, not multiplied damage

	One of the projectiles is designated the master of the wave, and this is the only one which typically has a visual representation.
	Large enough to cover fro the others
	The master is responsible for adjusting its visuals to represent projectiles that are lost

	Any projectile may be lost from the wave. If one is lost from somewhere in the middle which results in the wave no longer being cardinally connected,
	then the wave will split into two smaller waves

	Some projectiles are designated as backstops. They are extras created to fill gaps when the main projectiles do not connect cardinally.
	Backstops cannot become master projectiles, and will be deleted if they are orphaned into a wave with no normal projectiles

*/

/*----------------------------
	Creating a Wave
-----------------------------*/
//Actually creates and launches a wave.
//Width should be an odd number or it will skew to the right
/proc/launch_wave(var/atom/source, var/atom/target, var/projectile_type = /obj/item/projectile/wave, var/width = 3, var/mob/living/user, var/obj/item/weapon/gun/launcher)

	var/datum/projectile_wave/wave = new()

	if (user)
		wave.altitude = get_aiming_height(user, target)
	wave.origin = source
	wave.target = target
	wave.projectile_type = projectile_type

	wave.target_zone = get_zone_sel(user)

	var/vector2/direction = Vector2.DirectionBetween(source, target)
	wave.direction = direction
	wave.perpendicular_direction = direction.Turn(90)
	//These belong to the wave now, so we won't release them

	var/turf/start_turf = wave.origin.get_turf_at_pixel_offset(direction * WORLD_ICON_SIZE)

	//Lets make our first/master projectile
	var/obj/item/projectile/wave/W = new projectile_type(start_turf)
	W.altitude = wave.altitude
	wave.register(W, FALSE)
	wave.select_master()
	width--

	var/steps_out = 0
	var/vector2/direction_right = direction.Turn(90)
	var/vector2/direction_left = direction.Turn(-90)
	while(width > 0)
		steps_out++

		//We go to the left first
		var/vector2/offset = direction_left * (WORLD_ICON_SIZE * steps_out)
		var/turf/T = start_turf.get_turf_at_pixel_offset(offset)
		release_vector(offset)
		W = new projectile_type(T)
		wave.register(W, FALSE)
		W.side = LEFT
		W.altitude = wave.altitude
		width--

		if (width <= 0)
			break

		//Then we go right
		offset = direction_right * (WORLD_ICON_SIZE * steps_out)
		T = start_turf.get_turf_at_pixel_offset(offset)
		release_vector(offset)
		W = new projectile_type(T)
		wave.register(W, FALSE)
		W.side = RIGHT
		W.altitude = wave.altitude
		width--

	release_vector(direction_right)
	release_vector(direction_left)

	//Alright we have now created all the mainline projectiles that we need.
	wave.update_connections()	//This will create backstops as needed

	//Now finally, the wave is ready to fire!
	for (W as anything in wave.projectiles)
		//Each tile aims at a tile offset from the base target, equal to its offset from the master projectile
		var/turf/target_loc = target.get_turf_at_offset(W.offset)


		//We can't do launch_from_gun for positional reasons. But if a gun is supplied, we'll populate the variables that proc would
		if (launcher)
			W.last_loc = W.loc
			W.shot_from = launcher

		if (user)
			W.firer = user

		W.launch(target_loc, wave.target_zone)


//This projectile creates a wave and then deletes itself()
/obj/item/projectile/wavespawner
	var/wave_type = /obj/item/projectile/wave
	var/width = 3

/obj/item/projectile/wavespawner/finalize_launch(var/turf/curloc, var/turf/targloc, var/x_offset, var/y_offset, var/angle_offset)

	launch_wave(firer, original, wave_type, width, firer, shot_from)
	expire()





/*----------------------------
	Wave Datum
-----------------------------*/
/datum/projectile_wave
	var/projectile_type = /obj/item/projectile/wave
	var/list/projectiles = list()	//All the projectiles in the list
	var/obj/item/projectile/wave/master	//The specific projectile which is designated master

	var/vector2/direction
	var/vector2/perpendicular_direction

	var/width = 3

	var/atom/origin //Where is this wave being fired from?
	var/atom/target	//Where is this wave being fired -at- ? The master projectile will go straight here, the others will target a tile appropriately offset from it

	//A list of things that have already been hit by this wave.
	//These atoms can't be damaged a second time, although they can still block parts of the wave
	var/list/damaged_atoms = list()


	//A temporary list used during split handling
	var/list/connected = list()


	//What bodypart is the wave aimed at
	var/target_zone = BP_CHEST

	//If a projectile is more than WORLD_ICON_SIZE pixels away from the master, it may move up to this many towards it, to make the wave more whole
	var/squish = 16

	//How high above the ground is this travelling
	var/altitude = 1

/datum/projectile_wave/Destroy()
	release_vector(direction)
	release_vector(perpendicular_direction)
	.=..()

/*
	Adds a projectile to this wave
*/
/datum/projectile_wave/proc/register(var/obj/item/projectile/wave/A, var/refresh_connections = TRUE)
	//We are its wave controller now
	A.PW = src


	//And we put it in our list
	projectiles |= A



	//This is optional so that we can batch-add many projectiles during wave creation
	if (refresh_connections)
		update_connections()

/*
	Removes a projectile from this wave
	This is quite likely to split the wave in two, we'll check and handle that
*/
/datum/projectile_wave/proc/remove(var/obj/item/projectile/wave/A, var/refresh_connections = TRUE, var/do_split = TRUE)
	var/split = FALSE

	//If we lost the master, we split
	if (master == A)
		master = null
		split = TRUE

	//If it was connected to more than one other projectile, then it causes a split
	else if (A.connections.len >= 2)
		split = TRUE

	A.clear_connections()
	A.PW = null
	projectiles -= A


	//If we just lost our last projectile, we have no more reason to exist
	if (!projectiles.len)
		qdel(src)
		return

	if (split && do_split)
		handle_split()
		update_connections()	//Split forces an update so we'll return and not bother with the optional check below
		return

	//This is optional so that we can batch-add many projectiles during wave creation
	if (refresh_connections)
		update_connections()



//Picks a new master projectile. null out the old one first
/datum/projectile_wave/proc/select_master()
	if (master && (master in projectiles))
		return

	if (!projectiles.len)
		if (!QDELETED(src))
			qdel(src)
		return

	if (projectiles.len == 1)
		master = projectiles[1]
	else
		//Here it gets complicated and i'll go for a quick solution for now.  Pick the most connected
		var/list/candidates = list()
		var/most_connections = 0
		for (var/obj/item/projectile/wave/W in projectiles)
			if (W.backstop)
				continue	//Backstop cant be master
			if (W.connections.len > most_connections)
				candidates = list()
			candidates += W

		//Randomly pick from those that are joint top in number of connections
		master = pick(candidates)


	master.designated_master()
	//The wave is aimed at whatever our new master was going towards
	if (master.original)
		target = master.original

/*----------------------------
	Connection Handling
-----------------------------*/
//Clear all existing connections and then re-connect
//Yes we have to loop through the projectiles three times. No these can't all be done at once
/datum/projectile_wave/proc/update_connections()
	for (var/obj/item/projectile/wave/W as anything in projectiles)
		W.clear_connections()

	for (var/obj/item/projectile/wave/W as anything in projectiles)
		W.connect_projectile()

	if (master)
		for (var/obj/item/projectile/wave/W as anything in projectiles)
			W.update_offset()




//This assumes that each projectiles' connections list is up to date. If they might not be, update them with update_connections before calling it
//Starting at a specified projectile, it recurses through everything in its connections, populating the connected list as it goes
/datum/projectile_wave/proc/get_connected(var/obj/item/projectile/wave/W)
	for (var/obj/item/projectile/wave/W2 as anything in W.connections)
		if (!(W2 in connected))
			connected += W2
			get_connected(W2)



/*----------------------------
	Split Handling
-----------------------------*/
//Called whenever there's a possibility that the wave has split apart, as a result of a projectile being removed
//This picks a start point and recurses through the connections until its done.
/datum/projectile_wave/proc/handle_split()
	//First clear this
	connected = list()

	var/start_point
	//Now, where shall we start?
	if (master)
		//If there's a master we start there, otherwise anywhere will do
		start_point = master
	else
		start_point = projectiles[1]

	//Populate the list of everything we're connected to
	connected += start_point
	get_connected(start_point)

	//This will produce a list of all projectiles which are disconnected from the main wave.
	var/list/leftover = projectiles - connected

	split_wave(leftover)

//Given a list of projectiles, removes them all from this wave, and adds them to a brand new wave instead
/datum/projectile_wave/proc/split_wave(var/list/leftover)

	//First of all, remove them from us
	for (var/obj/item/projectile/wave/W as anything in leftover)
		remove(W, FALSE, FALSE)//Pass in false for these to prevent infinite loops

	//Now lets make a new wave datum
	var/datum/projectile_wave/new_wave = new()

	//And we'll copy over some of our data
	new_wave.damaged_atoms = damaged_atoms.Copy()
	new_wave.origin = origin

	//Add the leftovers to it
	for (var/obj/item/projectile/wave/W as anything in leftover)
		new_wave.register(W, FALSE)//Pass in false for these to prevent infinite loops

	//Update all the connections now everything is added
	new_wave.update_connections()
	select_master()












/*----------------------------
	Wave Projectiles
-----------------------------*/

/*
	A part of a wave. This can be a master or an outlying part
*/
/obj/item/projectile/wave
	var/backstop = FALSE	//If true, this is a hole-filler and it can't form its own wave
	var/datum/projectile_wave/PW	//The datum that coordinates us
	var/list/connections = list()
	var/list/primary_connections = list()	//This holds a list of all non-backstop projectiles we're connected to. Even diagonally!
	var/backstop_state = ""
	//Our offset from the master of the wave. 0 if we are the master
	var/vector2/offset = new /vector2(0,0)
	randpixel = 0	//These need to sync up

	var/side = null	//Left or right

//When deleted, unregister ourselves from the wave
/obj/item/projectile/wave/Destroy()
	if (PW)
		PW.remove(src)

	.=..()

//Connects this projectile to others around it
/obj/item/projectile/wave/proc/connect_projectile(var/create_backstops = TRUE)


	//1. First of all, connect to all wave projectiles in cardinal directions, which are part of the same wave as us
	for (var/turf/T as anything in get_cardinal_turfs())
		for (var/obj/item/projectile/wave/W in T)

			//If its part of a different wave, we don't want to know
			if (W.PW != src.PW)
				continue
			connect_to(W)
			if (!W.backstop)
				primary_connections |= W


	//2. Secondly, find non-backstop projectiles in diagonal directions from us
	for (var/turf/T as anything in get_diagonal_turfs())
		for (var/obj/item/projectile/wave/W in T)
			if (W.backstop)
				continue	//We don't care about diagonal backstops

			//If its part of a different wave, we don't want to know
			if (W.PW != src.PW)
				continue

			//Alright theres a normal projectile diagonally to us, we need to check if we're currently connected to it through an existing projectile

			//To do this, we cycle through our own connections
			var/connected = FALSE
			for (var/obj/item/projectile/wave/W2 as anything in connections)
				//And we check if each of those is cardinally adjacent to the target
				if (W2.cardinally_adjacent(W))
					connected = TRUE

			//We're connected, dont worry about it
			if (connected)
				primary_connections |= W
				continue

			else if (create_backstops)
				//Okay we are not connected. But we have to be. So we will create a backstop to link us
				connect_with_backstop(W)
				primary_connections |= W
				//When that other projectile tries to link up in future, it will find and connect to the backstop we just made. it won't make another one


	//If this projectile is a backstop and it is now orphaned, then it simply deletes itself
	if (backstop && !connections.len)
		qdel(src)

	else
		update_icon()


/obj/item/projectile/wave/proc/clear_connections()
	for (var/obj/item/projectile/wave/W2 as anything in connections)
		W2.connections -= src
		connections -= W2

	connections = list()
	primary_connections = list()


//Connects to another cardinally
/obj/item/projectile/wave/proc/connect_to(var/obj/item/projectile/wave/W)
	connections |= W
	W.connections |= src

//Connects this projectile another one diagonally, by creating a backstop on a tile they share cardinally.
//This proc expects both projectiles to be exactly one tile apart diagonally
/obj/item/projectile/wave/proc/connect_with_backstop(var/obj/item/projectile/wave/W)

	//First of all, lets get some candidate sites for this backstop wave projectile
	var/list/ours = get_cardinal_turfs()
	var/list/theirs = W.get_cardinal_turfs()

	//Alright this contains all cardinally adjacent turfs which are shared between the two projectiles. in 99.9% of cases this will contain exactly two elements
	var/list/shared = ours & theirs
	//We'll favor the one closest to the shooter so that backstops are at the back
	var/turf/T = pick_closest(shared, PW.origin)

	//Now lets create the backstop
	var/obj/item/projectile/wave/B = new /obj/item/projectile/wave(T)
	B.designated_backstop(TRUE)
	PW.register(B)	//And register it




/*--------------------------------
	Master, offset and targeting
---------------------------------*/
/obj/item/projectile/wave/proc/designated_master()

/obj/item/projectile/wave/proc/designated_backstop(var/newsetting)
	backstop = newsetting
	icon_state = backstop_state


/obj/item/projectile/wave/proc/update_offset()
	offset.x = x - PW.master.x
	offset.y = y - PW.master.y


/obj/item/projectile/wave/set_pixel_offset()
	//Lets align it with the master
	if (PW && PW.master && src != PW.master)
		place_on_projection_line(PW.master, PW.perpendicular_direction * PW.width * WORLD_ICON_SIZE, src)

		//And now lets handle squish
		if (PW.squish)
			var/vector2/offset = get_global_pixel_offset(PW.master)
			var/distance = offset.Magnitude() - WORLD_ICON_SIZE
			if (distance > 0)
				offset = offset.ClampMag(0, min(PW.squish, distance))
				modify_pixels(offset*-1)

/*
*/
/obj/item/projectile/wave/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)
	//We've already hit it, return the same result as the last time without hitting it again
	if (target_mob in PW.damaged_atoms)
		return PW.damaged_atoms[target_mob]

	//Not hit yet, hit it normally
	.=..()

	//Record the result incase there's a next time
	PW.damaged_atoms[target_mob] = .



/obj/item/projectile/wave/attack_atom(var/atom/A,  var/distance, var/miss_modifier=0)
	//We've already hit it, return the same result as the last time without hitting it again
	if (A in PW.damaged_atoms)
		return PW.damaged_atoms[A]

	//Not hit yet, hit it normally
	.=..()

	//Record the result incase there's a next time
	PW.damaged_atoms[A] = .