// Dopamine. Generates in character after orgasm.
/datum/reagent/drug/aphrodisiac/dopamine
	name = "dopamine...?"
	description = "Pure happiness"
	taste_description = "an indescribable, slightly sour taste. Something in it relaxes you, filling you with pleasure."
	color = "#97ffee"
	reagent_state = LIQUID
	overdose_threshold = 10
	life_pref_datum = /datum/preference/toggle/erp/aphro
	overdose_pref_datum = /datum/preference/toggle/erp/aphro
	arousal_adjust_amount = 0.5
	pleasure_adjust_amount = 0.3
	pain_adjust_amount = -0.5

	/// How druggy the chem will make the mob
	var/drugginess_amount = 5 SECONDS
	/// How likely the drug is to make the mob druggy per life process
	var/drugginess_chance = 7

/datum/glass_style/drinking_glass/dopamine
	required_drink_type = /datum/reagent/drug/aphrodisiac/dopamine
	name = "dopamine"
	desc = "Delicious flavored reagent. You feel happy even looking at it."

/datum/reagent/drug/aphrodisiac/dopamine/on_mob_add(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		return ..()
	exposed_mob.add_mood_event("[type]_start", /datum/mood_event/orgasm, 1, name)
	return ..()

/datum/reagent/drug/aphrodisiac/dopamine/life_effects(mob/living/carbon/human/exposed_mob)
	exposed_mob.set_drugginess(drugginess_amount)
	if(prob(drugginess_chance))
		exposed_mob.emote(pick("twitch", "drool", "moan", "giggle", "shaking"))

/datum/reagent/drug/aphrodisiac/dopamine/overdose_start(mob/living/carbon/human/exposed_mob)
	. = ..()
	to_chat(exposed_mob, span_purple("You feel so happy!"))
	exposed_mob.add_mood_event("[type]_overdose", /datum/mood_event/overgasm, 1, name)

/datum/reagent/drug/aphrodisiac/dopamine/overdose_effects(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.get_timed_status_effect_duration(/datum/status_effect/hallucination) / (2 SECONDS) < volume && prob(20)))
		return ..()
	exposed_mob.adjust_arousal(arousal_adjust_amount)
	exposed_mob.adjust_pleasure(pleasure_adjust_amount)
	exposed_mob.adjust_pain(pain_adjust_amount)
	if(prob(2))
		exposed_mob.emote(pick("moan", "twitch_s"))

// This chem shouldn't affect user's mood negatively.
/datum/reagent/drug/aphrodisiac/dopamine/overdose_process(mob/living/carbon/human/exposed_mob)
	return
