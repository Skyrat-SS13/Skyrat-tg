/obj/machinery/rave_cube/proc/dance(mob/living/peep) //Show your moves
	set waitfor = FALSE
	switch(rand(1, 3))
		if(1)
			dance1(peep)
		if(2)
			dance2(peep)
		if(3)
			dance3(peep)

/obj/machinery/rave_cube/proc/dance1(mob/living/peep) //Flip
	for(var/i in 1 to 4)
		dance_rotate(peep, CALLBACK(peep, TYPE_PROC_REF(/mob, dance_flip)))
		sleep(3 SECONDS)

/obj/machinery/rave_cube/proc/dance2(mob/living/peep) //Spin
	set waitfor = FALSE
	var/matrix/initial_matrix = matrix(peep.transform)
	for (var/i in 1 to 40)
		if (!peep)
			return

		switch(i)
			if (1 to 10)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(0,1)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (11 to 20)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(1,-1)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (21 to 30)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(-1,-1)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (31 to 40)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(-1,1)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)

		peep.setDir(turn(peep.dir, 90))

		switch (peep.dir)
			if (NORTH)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(0,3)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (SOUTH)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(0,-3)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (EAST)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(3,0)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (WEST)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(-3,0)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)

		sleep(0.2 SECONDS)

	peep.lying_fix()

/obj/machinery/rave_cube/proc/dance3(mob/living/peep) // Helicopter
	animate(peep, transform = matrix(180, MATRIX_ROTATE), time = 1, loop = 0)
	var/matrix/initial_matrix = matrix(peep.transform)
	for (var/i in 1 to 15)
		if (!peep)
			return

		if(!active)
			break

		if (i<91)
			initial_matrix = matrix(peep.transform)
			initial_matrix.Translate(0,1)
			animate(peep, transform = initial_matrix, time = 1, loop = 0)
		if (i>90)
			initial_matrix = matrix(peep.transform)
			initial_matrix.Translate(0,-1)
			animate(peep, transform = initial_matrix, time = 1, loop = 0)

		peep.setDir(turn(peep.dir, 90))

		switch (peep.dir)
			if (NORTH)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(0,3)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (SOUTH)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(0,-3)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (EAST)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(3,0)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
			if (WEST)
				initial_matrix = matrix(peep.transform)
				initial_matrix.Translate(-3,0)
				animate(peep, transform = initial_matrix, time = 1, loop = 0)
		sleep(0.2 SECONDS)

	peep.lying_fix()
