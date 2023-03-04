/datum/species/monkey
	default_mutant_bodyparts = list("tail" = "Monkey")

/datum/species/monkey/prepare_human_for_preview(mob/living/carbon/human/monke)
	regenerate_organs(monke, src, visual_only = TRUE)
	monke.update_body(is_creating = TRUE)
