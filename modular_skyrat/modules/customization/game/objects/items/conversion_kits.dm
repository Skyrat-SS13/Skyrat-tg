/obj/item/device/custom_kit
	name = "modification kit"
	desc = "A box of parts for modifying a certain object."
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit"
	/// The base object to be converted.
	var/obj/item/from_obj
	/// The object to turn it into.
	var/obj/item/to_obj

/obj/item/device/custom_kit/afterattack(obj/target_obj, mob/user, proximity_flag)
	if(!proximity_flag) //Gotta be adjacent to your target
		return
	if(isturf(target_obj)) //This shouldn't be needed, but apparently it throws runtimes otherwise.
		return
	else if(target_obj.type == from_obj) //Checks whether the item is eligible to be converted
		if(!pre_convert_check(target_obj, user))
			return FALSE
		var/obj/item/converted_item = new to_obj(get_turf(src))
		user.put_in_hands(converted_item)
		user.visible_message(span_notice("[user] modifies [target_obj] into [converted_item]."), span_notice("You modify [target_obj] into [converted_item]."))
		qdel(target_obj)
		qdel(src)
	else
		to_chat(user, span_warning("It looks like this kit won't work on [target_obj]..."))

/// Override this if you have some condition you want fulfilled before allowing the conversion. Return TRUE to allow it to convert, return FALSE to prevent it.
/obj/item/device/custom_kit/proc/pre_convert_check(obj/target_obj, mob/user)
	return TRUE
