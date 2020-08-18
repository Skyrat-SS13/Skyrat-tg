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
	if(check_hostile_mobs())
		return
	if(!check_cooldown())
		return
	if(!check_coolant())
		return
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
		//make sure it is greater than or equal to the amount. if it isnt, return
		if(req_item_1[3] < req_item_1[2])
			return
	//back to this, do we require a second item? (no for the first tier, yes for the rest)
	if(item2_dependent)
		//make sure it is greater than or equal to the amount. if it isnt, return
		if(req_item_2[3] < req_item_2[2])
			return
	//now, in the buffer, is both the item1 and item2 satisfied in their contents?
	//item1 is always used, so ramount should be a certain amount, so we count on the current buffer to be greater or equal to the price
	//item2 is not always used. so it is set to 0. 0 = 0 last time I checked, so this passes if a recipe only requires one
	//if its item1 dependent, we need to remove the amount required from the current amount, since current is above or equal to the required
	if(item1_dependent)
		//quick math, set req1 current amount to itself minus the required amount
		req_item_1[3] -= req_item_1[2]
	//item1 is always used, so ramount should be a certain amount, so we count on the current buffer to be greater or equal to the price
	//item2 is not always used. so it is set to 0. 0 = 0 last time I checked, so this passes if a recipe only requires one
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
