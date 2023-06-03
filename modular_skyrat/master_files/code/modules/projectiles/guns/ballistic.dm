/obj/item/gun/ballistic/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	. = ..()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(.)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
