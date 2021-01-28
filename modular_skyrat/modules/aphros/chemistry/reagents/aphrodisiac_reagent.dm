//quick and dirty aphrodisiacs for the new base

/datum/reagent/drug/aphrodisiac
	name = "Crocin"
	description = "Naturally found in the crocus and gardenia flowers, this drug acts as a natural and safe aphrodisiac."
	taste_description = "strawberries"
	color = "#FFADFF"//PINK, rgb(255, 173, 255)
	//can_synth = FALSE

/datum/reagent/drug/aphrodisiac/on_mob_life(mob/living/M)
	if(M && (M.client.prefs.skyrat_toggles & APHRO_PREF))
		if((prob(min(current_cycle/2,5))))
			M.emote(pick("moan","blush"))
		if(prob(min(current_cycle/4,10)))
			var/aroused_message = pick("You feel frisky.", "You're having trouble suppressing your urges.", "You feel in the mood.")
			to_chat(M, "<span class='notice'>[aroused_message]</span>")
		if(ishuman(M))
			for(var/obj/item/organ/genital/G)
				if(!G.aroused == AROUSAL_CANT)
					G.aroused = AROUSAL_FULL
					G.update_sprite_suffix()
			M.update_body()
	..()

/datum/reagent/drug/aphrodisiacplus
	name = "Hexacrocin"
	description = "Chemically condensed form of basic crocin. This aphrodisiac is extremely powerful and addictive in most animals.\
					Addiction withdrawals can cause brain damage and shortness of breath. Overdosage can lead to brain damage."
	taste_description = "liquid desire"
	color = "#FF2BFF"//dark pink
	addiction_threshold = 20
	overdose_threshold = 20
	//can_synth = FALSE

/datum/reagent/drug/aphrodisiacplus/on_mob_life(mob/living/M)
	if(M && (M.client.prefs.skyrat_toggles & APHRO_PREF))
		if(prob(5))
			if(prob(current_cycle))
				M.say(pick("Hnnnnngghh...", "Ohh...", "Mmnnn..."))
			else
				M.emote(pick("moan","blush"))
		if(prob(5))
			var/aroused_message
			if(current_cycle>25)
				aroused_message = pick("You need to fuck someone!", "You're bursting with sexual tension!", "You can't get sex off your mind!")
			else
				aroused_message = pick("You feel a bit hot.", "You feel strong sexual urges.", "You feel in the mood.", "You're ready to go down on someone.")
			to_chat(M, "<span class='notice'>[aroused_message]</span>")
			//REMOVE_TRAIT(M,TRAIT_NEVERBONER,APHRO_TRAIT)
		if(ishuman(M))
			for(var/obj/item/organ/genital/G)
				if(!G.aroused == AROUSAL_CANT)
					G.aroused = AROUSAL_FULL
					G.update_sprite_suffix()
			M.update_body()
	..()

/datum/reagent/drug/aphrodisiacplus/addiction_act_stage2(mob/living/M)
	if(prob(30))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	..()
/datum/reagent/drug/aphrodisiacplus/addiction_act_stage3(mob/living/M)
	if(prob(30))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3)

		..()
/datum/reagent/drug/aphrodisiacplus/addiction_act_stage4(mob/living/M)
	if(prob(30))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 4)
	..()

/datum/reagent/drug/aphrodisiacplus/overdose_process(mob/living/M)
	if(M && (M.client.prefs.skyrat_toggles & APHRO_PREF) && prob(33))
		if(prob(5) && ishuman(M)/* && M.has_dna() && some shit about bimbofication*/)
			to_chat(M, "<span class='notice'>Your libido is going haywire!</span>")
	..()
