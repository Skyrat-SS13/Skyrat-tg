/// For modularly handling can_equip. Use the CAN_EQUIP_TRUE, CAN_EQUIP_FALSE, or CAN_EQUIP_PASS.
/datum/species/proc/modular_can_equip(mob/living/carbon/human/human, obj/item/item, slot, disable_warning, bypass_equip_delay_self)
	if(slot == ITEM_SLOT_PASSPORT)
		var/obj/item/bodypart/O = human.get_bodypart(BODY_ZONE_CHEST)
		if(!human.w_uniform && !nojumpsuit && (!O || IS_ORGANIC_LIMB(O)))
			if(!disable_warning)
				to_chat(human, span_warning("You need a jumpsuit before you can attach this [item.name]!"))
			return CAN_EQUIP_FALSE
		return equip_delay_self_check(item, human, bypass_equip_delay_self)? CAN_EQUIP_TRUE : CAN_EQUIP_FALSE
