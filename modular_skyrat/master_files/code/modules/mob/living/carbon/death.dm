// By temporarily removing the unspillable organs before calling the parent proc we can avoid Skyrat edits and make this less likely to break in the future
/mob/living/carbon/spill_organs(drop_bitflags)
	var/list/held_organs = list()
	for(var/obj/item/organ/organ as anything in organs)
		if(!organ.drop_when_organ_spilling)
			held_organs.Add(organ)
			organs.Remove(organ)

	. = ..()

	// put the unspillable organs back
	for(var/obj/item/organ/organ as anything in held_organs)
		organs.Add(organ)
