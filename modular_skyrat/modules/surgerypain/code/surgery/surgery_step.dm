/datum/surgery_step/proc/display_pain(mob/living/target, pain_message, mechanical = FALSE)
	if(HAS_TRAIT(target, TRAIT_NUMBED))
		return
	if(target.stat < UNCONSCIOUS && !isrobotic(target) || (isrobotic(target) && mechanical))
		to_chat(target, pain_message)
		if(prob(30) && !mechanical)
			INVOKE_ASYNC(target, /mob.proc/emote, "scream") //i have no idea what async does but i'm copying it from dismemberment
