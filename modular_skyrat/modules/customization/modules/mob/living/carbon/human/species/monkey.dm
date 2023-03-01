/datum/species/monkey
	default_mutant_bodyparts = list("tail" = "Monkey")

/datum/species/monkey/prepare_human_for_preview(mob/living/carbon/human/monke)
	monke.update_mutant_bodyparts(force_update = TRUE)
	monke.update_body(is_creating = TRUE)
