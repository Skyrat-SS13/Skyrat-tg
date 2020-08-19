/obj/machinery/factory/loader
	name = "factory loader"
	desc = "A machine that is used to load and unload ores."
	icon_state = "miner"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = TRUE
	has_refined_products = FALSE
	produces_credits = FALSE

/obj/machinery/factory/butcher/process()
	if(check_hostile_mobs())
		return
	if(!check_cooldown())
		return
	if(!check_coolant())
		return
