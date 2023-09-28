/datum/brain_trauma/severe/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = DEATH_CONSEQUENCES_QUIRK_DESC
	scan_desc = "mortality-induced resonance degradation"
	gain_text = span_warning("For a brief moment, you completely disassociate.")
	lose_text = span_notice("You feel like you have a firm grasp on your conciousness again!")
	random_gain = FALSE

	/// The current degradation we are currently at. Genreally speaking, things get worse the higher this is. Can never go below 0.
	var/current_degradation = 0
	/// The absolute maximum degradation we can receive. Will cause permadeath if [permakill_if_at_max_degradation] is TRUE.
	var/max_degradation = 500 // arbitrary
	/// The
	var/base_degradation_reduction_per_second_while_alive = 0.05 // arbitrary
	var/base_degradation_on_death = DEATH_CONSEQUENCES_BASE_DEGRADATION_ON_DEATH
	var/base_degradation_per_second_while_dead = 0

	var/list/dead_reagent_effects = list(
		/datum/reagent/toxin/formaldehyde = list(
			DEATH_CONSEQUENCES_REAGENT_DEGRADATION_INCREASE_MULT_AMOUNT = 0,
			DEATH_CONSEQUENCES_REAGENT_CHECK_PROCESSING_FLAGS = TRUE,
		),
	)

	var/permakill_if_at_max_degradation = FALSE
	var/force_death_if_permakilled = FALSE

	// Higher = overall less intense threshold reduction but it still maxes out once it gets there
	var/max_degradation_for_crit_threshold_reduction = 200

	var/crit_threshold_currently_reduced_by = 0

	/// The last world.time we sent a message to our owner reminding them of their current degradation. Used for cooldowns and such.
	var/time_of_last_message_sent = 0

	// Will be iterated through sequentially, so the higher a path is, the quicker itll be searched
	// Make sure to put the larger bonuses and more specific types higher than the generic ones
	var/static/list/buckled_to_recovery_mult_table = list(
		/obj/structure/bed/medical = 5,
		/obj/structure/bed = 3,

		/obj/structure/chair/comfy = 2,
		/obj/structure/chair/sofa = 2,
		/obj/structure/chair = 1.5,

		/mob/living = 1.25, // being carried
	)
	// Only used if the thing we are buckled to is not in [buckled_to_recovery_mult_table]
	var/static/buckled_to_default_mult = 1.15

/datum/brain_trauma/severe/death_consequences/on_gain()
	. = ..()

	RegisterSignal(owner, COMSIG_LIVING_REVIVE, PROC_REF(victim_revived))

/datum/brain_trauma/severe/death_consequences/on_lose(silent)
	. = ..()

	UnregisterSignal(owner, COMSIG_LIVING_REVIVE)
	owner.crit_threshold += crit_threshold_currently_reduced_by

/datum/brain_trauma/severe/death_consequences/on_death()
	. = ..()

	adjust_degradation(base_degradation_on_death)

/datum/brain_trauma/severe/death_consequences/process(seconds_per_tick)

	var/is_dead = (owner.stat == DEAD)
	var/degradation_increase = get_degradation_increase(is_dead)
	var/degradation_reduction = get_degradation_reduction(is_dead)

	adjust_degradation(degradation_increase - degradation_reduction)

	if (owner.stat == DEAD)
		degradation_adjustment = (base_degradation_per_second_while_alive * get_degradation_reduction_mult())
	else
		degradation_adjustment = (base_degradation_per_second_while_dead * get_degradation_reduction_mult())
	degradation_adjustment *= seconds_per_tick

	if (degradation_adjustment)
		adjust_degradation(degradation_adjustment)

#define DEGRADATION_REDUCTION_SLEEPING_MULT 3
#define DEGRADATION_REDUCTION_RESTING_MULT 1.5

/datum/brain_trauma/severe/death_consequences/proc/get_degradation_increase(is_dead)
	var/base_increase = 0
	if (is_dead)
		base_increase += base_degradation_per_second_while_dead

	var/increase_mult = get_degradation_increase_mult(is_dead)

	return base_increase

/datum/brain_trauma/severe/death_consequences/proc/get_degradation_increase_mult(is_dead)
	var/mult = 1

	for (var/datum/reagent_typepath as anything in dead_reagent_effects)
		if (!reagent_can_affect_degradation(reagent_typepath, is_dead, dead_reagent_effects))
			continue
		
		mult += affecting_reagents[reagent_typepath][DEATH_CONSEQUENCES_REAGENT_MULT_AMOUNT]


	return mult

/datum/brain_trauma/severe/death_consequences/proc/get_degradation_decrease(is_dead)
	var/base_decrease

/datum/brain_trauma/severe/death_consequences/proc/get_degradation_reduction_mult()
	var/reduction_mult = 1

	if (owner.IsSleeping())
		reduction_mult *= DEGRADATION_REDUCTION_SLEEPING_MULT
	else if (owner.resting)
		reduction_mult *= DEGRADATION_REDUCTION_RESTING_MULT

	var/buckled_to_mult
	if (owner.buckled)
		buckled_to_mult = buckled_to_recovery_mult_table[owner.buckled.type]
	else
		buckled_to_mult = buckled_to_default_mult

	reduction_mult *= buckled_to_mult

	return reduction_mult

#undef DEGRADATION_REDUCTION_SLEEPING_MULT
#undef DEGRADATION_REDUCTION_RESTING_MULT

/datum/brain_trauma/severe/death_consequences/proc/reagent_can_affect_degradation(datum/reagent/reagent_typepath, list/list_to_look_into)
	if (!owner.has_reagent(reagent_typepath, needs_metabolizing = list_to_look_into[reagent_typepath][DEATH_CONSEQUENCES_REAGENT_METABOLIZE_KEY], check_subtypes = FALSE))
		return FALSE

	if (list_to_look_into[reagent_typepath][DEATH_CONSEQUENCES_REAGENT_CHECK_PROCESSING_FLAGS_KEY] && !reagent_process_flags_valid(owner, owner.get_reagent(reagent_typepath)))
		return FALSE

	return TRUE

/datum/brain_trauma/severe/death_consequences/proc/adjust_degradation(adjustment)
	var/old_degradation = current_degradation
	current_degradation = clamp((current_degradation + adjustment), 0, max_degradation)
	if (current_degradation != old_degradation)
		update_effects()

/datum/brain_trauma/severe/death_consequences/proc/update_effects()
	var/threshold_reduction = get_crit_threshold_reduction()
	owner.crit_threshold = ((owner.crit_threshold - crit_threshold_currently_reduced_by) - threshold_reduction)
	crit_threshold_currently_reduced_by = threshold_reduction

	if (permakill_if_at_max_degradation && (current_degradation >= max_degradation))
		// this is a sufficiently dramatic event for some dramatic to_chats
		var/visible_message
		var/self_message
		var/self_message_target = owner
		ADD_TRAIT(owner, TRAIT_DNR) // youre gone bro
		if (owner.stat == DEAD)
			visible_message = span_revenwarning("The air around [owner] seems to ripple for a moment. You sense that something terrible has happened.")
			self_message = span_revendanger("The metaphorical \"tether\" binding you to your body finally gives way. You try holding on, but you soon find yourself \
			falling into a deep, deep abyss...")
		else
			if (force_death_if_permakilled)
				visible_message = span_revenwarning("[owner] suddenly lets out a harrowing gasp and falls to one knee, clutching their head! The remainder of their \
				body goes limp soon after, failing to stand back up. You sense something terrible has happened.")
				owner.death(gibbed = FALSE)
			else
				visible_message = span_revenwarning("[owner] jerkily arches their head upwards, untensing and going slackjawed with dilated pupils. They \
				cease all action and simply stand there, swaying. You sense something terrible has happened.")
				owner.ghostize()

			self_message = span_revendanger("Your mind suddenly clouds, and you lose control of all thought and function. You try to squeeze your eyes shut, but you forget \
			where they are only a split second later. You drift away from yourself, further and further, until it's impossible to return...")

		var/mob/dead/observer/owner_ghost = owner.get_ghost()
		var/mob/self_message_target = (owner_ghost ? owner_ghost : owner)

		self_message += span_danger(" You have been killed by your resonance degradation, which prevents you from returning to your body or even being revived. \
		You may roleplay this however you wish - this death may be temporary, permanent - you may or may not appear in soulcatchers - it's all up to you.")

		owner.visible_message(visible_message, ignored_mobs = self_message_target)
		to_chat(self_message_target, self_message)

// you need to put the clamp in here so you can properly subtract crit_threshold_currently_reduced_by
/datum/brain_trauma/severe/death_consequences/proc/get_crit_threshold_reduction()
	SHOULD_BE_PURE(TRUE)

	var/clamped_degradation = min(current_degradation, max_degradation_for_crit_threshold_reduction)
	var/percent_to_max = (clamped_degradation / max_degradation_for_crit_threshold_reduction)

	var/proposed_alteration = (clamped_degradation * percent_to_max)
	var/proposed_threshold_reduction = ((owner.crit_threshold - crit_threshold_currently_reduced_by) - proposed_alteration)
	var/clamped_threshold_reduction = max(proposed_threshold_reduction, DEATH_CONSEQUENCES_MINIMUM_VICTIM_CRIT_THRESHOLD)

	var/difference = (clamped_threshold_reduction - proposed_threshold_reduction)

	return proposed_alteration - difference

/datum/brain_trauma/severe/death_consequences/proc/get_health_analyzer_info()
	return span_boldwarning("Subject suffers from mortality-induced resonance instability. \
	[span_warning("Current degradation: [span_blue("[current_degradation]")]")]")

