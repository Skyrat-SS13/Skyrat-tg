/datum/surgery_step/proc/display_pain(mob/living/target, pain_message)
	if(target.stat < UNCONSCIOUS)
		to_chat(target, pain_message)
		if(prob(10))
			INVOKE_ASYNC(target, /mob.proc/emote, "scream") //i have no idea what async does but i'm copying it from dismemberment
