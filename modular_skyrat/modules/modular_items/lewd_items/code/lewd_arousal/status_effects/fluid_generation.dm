// These are effectively magic numbers.
#define AROUSAL_MULTIPLIER 25
#define TESTES_MULTIPLIER 235
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

/datum/status_effect/body_fluid_regen/vagina
	id = "vagina fluid regen"

/datum/status_effect/body_fluid_regen/vagina/tick(seconds_between_ticks)
	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy) || !istype(affected_human))
		return FALSE

	var/obj/item/organ/external/genital/vagina/vagina = owner.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(!vagina)
		return FALSE

	if(affected_human.arousal > AROUSAL_LOW)
		var/regen = (affected_human.arousal / AROUSAL_MULTIPLIER) * (vagina.internal_fluid_maximum / VAGINA_MULTIPLIER) * BASE_MULTIPLIER
		vagina.adjust_internal_fluid(regen)
	else
		vagina.adjust_internal_fluid(VAGINA_FLUID_REMOVAL_AMOUNT)

/datum/status_effect/body_fluid_regen/testes
	id = "testes fluid regen"

/datum/status_effect/body_fluid_regen/testes/tick(seconds_between_ticks)
	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy) || !istype(affected_human))
		return FALSE

	var/obj/item/organ/external/genital/testicles/testes = owner.get_organ_slot(ORGAN_SLOT_TESTICLES)
	if(!testes || (affected_human.arousal < AROUSAL_LOW))
		return FALSE

	var/regen = (affected_human.arousal / AROUSAL_MULTIPLIER) * (testes.internal_fluid_maximum / TESTES_MULTIPLIER) * BASE_MULTIPLIER
	testes.internal_fluid_count += regen

/datum/status_effect/body_fluid_regen/breasts
	id = " breast milk regen"

/datum/status_effect/body_fluid_regen/breasts/tick(seconds_between_ticks)
	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy) || !istype(affected_human))
		return FALSE

	var/obj/item/organ/external/genital/breasts/breasts = owner.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(!breasts || !breasts.lactates)
		return FALSE

	var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED / NUTRITION_MULTIPLIER)) / NUTRITION_MULTIPLIER) * (breasts.internal_fluid_maximum / BREASTS_MULTIPLIER) * BASE_MULTIPLIER
	if(!breasts.internal_fluid_full())
		owner.adjust_nutrition(-regen / NUTRITION_COST_MULTIPLIER)
		breasts.adjust_internal_fluid(regen)

#undef AROUSAL_MULTIPLIER
#undef TESTES_MULTIPLIER
#undef NUTRITION_MULTIPLIER
#undef NUTRITION_COST_MULTIPLIER
#undef BREASTS_MULTIPLIER
#undef VAGINA_MULTIPLIER
#undef VAGINA_FLUID_REMOVAL_AMOUNT
#undef BASE_MULTIPLIER
