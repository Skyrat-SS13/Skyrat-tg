/datum/preference_middleware/species_additional_changes

/datum/preference_middleware/species_additional_changes/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only)
	target.dna.species.apply_supplementary_body_changes(target, preferences, visuals_only)

