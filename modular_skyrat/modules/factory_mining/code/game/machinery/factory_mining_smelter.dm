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
	if(check_hostile_mobs())
		return
	if(!check_cooldown())
		return
	if(!check_coolant())
		return
	//if it doesnt have an input or output, something went wrong
	if(!has_output || !has_input)
		return
	//just to make sure it has an ore choice, because lord forbid, if it doesnt, something went wrong
	if(!has_ore_choice)
		return
	//this is the input get_step. So it will take the turf to the direction and pull from this
	var/turf/T = get_step(src, input_turf)
	//specifically check for ore in the contents of the turf
	for(var/obj/item/stack/ore/O in T.contents)
		//if it doesnt have an ore choice, its time to just set it to the first thing it comes across
		if(!ore_choice)
			//check the modules/mining/ore_coins.dm in the factory_mining module to see this
			ore_choice = O.type
			orename = O.factory_name
			sheet_choice = O.refined_type
			update_overlays()
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
