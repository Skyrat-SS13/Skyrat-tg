/datum/species/modular_can_equip(mob/living/carbon/human/human, obj/item/item, disable_warning, bypass_equip_delay_self)
	. = ..()
	if(. != CAN_EQUIP_PASS)
		return

	if(ITEM_SLOT_PASSPORT)
		var/obj/item/bodypart/O = human.get_bodypart(BODY_ZONE_CHEST)
		if(!human.w_uniform && !nojumpsuit && (!O || IS_ORGANIC_LIMB(O)))
			if(!disable_warning)
				to_chat(human, span_warning("You need a jumpsuit before you can attach this [item.name]!"))
			return CAN_EQUIP_FALSE
		return equip_delay_self_check(item, human, bypass_equip_delay_self)? CAN_EQUIP_TRUE : CAN_EQUIP_FALSE
