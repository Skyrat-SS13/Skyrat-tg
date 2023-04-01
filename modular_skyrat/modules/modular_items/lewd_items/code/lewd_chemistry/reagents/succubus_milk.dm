/*
* BREAST ENLARGEMENT
* Normal function increases the player's breast size.
* If the player's breasts are near or at the maximum size and they're wearing clothing, they press against the player's clothes and causes brute and oxygen damage.
* If gender change preference is enabled: Overdosing makes you female if male, makes the player grow breasts, sets the player's testicles to the minimum size, and shrinks the player's penis to a minimum size.
* If the gender change preference is not enabled: Overdosing will just make you grow breasts if you don't have any.
* Credit to Citadel for the original code before modification
*/

/datum/reagent/drug/aphrodisiac/succubus_milk
	name = "succubus milk"
	description = "A volatile collodial mixture derived from milk that encourages mammary production via a potent estrogen mix."
	color = "#E60584"
	taste_description = "a milky ice cream like flavour"
	overdose_threshold = 20
	metabolization_rate = 0.25
	life_pref_datum = /datum/preference/toggle/erp/breast_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp

	/// Words for the breasts when huge.
	var/static/list/words_for_bigger = list(
		"huge",
		"massive",
		"squishy",
		"gigantic",
		"rather large",
		"jiggly",
		"hefty",
	)
	/// Synonyms for breasts.
	var/static/list/boob_text_list = list(
		"boobs",
		"tits",
		"breasts",
	)
	/// Synonyms for the chest.
	var/static/list/covered_boobs_list = list(
		"bust",
		"chest",
		"bosom",
	)
	/// Synonyms for bigger breasts.
	var/static/list/bigger_boob_text_list = list(
		"jigglies",
		"melons",
		"jugs",
		"boobies",
		"milkers",
		"boobs",
		"tits",
		"breasts",
	)
	/// Wording chosen to expand the breasts,shown only to the mob.
	var/static/list/action_text_list = list(
		"expand outward to ",
		"grow out to ",
		"begin to enlarge, growing to ",
		"suddenly expand to ",
		"swell out to ",
	)
	/// Wording chosen to be seen by other mobs, regardless of whether mob is clothed/unclothed.
	var/static/list/public_bigger_action_text_list = list(
		"expand and jiggle outward.",
		"grow a bit larger, bouncing about.",
		"seem a bit bigger than they were before.",
		"bounce and jiggle as they suddenly expand.",
	)
	/// Wording chosen to be seen by other mobs, while mob is unclothed.
	var/static/list/public_action_text_list = list(
		"expand outward.",
		"seem to grow a bit larger.",
		"appear a bit bigger than they were before.",
		"bounce and jiggle as they suddenly expand.",
	)
	/// Wording chosen to be seen by other mobs, while mob is clothed.
	var/static/list/notice_boobs = list(
		"seems to be a bit tighter.",
		"appears to be a bit bigger.",
		"seems to swell outward a bit.",
	)

/datum/reagent/drug/aphrodisiac/succubus_milk/life_effects(mob/living/carbon/human/exposed_mob) //Increases breast size
	// Attempt to grow breasts!
	grow_breasts(exposed_mob)

// Turns you into a female if character is male. Also adds breasts and female genitalia.
/datum/reagent/drug/aphrodisiac/succubus_milk/overdose_effects(mob/living/carbon/human/exposed_mob)

	// Check if overdosing on succubus milk and incubus draft simultaneously, to prevent chat spam
	var/suppress_chat = FALSE
	var/datum/reagent/drug/aphrodisiac/incubus_draft/incubus_draft = locate(/datum/reagent/drug/aphrodisiac/incubus_draft) in exposed_mob.reagents.reagent_list
	if(incubus_draft && incubus_draft.overdosed)
		suppress_chat = TRUE

	// Begin breast growth if prefs allow it
	if(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/breast_enlargement))
		create_genitals(exposed_mob, suppress_chat, list(GENITAL_BREASTS))

	// Separates gender change stuff from breast growth and shrinkage, as well as from new genitalia growth/removal
	change_gender(exposed_mob, FEMALE, suppress_chat)

	// Womb and vagina creation
	create_genitals(exposed_mob, suppress_chat, list(GENITAL_VAGINA, GENITAL_WOMB))

	// Cock & ball shrinkage
	shrink_genitals(exposed_mob, suppress_chat, list(GENITAL_PENIS, GENITAL_TESTICLES))

/**
* Helper function used to display the messages that appear in chat while the growth is occurring
*
* exposed_mob - the mob being affected by the reagent
* genital - the genital that is causing the messages
* suppress_chat - whether or not to display a message in chat
* NOTE: this function doesn't get called often enough to warrant suppressing chat, hence the var's omission
*/
/datum/reagent/drug/aphrodisiac/succubus_milk/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob?.get_organ_slot(ORGAN_SLOT_BREASTS))

	if(!mob_breasts)
		return

	// Checks for cup size.
	var/translation = mob_breasts.breasts_size_to_cup(mob_breasts.genital_size)

	if(mob_breasts.visibility_preference == GENITAL_ALWAYS_SHOW || exposed_mob.is_topless())
		switch(translation)
			if(BREAST_SIZE_FLATCHESTED)
				return
			if(BREAST_SIZE_BEYOND_MEASUREMENT)
				exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(words_for_bigger)] [pick(bigger_boob_text_list)] [pick(public_bigger_action_text_list)]"))
				to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger)] [pick(bigger_boob_text_list)] [pick(action_text_list)]about [mob_breasts.genital_size] inches in diameter."))
			else
				if(mob_breasts?.genital_size >= (max_breast_size - 2))
					exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(words_for_bigger)] [pick(bigger_boob_text_list)] [pick(public_bigger_action_text_list)]"))
					to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger)] [pick(bigger_boob_text_list)] [pick(action_text_list)]about [translation]-cups."))
				else
					exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(boob_text_list)] [pick(public_action_text_list)]"))
					to_chat(exposed_mob, span_purple("Your [pick(boob_text_list)] [pick(action_text_list)]about [translation]-cups."))
	else
		switch(translation)
			if(BREAST_SIZE_FLATCHESTED)
				return

			if(BREAST_SIZE_BEYOND_MEASUREMENT)
				exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(boob_text_list)] [pick(public_bigger_action_text_list)]"))
				to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger)] [pick(bigger_boob_text_list)] [pick(action_text_list)]about [mob_breasts.genital_size] inches in diameter."))
			else
				if(mob_breasts?.genital_size >= (max_breast_size - 2))
					exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(boob_text_list)] [pick(public_bigger_action_text_list)]"))
					to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger)] [pick(bigger_boob_text_list)] [pick(action_text_list)]about [translation]-cups."))
				else
					exposed_mob.visible_message(span_notice("The area around [exposed_mob]'s [pick(covered_boobs_list)] [pick(notice_boobs)]"))
					to_chat(exposed_mob, span_purple("Your [pick(boob_text_list)] [pick(action_text_list)]about [translation]-cups."))

// Notify the user that they're overdosing. Doesn't affect their mood.
/datum/reagent/drug/aphrodisiac/succubus_milk/overdose_start(mob/living/carbon/human/exposed_mob)
	to_chat(exposed_mob, span_userdanger("You feel like you took too much [name]!"))
	exposed_mob.add_mood_event("[type]_overdose", /datum/mood_event/minor_overdose, name)

/datum/chemical_reaction/succubus_milk
	results = list(/datum/reagent/drug/aphrodisiac/succubus_milk = 8)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/silicon = 3, /datum/reagent/drug/aphrodisiac/crocin = 3)
	mix_message = "the reaction gives off a mist of milk."
	erp_reaction = TRUE
