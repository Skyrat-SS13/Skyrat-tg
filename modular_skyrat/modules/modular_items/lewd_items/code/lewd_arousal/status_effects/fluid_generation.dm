/datum/status_effect/body_fluid_regen
	id = "body fluid regen"
	tick_interval = 50
	duration = -1
	alert_type = null

/datum/status_effect/body_fluid_regen/tick()
	var/mob/living/carbon/human/affected_mob = owner
	if(owner.stat != DEAD && affected_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		var/obj/item/organ/external/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
		var/obj/item/organ/external/genital/breasts/breasts = owner.getorganslot(ORGAN_SLOT_BREASTS)
		var/obj/item/organ/external/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)

		var/interval = 5
		if(balls)
			if(affected_mob.arousal >= AROUSAL_LOW)
				var/regen = (affected_mob.arousal / 25) * (balls.internal_fluids.maximum_volume / 235) * interval
				balls.internal_fluids.add_reagent(/datum/reagent/consumable/cum, regen)

		if(breasts)
			if(breasts.lactates == TRUE)
				var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED / 100)) / 100) * (breasts.internal_fluids.maximum_volume / 11000) * interval
				if(!breasts.internal_fluids.holder_full())
					owner.adjust_nutrition(-regen / 2)
					breasts.internal_fluids.add_reagent(/datum/reagent/consumable/breast_milk, regen)

		if(vagina)
			if(affected_mob.arousal >= AROUSAL_LOW)
				var/regen = (affected_mob.arousal / 25) * (vagina.internal_fluids.maximum_volume / 250) * interval
				vagina.internal_fluids.add_reagent(/datum/reagent/consumable/femcum, regen)
				if(vagina.internal_fluids.holder_full() && regen >= 0.15)
					regen = regen
			else
				vagina.internal_fluids.remove_any(0.05)
