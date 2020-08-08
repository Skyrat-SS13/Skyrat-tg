/obj/item/factory/remote
	name = "remote"
	desc = "A remote."
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/tools.dmi'

/obj/item/factory/remote/build
	name = "build remote"
	desc = "A remote used to build factory mining machinery."
	icon_state = "build"
	var/build_dir = NORTH
	var/obj/build_choice = /obj/machinery/conveyor/factory

	var/max_mats = 100
	var/current_mats = 100

/obj/item/factory/remote/build/Initialize()
	. = ..()
	desc = "[initial(src.desc)] There is [current_mats] matunits left."

/obj/item/factory/remote/build/proc/build_cost(num)
	if(current_mats < num)
		return FALSE
	current_mats -= num
	desc = "[initial(src.desc)] There is [current_mats] matunits left."
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

	var/static/list/full_choice
	if(!full_choice)
		full_choice = list(
			"North" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north"),
			"South" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "south"),
			"East" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "east"),
			"West" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "west"),
			"North-East" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "northeast"),
			"North-West" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "northwest"),
			"South-East" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "southeast"),
			"South-West" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "southwest")
		)

	var/static/list/building_choice
	if(!building_choice)
		building_choice = list(
			"Conveyor Belts"= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "choiceconveyor"),
			"Machinery"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "choicemachinery"),
			"Directions"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north")
		)

	var/static/list/conveyor_choice
	if(!conveyor_choice)
		conveyor_choice = list(
			"Single Clockwise"			= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "conveyor1"),
			"Single Counter-Clockwise"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "conveyor-1"),
			"Filter-Left"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor1"),
			"Filter-Right"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor-1"),
			"Split-Left"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor1"),
			"Split-Right"				= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "splitconveyor-1"),
			"Split-T"					= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "tconveyor"),
			"Crosser"					= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/conveyor.dmi', icon_state = "crossconveyor")
		)

	var/static/list/machinery_choice
	if(!machinery_choice)
		machinery_choice = list(
			"Smeltery"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "furnace"),
			"Processor"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "processor"),
			"Miner"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi', icon_state = "miner")
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
				if("Single Counter-Clockwise")
					build_choice = /obj/machinery/conveyor/factory/inverted
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
		if("Directions")
			var/choice2 = show_radial_menu(user, src, full_choice, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				return
			switch(choice2)
				if("North")
					build_dir = NORTH
				if("North-East")
					build_dir = NORTHEAST
				if("East")
					build_dir = EAST
				if("South-East")
					build_dir = SOUTHEAST
				if("South")
					build_dir = SOUTH
				if("South-West")
					build_dir = SOUTHWEST
				if("West")
					build_dir = WEST
				if("North-West")
					build_dir = NORTHWEST

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
	var/build_price = 0
	if(istype(build_choice, /obj/machinery/conveyor) || istype(build_choice, /obj/machinery/conveycrosser))
		build_price = 1
	else if(istype(build_choice, /obj/machinery/factory ))
		build_price = 5
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

/obj/item/factory/remote/config
	name = "config remote"
	desc = "A remote used to configure factory mining machinery"
	icon_state = "config"
	var/input_choice = NORTH
	var/output_choice = SOUTH
	var/ore_choice = /obj/item/stack/ore/iron
	var/sheet_choice = /obj/item/stack/sheet/metal
	var/orename = "iron"

/obj/item/factory/remote/config/attack_self(mob/user)
	. = ..()

	var/static/list/full_choice
	if(!full_choice)
		full_choice = list(
			"North" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north"),
			"South" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "south"),
			"East" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "east"),
			"West" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "west"),
			"North-East" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "northeast"),
			"North-West" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "northwest"),
			"South-East" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "southeast"),
			"South-West" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "southwest")
		)

	var/static/list/config_choice
	if(!config_choice)
		config_choice = list(
			"Input Turf"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "input"),
			"Output Turf"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "output"),
			"Ore Type"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "ore")
		)

	var/static/list/choose_ore
	if(!choose_ore)
		choose_ore = list(
			"Iron"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "iron"),
			"Glass"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "coal"),
			"Silver"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "silver"),
			"Titanium"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "titanium"),
			"Plasma"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "plasma"),
			"Gold"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "gold"),
			"Uranium"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "uranium"),
			"Diamond"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "diamond"),
			"Bluespace"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "bluespace"),
			"Bananium"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi', icon_state = "bananium"),
		)

	var/choice1 = show_radial_menu(user, src, config_choice, require_near = TRUE, tooltips = TRUE)
	if(!choice1)
		return
	switch(choice1)
		if("Input Turf")
			var/choice2 = show_radial_menu(user, src, full_choice, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				input_choice = NORTH
				return
			switch(choice2)
				if("North")
					input_choice = NORTH
				if("North-East")
					input_choice = NORTHEAST
				if("East")
					input_choice = EAST
				if("South-East")
					input_choice = SOUTHEAST
				if("South")
					input_choice = SOUTH
				if("South-West")
					input_choice = SOUTHWEST
				if("West")
					input_choice = WEST
				if("North-West")
					input_choice = NORTHWEST
			output_choice = null
			ore_choice = null
			sheet_choice = null
			orename = null
		if("Output Turf")
			var/choice2 = show_radial_menu(user, src, full_choice, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				output_choice = NORTH
				return
			switch(choice2)
				if("North")
					output_choice = NORTH
				if("North-East")
					output_choice = NORTHEAST
				if("East")
					output_choice = EAST
				if("South-East")
					output_choice = SOUTHEAST
				if("South")
					output_choice = SOUTH
				if("South-West")
					output_choice = SOUTHWEST
				if("West")
					output_choice = WEST
				if("North-West")
					output_choice = NORTHWEST
			input_choice = null
			ore_choice = null
			sheet_choice = null
			orename = null
		if("Ore Type")
			var/choice2 = show_radial_menu(user, src, choose_ore, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				ore_choice = /obj/item/stack/ore/iron
				return
			switch(choice2)
				if("Iron")
					ore_choice = /obj/item/stack/ore/iron
					sheet_choice = /obj/item/stack/sheet/metal
					orename = "iron"
				if("Glass")
					ore_choice = /obj/item/stack/ore/glass
					sheet_choice = /obj/item/stack/sheet/glass
					orename = "sand"
				if("Silver")
					ore_choice = /obj/item/stack/ore/silver
					sheet_choice = /obj/item/stack/sheet/mineral/silver
					orename = "silver"
				if("Titanium")
					ore_choice = /obj/item/stack/ore/titanium
					sheet_choice = /obj/item/stack/sheet/mineral/titanium
					orename = "titanium"
				if("Plasma")
					ore_choice = /obj/item/stack/ore/plasma
					sheet_choice = /obj/item/stack/sheet/mineral/plasma
					orename = "plasma"
				if("Gold")
					ore_choice = /obj/item/stack/ore/gold
					sheet_choice = /obj/item/stack/sheet/mineral/gold
					orename = "gold"
				if("Uranium")
					ore_choice = /obj/item/stack/ore/uranium
					sheet_choice = /obj/item/stack/sheet/mineral/uranium
					orename = "uranium"
				if("Diamond")
					ore_choice = /obj/item/stack/ore/diamond
					sheet_choice = /obj/item/stack/sheet/mineral/diamond
					orename = "diamond"
				if("Bluespace")
					ore_choice = /obj/item/stack/ore/bluespace_crystal
					sheet_choice = /obj/item/stack/sheet/bluespace_crystal
					orename = "bluespace"
				if("Bananium")
					ore_choice = /obj/item/stack/ore/bananium
					sheet_choice = /obj/item/stack/sheet/mineral/bananium
					orename = "bananium"
			input_choice = null
			output_choice = null
