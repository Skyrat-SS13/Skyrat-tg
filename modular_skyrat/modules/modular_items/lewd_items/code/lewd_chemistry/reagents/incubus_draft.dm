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

	// Not important at all, really, but I don't want folk complaining about a removed feature.
	var/static/list/species_to_penis = list(
		SPECIES_HUMAN = list(
			"sheath" = SHEATH_NONE,
			"mutant_index" = "Human",
			"balls" = "Pair"
		),
		SPECIES_LIZARD = list(
			"sheath" = SHEATH_SLIT,
			"color" = "#FFB6C1",
			"mutant_index" = "Flared",
			"balls" = "Internal"
		),
		SPECIES_LIZARD_ASH = list(
			"sheath" = SHEATH_SLIT,
			"color" = "#FFB6C1",
			"mutant_index" = "Flared",
			"balls" = "Internal"
		),
	)

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
	/// Wording chosen to grow the balls, shown only to the mob.
	var/static/list/ball_action_text_list = list(
		"begin to swell",
		"feel heavier all of a sudden",
		"throb as they increase in size",
		"begin to pulse, feeling larger than they were before",
	)
	/// Wording chosen to be seen by other mobs, while mob is unclothed.
	var/static/list/public_cock_action_text_list = list(
		"expands by an inch or so.",
		"appears to grow a bit longer.",
		"seems a bit bigger than it was before.",
		"suddenly lengthens about an inch or two.",
	)

/datum/reagent/drug/aphrodisiac/incubus_draft/life_effects(mob/living/carbon/human/exposed_mob)
	var/obj/item/organ/external/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
	enlargement_amount += enlarger_increase_step
	// Add yet another check because I hate errors!!
	if(!mob_penis)
		return
	if(enlargement_amount >= enlargement_threshold)
		if(mob_penis?.genital_size >= penis_max_length)
			return ..()
		mob_penis.genital_size += penis_length_increase_step
		// Improvision to girth to not make it random chance.
		if(mob_penis?.girth < penis_max_girth) // Because any higher is ridiculous. However, should still allow for regular penis growth.
			mob_penis.girth = round(mob_penis.girth + (mob_penis.genital_size/mob_penis.girth))
		mob_penis.update_sprite_suffix()
		exposed_mob.update_body()
		enlargement_amount = 0

	if((mob_penis?.genital_size >= (penis_max_length - 2)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target_bodypart = exposed_mob.get_bodypart(BODY_ZONE_PRECISE_GROIN)
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("You feel a tightness in your pants!"))
			exposed_mob.apply_damage(1, BRUTE, target_bodypart)

	return ..()

/datum/reagent/drug/aphrodisiac/incubus_draft/overdose_effects(mob/living/carbon/human/exposed_mob)
	// Check if overdosing on incubus draft and succubus milk simultaneously, to prevent chat spam
	var/datum/reagent/drug/aphrodisiac/succubus_milk/succubus_milk = locate(/datum/reagent/drug/aphrodisiac/succubus_milk) in exposed_mob.reagents.reagent_list 
	if(succubus_milk && !succubus_milk.overdosed)
		succubus_milk  = null

	// Begin cock growth
	if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/penis_enlargement))
		// Start making new genitals if prefs allow it and if there isn't already one there
		if(!exposed_mob.getorganslot(ORGAN_SLOT_PENIS) && exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
			// If the user has not defined their own prefs for their penis type, try to assign a default based on their species, defaulting to human
			var/list/data = species_to_penis[exposed_mob.dna.species.id]
			if(!data)
				data = species_to_penis[SPECIES_HUMAN]

			if(exposed_mob.dna.features["penis_sheath"] == "None")
				exposed_mob.dna.features["penis_sheath"] = data["sheath"]

			if(exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_NAME] == "None")
				exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_NAME] = data["mutant_index"]

			if(exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_TESTICLES][MUTANT_INDEX_NAME] == "None")
				exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_TESTICLES][MUTANT_INDEX_NAME] = data["balls"]

			var/colour = data["colour"]
			if(colour)
				exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_COLOR_LIST] = list(colour)

			// Create the new testicles
			if(!exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES))
				var/obj/item/organ/external/genital/testicles/new_balls = new
				new_balls.build_from_dna(exposed_mob.dna, ORGAN_SLOT_TESTICLES)
				new_balls.Insert(exposed_mob, 0, FALSE)
				new_balls.genital_size = 0
				new_balls.update_sprite_suffix()

			// Create the new penis
			var/obj/item/organ/external/genital/penis/new_penis = new
			new_penis.build_from_dna(exposed_mob.dna, ORGAN_SLOT_PENIS)
			new_penis.Insert(exposed_mob, 0, FALSE)
			new_penis.genital_size = 4
			new_penis.girth = 3
			new_penis.update_sprite_suffix()
			exposed_mob.update_body()
			if(!succubus_milk)
				to_chat(exposed_mob, span_purple("Your crotch feels warm as something suddenly sprouts between your legs."))
			
		// Makes the balls bigger if they're small.
		var/obj/item/organ/external/genital/testicles/mob_testicles = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)
		if(mob_testicles)
			if(mob_testicles.genital_size < balls_max_size && prob(balls_increase_chance)) // Add some randomness so growth happens more gradually in most cases
				mob_testicles.genital_size++
				mob_testicles.update_sprite_suffix()
				exposed_mob.update_body()
				if(!succubus_milk) // So we don't spam chat
					to_chat(exposed_mob, span_purple("Your balls [pick(ball_action_text_list)]. They are now [mob_testicles.balls_size_to_description(mob_testicles.genital_size)]."))

			else if(mob_testicles.genital_size == balls_max_size) 
				var/obj/item/organ/external/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)

				if(mob_penis?.genital_size >= balls_enormous_size_threshold) // Make the balls enormous only when the penis reaches a certain size
					mob_testicles.genital_size++
					mob_testicles.update_sprite_suffix()
					exposed_mob.update_body()

					if(!succubus_milk)
						to_chat(exposed_mob, span_purple("You can feel your heavy balls churn as they swell to enormous proportions!"))
	
	// Separates gender change stuff from cock growth, breast shrinkage, and female genitalia removal
	if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/gender_change))
		if (succubus_milk)
			if(exposed_mob.gender != PLURAL)
				exposed_mob.set_gender(PLURAL)
				exposed_mob.physique = exposed_mob.gender
				exposed_mob.update_body()
				exposed_mob.update_mutations_overlay()

		else if(exposed_mob.gender != MALE)
			exposed_mob.set_gender(MALE)		
			exposed_mob.physique = exposed_mob.gender
			exposed_mob.update_body()
			exposed_mob.update_mutations_overlay()
		
	// To do breast shrinkage, check if there are breasts & if prefs allow for this
	var/obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
	if(mob_breasts)
		if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/breast_shrinkage)) 
			if(mob_breasts.genital_size > breast_minimum_size)
				mob_breasts.genital_size = max(mob_breasts.genital_size - breast_size_reduction_step, breast_minimum_size)
				mob_breasts.update_sprite_suffix()
				exposed_mob.update_body()
			// Handle completely shrinking away, if prefs allow
			else if(mob_breasts.genital_size == breast_minimum_size) 
				if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))
					if(!succubus_milk)
						to_chat(exposed_mob, span_purple("Your breasts have completely tightened into firm, flat pecs."))
					mob_breasts.Remove(exposed_mob)
					exposed_mob.update_body()
	
	// Vagina and womb removal. check if they exist & if prefs allow for this
	var/obj/item/organ/external/genital/vagina/mob_vagina = exposed_mob.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/external/genital/womb/mob_womb = exposed_mob.getorganslot(ORGAN_SLOT_WOMB)
	if(mob_vagina)
		if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))
			mob_vagina.Remove(exposed_mob)
			exposed_mob.update_body()
			if(!succubus_milk)
				to_chat(exposed_mob, span_purple("You can the feel the muscles in your groin begin to tighten as your vagina seals itself completely shut."))
			
	if(mob_womb)
		if(exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))
			mob_womb.Remove(exposed_mob)
			exposed_mob.update_body()

/datum/reagent/drug/aphrodisiac/incubus_draft/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/penis/mob_penis)
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
