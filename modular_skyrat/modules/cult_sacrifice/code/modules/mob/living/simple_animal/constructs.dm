/mob/living/simple_animal/hostile/construct
	var/datum/mind/original_mind //To save the original mind of the mob that was sacrificed and used for this construct.

/mob/living/simple_animal/hostile/construct/death()
	if(original_mind)
		if(!original_mind || (!ckey && original_mind.key))
			CRASH("[src] tried to transfer ckey [original_mind ? "on ckey-less mob with a player mob as target" : "without a valid mob target"]!")
		mind.transfer_to(original_mind, TRUE)
		if(HAS_TRAIT_FROM(original_mind, TRAIT_SACRIFICED, "sacrificed"))
			REMOVE_TRAIT(original_mind, TRAIT_SACRIFICED, "sacrificed")
	..()
