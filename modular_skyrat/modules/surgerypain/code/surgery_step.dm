/datum/surgery_step/proc/display_pain(mob/living/target, pain_message, mechanical = FALSE)
	var/mob/living/carbon/human/target_human = target
	if(target.stat < UNCONSCIOUS && !(target_human.dna.species == /datum/species/robotic) || (target_human.dna.species == /datum/species/robotic && mechanical))
		to_chat(target, pain_message)
		if(prob(30) && !mechanical)
			INVOKE_ASYNC(target, /mob.proc/emote, "scream") //i have no idea what async does but i'm copying it from dismemberment
