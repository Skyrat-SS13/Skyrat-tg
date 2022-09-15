/datum/status_effect/aroused
	id = "aroused"
	tick_interval = 10
	duration = -1
	alert_type = null

/datum/status_effect/aroused/tick()
	var/mob/living/carbon/human/affected_mob = owner
	var/temp_arousal = -0.1
	var/temp_pleasure = -0.5
	var/temp_pain = -0.5
	if(affected_mob.stat != DEAD)

		var/obj/item/organ/external/genital/testicles/balls = affected_mob.getorganslot(ORGAN_SLOT_TESTICLES)
		if(balls)
			if(balls.internal_fluids.holder_full())
				temp_arousal += 0.08

		if(HAS_TRAIT(affected_mob, TRAIT_MASOCHISM))
			temp_pain -= 0.5
		if(HAS_TRAIT(affected_mob, TRAIT_NEVERBONER))
			temp_pleasure -= 50
			temp_arousal -= 50

		if(affected_mob.pain > affected_mob.pain_limit)
			temp_arousal -= 0.1
		if(affected_mob.arousal >= AROUSAL_MEDIUM && affected_mob.stat != DEAD)
			if(prob(3))
				affected_mob.try_lewd_autoemote(pick("moan", "blush"))
			temp_pleasure += 0.1
			//moan
		if(affected_mob.pleasure >= AROUSAL_HIGH && affected_mob.stat != DEAD)
			if(prob(3))
				affected_mob.try_lewd_autoemote(pick("moan", "twitch_s"))
			//moan x2

	affected_mob.adjustArousal(temp_arousal)
	affected_mob.adjustPleasure(temp_pleasure)
	affected_mob.adjustPain(temp_pain)
