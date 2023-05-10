/*
* PENIS ENLARGEMENT
* Normal function increases the player's penis size.
* If the player's penis is near or at the maximum size and they're wearing clothing, it presses against the player's clothes and causes brute damage.
* If gender change preference is enabled: Overdosing makes you male if female, makes the player grow a cock, and shrinks the player's breasts to a minimum size.
* If the gender change preference is not enabled: Overdosing will just make you grow a cock if you don't have one.
*/

/datum/reagent/drug/aphrodisiac/incubus_draft
	name = "incubus draft"
	description = "A volatile collodial mixture derived from various masculine solutions that encourages a larger gentleman's package via a potent testosterone mix."
	color = "#888888"
	taste_description = "chinese dragon powder"
	overdose_threshold = 20 // ODing makes you male and shrinks female genitals if gender change prefs are enabled. Otherwise, grows a cock.
	metabolization_rate = 0.25
	life_pref_datum = /datum/preference/toggle/erp/penis_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp

	/// Words for the cock when huge.
	var/static/list/words_for_bigger_cock = list(
		"huge",
		"massive",
		"gigantic",
		"rather lengthy",
		"colossal",
		"hefty",
	)
	/// Synonyms for cock.
	var/static/list/cock_text_list = list(
		"cock",
		"penis",
		"dick",
		"member",
		"richard",
		"johnston",
		"johnson",
	)
	/// Synonyms for bigger cock.
	var/static/list/bigger_cock_text_list = list(
		"rod",
		"shaft",
		"cock",
		"penis",
		"dick",
		"member",
		"richard",
		"johnston",
		"johnson",
	)
	/// Wording chosen to extend the cock, shown only to the mob.
	var/static/list/cock_action_text_list = list(
		"extends to ",
		"grows out to ",
		"begins to enlarge, growing to ",
		"suddenly expands to ",
		"lengthens out to ",
	)
	/// Wording chosen to be seen by other mobs, while mob is unclothed.
	var/static/list/public_cock_action_text_list = list(
		"expands by an inch or so.",
		"appears to grow a bit longer.",
		"seems a bit bigger than it was before.",
		"suddenly lengthens about an inch or two.",
	)
	/// Wording chosen to grow the balls, shown only to the mob.
	var/static/list/ball_action_text_list = list(
		"begin to swell",
		"feel heavier all of a sudden",
		"throb as they increase in size",
		"begin to pulse, feeling larger than they were before",
	)

/datum/reagent/drug/aphrodisiac/incubus_draft/life_effects(mob/living/carbon/human/exposed_mob)
	// Attempt to grow penis
	grow_penis(exposed_mob)

	return ..()

/datum/reagent/drug/aphrodisiac/incubus_draft/overdose_effects(mob/living/carbon/human/exposed_mob)
	// Check if overdosing on incubus draft and succubus milk simultaneously, to prevent chat spam
	var/suppress_chat = FALSE
	var/datum/reagent/drug/aphrodisiac/succubus_milk/succubus_milk = locate(/datum/reagent/drug/aphrodisiac/succubus_milk) in exposed_mob.reagents.reagent_list
	if(succubus_milk && succubus_milk.overdosed)
		suppress_chat = TRUE

	// Do prefs allow penis enlargement?
	if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/penis_enlargement))
		// Attempt to make new male genitals if applicable
		create_genitals(exposed_mob, suppress_chat, list(GENITAL_PENIS, GENITAL_TESTICLES))
				
		// Make the balls bigger if they're small.
		grow_balls(exposed_mob, suppress_chat)
	
	// Separates gender change stuff from cock growth, breast shrinkage, and female genitalia removal
	change_gender(exposed_mob, MALE, suppress_chat)
		
	// Attempt genital shrinkage where applicable
	shrink_genitals(exposed_mob, suppress_chat, list(GENITAL_BREASTS, GENITAL_VAGINA, GENITAL_WOMB))

/**
* Helper function used to display the messages that appear in chat while the growth is occurring
*
* exposed_mob - the mob being affected by the reagent
* genital - the genital that is causing the messages
*/ 
/datum/reagent/drug/aphrodisiac/incubus_draft/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/mob_genital, suppress_chat = FALSE)
	if(!mob_genital)
		return
	
	if(istype(mob_genital, /obj/item/organ/external/genital/penis))
		penis_growth_to_chat(exposed_mob, mob_genital)
	else if(istype(mob_genital, /obj/item/organ/external/genital/testicles))
		testicles_growth_to_chat(exposed_mob, mob_genital, suppress_chat)

/**
* Helper function for the helper function used to display the messages that appear in chat while the growth is occurring
*
* exposed_mob - the mob being affected by the reagent
* mob_penis - the penis that is causing the message
* NOTE: this function doesn't get called often enough to warrant suppressing chat, hence the var's omission
*/ 
/datum/reagent/drug/aphrodisiac/incubus_draft/proc/penis_growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/penis/mob_penis)

	if(!mob_penis)
		return
		
	if(mob_penis.visibility_preference == GENITAL_ALWAYS_SHOW || exposed_mob.is_bottomless())
		if(mob_penis.genital_size >= (penis_max_length - 2))
			if(exposed_mob.dna.features["penis_sheath"] == SHEATH_SLIT)
				if(mob_penis.aroused != AROUSAL_FULL)
					to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
			exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(public_cock_action_text_list)]"))
			to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
		else
			if(exposed_mob.dna.features["penis_sheath"] == SHEATH_SLIT)
				if(mob_penis.aroused != AROUSAL_FULL)
					to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
			exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(cock_text_list)] [pick(public_cock_action_text_list)]"))
			to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
	else
		if(mob_penis.genital_size >= (penis_max_length - 2))
			to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
		else
			to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
			
/**
* Helper function for the helper function used to display the messages that appear in chat while the testicles growth is occurring
*
* exposed_mob - the mob being affected by the reagent
* mob_testicles - the testicles that are causing the message
*/ 
/datum/reagent/drug/aphrodisiac/incubus_draft/proc/testicles_growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/testicles/mob_testicles, suppress_chat = FALSE)

	// So we don't spam chat
	if(suppress_chat)
		return

	if(!mob_testicles)
		return
	
	// Display a different message when they reach 'enormous'
	if(mob_testicles.genital_size <= balls_big_size) 
		to_chat(exposed_mob, span_purple("Your balls [pick(ball_action_text_list)]. They are now [mob_testicles.balls_size_to_description(mob_testicles.genital_size)]."))	
	else if(mob_testicles.genital_size == balls_max_size)
		to_chat(exposed_mob, span_purple("You can feel your heavy balls churn as they swell to enormous proportions!"))		
			
// Notify the user that they're overdosing. Doesn't affect their mood.
/datum/reagent/drug/aphrodisiac/incubus_draft/overdose_start(mob/living/carbon/human/exposed_mob)
	to_chat(exposed_mob, span_userdanger("You feel like you took too much [name]!"))
	exposed_mob.add_mood_event("[type]_overdose", /datum/mood_event/minor_overdose, name)

/datum/chemical_reaction/incubus_draft
	results = list(/datum/reagent/drug/aphrodisiac/incubus_draft = 8)
	required_reagents = list(/datum/reagent/blood = 5, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/carbon = 2, /datum/reagent/drug/aphrodisiac/crocin = 2, /datum/reagent/medicine/salglu_solution = 1)
	mix_message = "the reaction gives off a spicy mist."
	erp_reaction = TRUE
