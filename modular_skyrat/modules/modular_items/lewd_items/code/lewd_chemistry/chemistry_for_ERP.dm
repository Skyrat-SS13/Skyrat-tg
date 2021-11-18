// The base ERP chem. It handles pref and human type checks for you, so ALL chems relating to ERP should be subtypes of this.
/datum/reagent/drug/aphrodisiac
	name = "liquid ERP"
	description = "ERP in its liquified form. Complain to a coder."

	/// What preference you need enabled for effects on life
	var/life_pref_datum = /datum/preference/toggle/erp
	/// What preference you need enabled for effects on overdose
	var/overdose_pref_datum = /datum/preference/toggle/erp

/// Runs on life after preference checks. Use this instead of on_mob_life
/datum/reagent/drug/aphrodisiac/proc/life_effects(mob/living/carbon/human/exposed_mob)
	return

/// Runs on OD process after preference checks. Use this instead of overdose_process
/datum/reagent/drug/aphrodisiac/proc/overdose_effects(mob/living/carbon/human/exposed_mob)
	return

/datum/reagent/drug/aphrodisiac/on_mob_life(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(life_pref_datum && exposed_mob.client?.prefs.read_preference(life_pref_datum) && ishuman(exposed_mob))
		life_effects(exposed_mob)

/datum/reagent/drug/aphrodisiac/overdose_process(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(overdose_pref_datum && exposed_mob.client?.prefs.read_preference(overdose_pref_datum) && ishuman(exposed_mob))
		overdose_effects(exposed_mob)

//////////////////
///APHRODISIACS///
//////////////////

//Crocin. Basic aphrodisiac with no consequences
/datum/reagent/drug/aphrodisiac/crocin
	name = "crocin"
	description = "Naturally found in the crocus and gardenia flowers, this drug acts as a natural and safe aphrodisiac."
	taste_description = "strawberries"
	color = "#FFADFF"
	life_pref_datum = /datum/preference/toggle/erp/aphro

	//Probabilities of flavour messages, as a %, run on mob life
	var/emote_probability = 3
	var/thought_probability = 2

	//The possible contents of those flavour messages
	var/list/possible_aroused_emotes = list("moan", "blush")
	var/list/possible_aroused_thoughts = list("You feel frisky.", "You're having trouble suppressing your urges.", "You feel in the mood.")

	var/arousal_adjust_amount = 1
	var/pleasure_adjust_amount = 0
	var/pain_adjust_amount = 0

/datum/reagent/drug/aphrodisiac/crocin/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()

	if(prob(emote_probability))
		exposed_mob.emote(pick(possible_aroused_emotes))
	if(prob(thought_probability))
		var/displayed_thought = pick(possible_aroused_thoughts)
		to_chat(exposed_mob, span_notice("[displayed_thought]"))

	exposed_mob.adjustArousal(arousal_adjust_amount)
	exposed_mob.adjustPleasure(pleasure_adjust_amount)
	exposed_mob.adjustPain(pain_adjust_amount)

	for(var/obj/item/organ/genital/mob_genitals in exposed_mob.internal_organs)
		if(!mob_genitals.aroused == AROUSAL_CANT)
			mob_genitals.aroused = AROUSAL_FULL
			mob_genitals.update_sprite_suffix()
	exposed_mob.update_body()

//Hexacrocin. Advanced aphrodisiac that can cause brain traumas.
/datum/reagent/drug/aphrodisiac/crocin/hexacrocin
	name = "hexacrocin"
	description = "Chemically condensed form of basic crocin. This aphrodisiac is extremely powerful and addictive for most animals.\
					Addiction withdrawals can cause brain damage and shortness of breath. Overdose can lead to brain traumas."
	taste_description = "liquid desire"
	color = "#FF2BFF"
	overdose_threshold = 25
	overdose_pref_datum = /datum/preference/toggle/erp/bimbofication

	emote_probability = 5
	thought_probability = 5
	arousal_adjust_amount = 2
	pleasure_adjust_amount = 1.5
	pain_adjust_amount = 0.2
	possible_aroused_thoughts = list("You feel a bit hot.", "You feel strong sexual urges.", "You feel in the mood.", "You're ready to go down on someone.")
	var/list/extreme_aroused_thoughts = list("You need to fuck someone!", "You're bursting with sexual tension!", "You can't get sex off your mind!")

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(prob(thought_probability) && current_cycle > 25)
		var/displayed_extreme_thought = pick(extreme_aroused_thoughts)
		to_chat(exposed_mob, span_purple("[displayed_extreme_thought]"))

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/overdose_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(HAS_TRAIT(exposed_mob, TRAIT_BIMBO) || HAS_TRAIT(exposed_mob, TRAIT_SOBSESSED))
		return ..()

	if(prob(5))
		to_chat(exposed_mob, span_purple("Your libido is going haywire! Speaking gets much harder..."))
		exposed_mob.gain_trauma(/datum/brain_trauma/special/bimbo, TRAUMA_RESILIENCE_BASIC)
		ADD_TRAIT(exposed_mob, TRAIT_BIMBO, LEWDCHEM_TRAIT)


//Dopamine. Generates in character after orgasm.
/datum/reagent/drug/aphrodisiac/dopamine
	name = "dopamine"
	description = "Pure happiness"
	taste_description = "an indescribable, slightly sour taste. Something in it relaxes you, filling you with pleasure."
	color = "#97ffee"
	glass_name = "dopamine"
	glass_desc = "Delicious flavored reagent. You feel happy even looking at it."
	reagent_state = LIQUID
	overdose_threshold = 10
	life_pref_datum = /datum/preference/toggle/erp/aphro
	overdose_pref_datum = /datum/preference/toggle/erp/aphro

/datum/reagent/drug/aphrodisiac/dopamine/on_mob_add(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		return ..()
	SEND_SIGNAL(exposed_mob, COMSIG_ADD_MOOD_EVENT, "[type]_start", /datum/mood_event/orgasm, name)
	..()

/datum/reagent/drug/aphrodisiac/dopamine/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	exposed_mob.set_drugginess(5)
	if(prob(7))
		exposed_mob.emote(pick("twitch","drool","moan","giggle","shaking"))

/datum/reagent/drug/aphrodisiac/dopamine/overdose_start(mob/living/carbon/human/exposed_mob)
	. = ..()
	to_chat(exposed_mob, span_purple("You feel so happy!"))
	SEND_SIGNAL(exposed_mob, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overgasm, name)

/datum/reagent/drug/aphrodisiac/dopamine/overdose_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(!(exposed_mob.hallucination < volume && prob(20)))
		return ..()
	exposed_mob.adjustArousal(0.5)
	exposed_mob.adjustPleasure(0.3)
	exposed_mob.adjustPain(-0.5)
	if(prob(2))
		exposed_mob.emote(pick("moan","twitch_s"))

////////////////////
///ANAPHRODISIACS///
////////////////////

//Camphor. Used to reduce libido.
/datum/reagent/drug/aphrodisiac/camphor
	name = "Camphor"
	description = "Naturally found in some species of evergreen trees, camphor is a waxy substance. When ingested by most animals it acts as an anaphrodisiac, \
					reducing libido and calming them. Non-habit forming and non-addictive."
	taste_description = "dull bitterness"
	taste_mult = 2
	color = "#D9D9D9"//rgb(157, 157, 157)
	reagent_state = SOLID
	life_pref_datum = /datum/preference/toggle/erp/aphro

	//amount to reduce arousal by
	var/arousal_change = -12
	//amount to reduce pleasure by
	var/pleasure_change = -3

/datum/reagent/drug/aphrodisiac/camphor/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	var/old_arousal = exposed_mob.arousal
	exposed_mob.adjustArousal(arousal_change)
	exposed_mob.adjustPleasure(pleasure_change)
	if(exposed_mob.arousal <= 0 && old_arousal > 0)
		to_chat(exposed_mob, span_notice("You no longer feel aroused."))

//Pentacamphor. Used to purge crocin and hexacrocin. Can permanently disable arousal or cure bimbofication on overdose.
/datum/reagent/drug/aphrodisiac/camphor/pentacamphor
	name = "Pentacamphor"
	description = "Chemically condensed camphor. Causes an extreme reduction in libido and a permanent one if overdosed. Non-addictive."
	taste_description = "tranquil celibacy"
	color = "#D9D9D9"//rgb(255, 255, 255)
	reagent_state = SOLID
	overdose_threshold = 20
	arousal_change = -18
	overdose_pref_datum = /datum/preference/toggle/erp/aphro

/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/crocin))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/crocin, 20)
	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin, 20)

/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/overdose_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(!HAS_TRAIT(exposed_mob, TRAIT_BIMBO) && !HAS_TRAIT(exposed_mob, TRAIT_NEVERBONER))
		to_chat(exposed_mob, span_notice("You feel like you'll never feel aroused again..."))
		ADD_TRAIT(exposed_mob,TRAIT_NEVERBONER, LEWDCHEM_TRAIT)

	if(HAS_TRAIT(exposed_mob, TRAIT_BIMBO))
		if(prob(30))
			exposed_mob.cure_trauma_type(/datum/brain_trauma/special/bimbo, TRAUMA_RESILIENCE_BASIC)
			to_chat(exposed_mob, span_notice("Your mind is free. Your thoughts are pure and innocent once more."))
			REMOVE_TRAIT(exposed_mob, TRAIT_BIMBO, LEWDCHEM_TRAIT)

///////////////////////////////////
///GENITAL ENLARGEMENT CHEMICALS///
///////////////////////////////////

//Some global vars, you can make this stuff work more smart than i did.
/mob/living/carbon/human
	var/breast_enlarger_amount = 0

/mob/living/carbon/human
	var/penis_enlarger_amount = 0

////////////////////////////////////////////////////////////////////////////////////////////////////
//										BREAST ENLARGEMENT										  //
////////////////////////////////////////////////////////////////////////////////////////////////////

//Normal function increases your breast size by 0.05, 10units = 1 cup.
//If you get stupid big, it presses against your clothes, causing brute and oxydamage. Then rips them off.
//If you keep going, it makes you slower, in speed and action.
//decreasing your size will return you to normal.
//(see the status effect in chem.dm)
//Overdosing on (what is essentially space estrogen) makes you female, removes balls and shrinks your dick.
//Credit to Citadel for the original code before modification

/datum/reagent/drug/aphrodisiac/breast_enlarger
	name = "succubus milk"
	description = "A volatile collodial mixture derived from milk that encourages mammary production via a potent estrogen mix."
	color = "#E60584" // rgb: 96, 0, 255
	taste_description = "a milky ice cream like flavour."
	overdose_threshold = 20
	metabolization_rate = 0.25
	life_pref_datum = /datum/preference/toggle/erp/breast_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp/gender_change

/datum/reagent/drug/aphrodisiac/breast_enlarger/life_effects(mob/living/carbon/human/exposed_mob) //Increases breast size
	. = ..()

	var/obj/item/organ/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
	exposed_mob.breast_enlarger_amount += 5
	if(exposed_mob.breast_enlarger_amount >= 100)
		if(mob_breasts?.genital_size > 16)
			return
		mob_breasts.genital_size += 1
		mob_breasts.update_sprite_suffix()
		exposed_mob.update_body()
		exposed_mob.breast_enlarger_amount = 0

	if(ISINRANGE_EX(mob_breasts?.genital_size, 14, 16) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target = exposed_mob.get_bodypart(BODY_ZONE_CHEST)
		if(prob(20))
			to_chat(exposed_mob, span_danger("Your breasts begin to strain against your clothes!"))
			exposed_mob.adjustOxyLoss(5, 0)
			exposed_mob.apply_damage(1, BRUTE, target)

/datum/reagent/drug/aphrodisiac/breast_enlarger/overdose_effects(mob/living/carbon/human/exposed_mob) //Turns you into a female if character is male. Also supposed to add breasts but i'm too dumb to figure out how to make it work
	. = ..()

	var/obj/item/organ/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/mob_testicles = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)
	if(exposed_mob.gender == MALE)
		exposed_mob.set_gender(FEMALE)
		exposed_mob.body_type = exposed_mob.gender
		exposed_mob.update_body()
		exposed_mob.update_mutations_overlay()

	if(mob_penis.genital_size > 2 && mob_penis.girth > 2)
		mob_penis.genital_size -= 2
		mob_penis.girth -= 2

	mob_testicles.genital_size = 1

////////////////////////////////////////////////////////////////////////////////////////////////////
//										PENIS ENLARGE											  //
////////////////////////////////////////////////////////////////////////////////////////////////////

//See breast explanation, it's the same but with taliwhackers
//instead of slower movement and attacks, it slows you and increases the total blood you need in your system.
//Since someone else made this in the time it took me to PR it, I merged them.

/datum/reagent/drug/aphrodisiac/penis_enlarger
	name = "Incubus draft"
	description = "A volatile collodial mixture derived from various masculine solutions that encourages a larger gentleman's package via a potent testosterone mix."
	color = "#888888"
	taste_description = "chinese dragon powder"
	overdose_threshold = 17 //ODing makes you male and removes female genitals
	metabolization_rate = 0.5
	life_pref_datum = /datum/preference/toggle/erp/penis_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp/gender_change

/datum/reagent/drug/aphrodisiac/penis_enlarger/life_effects(mob/living/carbon/human/exposed_mob) //Increases penis size, 5u = +1 inch.
	. = ..()

	var/obj/item/organ/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
	exposed_mob.penis_enlarger_amount += 5
	if(exposed_mob.penis_enlarger_amount >= 100)
		if(mob_penis?.genital_size > 20)
			return ..()
		mob_penis.genital_size += 1
		if(prob(20) && mob_penis.girth < 20)
			mob_penis.girth +=1
		mob_penis.update_sprite_suffix()
		exposed_mob.update_body()
		exposed_mob.penis_enlarger_amount = 0

	if(ISINRANGE_EX(mob_penis?.genital_size, 18, 20) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target = exposed_mob.get_bodypart(BODY_ZONE_PRECISE_GROIN)
		if(prob(20))
			to_chat(exposed_mob, span_danger("You feel a tightness in your pants!"))
			exposed_mob.apply_damage(1, BRUTE, target)

	return ..()

/datum/reagent/drug/aphrodisiac/penis_enlarger/overdose_effects(mob/living/carbon/human/exposed_mob) //Turns you into a male if female and ODing, doesn't touch nonbinary and object genders.
	. = ..()

	var/obj/item/organ/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
	if(exposed_mob.gender == FEMALE)
		exposed_mob.set_gender(MALE)
		exposed_mob.body_type = exposed_mob.gender
		exposed_mob.update_body()
		exposed_mob.update_mutations_overlay()

	if(mob_breasts.genital_size > 2)
		mob_breasts.genital_size -=2

////////////////////////
///CHEMICAL REACTIONS///
////////////////////////

/datum/chemical_reaction/crocin
	results = list(/datum/reagent/drug/aphrodisiac/crocin = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/water = 1)
	required_temp = 400
	mix_message = "The mixture boils off a pink vapor..."

/datum/chemical_reaction/hexacrocin
	results = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 6, /datum/reagent/phenol = 1)
	required_temp = 600
	mix_message = "The mixture rapidly condenses and darkens in color..."

/datum/chemical_reaction/camphor
	results = list(/datum/reagent/drug/aphrodisiac/camphor = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/sulfur = 1)
	required_temp = 400
	mix_message = "The mixture boils off a yellow, smelly vapor..."

/datum/chemical_reaction/pentacamphor
	results = list(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac/camphor = 5, /datum/reagent/acetone = 1)
	required_temp = 500
	mix_message = "The mixture thickens and heats up slighty..."

/datum/chemical_reaction/cum
	results = list(/datum/reagent/consumable/cum = 5)
	required_reagents = list(/datum/reagent/blood = 2, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/salt = 1)
	mix_message = "The mixture turns into a gooey, musky white liquid..."

/datum/chemical_reaction/breast_enlarger
	results = list(/datum/reagent/drug/aphrodisiac/breast_enlarger = 8)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/silicon = 3, /datum/reagent/drug/aphrodisiac/crocin = 3)
	mix_message = "the reaction gives off a mist of milk."

/datum/chemical_reaction/penis_enlarger
	results = list(/datum/reagent/drug/aphrodisiac/penis_enlarger = 8)
	required_reagents = list(/datum/reagent/blood = 5, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/carbon = 2, /datum/reagent/drug/aphrodisiac/crocin = 2, /datum/reagent/medicine/salglu_solution = 1)
	mix_message = "the reaction gives off a mist of milk."

///////////////////////////
///	PREMADE CONTAINERS	///
///////////////////////////

// BOTTLES

/obj/item/reagent_containers/glass/bottle/crocin
	name = "crocin bottle"
	desc = "A bottle of mild aphrodisiac. Increases libido."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 30)

/obj/item/reagent_containers/glass/bottle/hexacrocin
	name = "hexacrocin bottle"
	desc = "A bottle of strong aphrodisiac. Increases libido. Potentially  dangerous."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 30)

/obj/item/reagent_containers/glass/bottle/dopamine
	name = "dopamine bottle"
	desc = "Pure pleasure and happines in a bottle."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/dopamine = 30)

/obj/item/reagent_containers/glass/bottle/camphor
	name = "camphor bottle"
	desc = "A bottle of mild anaphrodisiac. Reduces libido."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor = 30)

/obj/item/reagent_containers/glass/bottle/pentacamphor
	name = "pentacamphor bottle"
	desc = "A bottle of strong anaphrodisiac. Reduces libido."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor = 30)

/obj/item/reagent_containers/glass/bottle/breast_enlarger
	name = "succubus milk bottle"
	desc = "A bottle of strong breast enlargement reagent."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/breast_enlarger = 30)

/obj/item/reagent_containers/glass/bottle/penis_enlarger
	name = "incubus draft bottle"
	desc = "A bottle of strong penis enlargement reagent."
	list_reagents = list(/datum/reagent/drug/aphrodisiac/penis_enlarger = 30)


// PILLS

/obj/item/reagent_containers/pill/crocin
	name = "crocin pill (10u)"
	desc = "I've fallen, and I can't get it up!"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "crocin"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 10)

/obj/item/reagent_containers/pill/hexacrocin
	name = "hexacrocin pill (10u)"
	desc = "Pill in creepy heart form."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "hexacrocin"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = 10)

/obj/item/reagent_containers/pill/dopamine
	name = "dopamine pill (5u)"
	desc = "Feelings of orgasm, contained in a pill... Weird."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "dopamine"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/dopamine = 5)

/obj/item/reagent_containers/pill/camphor
	name = "camphor pill (10u)"
	desc = "For the early bird."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "camphor"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor = 10)

/obj/item/reagent_containers/pill/pentacamphor
	name = "pentacamphor pill (10u)"
	desc = "The chemical equivalent of horny jail."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_pills.dmi'
	icon_state = "pentacamphor"
	list_reagents = list(/datum/reagent/drug/aphrodisiac/camphor/pentacamphor = 10)
