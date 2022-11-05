// These are effectively magic numbers.
#define AROUSAL_MULTIPLIER 25
#define BALLS_MULTIPLIER 235
#define NUTRITION_MULTIPLIER 100
#define NUTRITION_COST_MULTIPLIER 2
// Breasts have ungodly scaling at larger sizes, so the massive multiplier to ensure there's no runaway production makes sense here.
#define BREASTS_MULTIPLIER 11000
#define VAGINA_MULTIPLIER 250
#define VAGINA_FLUID_REMOVAL_AMOUNT -0.05
#define BASE_MULTIPLIER 5

/datum/status_effect/body_fluid_regen
	id = "body fluid regen"
	tick_interval = 5 SECONDS
	duration = -1
	alert_type = null

/datum/status_effect/body_fluid_regen/tick()
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	var/mob/living/carbon/human/affected_mob = owner
	var/obj/item/organ/external/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/breasts/breasts = owner.getorganslot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/external/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)

	if(balls)
		if(affected_mob.arousal >= AROUSAL_LOW)
			var/regen = (affected_mob.arousal / AROUSAL_MULTIPLIER) * (balls.internal_fluid_maximum / BALLS_MULTIPLIER) * BASE_MULTIPLIER
			balls.internal_fluid_count += regen

	if(breasts)
		if(breasts.lactates == TRUE)
			var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED / NUTRITION_MULTIPLIER)) / NUTRITION_MULTIPLIER) * (breasts.internal_fluid_maximum / BREASTS_MULTIPLIER) * BASE_MULTIPLIER
			if(!breasts.internal_fluid_full())
				owner.adjust_nutrition(-regen / NUTRITION_COST_MULTIPLIER)
				breasts.adjust_internal_fluid(regen)

	if(vagina)
		if(affected_mob.arousal >= AROUSAL_LOW)
			var/regen = (affected_mob.arousal / AROUSAL_MULTIPLIER) * (vagina.internal_fluid_maximum / VAGINA_MULTIPLIER) * BASE_MULTIPLIER
			vagina.adjust_internal_fluid(regen)
		else
			vagina.adjust_internal_fluid(VAGINA_FLUID_REMOVAL_AMOUNT)

#undef AROUSAL_MULTIPLIER
#undef BALLS_MULTIPLIER
#undef NUTRITION_MULTIPLIER
#undef NUTRITION_COST_MULTIPLIER
#undef BREASTS_MULTIPLIER
#undef VAGINA_MULTIPLIER
#undef VAGINA_FLUID_REMOVAL_AMOUNT
#undef BASE_MULTIPLIER
