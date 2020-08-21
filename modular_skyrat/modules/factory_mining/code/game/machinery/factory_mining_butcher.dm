/obj/machinery/factory/butcher
	name = "factory butcher"
	desc = "A machine that is used to butcher creatures."
	icon_state = "miner"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = FALSE
	has_refined_products = FALSE
	produces_credits = FALSE

/obj/machinery/factory/butcher/process()
	if(check_hostile_mobs())
		return
	if(!check_cooldown())
		return
	if(!check_coolant())
		return
	var/turf/inputing_turf = get_step(src, input_turf)
	var/turf/outputing_turf = get_step(src, output_turf)
	if(inputing_turf.contents)
		for(var/mob/living/simple_animal/chosen_mob in inputing_turf)
			if(chosen_mob.stat != DEAD)
				continue
			if(chosen_mob.butcher_results)
				var/obj/chosen_butcher_result = pickweight(chosen_mob.butcher_results)
				new chosen_butcher_result(outputing_turf)
			if(chosen_mob.guaranteed_butcher_results)
				for(var/butcher_item in chosen_mob.guaranteed_butcher_results)
					var/obj/sinew = butcher_item
					var/amount = chosen_mob.guaranteed_butcher_results[sinew]
					for(var/i in 1 to amount)
						new sinew (outputing_turf)
			chosen_mob.forceMove(outputing_turf)
			chosen_mob.gib()


