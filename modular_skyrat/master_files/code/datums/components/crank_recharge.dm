// Update ammo counter for crank recharge weapons like the musket and smoothbore
/datum/component/crank_recharge/crank(obj/source, mob/living/user as mob)
	if(!charging_cell)
		return ..()

	var/initial_cell_charge = charging_cell.charge

	. = ..()
	
	if(charging_cell.charge != initial_cell_charge)
		SEND_SIGNAL(parent, COMSIG_UPDATE_AMMO_HUD)
	
	return ..()
	

