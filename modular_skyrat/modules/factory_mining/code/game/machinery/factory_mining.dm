/obj/machinery/factory
	name = "factory machine"
	desc = "debug machine"
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi'

	density = TRUE

	///the var that determines if a machine has an input
	var/has_input = FALSE
	///the var that determines which direction to get_step the input
	var/input_turf = NORTH

	///the var that determines if a machine has an output
	var/has_output = FALSE
	///the var that determines which direction to get_step the output
	var/output_turf = SOUTH

	///upgrades. get from megafauna hunting
	///implemented
	///increases the chance of the miner outputting on process
	var/output_chance = 1
	///implemented
	///increases the amount of stuff produced
	var/output_efficiency = 1
	///implemented
	///the chance that an ore will not be destroyed. at 1, an ore will always be used
	var/destroy_chance = 1
	///somewhat implemented
	///increases the amount of credits you get from each sheet melted
	var/credit_efficiency = 1

	///in order to prevent crazy machines, machines are limited to 3 upgrades
	var/upgrade1
	var/upgrade2
	var/upgrade3

	///the var that determines if a machine uses ore
	///processors and smelters have this, not miners
	var/has_ore_choice = FALSE
	///the var that checks in the input turf for smelters
	var/ore_choice
	///the var that produces in the output turf for smelters
	///the var that checks in the input turf for processors
	var/sheet_choice
	///multi-use var
	///used for making icons for products
	///used for making overlays for smelters and processors
	var/orename

	///var strictly for the processor; var that determines if a machine produces stuff besides sheets
	var/has_refined_products = FALSE
	///var that is set on creating this kind of product
	///do check within products.dm to see what vars and how it is done
	var/refined_product
	var/shorthand_refined

	///it is entirely possible to have 2 types of items required for a recipe. Ill somehow figure out a better solution!
	///the req_item_x should be the actual type of item
	///the req_item_x_ramount should be the amount required
	///the req_item_x_camount should be the amount currently
	var/list/req_item_1 = list()
	var/list/req_item_2 = list()

	///var that determines if a machine produces credits
	///only smelters and processors make credits
	var/produces_credits = FALSE
	///var that stores the amount of credits produced from credit producing machines
	var/credit_number = 0

	///var that initially sets up the cooldown for the process
	var/cooldown_time = 0
	///var that sets the world.time + this. in deciseconds. 50 = 5 seconds
	///there is an upgrade for this
	var/upgrade_cooldown = 50

	///vars that control the max coolant, current coolant, etc.
	//Machines wont work if there isnt enough coolant, and will slowly lower the percent
	var/max_coolant = 500
	var/current_coolant = 500

	light_color = COLOR_WHITE
	light_power = 5
	light_range = 2

/obj/machinery/factory/update_overlays()
	. = ..()
	var/obj/effect/overlay/vis/input_dir = image("modular_skyrat/modules/factory_mining/icons/obj/machines.dmi", "input", dir = input_turf)
	var/obj/effect/overlay/vis/output_dir = image("modular_skyrat/modules/factory_mining/icons/obj/machines.dmi", "output", dir = output_turf)
	var/obj/effect/overlay/vis/ore_output = image("modular_skyrat/modules/factory_mining/icons/obj/machines.dmi", orename)
	cut_overlays()
	if(has_input)
		add_overlay(input_dir)
	if(has_output)
		add_overlay(output_dir)
	if(has_ore_choice)
		add_overlay(ore_output)

/obj/machinery/factory/Initialize()
	. = ..()
	GLOB.factory_machines += src
	START_PROCESSING(SSobj, src)
	for(var/directions in GLOB.cardinals)
		var/turf/step_turf = get_step(src, directions)
		for(var/obj/machinery/conveyor/factory/chosen_conveyor in step_turf.contents)
			if(directions == REVERSE_DIR(chosen_conveyor.forwards))
				input_turf = directions
			else
				output_turf = directions
		for(var/obj/machinery/conveyor/factory/split/chosen_conveyor in step_turf.contents)
			if(directions == REVERSE_DIR(chosen_conveyor.forwards))
				input_turf = directions
			else if(directions == REVERSE_DIR(chosen_conveyor.split_dir))
				input_turf = directions
			else
				output_turf = directions

/obj/machinery/factory/Destroy()
	GLOB.factory_machines -= src
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/machinery/factory/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/factory/remote/destroy))
		if(!do_after(user, 5, FALSE))
			return
		cut_overlays()
		qdel(src)
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)
		return
	else if(istype(I, /obj/item/factory/remote/copysettings))
		var/obj/item/factory/remote/copysettings/C = I
		if(!C.saved_settings)
			if(has_input)
				C.input_choice = input_turf
			if(has_output)
				C.output_choice = output_turf
			if(has_ore_choice)
				C.ore_choice = ore_choice
				C.sheet_choice = sheet_choice
				C.orename = orename
			C.saved_settings = TRUE
		else
			input_turf = C.input_choice
			output_turf = C.output_choice
			ore_choice = C.ore_choice
			sheet_choice = C.sheet_choice
			orename = C.orename
		update_overlays()
		return
	else if(istype(I, /obj/item/card/id))
		if(!produces_credits || !credit_number)
			return
		var/obj/item/card/id/D = I
		D.mining_points += credit_number
		credit_number = 0
		return
	else if(istype(I, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RC = I
		if(!RC.reagents)
			return
		for(var/R in RC.reagents.reagent_list)
			if(!istype(R, /datum/reagent/lube))
				continue
			var/datum/reagent/lube/L = R
			var/coolant_left = max_coolant - current_coolant
			if(coolant_left >= L.volume)
				current_coolant += L.volume
				qdel(L)
				return
			else if(L.volume > coolant_left)
				current_coolant = max_coolant
				L.volume -= coolant_left
				return
	else
		return ..()

/obj/machinery/factory/attack_hand(mob/living/user)
	var/list/full_choice
	if(!full_choice)
		full_choice = list(
			"North" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north"),
			"East" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "east"),
			"South" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "south"),
			"West" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "west")
		)

	var/list/config_choice
	if(!config_choice)
		config_choice = list()
		if(has_input)
			config_choice += list("Input Turf"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "input"))
		if(has_output)
			config_choice += list("Output Turf"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "output"))
		if(has_ore_choice)
			config_choice += list("Ore Type"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "ore"))
		if(istype(src, /obj/machinery/factory/processor))
			config_choice += list("Product"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "product"))

	var/list/choose_ore
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

	var/list/choose_product
	if(!choose_product)
		choose_product = list(
			"Coil"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi', icon_state = "iron_coil"),
			"Plate"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi', icon_state = "iron_plate"),
			"Rim"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi', icon_state = "iron_rim"),
			"Gear"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi', icon_state = "iron_gear"),
			"Rod"		= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi', icon_state = "iron_rod"),
			"Fabric"	= image(icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi', icon_state = "iron_fabric")
		)

	var/choice1 = show_radial_menu(user, src, config_choice, require_near = TRUE, tooltips = TRUE)
	if(!choice1)
		return
	switch(choice1)
		if("Input Turf")
			var/choice2 = show_radial_menu(user, src, full_choice, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				input_turf = NORTH
				return
			switch(choice2)
				if("North")
					input_turf = NORTH
				if("East")
					input_turf = EAST
				if("South")
					input_turf = SOUTH
				if("West")
					input_turf = WEST

		if("Output Turf")
			var/choice2 = show_radial_menu(user, src, full_choice, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				output_turf = NORTH
				return
			switch(choice2)
				if("North")
					output_turf = NORTH
				if("East")
					output_turf = EAST
				if("South")
					output_turf = SOUTH
				if("West")
					output_turf = WEST

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
					orename = "glass"
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

		if("Product")
			var/choice2 = show_radial_menu(user, src, choose_product, require_near = TRUE, radius = 50, tooltips = TRUE)
			if(!choice2)
				ore_choice = /obj/item/stack/ore/iron
				return
			switch(choice2)
				if("Coil")
					req_item_1 = list(/obj/item/stack/sheet, 5, 0)
					req_item_2 = list(/obj/item/stack/factory/products/rod, 5, 0)
					refined_product = /obj/item/stack/factory/products/coil
					shorthand_refined = "coil"
				if("Plate")
					req_item_1 = list(/obj/item/stack/sheet, 5, 0)
					req_item_2 = null
					refined_product = /obj/item/stack/factory/products/plate
					shorthand_refined = "plate"
				if("Rim")
					req_item_1 = list(/obj/item/stack/sheet, 5, 0)
					req_item_2 = list(/obj/item/stack/factory/products/rod, 5, 0)
					refined_product = /obj/item/stack/factory/products/rim
					shorthand_refined = "rim"
				if("Gear")
					req_item_1 = list(/obj/item/stack/factory/products/rod, 5, 0)
					req_item_2 = list(/obj/item/stack/factory/products/rim, 5, 0)
					refined_product = /obj/item/stack/factory/products/gear
					shorthand_refined = "gear"
				if("Rod")
					req_item_1 = list(/obj/item/stack/sheet, 5, 0)
					req_item_2 = null
					refined_product = /obj/item/stack/factory/products/rod
					shorthand_refined = "rod"
				if("Fabric")
					req_item_1 = list(/obj/item/stack/factory/products/coil, 5, 0)
					req_item_2 = list(/obj/item/stack/factory/products/rod, 5, 0)
					refined_product = /obj/item/stack/factory/products/fabric
					shorthand_refined = "fabric"

	update_overlays()

/obj/machinery/factory/proc/check_cooldown()
	if(cooldown_time > world.time)
		return FALSE
	cooldown_time = world.time + upgrade_cooldown
	return TRUE

/obj/machinery/factory/proc/check_coolant()
	current_coolant -= 5
	if(current_coolant <= 5)
		current_coolant = 0
	desc = "[initial(desc)] There is [current_coolant] lubricant left."
	if(current_coolant <= 0)
		return FALSE
	if(prob(max_coolant / current_coolant))
		return FALSE
	return TRUE

/obj/machinery/factory/proc/check_hostile_mobs()
	for(var/mob/living/simple_animal/hostile/hostile_mob in range(5, src))
		if(hostile_mob.stat == DEAD)
			return FALSE
		return TRUE
	return FALSE
