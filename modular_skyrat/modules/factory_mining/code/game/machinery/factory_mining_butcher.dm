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
