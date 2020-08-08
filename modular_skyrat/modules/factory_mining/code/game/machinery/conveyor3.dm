#define MAX_CONVEYOR_ITEMS_MOVE 30

/obj/machinery/conveyor/factory
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi'
	icon_state = "conveyor1"
	operating = 1

	verted = 1
	processing_flags = START_PROCESSING_ON_INIT
	subsystem_type = /datum/controller/subsystem/processing/fastprocess

	light_color = COLOR_WHITE
	light_power = 5
	light_range = 2

/obj/machinery/conveyor/factory/process()
	//get the first 30 items in contents
	affecting = list()
	var/i = 0
	var/list/items = loc.contents - src
	for(var/item in items)
		i++ // we're sure it's a real target to move at this point
		if(i >= MAX_CONVEYOR_ITEMS_MOVE)
			break
		affecting.Add(item)

	conveying = TRUE
	addtimer(CALLBACK(src, .proc/convey, affecting), 1)

/obj/machinery/conveyor/factory/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/factory/remote/destroy))
		if(!do_after(user, 5, FALSE))
			return
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)
		qdel(src)

/obj/machinery/conveyor/factory/update_icon_state()
	if(istype(src, /obj/machinery/conveyor/factory/split))
		icon_state = "splitconveyor[operating * verted]"
	else if(istype(src, /obj/machinery/conveyor/factory/split/split_t))
		icon_state = "tconveyor"
	else
		icon_state = "conveyor[operating * verted]"

/obj/machinery/conveyor/factory/update()
	return TRUE

/obj/machinery/conveyor/factory/inverted
	icon_state = "conveyor-1"
	verted = -1

/obj/machinery/conveyor/factory/split
	var/split_dir
	var/split = FALSE
	var/filter = FALSE
	var/list/filter_list = list()

/obj/machinery/conveyor/factory/split/Crossed(atom/movable/AM, oldloc)
	. = ..()
	split = !split

/obj/machinery/conveyor/factory/split/AltClick(mob/user)
	. = ..()
	if(filter_list)
		filter_list = list()

/obj/machinery/conveyor/factory/split/convey(list/affecting)
	for(var/atom/movable/A in affecting)
		if(!QDELETED(A) && (A.loc == loc))
			if(filter)
				if(A.type in filter_list)
					A.ConveyorMove(split_dir)
				else
					A.ConveyorMove(forwards)
			else
				if(split)
					A.ConveyorMove(split_dir)
				else
					A.ConveyorMove(forwards)
			//Give this a chance to yield if the server is busy
			stoplag()
	conveying = FALSE


/obj/machinery/conveyor/factory/split/filter_l
	name = "left-filter conveyor"
	icon_state = "splitconveyor1"
	filter = TRUE
	verted = 1

/obj/machinery/conveyor/factory/split/filter_l/attackby(obj/item/I, mob/user, params)
	. = ..()
	filter_list |= I.type
	audible_message("<span class='notice'>[I.name] has been added to the filter.</span>")

/obj/machinery/conveyor/factory/split/filter_l/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
			split_dir = WEST
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
			split_dir = EAST
		if(EAST)
			forwards = EAST
			backwards = WEST
			split_dir = NORTH
		if(WEST)
			forwards = WEST
			backwards = EAST
			split_dir = SOUTH
	update()

/obj/machinery/conveyor/factory/split/filter_r
	name = "right-filter conveyor"
	icon_state = "splitconveyor-1"
	filter = TRUE
	verted = -1

/obj/machinery/conveyor/factory/split/filter_r/attackby(obj/item/I, mob/user, params)
	. = ..()
	filter_list |= I.type
	audible_message("<span class='notice'>[I.name] has been added to the filter.</span>")

/obj/machinery/conveyor/factory/split/filter_r/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
			split_dir = EAST
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
			split_dir = WEST
		if(EAST)
			forwards = EAST
			backwards = WEST
			split_dir = SOUTH
		if(WEST)
			forwards = WEST
			backwards = EAST
			split_dir = NORTH
	update()

/obj/machinery/conveyor/factory/split/split_l
	name = "left-split conveyor"
	icon_state = "splitconveyor1"
	verted = 1

/obj/machinery/conveyor/factory/split/split_l/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
			split_dir = WEST
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
			split_dir = EAST
		if(EAST)
			forwards = EAST
			backwards = WEST
			split_dir = NORTH
		if(WEST)
			forwards = WEST
			backwards = EAST
			split_dir = SOUTH
	update()

/obj/machinery/conveyor/factory/split/split_r
	name = "right-split conveyor"
	icon_state = "splitconveyor-1"
	verted = -1

/obj/machinery/conveyor/factory/split/split_r/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
			split_dir = EAST
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
			split_dir = WEST
		if(EAST)
			forwards = EAST
			backwards = WEST
			split_dir = SOUTH
		if(WEST)
			forwards = WEST
			backwards = EAST
			split_dir = NORTH
	update()

/obj/machinery/conveyor/factory/split/split_t
	name = "t-split conveyor"
	icon_state = "tconveyor"

/obj/machinery/conveyor/factory/split/split_t/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = EAST
			backwards = SOUTH
			split_dir = WEST
		if(SOUTH)
			forwards = WEST
			backwards = NORTH
			split_dir = EAST
		if(EAST)
			forwards = SOUTH
			backwards = WEST
			split_dir = NORTH
		if(WEST)
			forwards = NORTH
			backwards = EAST
			split_dir = SOUTH
	update()

#undef MAX_CONVEYOR_ITEMS_MOVE

/obj/machinery/conveycrosser
	name = "underground conveyor belt"
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi'
	desc = "A conveyor belt."
	icon_state = "crossconveyor"
	var/obj/machinery/conveycrosser/linked_crosser
	var/enter_dir = NORTH

	light_color = COLOR_WHITE
	light_power = 5
	light_range = 2

/obj/machinery/conveycrosser/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/factory/remote/destroy))
		if(!do_after(user, 5, FALSE))
			return
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)
		qdel(src)

/obj/machinery/conveycrosser/proc/setup_dir()
	if(dir == NORTH)
		enter_dir = SOUTH
		for(var/obj/machinery/conveycrosser/C in range(4, src))
			if(!C)
				break
			if(C == src)
				continue
			if(C.x != src.x)
				continue
			if(C.y < src.y)
				continue
			if(C.linked_crosser)
				continue
			linked_crosser = C
			C.linked_crosser = src
			break
	else if(dir == SOUTH)
		enter_dir = NORTH
		for(var/obj/machinery/conveycrosser/C in range(4, src))
			if(!C)
				break
			if(C == src)
				continue
			if(C.x != src.x)
				continue
			if(C.y > src.y)
				continue
			if(C.linked_crosser)
				continue
			linked_crosser = C
			C.linked_crosser = src
			break
	else if(dir == EAST)
		enter_dir = WEST
		for(var/obj/machinery/conveycrosser/C in range(4, src))
			if(!C)
				break
			if(C == src)
				continue
			if(C.y != src.y)
				continue
			if(C.x < src.x)
				continue
			if(C.linked_crosser)
				continue
			linked_crosser = C
			C.linked_crosser = src
			break
	else if(dir == WEST)
		enter_dir = EAST
		for(var/obj/machinery/conveycrosser/C in range(4, src))
			if(!C)
				break
			if(C == src)
				continue
			if(C.y != src.y)
				continue
			if(C.x > src.x)
				continue
			if(C.linked_crosser)
				continue
			linked_crosser = C
			C.linked_crosser = src
			break

/obj/machinery/conveycrosser/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(linked_crosser)
		var/turf/T = get_step(linked_crosser, linked_crosser.enter_dir)
		AM.forceMove(T)
