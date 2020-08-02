/datum/sprite_accessory
	///Unique key of an accessroy. All tails should have "tail", ears "ears" etc.
	var/key = null
	///If an accessory is special, it wont get included in the normal accessory lists
	var/special = FALSE
	var/list/recommended_species
	///Which color we default to on acquisition of the accessory (such as switching species, default color for character customization etc)
	var/default_color = DEFAULT_PRIMARY

/datum/sprite_accessory/proc/can_show(mob/living/carbon/human?H, obj/item/bodypart/BP)
	return TRUE