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
	if(check_hostile_mobs())
		return
	if(!check_cooldown())
		return
	if(!check_coolant())
		return
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral))
		var/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/M = T
		if(M.max_mining_allowed <= 0)
			STOP_PROCESSING(SSobj, src)
			return
		var/turf/TO = get_step(src, output_turf)
		var/chosen_ore_spawn = pickweight(M.possible_minerals)
		if(prob(50 * output_chance))
			if(prob(100 / destroy_chance))
				M.max_mining_allowed--
			var/obj/item/stack/ore/I = new chosen_ore_spawn(TO)
			I.amount = output_efficiency
