/obj/machinery/shower/infinite
	desc = "The HS-453. Installed in the 2550s by the Nanotrasen Hygiene Division, now with 2561 chemical compliance!"
	can_toggle_refill = FALSE
	can_refill = FALSE

/obj/machinery/shower/interact(mob/M)
	if(reagents.total_volume < reagent_capacity)
		reagents.add_reagent(reagent_id, reagent_capacity - reagents.total_volume) //it will always be full, even if it's drained somehow
	..()

/obj/machinery/shower/process(delta_time)
	if(!on) //if through admin fuckery the on variable is changed or when interact is called
		soundloop.stop()
		handle_mist()
		update_appearance()
		return
	wash_atom(loc)
	for(var/am in loc)
		var/atom/movable/movable_content = am
		if(!ismopable(movable_content)) // Mopables will be cleaned anyways by the turf wash above
			wash_atom(movable_content) // Reagent exposure is handled in wash_atom
