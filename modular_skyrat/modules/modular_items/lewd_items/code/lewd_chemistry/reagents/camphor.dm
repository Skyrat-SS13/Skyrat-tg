//Camphor. Used to reduce libido.
///Able to reset one's genital size back to normal upon OD, or alternatively, if the user sets the size and then disables the organ, that size.
/datum/reagent/drug/aphrodisiac/camphor
	name = "Camphor"
	description = "Naturally found in some species of evergreen trees, camphor is a waxy substance. When ingested by most animals it acts as an anaphrodisiac, \
					reducing libido and calming them. Non-habit forming and non-addictive."
	taste_description = "dull bitterness"
	taste_mult = 2
	color = "#D9D9D9"//rgb(157, 157, 157)
	reagent_state = SOLID
	overdose_threshold = 25 ///OD will reset sizes of genitals back to normal.
	life_pref_datum = /datum/preference/toggle/erp/aphro
	arousal_adjust_amount = -12
	pleasure_adjust_amount = -3
	overdose_pref_datum = /datum/preference/toggle/erp ///This will work without having aphrodisiacs enabled.

/datum/reagent/drug/aphrodisiac/camphor/life_effects(mob/living/carbon/human/exposed_mob)
	var/old_arousal = exposed_mob.arousal
	exposed_mob.adjustArousal(arousal_adjust_amount)
	exposed_mob.adjustPleasure(pleasure_adjust_amount)
	if(exposed_mob.arousal <= 0 && old_arousal > 0)
		to_chat(exposed_mob, span_notice("You no longer feel aroused."))

/datum/reagent/drug/aphrodisiac/camphor/overdose_effects(mob/living/carbon/human/exposed_mob)
	///Grows and shrinks organs depending on prefs, returning to normal. Offers a way of resetting succubus milk / incubus draft sizes, but not organs.

	///Resets gender if prefs enabled.
	if(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/gender_change))
		if(exposed_mob.gender != exposed_mob.client?.prefs?.read_preference(/datum/preference/choiced/gender))
			exposed_mob.set_gender(exposed_mob.client?.prefs?.read_preference(/datum/preference/choiced/gender))

	if(exposed_mob.getorganslot(ORGAN_SLOT_BREASTS))
		var/obj/item/organ/external/genital/breasts/mob_breasts = exposed_mob.getorganslot(ORGAN_SLOT_BREASTS)
		if(exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/breasts_size))
			var/original_breast_size = exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/breasts_size)
			if(mob_breasts?.genital_size > original_breast_size)
				mob_breasts.genital_size -= breast_size_reduction_step
				mob_breasts.update_sprite_suffix()
				exposed_mob.update_body()
				return
			if(mob_breasts?.genital_size < original_breast_size)
				mob_breasts.genital_size += breast_size_increase_step
				mob_breasts.update_sprite_suffix()
				exposed_mob.update_body()
				return
	if(exposed_mob.getorganslot(ORGAN_SLOT_PENIS))
		var/obj/item/organ/external/genital/penis/mob_penis = exposed_mob.getorganslot(ORGAN_SLOT_PENIS)
		if(exposed_mob.client?.prefs?.read_preference(/datum/preference/numeric/penis_length))
			var/original_penis_length = exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/penis_length)
			var/original_penis_girth = exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/penis_girth)
			var/modified_genitals = FALSE
			///Run to go through girth first.
			if(mob_penis?.girth > original_penis_girth)
				mob_penis.girth -= penis_girth_reduction_step
				mob_penis.update_sprite_suffix()
				modified_genitals = TRUE
			if(mob_penis?.girth < original_penis_girth)
				mob_penis.girth += penis_girth_increase_step
				mob_penis.update_sprite_suffix()
				modified_genitals = TRUE
			///No returns in order to continue code.
			if(mob_penis?.genital_size > original_penis_length)
				mob_penis.genital_size -= penis_size_reduction_step
				mob_penis.update_sprite_suffix()
				modified_genitals = TRUE
				return
			if(mob_penis?.genital_size < original_penis_length)
				mob_penis.genital_size += penis_length_increase_step
				mob_penis.update_sprite_suffix()
				modified_genitals = TRUE
				return
			if(modified_genitals)
				exposed_mob.update_body()
	if(exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES))
		var/obj/item/organ/external/genital/testicles/mob_testicles = exposed_mob.getorganslot(ORGAN_SLOT_TESTICLES)
		if(exposed_mob.client?.prefs?.read_preference(/datum/preference/numeric/balls_size))
			var/original_ball_size = exposed_mob.client?.prefs.read_preference(/datum/preference/numeric/balls_size)
			if(mob_testicles?.genital_size > original_ball_size)
				mob_testicles.genital_size -= 1
				mob_testicles.update_sprite_suffix()
				exposed_mob.update_body()
				return
			if(mob_testicles?.genital_size < original_ball_size)
				mob_testicles.genital_size += 1
				mob_testicles.update_sprite_suffix()
				exposed_mob.update_body()
				return

/datum/chemical_reaction/camphor
	results = list(/datum/reagent/drug/aphrodisiac/camphor = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/sulfur = 1)
	required_temp = 400
	mix_message = "The mixture boils off a yellow, smelly vapor..."
