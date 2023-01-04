/// For modularly handling can_equip.
/datum/species/proc/modular_can_equip(mob/living/carbon/human/human, obj/item/item, slot, disable_warning, bypass_equip_delay_self)
	if(slot == ITEM_SLOT_PASSPORT)
		var/obj/item/bodypart/bodypart = human.get_bodypart(BODY_ZONE_CHEST)
		if(!human.w_uniform && !nojumpsuit && (!bodypart || IS_ORGANIC_LIMB(bodypart)))
			if(!disable_warning)
				to_chat(human, span_warning("You need a jumpsuit before you can store [item.name]!"))
			return FALSE
		return equip_delay_self_check(item, human, bypass_equip_delay_self)
