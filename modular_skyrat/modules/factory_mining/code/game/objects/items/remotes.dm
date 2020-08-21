/obj/item/factory/remote
	name = "remote"
	desc = "A remote."
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/tools.dmi'

/obj/item/factory/remote/build
	name = "build remote"
	desc = "A remote used to build factory mining machinery."
	icon_state = "build"
	var/obj/build_choice = /obj/machinery/conveyor/factory

	var/max_mats = 100
	var/current_mats = 100

	var/build_dir = NORTH

	var/build_price = 5

/obj/item/factory/remote/build/Initialize()
	. = ..()
	desc = "[initial(src.desc)] [current_mats] matunits left."

/obj/item/factory/remote/build/proc/build_cost(num)
	if(current_mats < num)
		return FALSE
	current_mats -= num
	desc = "[initial(src.desc)] [current_mats] matunits left."
	return TRUE

/obj/item/factory/remote/build/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/ore/iron) || istype(I, /obj/item/stack/sheet/metal))
		var/obj/item/stack/S = I
		if(current_mats >= max_mats)
			return
		var/left_mats = max_mats - current_mats
		var/Samount = S.amount
		if(Samount >= left_mats)
			S.use(left_mats)
			current_mats += left_mats
		else if(Samount < left_mats)
			S.use(Samount)
			current_mats += Samount
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)
		desc = "[initial(src.desc)] There is [current_mats] matunits left."
		return
	else
		return ..()

/obj/item/factory/remote/build/attack_self(mob/user)
	. = ..()

	var/list/building_choice
	if(!building_choice)
		building_choice = list(
			"Conveyor Belts"= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "choiceconveyor"),
			"Direction"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north"),
			"Machinery"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "choicemachinery")
		)

	var/list/card_choice
	if(!card_choice)
		card_choice = list(
			"North"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north"),
			"East"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "east"),
			"South"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "south"),
			"West"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "west")
		)

	var/list/conveyor_choice
	if(!conveyor_choice)
		conveyor_choice = list(
			"Single Clockwise"			= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "conveyor1"),
			"Filter-Left"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor1"),
			"Filter-Right"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor-1"),
			"Split-Left"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor1"),
			"Split-Right"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor-1"),
			"Split-T"					= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "tconveyor"),
			"Crosser"					= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "crossconveyor")
		)

	var/list/machinery_choice
	if(!machinery_choice)
		machinery_choice = list(
			"Smeltery"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "furnace"),
			"Processor"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "processor"),
			"Miner"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "miner"),
			"Loader"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "miner"),
			"Butcher"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "miner")
		)

	var/choice1 = show_radial_menu(user, src, building_choice, require_near = TRUE, tooltips = TRUE)
	if(!choice1)
		return
	switch(choice1)
		if("Conveyor Belts")
			var/choice2 = show_radial_menu(user, src, conveyor_choice, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				return
			switch(choice2)
				if("Single Clockwise")
					build_choice = /obj/machinery/conveyor/factory
				if("Filter-Left")
					build_choice = /obj/machinery/conveyor/factory/split/filter_l
				if("Filter-Right")
					build_choice = /obj/machinery/conveyor/factory/split/filter_r
				if("Split-Left")
					build_choice = /obj/machinery/conveyor/factory/split/split_l
				if("Split-Right")
					build_choice = /obj/machinery/conveyor/factory/split/split_r
				if("Split-T")
					build_choice = /obj/machinery/conveyor/factory/split/split_t
				if("Crosser")
					build_choice = /obj/machinery/conveycrosser
		if("Machinery")
			var/choice2 = show_radial_menu(user, src, machinery_choice, require_near = TRUE, tooltips = TRUE)
			if(!choice2)
				return
			switch(choice2)
				if("Smeltery")
					build_choice = /obj/machinery/factory/smelter
				if("Processor")
					build_choice = /obj/machinery/factory/processor
				if("Miner")
					build_choice = /obj/machinery/factory/miner
				if("Loader")
					build_choice = /obj/machinery/factory/loader
				if("Butcher")
					build_choice = /obj/machinery/factory/butcher
			build_dir = NORTH
		if("Direction")
			var/choice2 = show_radial_menu(user, src, card_choice, require_near = TRUE, tooltips = TRUE)
			if(!choice2)
				return
			switch(choice2)
				if("North")
					build_dir = NORTH
				if("East")
					build_dir = EAST
				if("South")
					build_dir = SOUTH
				if("West")
					build_dir = WEST

/obj/item/factory/remote/build/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag)
		return
	var/turf/T = get_turf(target)
	for(var/obj/machinery/M in T.contents)
		if(istype(M, /obj/machinery/conveyor))
			return
		if(istype(M, /obj/machinery/factory))
			return
		if(istype(M, /obj/machinery/conveycrosser))
			return
	if(!do_after(user, 5, FALSE))
		return
	if(build_cost(build_price))
		var/obj/machinery/M = new build_choice(T)
		M.dir = build_dir
		if(istype(M, /obj/machinery/conveyor))
			var/obj/machinery/conveyor/C = M
			C.update_move_direction()
		if(istype(M, /obj/machinery/conveycrosser))
			var/obj/machinery/conveycrosser/C = M
			C.setup_dir()
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)

/obj/item/factory/remote/destroy
	name = "destroy remote"
	desc = "A remote used to destroy factory mining machinery"
	icon_state = "destroy"

/obj/item/factory/remote/copysettings
	name = "config copy remote"
	icon_state = "config"
	var/saved_settings = FALSE
	var/input_choice = NORTH
	var/output_choice = SOUTH
	var/ore_choice = /obj/item/stack/ore/iron
	var/sheet_choice = /obj/item/stack/sheet/metal
	var/orename = "iron"

/obj/item/factory/remote/copysettings/attack_self(mob/user)
	. = ..()
	saved_settings = FALSE
	input_choice = null
	output_choice = null
	ore_choice = null
	sheet_choice = null
	orename = null
