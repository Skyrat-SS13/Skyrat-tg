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
	overdose_threshold = 20 ///ODing makes you male and shrinks female genitals if gender change prefs are enabled. Otherwise, grows a cock.
	metabolization_rate = 0.25
	life_pref_datum = /datum/preference/toggle/erp/penis_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp/gender_change ///Changed from penis_enlargement in order to have gender swapping as a separate feature within overdose.

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
	/// Add yet another check because I hate errors!!
	if(!mob_penis)
		return
	if(enlargement_amount >= enlargement_threshold)
		if(mob_penis?.genital_size >= penis_max_length)
			return ..()
		mob_penis.genital_size += penis_length_increase_step
		///Improvision to girth to not make it random chance.
		if(mob_penis?.girth < penis_max_girth) ///Because any higher is ridiculous. However, should still allow for regular penis growth.
			mob_penis.girth = round(mob_penis.girth + (mob_penis.genital_size/mob_penis.girth))
		mob_penis.update_sprite_suffix()
		exposed_mob.update_body()
		enlargement_amount = 0

		if(mob_penis.visibility_preference == GENITAL_ALWAYS_SHOW || exposed_mob.is_bottomless())
			if(mob_penis?.genital_size >= (penis_max_length - 2))
				if(exposed_mob.dna.features["penis_sheath"] == SHEATH_SLIT)
					if(mob_penis.aroused != AROUSAL_FULL)
						to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
					return
				exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(public_cock_action_text_list)]"))
				to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
				return
			else
				if(exposed_mob.dna.features["penis_sheath"] == SHEATH_SLIT)
					if(mob_penis.aroused != AROUSAL_FULL)
						to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
					return
				exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(cock_text_list)] [pick(public_cock_action_text_list)]"))
				to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
				return
		else
			if(mob_penis?.genital_size >= (penis_max_length - 2))
				to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger_cock)] [pick(bigger_cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
				return
			else
				to_chat(exposed_mob, span_purple("Your [pick(cock_text_list)] [pick(cock_action_text_list)]about [mob_penis.genital_size] inches long, and [mob_penis.girth] inches in circumference."))
				return

	if((mob_penis?.genital_size >= (penis_max_length - 2)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		var/target_bodypart = exposed_mob.get_bodypart(BODY_ZONE_PRECISE_GROIN)
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("You feel a tightness in your pants!"))
			exposed_mob.apply_damage(1, BRUTE, target_bodypart)

	return ..()

/datum/reagent/drug/aphrodisiac/incubus_draft/overdose_effects(mob/living/carbon/human/exposed_mob)
	if(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/penis_enlargement))
		if(!exposed_mob.getorganslot(ORGAN_SLOT_PENIS))
			var/list/data = species_to_penis[exposed_mob.dna.species.id]
			if(!data)
				data = species_to_penis[SPECIES_HUMAN]

			exposed_mob.dna.features["penis_sheath"] = data["sheath"]
			exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_NAME] = data["index_name"]
			exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_TESTICLES][MUTANT_INDEX_NAME] = data["balls"]
			var/colour = data["colour"]
			if(colour)
				exposed_mob.dna.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_COLOR_LIST] = list(colour)

			if(!exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES))
				var/obj/item/organ/balls_path = /obj/item/organ/external/genital/testicles
				balls_path = new /obj/item/organ/external/genital/testicles
				balls_path.build_from_dna(exposed_mob.dna, ORGAN_SLOT_TESTICLES)
				balls_path.Insert(exposed_mob, 0, FALSE)
				var/obj/item/organ/external/genital/new_balls = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)
				new_balls.genital_size = 1
				new_balls.update_sprite_suffix()

			var/obj/item/organ/external/genital/penis/new_penis = new /obj/item/organ/external/genital/penis
			new_penis.build_from_dna(exposed_mob.dna, ORGAN_SLOT_PENIS)
			new_penis.Insert(exposed_mob, 0, FALSE)
			new_penis.genital_size = 4
			new_penis.girth = 3
			new_penis.update_sprite_suffix()
			exposed_mob.update_body()
			to_chat(exposed_mob, span_purple("Your crotch feels warm as something suddenly sprouts between your legs."))
		///Makes the balls bigger if they're small.
		var/obj/item/organ/external/genital/testicles/mob_testicles = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)
		if(mob_testicles)
			if(mob_testicles.genital_size > 2)
				return
			mob_testicles.genital_size = 2
	///Separates gender change stuff from cock growth.
	var/obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
	if(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/gender_change))
		if(exposed_mob.gender == FEMALE)
			exposed_mob.set_gender(MALE)
			exposed_mob.physique = exposed_mob.gender
			exposed_mob.update_body()
			exposed_mob.update_mutations_overlay()
		if(!mob_breasts)
			return
		if(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/breast_enlargement)) ///To do breast shrinkage, check if prefs allow for this.
			if(mob_breasts.genital_size > breast_minimum_size)
				mob_breasts.genital_size -= breast_size_reduction_step
				mob_breasts.update_sprite_suffix()
				exposed_mob.update_body()
				return

/datum/chemical_reaction/incubus_draft
	results = list(/datum/reagent/drug/aphrodisiac/incubus_draft = 8)
	required_reagents = list(/datum/reagent/blood = 5, /datum/reagent/medicine/c2/synthflesh = 2, /datum/reagent/carbon = 2, /datum/reagent/drug/aphrodisiac/crocin = 2, /datum/reagent/medicine/salglu_solution = 1)
	mix_message = "the reaction gives off a mist of milk."
