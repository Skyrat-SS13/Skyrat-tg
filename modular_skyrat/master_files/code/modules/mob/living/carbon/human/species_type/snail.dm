/obj/item/storage/backpack/snail/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 30

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/snail)
	snail.dna.features["mcolor"] = "#adaba7"
	snail.update_body(TRUE)
