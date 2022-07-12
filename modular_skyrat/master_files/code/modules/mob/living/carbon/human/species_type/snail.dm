/obj/item/storage/backpack/snail/Initialize()
	. = ..()
	atom_storage.max_specific_storage = 30

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/snail)
	snail.dna.features["mcolor"] = "#adaba7"
	snail.update_body(TRUE)
