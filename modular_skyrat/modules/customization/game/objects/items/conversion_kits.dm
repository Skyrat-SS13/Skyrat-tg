/obj/item/device/custom_kit
    name = "modification kit"
    desc = "A box of parts for modifying a certain object."
    icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
    icon_state = "partskit"
    /// The base object to be converted.
    var/obj/item/from_obj
    /// The object to turn it into.
    var/obj/item/to_obj

/obj/item/device/custom_kit/afterattack(obj/target_obj, mob/user as mob, proximity_flag)
    if(!proximity_flag) //Gotta be adjacent to your target
        return
    if(isturf(target_obj)) //This shouldn't be needed, but apparently it throws runtimes otherwise.
        return
    else if(target_obj.type == from_obj) //Checks whether the item is eligible to be converted
        var/obj/item/converted_item = new to_obj(get_turf(src))
        user.put_in_hands(converted_item)
        user.visible_message(span_notice("[user] modifies [target_obj] into [converted_item]."), span_notice("You modify [target_obj] into [converted_item]."))
        qdel(target_obj)
        qdel(src)
    else
        user.visible_message(span_warning("It looks like this kit won't work on [target_obj]..."))
