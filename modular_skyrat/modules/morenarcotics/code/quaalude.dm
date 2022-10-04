/datum/chemical_reaction/quaalude
	results = list(/datum/reagent/drug/quaalude = 4)
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 2, /datum/reagent/hydrogen = 1, /datum/reagent/chlorine = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG


/datum/reagent/drug/quaalude
	name = "Quaalude"
	description = "Relaxes the user, putting them in a hypnotic, drugged state. A favorite drug of kids from Brooklyn." //THAT WAS THE BEST FUCKIN DRUG EVER MADE
	reagent_state = LIQUID
	color = "#ffe669"
	overdose_threshold = 20
	ph = 8
	taste_description = "lemons"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/drug/quaalude/on_mob_metabolize(mob/living/carbon/affected_carbon)
	if(affected_carbon.hud_used)
		var/atom/movable/plane_master_controller/game_plane_master_controller = affected_carbon.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.add_filter("quaalude_wave", 10, wave_filter(300, 300, 3, 0, WAVE_SIDEWAYS))


/datum/reagent/drug/quaalude/on_mob_life(mob/living/carbon/affected_carbon, delta_time, times_fired)
	if(DT_PROB(2.5, delta_time))
		var/high_message = pick("You feel relaxed.", "You feel like you're on the moon.", "You feel like you could walk 20 miles for a quaalude.")
		to_chat(affected_carbon, span_notice(high_message))

	affected_carbon.set_drugginess(1 MINUTES * REM * delta_time)
	affected_carbon.adjust_slurring_up_to(30 SECONDS, 2 MINUTES)
	affected_carbon.set_dizzy_if_lower(5 * REM * delta_time * 2 SECONDS)
	affected_carbon.adjustStaminaLoss(-5 * REM * delta_time, 0)

	if(DT_PROB(3.5, delta_time))
		affected_carbon.emote(pick("laugh", "drool"))

	if(DT_PROB(1, delta_time) && !HAS_TRAIT(affected_carbon, TRAIT_FLOORED))
			affected_carbon.visible_message(span_danger("[affected_carbon]'s legs become too weak to carry their own weight!"))
			affected_carbon.Knockdown(90, TRUE)
			affected_carbon.drop_all_held_items()

	return ..()


/datum/reagent/drug/quaalude/on_mob_end_metabolize(mob/living/carbon/affected_carbon)
	if(affected_carbon.hud_used != null)
		var/atom/movable/plane_master_controller/game_plane_master_controller = affected_carbon.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.remove_filter("quaalude_wave")


/datum/reagent/drug/quaalude/overdose_process(mob/living/affected_carbon, delta_time, times_fired)
	var/kidfrombrooklyn_message = pick("BRING BACK THE FUCKING QUAALUDES!", "I'd walk 20 miles for a quaalude, let me tell ya'!", "There's nothing like a fuckin' quaalude!")

	if(DT_PROB(1.5, delta_time))
		affected_carbon.say(kidfrombrooklyn_message)

	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25 * REM * delta_time)
	affected_carbon.adjustToxLoss(0.25 * REM * delta_time, 0)
	affected_carbon.adjust_drowsyness(0.25 * REM * normalise_creation_purity() * delta_time)

	if(DT_PROB(3.5, delta_time))
		affected_carbon.emote("twitch")

	return TRUE
