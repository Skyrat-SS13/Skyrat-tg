/*
	Spread is a special kind of projectile that, when fired, spawns a cloud of pellets in a cone, then sends them off and deletes itself
*/
/obj/item/projectile/spread
	var/pellet_type = /obj/item/projectile/bullet/pulse/spread
	var/spread_angle	=	22.5	//This is either side of the centre, the actual width of the cone is twice this value
	var/pellet_quantity = 10

/obj/item/projectile/spread/launch(atom/target, var/target_zone, var/x_offset=0, var/y_offset=0, var/angle_offset=0)


	var/turf/origin = get_turf(src)

	/*
		Spread calculations
		Here we will calculate how wide the target area is based on distance and spread angle
	*/
	var/list/measures = Vector2.DirMagBetween(origin, target)
	var/distance = measures["magnitude"]
	//We don't need the direction vector, but we've still gotta release it
	var/vector2/direction = measures["direction"]
	release_vector(direction)

	/*
		Our cone is really just two right angle triangles, we want to find the length of their endsides
		We need to calculate the hypotenuse of one first
	*/
	var/hypotenuse_length = distance / cos(spread_angle)

	/*
		And then the length of the remaining side uses pythagoras.
	*/
	var/spread_radius = sqrt(distance**2 + hypotenuse_length**2)

	//Now lets get all the possible turfs within the aiming radius
	var/list/target_turfs = circlerange(get_turf(target), spread_radius)


	//And for a neat optimisation in case of large numbers of shrapnel, lets just shuffle this list
	shuffle(target_turfs)

	//And iterate through it
	for (var/I in 1 to pellet_quantity)
		spawn()
			var/turf/T = target_turfs[Wrap(I, target_turfs.len+1)]	//Where will this shrapnel piece go?
			var/obj/item/projectile/P = new pellet_type(origin)
			P.shot_from = src.name
			P.launcher = src.launcher
			P.firer = src.firer
			P.original = src.original
			P.launch(T, target_zone)

/obj/item/projectile/bullet/pulse/spread
	randpixel = 8