/datum/action/chameleon_slowdown
	name = "Toggle Chameleon Slowdown"
	button_icon_state = "chameleon_outfit"
	var/savedslowdown = 0

/datum/action/chameleon_slowdown/New(Target, slowdown)
	..(Target)
	savedslowdown = slowdown

/datum/action/chameleon_slowdown/Trigger(trigger_flags)
	var/obj/item/clothing/target_clothing = target
	var/slow = target_clothing.slowdown
	target_clothing.slowdown = savedslowdown
	savedslowdown = slow
	owner.update_equipment_speed_mods()

/datum/action/item_action/chameleon/change
	var/datum/action/chameleon_slowdown/slowtoggle

/datum/action/item_action/chameleon/change/update_look(mob/user, obj/item/picked_item)
	. = ..()
	if(isliving(user))
		owner.regenerate_icons()

/datum/action/item_action/chameleon/change/update_item(obj/item/picked_item)
	. = ..()
	if(istype(target, /obj/item/clothing/))
		var/obj/item/clothing/target_clothing = target
		var/obj/item/clothing/picked_clothing = picked_item
		target_clothing.supports_variations_flags = initial(picked_clothing.supports_variations_flags)
		target_clothing.worn_icon_digi = initial(picked_clothing.worn_icon_digi)
		target_clothing.worn_icon_taur_snake = initial(picked_clothing.worn_icon_taur_snake)
		target_clothing.worn_icon_taur_paw = initial(picked_clothing.worn_icon_taur_paw)
		target_clothing.worn_icon_taur_hoof = initial(picked_clothing.worn_icon_taur_hoof)
		target_clothing.worn_icon_muzzled = initial(picked_clothing.worn_icon_muzzled)
		target_clothing.flags_inv = initial(picked_clothing.flags_inv)
		target_clothing.visor_flags_cover = initial(picked_clothing.visor_flags_cover)
		target_clothing.slowdown = 0
		// var/slow = initial(picked_clothing.slowdown) /// DISABLED UNTIL YOU CAN MAKE THIS WORK WITH THE BROKEN CHAMELEON CLOTHES!!!
		// if(slow)
		// 	slowtoggle = new(target_clothing, slow)
		// 	slowtoggle.Grant(owner)
		// 	slowtoggle.target = target_clothing
		// else if(slowtoggle)
		// 	qdel(slowtoggle)

/datum/action/item_action/chameleon/change/Grant(mob/target_mob)
	. = ..()
	if(target_mob && (target_mob == owner))
		if(slowtoggle)
			slowtoggle?.Grant(target_mob)

/datum/action/item_action/chameleon/change/Remove(mob/target_mob)
	. = ..()
	if(target_mob && (target_mob == owner))
		if(slowtoggle)
			slowtoggle?.Remove(target_mob)
