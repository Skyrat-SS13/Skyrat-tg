/mob/living/carbon/human/verb/disable_ghost_viewing()
	set name = "Toggle Ghost Viewing"
	set desc = "Toggles whether or not whispers and subtles done by you are visible to dead chat."
	set category = "IC"

	if(GetComponent(/datum/component/no_ghost_messages))
		qdel(GetComponent(/datum/component/no_ghost_messages))
		to_chat(src, span_notice("You will now send whispers and subtles to dead chat."))
		return TRUE

	AddComponent(/datum/component/no_ghost_messages)
	to_chat(src, span_notice("You will no longer send whispers and subtles to dead chat."))
	return TRUE

/datum/component/no_ghost_messages/Initialize(...)
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_EXIT_AREA, .proc/remove_self)
	ADD_TRAIT(parent, TRAIT_NO_GHOST_MESSAGES, INNATE_TRAIT)

/// Removes the component from the parent mob while sending them a message. This is called whenever the parent leaves an area.
/datum/component/no_ghost_messages/proc/remove_self()
	var/mob/living/parent_mob = parent
	to_chat(parent_mob, span_boldwarning("Due to leaving an area, your whispers and subtles will be sent to dead-chat. To re-disable sending, use the Toggle Ghost Viewing verb."))
	qdel(src)

/datum/component/no_ghost_messages/Destroy(force, silent)
	UnregisterSignal(parent, COMSIG_EXIT_AREA)
	REMOVE_TRAIT(parent, TRAIT_NO_GHOST_MESSAGES, INNATE_TRAIT)

	return ..()
