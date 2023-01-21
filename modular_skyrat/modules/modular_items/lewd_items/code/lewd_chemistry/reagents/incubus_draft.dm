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
	balls_max_size = TESTICLES_MAX_SIZE - 1

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
		create_genitals(exposed_mob, suppress_chat)
				
		// Make the balls bigger if they're small.
		grow_balls(exposed_mob, suppress_chat)
	
	// Separates gender change stuff from cock growth, breast shrinkage, and female genitalia removal
	change_gender(exposed_mob, suppress_chat)
		
	// Attempt genital shrinkage where applicable
	shrink_genitals(exposed_mob, suppress_chat)

// Handle gender change
/datum/reagent/drug/aphrodisiac/incubus_draft/change_gender(mob/living/carbon/human/exposed_mob, succubus_milk = FALSE) 

	// Check if prefs allow this
	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/gender_change))
		return
		
	if(succubus_milk)
		if(exposed_mob.gender != PLURAL)
			exposed_mob.set_gender(PLURAL)
			exposed_mob.physique = exposed_mob.gender
			update_appearance(exposed_mob, mutations_overlay = TRUE)

	else if(exposed_mob.gender != MALE)
		exposed_mob.set_gender(MALE)		
		exposed_mob.physique = exposed_mob.gender
		update_appearance(exposed_mob, mutations_overlay = TRUE)

// Handle genital shrinkage 
/datum/reagent/drug/aphrodisiac/incubus_draft/shrink_genitals(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE) 

	shrink_breasts(exposed_mob, suppress_chat)
	remove_genitals(exposed_mob, suppress_chat)

// Attempt vagina and womb removal
/datum/reagent/drug/aphrodisiac/incubus_draft/remove_genitals(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE) 		

	remove_vagina(exposed_mob, suppress_chat)
	remove_womb(exposed_mob, suppress_chat)

// Attempt new genital creation
/datum/reagent/drug/aphrodisiac/incubus_draft/create_genitals(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE) 
		
	create_penis(exposed_mob, suppress_chat)
	create_testicles(exposed_mob, suppress_chat)
	
// Helper function to display a growth message		
/datum/reagent/drug/aphrodisiac/incubus_draft/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/penis/mob_penis = exposed_mob?.getorganslot(ORGAN_SLOT_PENIS))

	if(mob_penis.visibility_preference == GENITAL_ALWAYS_SHOW || exposed_mob.is_bottomless())
		if(mob_penis?.genital_size >= (penis_max_length - 2))
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
		if(mob_penis?.genital_size >= (penis_max_length - 2))
			to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
		else
			to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
			
// Notify the user that they're overdosing. Doesn't affect their mood.
/datum/reagent/drug/aphrodisiac/incubus_draft/overdose_start(mob/living/carbon/human/exposed_mob)
	to_chat(exposed_mob, span_userdanger("You feel like you took too much [name]!"))
	exposed_mob.add_mood_event("[type]_overdose", /datum/mood_event/minor_overdose, name)

/datum/chemical_reaction/incubus_draft
	results = list(/datum/reagent/drug/aphrodisiac/incubus_draft = 8)
	required_reagents = list(/datum/reagent/blood = 5, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/carbon = 2, /datum/reagent/drug/aphrodisiac/crocin = 2, /datum/reagent/medicine/salglu_solution = 1)
	mix_message = "the reaction gives off a spicy mist."
	erp_reaction = TRUE
