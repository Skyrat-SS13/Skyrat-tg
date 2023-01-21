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
	
	/// % chance for testicle growth to occur
	var/balls_increase_chance = 20

	/// Largest length the chem can make a mob's penis
	var/penis_max_length = PENIS_MAX_LENGTH
	/// Smallest size the chem can make a mob's penis
	var/penis_min_length = PENIS_MIN_LENGTH
	/// How much the penis is increased in size each time it's run
	var/penis_length_increase_step = 1
	/// How much the penis is increased in girth each time it's run
	var/penis_girth_increase_step = 1
	/// How much the testicles are increased in size each time it's run
	var/testicles_size_increase_step = 1
	/// Largest girth the chem can make a mob's penis
	var/penis_max_girth = PENIS_MAX_GIRTH
	/// Smallest girth the chem can make a mob's penis
	var/penis_minimum_girth = 2
	/// How much to reduce the size of the penis each time it's run
	var/penis_size_reduction_step = 1
	/// How much to reduce the girth of the penis each time it's run
	var/penis_girth_reduction_step = 1
	/// How much to reduce the size of the balls each time it's run
	var/testicles_size_reduction_step = 1
	
	/// Largest size the chem can make a mob's balls
	var/balls_max_size = TESTICLES_MAX_SIZE
	/// Smallest size the chem can make a mob's balls
	var/balls_min_size = TESTICLES_MIN_SIZE
	/// Make the balls enormous only when the penis reaches a certain size
	var/balls_enormous_size_threshold = PENIS_MAX_LENGTH - 4

	/// Largest size the chem can make a mob's breasts
	var/max_breast_size = 16
	/// How much breasts are increased in size each time it's run
	var/breast_size_increase_step = 1
	/// Smallest size the chem can make a mob's breasts
	var/breast_minimum_size = 2
	/// How much to reduce the size of the breasts each time it's run
	var/breast_size_reduction_step = 1

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
	/// Wording chosen to grow the balls, shown only to the mob.
	var/static/list/ball_action_text_list = list(
		"begin to swell",
		"feel heavier all of a sudden",
		"throb as they increase in size",
		"begin to pulse, feeling larger than they were before",
	)

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

/// Handle changing of gender
/datum/reagent/drug/aphrodisiac/proc/change_gender(mob/living/carbon/human/exposed_mob, datum/reagent/drug/aphrodisiac/aphrodisiac) 

//Handle new genital creation
/datum/reagent/drug/aphrodisiac/proc/create_genitals(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE) 

// ---- New Genital Creation : Male genitals ----

//  Attempt to create new penis
/datum/reagent/drug/aphrodisiac/proc/create_penis(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/penis/mob_penis = exposed_mob?.getorganslot(ORGAN_SLOT_PENIS)) 
	
	// Create the new penis if we don't already have one and if prefs allow
	if(mob_penis)
		return
	
// Check if prefs allow it	
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
		return
	
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

	// Create the new penis
	var/obj/item/organ/external/genital/penis/new_penis = new
	new_penis.build_from_dna(exposed_mob.dna, ORGAN_SLOT_PENIS)
	new_penis.Insert(exposed_mob, 0, FALSE)
	new_penis.genital_size = 4
	new_penis.girth = 3
	update_appearance(exposed_mob, new_penis)
	
	if(!suppress_chat)
		to_chat(exposed_mob, span_purple("Your crotch feels warm as something suddenly sprouts between your legs."))

// Attempt to create new testicles
/datum/reagent/drug/aphrodisiac/proc/create_testicles(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/testicles/mob_balls = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)) 
	
	// Create the new testicles if we don't already have them and if prefs allow
	if(mob_balls)
		return
		
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
		return
		
	var/obj/item/organ/external/genital/testicles/new_balls = new
	new_balls.build_from_dna(exposed_mob.dna, ORGAN_SLOT_TESTICLES)
	new_balls.Insert(exposed_mob, 0, FALSE)
	new_balls.genital_size = 0
	update_appearance(genital = new_balls)
		
	return new_balls

// ---- New Genital Creation : Female genitals ----

// Attempt to create new breasts
/datum/reagent/drug/aphrodisiac/proc/create_breasts(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob?.getorganslot(ORGAN_SLOT_BREASTS)) 

	// Make sure we don't already have them
	if(mob_breasts)
		return
		
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
		return
		
	// If the user has not defined their own prefs for their breast type, default to two breasts
	if (exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_BREASTS][MUTANT_INDEX_NAME] == "None")
		exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_BREASTS][MUTANT_INDEX_NAME] = "Pair"
	
	// Create the new breasts
	var/obj/item/organ/external/genital/breasts/new_breasts = new
	new_breasts.build_from_dna(exposed_mob.dna, ORGAN_SLOT_BREASTS)
	new_breasts.Insert(exposed_mob, FALSE, FALSE)
	new_breasts.genital_size = 2
	update_appearance(exposed_mob, new_breasts)
	enlargement_amount = 0
	
	if(new_breasts.visibility_preference == GENITAL_ALWAYS_SHOW || exposed_mob.is_topless())
		if(!suppress_chat) // So we don't spam chat
			exposed_mob.visible_message(span_notice("[exposed_mob]'s bust suddenly expands!"))
			to_chat(exposed_mob, span_purple("Your chest feels warm, tingling with sensitivity as it expands outward."))
	else
		if(!suppress_chat)
			exposed_mob.visible_message(span_notice("The area around [exposed_mob]'s chest suddenly bounces a bit."))
			to_chat(exposed_mob, span_purple("Your chest feels warm, tingling with sensitivity as it strains against your clothes."))
	
	return new_breasts

/datum/reagent/drug/aphrodisiac/proc/create_vagina(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/vagina/mob_vagina = exposed_mob?.getorganslot(ORGAN_SLOT_VAGINA))
	
	// Add new vagina if we don't already have one. Use dna prefs before assigning a default human one.
	if(mob_vagina)
		return
	
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
		return
		
	if(!exposed_mob.getorganslot(ORGAN_SLOT_VAGINA))
		if (exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_VAGINA][MUTANT_INDEX_NAME] == "None")
			exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_VAGINA][MUTANT_INDEX_NAME] = "Human"
			
		var/obj/item/organ/external/genital/vagina/new_vagina = new
		new_vagina.build_from_dna(exposed_mob.dna, ORGAN_SLOT_VAGINA)
		new_vagina.Insert(exposed_mob, 0, FALSE)
		update_appearance(exposed_mob)
		if(!suppress_chat)
			to_chat(exposed_mob, span_purple("You feel a warmth in your groin as something blossoms down there."))

/datum/reagent/drug/aphrodisiac/proc/create_womb(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/womb/mob_womb = exposed_mob?.getorganslot(ORGAN_SLOT_WOMB))
	
	// Add a new womb if we don't already have one. Use dna prefs before assigning a default normal one.
	if(mob_womb)
		return
		
	if (exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_WOMB][MUTANT_INDEX_NAME] == "None")
		exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_WOMB][MUTANT_INDEX_NAME] = "Normal"
			
	var/obj/item/organ/external/genital/womb/new_womb = new
	new_womb.build_from_dna(exposed_mob.dna, ORGAN_SLOT_WOMB)
	new_womb.Insert(exposed_mob, 0, FALSE)
	update_appearance(exposed_mob)

// ---- Growth functions : Male genitals ----

// Attempt to grow penis
/datum/reagent/drug/aphrodisiac/proc/grow_penis(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/penis/mob_penis = exposed_mob?.getorganslot(ORGAN_SLOT_PENIS)) 
	
	// Check if we actually have a penis to grow
	if(!mob_penis)
		return
	
	// Check if prefs allow this
	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/penis_enlargement))
		return
		
	enlargement_amount += enlarger_increase_step
	
	if(enlargement_amount >= enlargement_threshold)
		if(mob_penis?.genital_size >= penis_max_length)
			return
		mob_penis.genital_size = min(mob_penis.genital_size + penis_length_increase_step, penis_max_length)
		// Improvision to girth to not make it random chance.
		if(mob_penis?.girth < penis_max_girth) // Because any higher is ridiculous. However, should still allow for regular penis growth.
			mob_penis.girth = round(mob_penis.girth + (mob_penis.genital_size/mob_penis.girth))
		update_appearance(exposed_mob, mob_penis)
		enlargement_amount = 0
	
		growth_to_chat(exposed_mob, mob_penis)

	// Damage from being too big for your clothes
	if((mob_penis?.genital_size >= (penis_max_length - 2)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target_bodypart = exposed_mob.get_bodypart(BODY_ZONE_PRECISE_GROIN)
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("You feel a tightness in your pants!"))
			exposed_mob.apply_damage(1, BRUTE, target_bodypart)

// Attempt to grow balls
/datum/reagent/drug/aphrodisiac/proc/grow_balls(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/testicles/mob_testicles = exposed_mob?.getorganslot(ORGAN_SLOT_TESTICLES)) 
	
	//no balls
	if(!mob_testicles)
		return

	// Check if prefs allow this
	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/penis_enlargement))
		return

	var/obj/item/organ/external/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
	
	if(mob_testicles.genital_size < balls_max_size && prob(balls_increase_chance)) // Add some randomness so growth happens more gradually in most cases
		mob_testicles.genital_size = min(mob_testicles.genital_size + testicles_size_increase_step, balls_max_size)
		update_appearance(exposed_mob, mob_testicles)
		if(!suppress_chat) // So we don't spam chat
			to_chat(exposed_mob, span_purple("Your balls [pick(ball_action_text_list)]. They are now [mob_testicles.balls_size_to_description(mob_testicles.genital_size)]."))

	else if(mob_testicles.genital_size == balls_max_size && mob_penis?.genital_size >= balls_enormous_size_threshold) // Make the balls enormous only when the penis reaches a certain size
		mob_testicles.genital_size = min(mob_testicles.genital_size + testicles_size_increase_step, balls_max_size)
		update_appearance(exposed_mob, mob_testicles)

		if(!suppress_chat)
			to_chat(exposed_mob, span_purple("You can feel your heavy balls churn as they swell to enormous proportions!"))

// ---- Genital Growth : Female genitals ----

// Handle breast growth
/datum/reagent/drug/aphrodisiac/proc/grow_breasts(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob?.getorganslot(ORGAN_SLOT_BREASTS)) 
	
	if(!mob_breasts)
		return
		
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/breast_enlargement))
		return
	
	enlargement_amount += enlarger_increase_step
	
	if(enlargement_amount >= enlargement_threshold)
		if(mob_breasts?.genital_size >= max_breast_size)
			return
		mob_breasts.genital_size = min(mob_breasts.genital_size + breast_size_increase_step, max_breast_size)
		update_appearance(exposed_mob, mob_breasts)
		enlargement_amount = 0
		
		growth_to_chat(exposed_mob, mob_breasts)
		
	// Damage from being too big for your clothes
	if((mob_breasts?.genital_size >= (max_breast_size - 2)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("Your breasts begin to strain against your clothes!"))
			exposed_mob.adjustOxyLoss(5)
			exposed_mob.apply_damage(1, BRUTE, exposed_mob.get_bodypart(BODY_ZONE_CHEST))

/// Handle genital shrinkage
/datum/reagent/drug/aphrodisiac/proc/shrink_genitals(mob/living/carbon/human/exposed_mob) 

// ---- Genital Shrinkage : Male genitals ----

// Attempt penis shrinkage
/datum/reagent/drug/aphrodisiac/proc/shrink_penis(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/penis/mob_penis = exposed_mob?.getorganslot(ORGAN_SLOT_PENIS)) 	

	// Is there a penis to shrink?
	if(!mob_penis)
		return
	
	// Make sure prefs allow this
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/penis_shrinkage))
		return
		
	// Handle completely shrinking away, if prefs allow
	if(mob_penis.genital_size == penis_min_length)
		remove_penis(exposed_mob, suppress_chat, mob_penis)
	else 
		if(mob_penis.genital_size > penis_min_length)
			mob_penis.genital_size = max(mob_penis.genital_size - penis_size_reduction_step, penis_min_length)
			update_appearance(exposed_mob, mob_penis)
		if(mob_penis.girth > penis_minimum_girth)
			mob_penis.girth = max(mob_penis.girth - penis_girth_reduction_step, penis_minimum_girth)
			update_appearance(exposed_mob, mob_penis)

// Attempt ball shrinkage			
/datum/reagent/drug/aphrodisiac/proc/shrink_testicles(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/penis/mob_penis = exposed_mob?.getorganslot(ORGAN_SLOT_PENIS), obj/item/organ/external/genital/testicles/mob_testicles = exposed_mob?.getorganslot(ORGAN_SLOT_TESTICLES)) 
	
	if(!mob_testicles)
		return
		
	// Make sure prefs allow this
	if(!exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/penis_shrinkage))
		return
		
	if(mob_testicles.genital_size > balls_min_size)
		mob_testicles.genital_size = max(mob_testicles.genital_size - testicles_size_reduction_step, balls_min_size)
		update_appearance(exposed_mob, mob_testicles)

	else if(mob_testicles.genital_size == balls_min_size && !mob_penis) // Wait for penis to completely shrink away first before removing balls
		remove_testicles(exposed_mob, suppress_chat, mob_testicles)


// ---- Genital Shrinkage : Female genitals ----

// Handle breast shrinkage
/datum/reagent/drug/aphrodisiac/proc/shrink_breasts(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob?.getorganslot(ORGAN_SLOT_BREASTS)) 

	if(!mob_breasts) 
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/breast_shrinkage))
		return

	if(mob_breasts.genital_size > breast_minimum_size)
		mob_breasts.genital_size = max(mob_breasts.genital_size - breast_size_reduction_step, breast_minimum_size)
		update_appearance(exposed_mob, mob_breasts)
		
	else if(mob_breasts.genital_size == breast_minimum_size) // Handle completely shrinking away, if prefs allow
		remove_breasts(exposed_mob, suppress_chat, mob_breasts)

/// Handle removal of old genitals
/datum/reagent/drug/aphrodisiac/proc/remove_genitals(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE) 

// ---- Genital Removal : Male genitals ----

/datum/reagent/drug/aphrodisiac/proc/remove_penis(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/penis/mob_penis = exposed_mob?.getorganslot(ORGAN_SLOT_PENIS)) 

	if(!mob_penis)
		return
		
	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))
		return
		
	mob_penis.Remove(exposed_mob)
	update_appearance(exposed_mob)
	
/datum/reagent/drug/aphrodisiac/proc/remove_testicles(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/testicles/mob_testicles = exposed_mob?.getorganslot(ORGAN_SLOT_TESTICLES))

	if(!mob_testicles) 
		return
		
	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))
		return
		
	mob_testicles.Remove(exposed_mob)
	update_appearance(exposed_mob)
	
	if(!suppress_chat)
		to_chat(exposed_mob, span_purple("You feel a tightening sensation in your groin as things seem to smooth out down there."))

// ---- Genital Removal : Female genitals ----

/datum/reagent/drug/aphrodisiac/proc/remove_breasts(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob?.getorganslot(ORGAN_SLOT_BREASTS)) 

	if(!mob_breasts)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))
		return
		
	mob_breasts.Remove(exposed_mob)
	update_appearance(exposed_mob)
	
	if(!suppress_chat)
		to_chat(exposed_mob, span_purple("Your breasts have completely tightened into firm, flat pecs."))

// Removes the vagina if it exists
/datum/reagent/drug/aphrodisiac/proc/remove_vagina(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/vagina/mob_vagina = exposed_mob?.getorganslot(ORGAN_SLOT_VAGINA)) 

	if(!mob_vagina)
		return
	
	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))	
		return 
		
	mob_vagina.Remove(exposed_mob)
	update_appearance(exposed_mob)
	
	if(!suppress_chat)
		to_chat(exposed_mob, span_purple("You can the feel the muscles in your groin begin to tighten as your vagina seals itself completely shut."))

// Removes the womb if it exists
/datum/reagent/drug/aphrodisiac/proc/remove_womb(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/womb/mob_womb = exposed_mob?.getorganslot(ORGAN_SLOT_WOMB))		

	if(!mob_womb)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/genitalia_removal))	
		return 
	
	mob_womb.Remove(exposed_mob)
	update_appearance(exposed_mob)

/// Used to display the messages that appear in chat while the growth is occurring
/datum/reagent/drug/aphrodisiac/proc/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/genital) 

/// Called after growth that alters appearance
/datum/reagent/drug/aphrodisiac/proc/update_appearance(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/genital, mutations_overlay = FALSE)
	if(genital)
		genital.update_sprite_suffix()
	if(exposed_mob) 
		exposed_mob.update_body()
		if(mutations_overlay)
			exposed_mob.update_mutations_overlay()
