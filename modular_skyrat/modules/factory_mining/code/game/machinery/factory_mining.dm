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
	///not implemented
	var/input_efficiency = 2
	var/current_input = 0
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
	var/ore_choice = /obj/item/stack/ore/iron
	///the var that produces in the output turf for smelters
	///the var that checks in the input turf for processors
	var/sheet_choice = /obj/item/stack/sheet/metal
	///multi-use var
	///used for making icons for products
	///used for making overlays for smelters and processors
	var/orename = "iron"

	///var strictly for the processor; var that determines if a machine produces stuff besides sheets
	var/has_refined_products = FALSE
	///var that is set on creating this kind of product
	///do check within products.dm to see what vars and how it is done
	var/refined_product = /obj/item/stack/factory/products/coil
	var/shorthand_refined = "coil"

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
	///var that sets the world.time + this. in deciseconds. 100 = 10 seconds
	///there is an upgrade for this
	var/upgrade_cooldown = 100

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
	START_PROCESSING(SSobj, src)

/obj/machinery/factory/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/machinery/factory/process()
	if(cooldown_time > world.time)
		return
	cooldown_time = world.time + upgrade_cooldown

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
		if(produces_credits && credit_number)
			var/obj/item/card/id/D = I
			D.mining_points += credit_number
			credit_number = 0
			return
	else
		return ..()

/obj/machinery/factory/attack_hand(mob/living/user)
	var/list/full_choice
	if(!full_choice)
		full_choice = list(
			"North" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "north"),
			"South" = image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "south"),
			"East" 	= image(icon = 'modular_skyrat/modules/factory_mining/icons/effects/radial.dmi', icon_state = "east"),
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
					req_item_2 = list()
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
					req_item_2 = list()
					refined_product = /obj/item/stack/factory/products/rod
					shorthand_refined = "rod"
				if("Fabric")
					req_item_1 = list(/obj/item/stack/factory/products/coil, 5, 0)
					req_item_2 = list(/obj/item/stack/factory/products/rod, 5, 0)
					refined_product = /obj/item/stack/factory/products/fabric
					shorthand_refined = "fabric"

	update_overlays()

/obj/machinery/factory/smelter
	name = "factory smelter"
	desc = "A machine that is used to smelt ores."
	icon_state = "furnace"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = TRUE
	has_refined_products = FALSE
	produces_credits = TRUE

/obj/machinery/factory/smelter/process()
	. = ..()
	//if it doesnt have an input or output, something went wrong
	if(!has_output || !has_input)
		return
	//just to make sure it has an ore choice
	if(!has_ore_choice)
		return
	//this is the input get_step. So it will take the turf to the direction and pull from this
	var/turf/T = get_step(src, input_turf)
	//specifically check for ore in the contents of the turf
	for(var/obj/item/stack/ore/O in T.contents)
		//if it isnt the chosen type of the furnace, move on
		if(!istype(O, ore_choice))
			continue
		//if the ore doesnt have a refined type, there is no reason to smelt it
		if(!O.refined_type)
			continue
		//this is the output get_step. So it will take the turf to the direction and push to this
		var/turf/TO = get_step(src, output_turf)
		//this creates a new items with a var, so that we can modify the item
		var/obj/item/stack/NR = new sheet_choice(TO)
		//this creates the amount of sheets according to efficiency. its normally 1:1, but can be 1:2
		NR.amount = O.amount * output_efficiency
		//this creates a number of points according to the amount and the amount of points each can aqquire.
		//can also be multiplied if the credit efficiency is up. Can get insane
		//this is affected by upgrades.
		credit_number += (O.points * NR.amount) * credit_efficiency
		//this makes it a chance to not destroy the ore once upgraded. from always to 50/50.
		//this is affected by upgrades.
		if(prob(100 / destroy_chance))
			qdel(O)

/obj/machinery/factory/processor
	name = "factory processor"
	desc = "A machine that is used to turn sheets into products."
	icon_state = "processor"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = TRUE
	has_refined_products = TRUE
	produces_credits = TRUE

	var/item1_dependent = FALSE
	var/item2_dependent = FALSE

/obj/machinery/factory/processor/process()
	. = ..()
	//if somehow, the processor doesnt have the necessary stuff, just stop
	if(!has_output || !has_input || !has_ore_choice || !shorthand_refined)
		return
	//it is important to get both the input turf and the output turf
	var/turf/T = get_step(src, input_turf)
	var/turf/TO = get_step(src, output_turf)
	//if its mainly important that the processor has an item1. however, it doesnt hurt to have the item2 either.
	if(!req_item_1 && !req_item_2)
		return
	//if there is the item1 in the recipe
	if(req_item_1)
		//make sure to set it to dependent
		item1_dependent = TRUE
		//check all the item/stack in the input turfs contents
		for(var/obj/item/stack/S in T.contents)
			//checking to see if its one of the products produced by the processors
			if(istype(S, /obj/item/stack/factory/products))
				//setting PR equal to the item/stack/S in the input contents
				var/obj/item/stack/factory/products/PR = S
				//if the req1 is a product item and it doesnt have the same ore type as the processor, move to the next item
				if(PR.ore_type != orename)
					continue
			//if it isnt a factory product, but just a normal sheet, this is where it goes
			else if(istype(S, /obj/item/stack/sheet))
				//setting SS equal to the item/stack/S in the input contents
				var/obj/item/stack/sheet/SS = S
				//same with the factory product, if it isnt the same material type, go onto the next one
				if(SS.oretypename != orename)
					continue
			//now, if you made it all the way here, odds are, you are the required material and required item!
			//this will now make sure you truly are the req item
			if(istype(S, req_item_1[1]))
				//now we add just... add it to the reqitem buffer, since it requires more than just 1 to produce
				req_item_1[3] += S.amount
				//here is one of the upgrades! a chance to not destroy the input.
				if(prob(100 / destroy_chance))
					//delete it! We dont want something to be too strong!
					qdel(S)
	//if there is a req2 item in the recipe
	if(req_item_2)
		//set it to require it now
		item2_dependent = TRUE
		//check all item/stack in the input turfs contents
		for(var/obj/item/stack/S in T.contents)
			//if it is a factory product
			if(istype(S, /obj/item/stack/factory/products))
				//setting so we can check factory product specific vars
				var/obj/item/stack/factory/products/PR = S
				//if the factory product isnt the material required, move on
				if(PR.ore_type != orename)
					continue
			//now, it isnt a factory product, is it a item/stack/sheet?
			else if(istype(S, /obj/item/stack/sheet))
				//seting it so we can get new set vars for the sheet
				var/obj/item/stack/sheet/SS = S
				//if it isnt the material needed, move on
				if(SS.oretypename != orename)
					continue
			//we have gone up to here, is it actually the required item?
			if(istype(S, req_item_2[1]))
				//yep, so add it to the buffer
				req_item_2[3] += S.amount
				//here is an upgrade. a chance to not destroy the input
				if(prob(100 / destroy_chance))
					//delete it! We dont want something to be too strong!
					qdel(S)
	//back to this, do we require the first item? (odds are, yes. You know, there are no recipes that are free)
	if(item1_dependent)
		//MAKE SURE THERE ISNT A ZERO. There MUST be an item here
		if(req_item_1[3] == 0)
			return
	//back to this, do we require a second item? (no for the first tier, yes for the rest)
	if(item2_dependent)
		//MAKE SURE THERE ISNT A ZERO. There MUST be an item here
		if(req_item_2[3] == 0)
			return
	//now, in the buffer, is both the item1 and item2 satisfied in their contents?
	//item1 is always used, so ramount should be a certain amount, so we count on the current buffer to be greater or equal to the price
	//item2 is not always used. so it is set to 0. 0 = 0 last time I checked, so this passes if a recipe only requires one
	if(req_item_1[3] >= req_item_1[2] && req_item_2[3] >= req_item_2[2])
		//if its item1 dependent, we need to remove the amount required from the current amount, since current is above or equal to the required
		if(item1_dependent)
			//quick math, set req1 current amount to itself minus the required amount
			req_item_1[3] -= req_item_1[2]
		//if its item2 dependent, we need to remove the amount required from the current amount, since current is above or equal to the required
		if(item2_dependent)
			//quick math, set req1 current amount to itself minus the required amount
			req_item_2[3] -= req_item_2[2]
		//setting up a var so that we can modify it. we also spawn the item here at the output turf (TO)
		var/obj/item/stack/factory/products/F = new refined_product(TO)
		//changing the material type to the type of the machine
		F.ore_type = orename
		//changing the product type to the type of the machine
		F.product_type = shorthand_refined
		//now, check this var out in products.dm. We are updating the name, the icon, and much more with this proc
		F.update_product()
		//this is now for the amount of credits produced. Do note it is not selling the product here, just passively making credits if it successfully creates stuff
		var/obj/item/stack/ore/O = ore_choice
		//there is an upgrade here.
		credit_number += O.points * credit_efficiency

/obj/machinery/factory/miner
	name = "factory miner"
	desc = "A machine that is used to mine ores from the ground."
	icon_state = "miner"

	has_input = FALSE
	has_output = TRUE
	has_ore_choice = FALSE
	has_refined_products = FALSE
	produces_credits = FALSE

/obj/machinery/factory/miner/process()
	. = ..()
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral))
		var/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/M = T
		var/turf/TO = get_step(src, output_turf)
		var/chosen_ore_spawn = pickweight(M.possible_minerals)
		if(prob(50 * output_chance))
			var/obj/item/stack/ore/I = new chosen_ore_spawn(TO)
			I.amount = output_efficiency
