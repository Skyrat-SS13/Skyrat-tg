/obj/item/pipe_dispenser/pre_attack(atom/target, mob/user, params)
	if(istype(target, /obj/item/rpd_upgrade/unwrench))
		install_upgrade(target, user)
		return TRUE
	return ..()

/obj/item/pipe_dispenser/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rpd_upgrade/unwrench))
		install_upgrade(W, user)
		return TRUE
	return ..()
