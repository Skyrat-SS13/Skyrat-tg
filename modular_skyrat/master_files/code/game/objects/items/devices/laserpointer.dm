/obj/item/laser_pointer
	//Whether the laser pointer is capable of receiving upgrades
	var/upgradable = TRUE

/obj/item/laser_pointer/limited
	//limited laser pointers cannot receive upgrades, mostly used in loadout
	upgradable = FALSE

/obj/item/laser_pointer/limited/red
	pointer_icon_state = "red_laser"

/obj/item/laser_pointer/limited/green
	pointer_icon_state = "green_laser"

/obj/item/laser_pointer/limited/blue
	pointer_icon_state = "blue_laser"

/obj/item/laser_pointer/limited/purple
	pointer_icon_state = "purple_laser"

/obj/item/laser_pointer/screwdriver_act(mob/living/user, obj/item/tool)
	if(!upgradable)
		balloon_alert(user, "can't remove integrated diode!")
		return
	return ..()

/obj/item/laser_pointer/attackby(obj/item/attack_item, mob/user, params)
	if(istype(attack_item, /obj/item/stock_parts/micro_laser) || istype(attack_item, /obj/item/stack/ore/bluespace_crystal))
		if(!upgradable)
			balloon_alert(user, "can't upgrade integrated parts!")
			return
	return ..()

/obj/item/laser_pointer/examine(mob/user)
	. = ..()
	if(!upgradable)
		. += span_notice("The diode and the lens are both cheap, integrated components. This pointer cannot be upgraded.")
