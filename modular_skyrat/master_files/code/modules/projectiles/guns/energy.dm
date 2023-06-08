/obj/item/gun/energy/process(seconds_per_tick)
	. = ..()
	if(selfcharge && cell && cell.percent() < 100)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/energy/select_fire(mob/living/user)
	. = ..()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
