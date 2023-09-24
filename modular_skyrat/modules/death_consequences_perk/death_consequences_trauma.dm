/datum/brain_trauma/severe/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = DEATH_CONSEQUENCES_QUIRK_DESC
	scan_desc = "mortality-induced resonance degradation"
	gain_text = span_warning("For a brief moment, you completely disassociate.")
	lose_text = span_notice("You feel like you have a firm grasp on your conciousness again!")

	var/current_degradation = 0
	var/max_degradation = 500 // arbitrary
	/// The
	var/base_degradation_reduction_per_second = 0.05 // arbitrary
	var/base_degradation_on_death = DEATH_CONSEQUENCES_BASE_DEGRADATION_ON_DEATH

	// Higher = overall less intense threshold reduction but it still maxes out once it gets there
	var/max_degradation_for_crit_threshold_reduction = 200

	var/crit_threshold_currently_reduced_by = 0

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

/datum/brain_trauma/severe/death_consequences/on_life(seconds_per_tick, times_fired)
	. = ..()

	var/degradation_adjustment = (base_degradation_reduction_per_second * get_degradation_reduction_mult()) * seconds_per_tick

	adjust_degradation(degradation_adjustment)

#define DEGRADATION_REDUCTION_SLEEPING_MULT 3
#define DEGRADATION_REDUCTION_RESTING_MULT 1.5
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
		buckled_to_mult = 1

	reduction_mult *= buckled_to_mult

	return reduction_mult

#undef DEGRADATION_REDUCTION_SLEEPING_MULT
#undef DEGRADATION_REDUCTION_RESTING_MULT

/datum/brain_trauma/severe/death_consequences/proc/adjust_degradation(adjustment)
	var/old_degradation = current_degradation
	current_degradation = clamp((current_degradation + adjustment), 0, max_degradation)
	if (current_degradation != old_degradation)
		update_effects()

/datum/brain_trauma/severe/death_consequences/proc/update_effects()
	var/threshold_reduction = get_crit_threshold_reduction()
	owner.crit_threshold = ((owner.crit_threshold - crit_threshold_currently_reduced_by) - threshold_reduction)
	crit_threshold_currently_reduced_by = threshold_reduction

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

/datum/brain_trauma/severe/death_consequences/process(seconds_per_tick)
	. = ..()

