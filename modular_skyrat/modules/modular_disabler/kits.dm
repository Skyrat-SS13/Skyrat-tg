/obj/item/device/custom_kit/disabler
	var/ammo_to_add
	var/name_to_append

/obj/item/device/custom_kit/disabler/afterattack(obj/target, mob/user, proximity_flag)
	var/obj/item/gun/energy/disabler/upgraded/target_obj = target
	var/_name_to_append = name_to_append
	if(!proximity_flag) //Gotta be adjacent to your target
		return
	if(isturf(target_obj)) //This shouldn't be needed, but apparently it throws runtimes otherwise.
		return
	if(target_obj.amount >= target_obj.maxamount)
		to_chat(user, span_warning("You can't improve [target_obj] any further!"))
		return
	target_obj.addammotype(ammo_to_add, _name_to_append)
	user.visible_message(span_notice("[user] modifies [target_obj] with [ammo_to_add]!"), span_notice("You modify [target_obj] with [ammo_to_add]."))
	qdel(src)


