// Lowers arousal and pleasure by a bunch to not chain climax.

/datum/status_effect/climax
	id = "climax"
	tick_interval =  10
	duration = 100
	alert_type = null

/datum/status_effect/climax/tick()
	if(!owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	var/mob/living/carbon/human/affected_mob = owner

	var/temp_arousal = -12
	var/temp_pleasure = -12
	var/temp_stamina = 15

	owner.reagents.add_reagent(/datum/reagent/drug/aphrodisiac/dopamine, 0.5)
	owner.adjustStaminaLoss(temp_stamina)
	affected_mob.adjust_arousal(temp_arousal)
	affected_mob.adjust_pleasure(temp_pleasure)

// Likely ready to be deprecated code that could be removed, due to nymphomaniac not existing anymore.
/datum/status_effect/masturbation_climax
	id = "climax"
	tick_interval =  10
	duration = 50 //Multiplayer better than singleplayer mode.
	alert_type = null

/datum/status_effect/masturbation_climax/tick() //this one should not leave decals on the floor. Used in case if character cumming in beaker.
	if(!owner.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	var/mob/living/carbon/human/affected_mob = owner
	var/temp_arousal = -12
	var/temp_pleasure = -12
	var/temp_stamina = 8

	owner.reagents.add_reagent(/datum/reagent/drug/aphrodisiac/dopamine, 0.3)
	owner.adjustStaminaLoss(temp_stamina)
	affected_mob.adjust_arousal(temp_arousal)
	affected_mob.adjust_pleasure(temp_pleasure)

// A second step in preventing chain climax, and also prevents spam.
/datum/status_effect/climax_cooldown
	id = "climax_cooldown"
	tick_interval = 10
	duration = 30 SECONDS
	alert_type = null

/datum/status_effect/climax_cooldown/tick()
	var/obj/item/organ/external/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/external/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/testicles/penis = owner.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/external/genital/testicles/anus = owner.getorganslot(ORGAN_SLOT_ANUS)

	if(penis)
		penis.aroused = AROUSAL_NONE
	if(vagina)
		vagina.aroused = AROUSAL_NONE
	if(balls)
		balls.aroused = AROUSAL_NONE
	if(anus)
		anus.aroused = AROUSAL_NONE
