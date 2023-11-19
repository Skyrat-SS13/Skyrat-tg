#define PARROT_PERCH (1<<0) //Sitting/sleeping, not moving
#define PARROT_SWOOP (1<<1) //Moving towards or away from a target
#define PARROT_WANDER (1<<2) //Moving without a specific target in mind

/*
* Parrot commands: Made modular
*/

/mob/living/basic/parrot
	/// Whether the parrot is on a human's shoulder or not
	var/buckled_to_human

/*
* Parrot commands: new code
*/

/mob/living/basic/parrot/proc/check_command(message, speaker)
	return FALSE // Simply return false for non-Poly parrots

/mob/living/basic/parrot/poly/check_command(message, speaker)
	var/mob/living/carbon/human/human_target = speaker
	if(!istype(human_target))
		return FALSE
	if(!(human_target.mind?.assigned_role.title == JOB_CHIEF_ENGINEER))
		return FALSE
	if(!(findtext(message, "poly")))
		return FALSE
	if(findtext(message, "perch") || findtext(message, "up"))
		command_perch(speaker)
		return TRUE
	else if(findtext(message, "off") || findtext(message, "down"))
		command_hop_off(speaker)
		return TRUE
	else
		return FALSE

/mob/living/basic/parrot/toggle_perched(perched)
	. = ..()
	if(!perched)
		buckled_to_human = FALSE

/mob/living/basic/parrot/poly/proc/command_perch(mob/living/carbon/human/human_target)
	if(!buckled)
		buckled_to_human = FALSE
	if(LAZYLEN(human_target.buckled_mobs) >= human_target.max_buckled_mobs)
		return
	if(buckled_to_human)
		manual_emote("gives [human_target] a confused look, squawking softly.")
		return
	if(get_dist(src, human_target) > 1 || buckled) // Only adjacent
		manual_emote("tilts their head at [human_target], before bawking loudly and staying put.")
		return
	manual_emote("obediently hops up onto [human_target]'s shoulder, spreading their wings for a moment before settling down.")
	if(start_perching(human_target))
		buckled_to_human = TRUE

/mob/living/basic/parrot/poly/proc/command_hop_off(mob/living/carbon/human/human_target)
	if(!buckled)
		buckled_to_human = FALSE
	if(!buckled_to_human || !buckled)
		manual_emote("gives [human_target] a confused look, squawking softly.")
		return

	if(buckled)
		to_chat(src, span_notice("You are no longer sitting on [human_target]."))
		buckled.unbuckle_mob(src, TRUE)
		manual_emote("squawks and hops off of [human_target], flying away.")

#undef PARROT_PERCH
#undef PARROT_SWOOP
#undef PARROT_WANDER
