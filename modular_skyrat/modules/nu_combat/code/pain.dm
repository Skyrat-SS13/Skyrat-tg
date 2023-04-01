#define PHYSICAL_HARM "physical"
#define BREATH_HARM "oxy"

/mob/living/carbon
	var/pain = 0
	var/pain_max = 500
	COOLDOWN_DECLARE(time_till_pain_process)

/mob/living/carbon/take_overall_damage(brute, burn, stamina, updating_health, required_bodytype)
	. = ..()
	if(brute || burn)
		take_pain(brute + burn, PHYSICAL_HARM)

	if((brute + burn) >= 5)
		harm_organs(brute + burn)

/mob/living/carbon/adjustBruteLoss(amount, updating_health, forced, required_bodytype)
	. = ..()
	if(amount > 0)
		take_pain(amount, PHYSICAL_HARM)

/mob/living/carbon/adjustFireLoss(amount, updating_health, forced, required_bodytype)
	. = ..()
	if(amount > 0)
		take_pain(amount, PHYSICAL_HARM)

/mob/living/carbon/adjustOxyLoss(amount, updating_health, forced, required_biotype, required_respiration_type)
	. = ..()
	if(amount > 0)
		take_pain(amount, BREATH_HARM)

/datum/species/apply_damage(damage, damagetype, def_zone, blocked, mob/living/carbon/human/H, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction)
	. = ..()
	var/pain = damage
	if(damagetype == OXY)
		pain *= 0.5
	if(damagetype == OXY || damagetype == BRUTE || damagetype == BURN)
		H.take_pain(pain)

/mob/living/carbon/Life(delta_time, times_fired)
	. = ..()
	process_pain()

/mob/living/carbon/proc/take_pain(damage, type)
	if(stat == DEAD)
		return

	if(type == BREATH_HARM)
		damage *= 0.5

	pain = clamp(pain + damage, 0, pain_max)

/mob/living/carbon/proc/harm_organs(damage_taken)
	for(var/obj/item/organ/internal/internal_organ as anything in organs)
		if(prob(damage_taken * 2.5))
			internal_organ.apply_organ_damage(damage_taken)

/mob/living/carbon/proc/process_pain()
	if(stat == DEAD)
		return

	if(!COOLDOWN_FINISHED(src, time_till_pain_process))
		return

	COOLDOWN_START(src, time_till_pain_process, 6 SECONDS)

	take_pain(-1)

	for(var/obj/item/bodypart/wounded_part as anything in get_wounded_bodyparts())
		for(var/datum/wound/ouchie as anything in wounded_part.wounds)
			take_pain(2.5)

	for(var/obj/item/organ/internal/internal_organ as anything in organs)
		if(internal_organ.damage > 75)
			take_pain(10)
		else if(internal_organ.damage > 50)
			take_pain(7.5)
		else if(internal_organ.damage > 25)
			take_pain(5)
		else if(internal_organ.damage > 0)
			take_pain(2.5)


	if((pain >= 250) && prob(pain / 25))
		var/datum/disease/heart_disease = new /datum/disease/heart_failure()
		ForceContractDisease(heart_disease, FALSE, TRUE)
		to_chat(src, span_warning("You feel something in your chest sieze up through your pain!"))
		return

	if(prob(pain / 10))
		Knockdown(10 SECONDS)
		Paralyze(10 SECONDS)
		to_chat(src, span_warning("You collapse from the pain! Oh please, just make it end!"))
		return

	if(prob(pain / 7.5))
		drop_all_held_items()
		to_chat(src, span_warning("You drop what you were holding, crying out in pain!"))
		emote("scream")
		return

	if(prob(50))
		return

	if(pain >= 300)
		to_chat(src, span_warning("Your body feels like it's on fire, you can barely see through the haze of pain!"))
		add_mood_event("pain", /datum/mood_event/pain/mortis)
		return

	if(pain >= 100)
		to_chat(src, span_warning("Your body aches terribly! It's hard to focus through the horrible, horrible pain!"))
		add_mood_event("pain", /datum/mood_event/pain/severe)
		return

	if(pain >= 50)
		to_chat(src, span_warning("Your body stings with pain. It's not too bad, but it still hurts."))
		add_mood_event("pain", /datum/mood_event/pain)
		return

	if(pain >= 20)
		to_chat(src, span_warning("Your body stings with pain. It's not too bad, but it still hurts."))
		add_mood_event("pain", /datum/mood_event/pain/minor)
		return

	if(pain)
		to_chat(src, span_warning("You feel a light throb of pain, but you're okay."))
		add_mood_event("pain", /datum/mood_event/pain/negligible)
		return


/datum/mood_event/pain
	description = "I'm in quite a bit of pain!"
	mood_change = -4

/datum/mood_event/pain/negligible
	description = "I'm in a tiny bit of pain, but nothing I haven't felt before."
	mood_change = -1

/datum/mood_event/pain/minor
	description = "I feel a dull pain, but it's not too bad."
	mood_change = -2

/datum/mood_event/pain/severe
	description = "Everything hurts horribly..."
	mood_change = -8

/datum/mood_event/pain/mortis
	description = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA FUCK"
	mood_change = -20


// And now: numbers pulled out of my ass
/datum/reagent
	var/pain_reduction = 0

/datum/reagent/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(pain_reduction)
		M.take_pain(-pain_reduction)

/datum/reagent/medicine/morphine
	pain_reduction = 10

/datum/reagent/determination
	pain_reduction = 7.5

/datum/reagent/medicine/mine_salve
	pain_reduction = 15

/datum/reagent/consumable/ethanol
	pain_reduction = 2.5

/datum/reagent/consumable/ethanol/painkiller
	pain_reduction = 7.5

/datum/reagent/medicine/granibitaluri
	pain_reduction = 2.5

/datum/reagent/drug/opium
	pain_reduction = 3

/datum/reagent/drug/opium/heroin
	pain_reduction = 5

/datum/reagent/drug/cocaine
	pain_reduction = 8

/datum/reagent/drug/pcp
	pain_reduction = 25

#undef PHYSICAL_HARM
#undef BREATH_HARM

