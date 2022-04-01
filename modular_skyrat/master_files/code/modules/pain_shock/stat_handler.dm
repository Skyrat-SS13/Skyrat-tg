/mob/living/carbon/set_stat(new_stat)
	. = ..()
	if(. == DEAD && new_stat == DEAD) // insurance
		return
	if(should_be_critical(new_stat))
		ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, STAT_TRAIT)
		ADD_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
		to_chat(src, "my fancy set_start ran and we're supposed to be [new_stat] according to it")
		if(flow_rate <= 60)
			ADD_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
			ADD_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
		if(stat == DEAD)
			consider_the_score(new_stat)
	else
		switch(new_stat)

			if(CONSCIOUS && !should_be_critical(new_stat))
				REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, STAT_TRAIT)
				REMOVE_TRAIT(src, TRAIT_INCAPACITATED, STAT_TRAIT)
				REMOVE_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
				REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
				REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
				cure_blind(UNCONSCIOUS_TRAIT)
				if(stat == DEAD)
					consider_the_score(new_stat)
				if(stat >= UNCONSCIOUS)
					REMOVE_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
					REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
/* 			if(UNCONSCIOUS)
				if(stat == DEAD)
					consider_the_score(new_stat)
				if(stat != HARD_CRIT)
					become_blind(UNCONSCIOUS_TRAIT)
				if(should_be_critical() && !HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
					ADD_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
					ADD_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
				else
					REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
					cure_blind(UNCONSCIOUS_TRAIT) */
			if(DEAD)
				ADD_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
				REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
				if(stat == DEAD)
					return
				consider_the_score(new_stat)

/mob/living/carbon/proc/consider_the_score(new_stat)
	if(stat == DEAD && new_stat != DEAD)
		remove_from_dead_mob_list()
		add_to_alive_mob_list()
	else
		remove_from_alive_mob_list()
		add_to_dead_mob_list()
/mob/living/carbon/proc/should_be_critical(new_stat)
	var/answer = FALSE
	if(in_shock)
		answer = TRUE
	if(health <= hardcrit_threshold || stat == DEAD)
		answer = TRUE
	if(new_stat == SOFT_CRIT || new_stat == HARD_CRIT || new_stat == DEAD)
		to_chat(src, "Ya??")
		answer = TRUE
	return answer
