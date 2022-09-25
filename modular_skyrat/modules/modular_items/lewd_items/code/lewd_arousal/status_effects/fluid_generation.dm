/datum/status_effect/body_fluid_regen
	id = "body fluid regen"
	tick_interval = 50
	duration = -1
	alert_type = null

/datum/status_effect/body_fluid_regen/tick()
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	var/mob/living/carbon/human/affected_mob = owner
	var/obj/item/organ/external/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/breasts/breasts = owner.getorganslot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/external/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)

	var/interval = 5
	if(balls)
		if(affected_mob.arousal >= AROUSAL_LOW)
			var/regen = (affected_mob.arousal / 25) * (balls.internal_fluid_maximum / 235) * interval
			balls.internal_fluid_count += regen

	if(breasts)
		if(breasts.lactates == TRUE)
			var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED / 100)) / 100) * (breasts.internal_fluid_maximum / 11000) * interval
			if(!breasts.internal_fluid_full())
				owner.adjust_nutrition(-regen / 2)
				breasts.adjust_internal_fluid(regen)

	if(vagina)
		if(affected_mob.arousal >= AROUSAL_LOW)
			var/regen = (affected_mob.arousal / 25) * (vagina.internal_fluid_maximum / 250) * interval
			vagina.adjust_internal_fluid(regen)
		else
			vagina.adjust_internal_fluid(-0.05)
