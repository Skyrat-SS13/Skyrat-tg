/datum/preference/choiced/tail
	savefile_key = "feature_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "tail"

/datum/preference/choiced/tail/init_possible_values()
	return GLOB.sprite_accessories["tail"]

/datum/preference/choiced/tail/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts["tail"])
		target.dna.mutant_bodyparts["tail"] = list()
	target.dna.mutant_bodyparts["tail"][MUTANT_INDEX_NAME] = value
	//target.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_COLOR_LIST] = your_list_with_colors //This list must be 3 hexa colors

//The issue is we now need to somehow pass through color
//the value being returned can be an associative list of name and color
//THe UI doesn't have this support right now, we need to add it
//Below is an example of one color support, we need to modify it to support three colors, maybe three individual SUPPLIMENTAL data keys
//problem is this only supports one supplemental feature
//I will have to make a new component to use that is just 3 color boxes.
