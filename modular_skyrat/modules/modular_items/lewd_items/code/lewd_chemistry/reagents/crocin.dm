//Crocin. Basic aphrodisiac with no consequences
/datum/reagent/drug/aphrodisiac/crocin
	name = "crocin"
	description = "Naturally found in the crocus and gardenia flowers, this drug acts as a natural and safe aphrodisiac."
	taste_description = "strawberries"
	color = "#FFADFF"
	life_pref_datum = /datum/preference/toggle/erp/aphro
	arousal_adjust_amount = 1
	pleasure_adjust_amount = 0
	pain_adjust_amount = 0

	/// Probability of the chem triggering an emote, as a %, run on mob life
	var/emote_probability = 3
	/// Probability of the chem triggering a to_chat, as a %, run on mob life
	var/thought_probability = 2

	/// A list of possible emotes the chem is able to trigger
	var/list/possible_aroused_emotes = list("moan", "blush")

	/// A list of possible to_chat messages the chem is able to trigger
	var/list/possible_aroused_thoughts = list("You feel frisky.", "You're having trouble suppressing your urges.", "You feel in the mood.")


/datum/reagent/drug/aphrodisiac/crocin/life_effects(mob/living/carbon/human/exposed_mob)
	if(prob(emote_probability))
		exposed_mob.emote(pick(possible_aroused_emotes))
	if(prob(thought_probability))
		var/displayed_thought = pick(possible_aroused_thoughts)
		to_chat(exposed_mob, span_notice("[displayed_thought]"))

	exposed_mob.adjustArousal(arousal_adjust_amount)
	exposed_mob.adjustPleasure(pleasure_adjust_amount)
	exposed_mob.adjustPain(pain_adjust_amount)

	for(var/obj/item/organ/external/genital/mob_genitals in exposed_mob.external_organs)
		if(!mob_genitals.aroused == AROUSAL_CANT)
			mob_genitals.aroused = AROUSAL_FULL
			mob_genitals.update_sprite_suffix()
	exposed_mob.update_body()

/datum/chemical_reaction/crocin
	results = list(/datum/reagent/drug/aphrodisiac/crocin = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/water = 1)
	required_temp = 400
	mix_message = "The mixture boils off a pink vapor..."
