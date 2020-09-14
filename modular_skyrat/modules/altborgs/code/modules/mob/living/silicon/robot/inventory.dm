/mob/living/silicon/robot/unequip_module_from_slot(obj/item/O)
	..()
	if(istype(O,/obj/item/gun/energy/laser/cyborg))
		update_icons()
	else if(istype(O,/obj/item/gun/energy/disabler/cyborg) || istype(O,/obj/item/gun/energy/e_gun/advtaser/cyborg))
		update_icons() //PUT THE GUN AWAY
	/* - TODO ADD SLEEPERS
	else if(istype(O,/obj/item/dogborg/sleeper))
		sleeper_g = FALSE
		sleeper_r = FALSE
		update_icons()
		var/obj/item/dogborg/sleeper/S = O
		S.go_out() //this should stop edgecase deletions
		*/

/mob/living/silicon/robot/equip_module_to_slot(obj/item/O)
	..()
	if(istype(O,/obj/item/gun/energy/laser/cyborg))
		update_icons() //REEEEEEACH FOR THE SKY
	if(istype(O,/obj/item/gun/energy/disabler/cyborg) || istype(O,/obj/item/gun/energy/e_gun/advtaser/cyborg))
		update_icons()
