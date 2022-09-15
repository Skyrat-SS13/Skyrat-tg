/mob/living/carbon/human/proc/get_pleasure()
	return pleasure

/mob/living/carbon/human/proc/adjustPleasure(pleas = 0)
	if(stat != DEAD && client?.prefs?.read_preference(/datum/preference/toggle/erp))
		pleasure += pleas
		if(pleasure >= 100) // lets cum
			climax(FALSE)
	else
		pleasure -= abs(pleas)
	pleasure = min(max(pleasure, 0), 100)

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
			INVOKE_ASYNC(affected_mob, /mob/living/carbon/human/.proc/adjustPain, amount)
		if(BURN)
			var/amount = forced ? damage : damage * hit_percent * burnmod * affected_mob.physiology.burn_mod
			INVOKE_ASYNC(affected_mob, /mob/living/carbon/human/.proc/adjustPain, amount)
