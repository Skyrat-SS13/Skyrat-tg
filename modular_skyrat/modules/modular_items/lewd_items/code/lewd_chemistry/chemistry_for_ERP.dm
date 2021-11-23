// The base ERP chem. It handles pref and human type checks for you, so ALL chems relating to ERP should be subtypes of this.
/datum/reagent/drug/aphrodisiac
	name = "liquid ERP"
	description = "ERP in its liquified form. Complain to a coder."

	/// What preference you need enabled for effects on life
	var/life_pref_datum = /datum/preference/toggle/erp
	/// What preference you need enabled for effects on overdose
	var/overdose_pref_datum = /datum/preference/toggle/erp

	/// The amount to adjust the mob's arousal by
	var/arousal_adjust_amount = 1
	/// The amount to adjust the mob's pleasure by
	var/pleasure_adjust_amount = 0
	/// The amount to adjust the mob's pain by
	var/pain_adjust_amount = 0

	// Vars for enlargement chems from here on
	/// Counts up to a threshold before triggering enlargement effects
	var/enlargement_amount = 0
	/// How much to increase the count by each process
	var/enlarger_increase_step = 5
	/// Count to reach before effects
	var/enlargement_threshold = 100

	/// % chance for damage to be applied when the organ is too large and the mob is clothed
	var/damage_chance = 20

	/// Largest length the chem can make a mob's penis
	var/penis_max_length = PENIS_MAX_LENGTH
	/// Smallest size the chem can make a mob's penis
	var/penis_min_length = PENIS_MIN_LENGTH
	/// How much the penis is increased in size each time it's run
	var/penis_length_increase_step = 1
	/// How much the penis is increased in girth each time it's run
	var/penis_girth_increase_step = 1
	/// Largest girth the chem can make a mob's penis
	var/penis_max_girth = PENIS_MAX_GIRTH
	/// Smallest girth the chem can make a mob's penis
	var/penis_minimum_girth = 2
	/// How much to reduce the size of the penis each time it's run
	var/penis_size_reduction_step = 2
	/// How much to reduce the girth of the penis each time it's run
	var/penis_girth_reduction_step = 2

	/// Largest size the chem can make a mob's breasts
	var/max_breast_size = 16
	/// How much breasts are increased in size each time it's run
	var/breast_size_increase_step = 1
	/// Smallest size the chem can make a mob's breasts
	var/breast_minimum_size = 2
	/// How much to reduce the size of the breasts each time it's run
	var/breast_size_reduction_step = 1

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

/*
* APHRODISIACS
*/

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

	/// A list of possible to_chat messages the chem is able to trigger after enough cycles in the mobs system
	var/list/extreme_aroused_thoughts = list("You need to fuck someone!", "You're bursting with sexual tension!", "You can't get sex off your mind!")
	/// How many cycles the chem has to be in the mob's system before triggering extreme effects
	var/extreme_thought_threshold = 25

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(prob(thought_probability) && current_cycle >= extreme_thought_threshold)
		var/displayed_extreme_thought = pick(extreme_aroused_thoughts)
		to_chat(exposed_mob, span_purple("[displayed_extreme_thought]"))

/datum/reagent/drug/aphrodisiac/crocin/hexacrocin/overdose_effects(mob/living/carbon/human/exposed_mob)
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
	arousal_adjust_amount = 0.5
	pleasure_adjust_amount = 0.3
	pain_adjust_amount = -0.5

	/// How druggy the chem will make the mob
	var/drugginess_amount = 5
	/// How likely the drug is to make the mob druggy per life process
	var/drugginess_chance = 7

/datum/reagent/drug/aphrodisiac/dopamine/on_mob_add(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		return ..()
	SEND_SIGNAL(exposed_mob, COMSIG_ADD_MOOD_EVENT, "[type]_start", /datum/mood_event/orgasm, name)
	..()

/datum/reagent/drug/aphrodisiac/dopamine/life_effects(mob/living/carbon/human/exposed_mob)
	exposed_mob.set_drugginess(drugginess_amount)
	if(prob(drugginess_chance))
		exposed_mob.emote(pick("twitch","drool","moan","giggle","shaking"))

/datum/reagent/drug/aphrodisiac/dopamine/overdose_start(mob/living/carbon/human/exposed_mob)
	. = ..()
	to_chat(exposed_mob, span_purple("You feel so happy!"))
	SEND_SIGNAL(exposed_mob, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overgasm, name)

/datum/reagent/drug/aphrodisiac/dopamine/overdose_effects(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.hallucination < volume && prob(20)))
		return ..()
	exposed_mob.adjustArousal(arousal_adjust_amount)
	exposed_mob.adjustPleasure(pleasure_adjust_amount)
	exposed_mob.adjustPain(pain_adjust_amount)
	if(prob(2))
		exposed_mob.emote(pick("moan","twitch_s"))

/*
* ANAPHRODISIACS
*/

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
	arousal_adjust_amount = -12
	pleasure_adjust_amount = -3

/datum/reagent/drug/aphrodisiac/camphor/life_effects(mob/living/carbon/human/exposed_mob)
	var/old_arousal = exposed_mob.arousal
	exposed_mob.adjustArousal(arousal_adjust_amount)
	exposed_mob.adjustPleasure(pleasure_adjust_amount)
	if(exposed_mob.arousal <= 0 && old_arousal > 0)
		to_chat(exposed_mob, span_notice("You no longer feel aroused."))

// Pentacamphor. Used to purge crocin and hexacrocin. Can permanently disable arousal or cure bimbofication on overdose.
/datum/reagent/drug/aphrodisiac/camphor/pentacamphor
	name = "Pentacamphor"
	description = "Chemically condensed camphor. Causes an extreme reduction in libido and a permanent one if overdosed. Non-addictive."
	taste_description = "tranquil celibacy"
	color = "#D9D9D9"//rgb(255, 255, 255)
	reagent_state = SOLID
	overdose_threshold = 20
	arousal_adjust_amount = -18
	overdose_pref_datum = /datum/preference/toggle/erp/aphro

	/// How much of the given reagent to remove per operation
	var/reagent_reduction_amount = 20

/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/life_effects(mob/living/carbon/human/exposed_mob)
	. = ..()
	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/crocin))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/crocin, reagent_reduction_amount)
	if(exposed_mob.reagents.has_reagent(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin))
		exposed_mob.reagents.remove_reagent(/datum/reagent/drug/aphrodisiac/crocin/hexacrocin, reagent_reduction_amount)

/datum/reagent/drug/aphrodisiac/camphor/pentacamphor/overdose_effects(mob/living/carbon/human/exposed_mob)
	if(!HAS_TRAIT(exposed_mob, TRAIT_BIMBO) && !HAS_TRAIT(exposed_mob, TRAIT_NEVERBONER))
		to_chat(exposed_mob, span_notice("You feel like you'll never feel aroused again..."))
		ADD_TRAIT(exposed_mob,TRAIT_NEVERBONER, LEWDCHEM_TRAIT)

	if(HAS_TRAIT(exposed_mob, TRAIT_BIMBO))
		if(prob(30))
			exposed_mob.cure_trauma_type(/datum/brain_trauma/special/bimbo, TRAUMA_RESILIENCE_BASIC)
			to_chat(exposed_mob, span_notice("Your mind is free. Your thoughts are pure and innocent once more."))
			REMOVE_TRAIT(exposed_mob, TRAIT_BIMBO, LEWDCHEM_TRAIT)

/*
* GENITAL ENLARGEMENT CHEMICALS
*/

/*
* BREAST ENLARGEMENT
* Normal function increases the player's breast size.
* If the player's breasts are near or at the maximum size and they're wearing clothing, they press against the player's clothes and causes brute and oxygen damage.
* Overdosing makes you female if male, sets the player's testicles to the minimum size, and shrinks the player's penis to a minimum size.
* Credit to Citadel for the original code before modification
*/

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
	var/obj/item/organ/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
	enlargement_amount += enlarger_increase_step
	if(enlargement_amount >= enlargement_threshold)
		if(mob_breasts?.genital_size >= max_breast_size)
			return
		mob_breasts.genital_size += breast_size_increase_step
		mob_breasts.update_sprite_suffix()
		exposed_mob.update_body()
		enlargement_amount = 0

	if(ISINRANGE_EX(mob_breasts?.genital_size, (max_breast_size - 2), (max_breast_size)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target_bodypart = exposed_mob.get_bodypart(BODY_ZONE_CHEST)
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("Your breasts begin to strain against your clothes!"))
			exposed_mob.adjustOxyLoss(5, 0)
			exposed_mob.apply_damage(1, BRUTE, target_bodypart)

/datum/reagent/drug/aphrodisiac/breast_enlarger/overdose_effects(mob/living/carbon/human/exposed_mob) //Turns you into a female if character is male. Also supposed to add breasts but enlargement_amount'm too dumb to figure out how to make it work
	var/obj/item/organ/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/mob_testicles = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)
	if(exposed_mob.gender == MALE)
		exposed_mob.set_gender(FEMALE)
		exposed_mob.body_type = exposed_mob.gender
		exposed_mob.update_body()
		exposed_mob.update_mutations_overlay()

	if(mob_penis.genital_size > penis_min_length && mob_penis.girth > penis_minimum_girth)
		mob_penis.genital_size -= penis_size_reduction_step
		mob_penis.girth -= penis_girth_reduction_step

	mob_testicles.genital_size = 1

/*
* PENIS ENLARGEMENT
* Normal function increases the player's penis size.
* If the player's penis is near or at the maximum size and they're wearing clothing, it presses against the player's clothes and causes brute damage.
* Overdosing makes you male if female and shrinks the player's breasts to a minimum size.
*/

/datum/reagent/drug/aphrodisiac/penis_enlarger
	name = "Incubus draft"
	description = "A volatile collodial mixture derived from various masculine solutions that encourages a larger gentleman's package via a potent testosterone mix."
	color = "#888888"
	taste_description = "chinese dragon powder"
	overdose_threshold = 17 //ODing makes you male and removes female genitals
	metabolization_rate = 0.5
	life_pref_datum = /datum/preference/toggle/erp/penis_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp/gender_change

/datum/reagent/drug/aphrodisiac/penis_enlarger/life_effects(mob/living/carbon/human/exposed_mob)
	var/obj/item/organ/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
	enlargement_amount += enlarger_increase_step
	if(enlargement_amount >= enlargement_threshold)
		if(mob_penis?.genital_size >= penis_max_length || mob_penis?.girth >= penis_max_girth)
			return ..()
		mob_penis.genital_size += penis_length_increase_step
		if(prob(20))
			mob_penis.girth += penis_girth_increase_step
		mob_penis.update_sprite_suffix()
		exposed_mob.update_body()
		enlargement_amount = 0

	if(ISINRANGE_EX(mob_penis?.genital_size, (penis_max_length - 2), penis_max_length) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target_bodypart = exposed_mob.get_bodypart(BODY_ZONE_PRECISE_GROIN)
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("You feel a tightness in your pants!"))
			exposed_mob.apply_damage(1, BRUTE, target_bodypart)

	return ..()

/datum/reagent/drug/aphrodisiac/penis_enlarger/overdose_effects(mob/living/carbon/human/exposed_mob)
	var/obj/item/organ/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
	if(exposed_mob.gender == FEMALE)
		exposed_mob.set_gender(MALE)
		exposed_mob.body_type = exposed_mob.gender
		exposed_mob.update_body()
		exposed_mob.update_mutations_overlay()

	if(mob_breasts.genital_size > breast_minimum_size)
		mob_breasts.genital_size -= breast_size_reduction_step

/*
* CHEMICAL REACTIONS
*/

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

/*
* PREMADE CONTAINERS
*/

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
