/mob/living/carbon/human/verb/disable_ghost_viewing()
	set name = "Toggle Ghost Viewing"
	set desc = "Toggles whether or not whispers and subtles done by you are visible to dead chat."
	set category = "IC"

	if(HAS_TRAIT(src, TRAIT_NO_GHOST_MESSAGES))
		REMOVE_TRAIT(src, TRAIT_NO_GHOST_MESSAGES, INNATE_TRAIT)
		to_chat(src, span_notice("You will now send whipsers and subtles to dead chat."))
		return TRUE

	ADD_TRAIT(src, TRAIT_NO_GHOST_MESSAGES, INNATE_TRAIT)
	to_chat(src, span_notice("You will no longer send whipsers and subtles to dead chat."))
	return TRUE

