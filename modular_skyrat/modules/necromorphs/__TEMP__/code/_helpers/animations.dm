/proc/remove_images_from_clients(image/I, list/show_to)
	for(var/client/C in show_to)
		C.images -= I
		qdel(I)


/atom/proc/SpinAnimation(speed = 1, loops = -1, var/spin_direction)
	//Pass a spin direction of -1 to spin counterclockwise, 1 clockwise, default random
	if (!spin_direction)
		spin_direction = pick(1, -1)
	var/matrix/m120 = matrix(transform)
	m120.Turn(120*spin_direction)
	var/matrix/m240 = matrix(transform)
	m240.Turn(240*spin_direction)
	var/matrix/m360 = matrix(transform)
	speed /= 3      //Gives us 3 equal time segments for our three turns.
	                //Why not one turn? Because byond will see that the start and finish are the same place and do nothing
	                //Why not two turns? Because byond will do a flip instead of a turn
	animate(src, transform = m120, time = ((10 / 3) / speed), loops,flags = ANIMATION_PARALLEL)
	animate(transform = m240, time = ((10 / 3) / speed))
	animate(transform = m360, time = ((10 / 3) / speed))