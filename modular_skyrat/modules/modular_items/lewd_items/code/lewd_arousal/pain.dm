// I guess some people enjoy it.

/mob/living/carbon/human/proc/adjust_pain(change_amount = 0)
	if(stat >= DEAD)
		return
	if(client?.prefs?.read_preference(/datum/preference/toggle/erp))
		if(pain > pain_limit || change_amount > pain_limit / 10) // pain system // YOUR SYSTEM IS PAIN, WHY WE'RE GETTING AROUSED BY STEPPING ON ANTS?!
			if(HAS_TRAIT(src, TRAIT_MASOCHISM))
				var/arousal_adjustment = change_amount - (pain_limit / 10)
				if(arousal_adjustment > 0)
					adjustArousal(-arousal_adjustment)
			else
				if(change_amount > 0)
					adjustArousal(-change_amount)
			if(prob(2) && pain > pain_limit && change_amount > pain_limit / 10)
				try_lewd_autoemote(pick("scream", "shiver")) //SCREAM!!!
		else
			if(change_amount > 0)
				adjustArousal(change_amount)
			if(HAS_TRAIT(src, TRAIT_MASOCHISM))
				var/pleasure_adjustment = change_amount / 2
				adjustPleasure(pleasure_adjustment)
		pain += change_amount
	else
		pain -= abs(change_amount)
	pain = clamp(pain, 0, AROUSAL_LIMIT)

// Get damage for pain system
/datum/species/apply_damage(damage, damagetype, def_zone, blocked, mob/living/carbon/human/affected_mob, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction)
	. = ..()
	if(!.)
		return
	if(affected_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return
	var/hit_percent = (100 - (blocked + armor)) / 100
	hit_percent = (hit_percent * (100 - affected_mob.physiology.damage_resistance)) / 100
	switch(damagetype)
		if(BRUTE)
			var/amount = forced ? damage : damage * hit_percent * brutemod * affected_mob.physiology.brute_mod
			INVOKE_ASYNC(affected_mob, /mob/living/carbon/human/.proc/adjust_pain, amount)
		if(BURN)
			var/amount = forced ? damage : damage * hit_percent * burnmod * affected_mob.physiology.burn_mod
			INVOKE_ASYNC(affected_mob, /mob/living/carbon/human/.proc/adjust_pain, amount)
