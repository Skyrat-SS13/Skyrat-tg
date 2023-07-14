/obj/item/gun/energy/process(seconds_per_tick)
	. = ..()
	if(selfcharge && cell && cell.percent() < 100)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/energy/select_fire(mob/living/user)
	. = ..()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/energy/laser/musket/attack_self(mob/living/user)
	var/initial_cell_charge
	var/post_cell_charge

	if(!cell)
		return ..()
	
	initial_cell_charge = get_charge_ratio()

	. = ..()
	
	post_cell_charge = get_charge_ratio()
	
	if(initial_cell_charge != post_cell_charge)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
