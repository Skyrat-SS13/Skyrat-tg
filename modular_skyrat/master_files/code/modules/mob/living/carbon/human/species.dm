/// For modularly handling can_equip. Use the CAN_EQUIP_TRUE, CAN_EQUIP_FALSE, or CAN_EQUIP_PASS.
/datum/species/proc/modular_can_equip(mob/living/carbon/human/human, obj/item/item, disable_warning, bypass_equip_delay_self)
	return CAN_EQUIP_PASS
