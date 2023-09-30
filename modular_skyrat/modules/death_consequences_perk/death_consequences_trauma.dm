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
	var/max_degradation = DEATH_CONSEQUENCES_DEFAULT_MAX_DEGRADATION // arbitrary
	/// The
	var/base_degradation_reduction_per_second_while_alive = DEATH_CONSEQUENCES_DEFAULT_LIVING_DEGRADATION_RECOVERY // arbitrary
	var/base_degradation_on_death = DEATH_CONSEQUENCES_DEFAULT_DEGRADATION_ON_DEATH
	var/base_degradation_per_second_while_dead = 0

	var/formaldehyde_death_degradation_mult = 0
	var/rezadone_degradation_decrease = DEATH_CONSEQUENCES_DEFAULT_REZADONE_DEGRADATION_REDUCTION

	var/on_stasis_death_degradation_mult = 0

	var/list/global_reagent_effects = list()

	var/permakill_if_at_max_degradation = FALSE
	var/force_death_if_permakilled = FALSE

	/// If we have killed our owner permanently.
	var/final_death_delivered = FALSE

	// Higher = overall less intense threshold reduction but it still maxes out once it gets there
	var/crit_threshold_min_degradation = 0
	var/crit_threshold_max_degradation = 200
	var/max_crit_threshold_reduction = 100

	var/max_stamina_damage = 80
	var/stamina_damage_max_degradation = 500
	var/stamina_damage_minimum_degradation = 100

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

	var/static/list/stamina_damage_messages = list(
		"Your muscles suddenly ache...",
		"You feel tired...",
		"You're striken by a body-wide pain..."
	)

/datum/brain_trauma/severe/death_consequences/on_gain()
	. = ..()

	//RegisterSignal(owner, COMSIG_LIVING_REVIVE, PROC_REF(victim_revived))
	RegisterSignal(owner, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(victim_ahealed))

	update_variables()
	START_PROCESSING(SSprocessing, src)

/datum/brain_trauma/severe/death_consequences/on_lose(silent)
	//UnregisterSignal(owner, COMSIG_LIVING_REVIVE)
	owner.crit_threshold -= crit_threshold_currently_reduced_by
	STOP_PROCESSING(SSprocessing, src)

	if (final_death_delivered)
		REMOVE_TRAIT(owner, TRAIT_DNR, TRAUMA_TRAIT)

	UnregisterSignal(owner, COMSIG_LIVING_POST_FULLY_HEAL)

	return ..()

// DEGRADATION ALTERATION / PROCESS

/datum/brain_trauma/severe/death_consequences/on_death()
	. = ..()

	adjust_degradation(base_degradation_on_death)

/datum/brain_trauma/severe/death_consequences/process(seconds_per_tick)

	var/is_dead = (owner.stat == DEAD)
	var/degradation_increase = get_degradation_increase(is_dead) * seconds_per_tick
	var/degradation_reduction = get_degradation_decrease(is_dead) * seconds_per_tick

	adjust_degradation(degradation_increase - degradation_reduction)

	// Ensure our victims stamina is at or above our minimum stamina damage
	if (!is_dead)
		damage_stamina(seconds_per_tick)

/datum/brain_trauma/severe/death_consequences/proc/get_degradation_increase(is_dead)
	var/increase = 0

	if (is_dead)
		increase += base_degradation_per_second_while_dead

		if (owner.has_reagent(/datum/reagent/toxin/formaldehyde, needs_metabolizing = FALSE))
			var/datum/reagent/reagent_instance = owner.reagents.get_reagent(/datum/reagent/toxin/formaldehyde)
			if (!reagent_process_flags_valid(owner, reagent_instance))
				return FALSE
			increase *= formaldehyde_death_degradation_mult

	if (IS_IN_STASIS(owner))
		increase *= on_stasis_death_degradation_mult

	return increase

/datum/brain_trauma/severe/death_consequences/proc/get_degradation_decrease(is_dead)
	var/decrease = 0

	if (!is_dead)
		decrease += base_degradation_reduction_per_second_while_alive

		if (owner.has_reagent(/datum/reagent/medicine/rezadone, needs_metabolizing = TRUE))
			var/datum/reagent/reagent_instance = owner.reagents.get_reagent(/datum/reagent/toxin/formaldehyde)
			if (!reagent_process_flags_valid(owner, reagent_instance))
				return FALSE
			decrease += rezadone_degradation_decrease

	return decrease * get_degradation_decrease_mult()

#define DEGRADATION_REDUCTION_SLEEPING_MULT 3
#define DEGRADATION_REDUCTION_RESTING_MULT 1.5
/// A global proc used for all scenarios we would decrease degradation.
/datum/brain_trauma/severe/death_consequences/proc/get_degradation_decrease_mult()
	var/reduction_mult = 1

	if (owner.IsSleeping())
		reduction_mult *= DEGRADATION_REDUCTION_SLEEPING_MULT
	else if (owner.resting)
		reduction_mult *= DEGRADATION_REDUCTION_RESTING_MULT

	var/buckled_to_mult
	if (owner.buckled)
		buckled_to_mult = buckled_to_recovery_mult_table[owner.buckled.type]
		if (isnull(buckled_to_mult))
			buckled_to_mult = buckled_to_default_mult
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

// EFFECTS

/datum/brain_trauma/severe/death_consequences/proc/update_effects()
	var/threshold_adjustment = get_crit_threshold_adjustment()
	owner.crit_threshold = ((owner.crit_threshold - crit_threshold_currently_reduced_by) + threshold_adjustment)
	crit_threshold_currently_reduced_by = threshold_adjustment

	if (permakill_if_at_max_degradation && (current_degradation >= max_degradation))
		and_so_your_story_ends()

/datum/brain_trauma/severe/death_consequences/proc/get_crit_threshold_adjustment()
	SHOULD_BE_PURE(TRUE)

	var/clamped_degradation = clamp((current_degradation - crit_threshold_min_degradation), 0, crit_threshold_max_degradation)
	var/percent_to_max = (clamped_degradation / crit_threshold_max_degradation)

	var/proposed_alteration = max_crit_threshold_reduction * percent_to_max
	var/proposed_threshold = ((owner.crit_threshold - crit_threshold_currently_reduced_by) + proposed_alteration)
	var/overflow = max((proposed_threshold - DEATH_CONSEQUENCES_MINIMUM_VICTIM_CRIT_THRESHOLD), 0)
	var/final_alteration = (proposed_alteration - overflow)

	return final_alteration

/datum/brain_trauma/severe/death_consequences/proc/damage_stamina(seconds_per_tick)
	if (victim_properly_resting())
		return

	var/clamped_degradation = clamp((current_degradation - stamina_damage_minimum_degradation), 0, stamina_damage_max_degradation)
	var/percent_to_max = min((clamped_degradation / stamina_damage_max_degradation), 1)
	var/minimum_stamina_damage = max_stamina_damage * percent_to_max

	if (owner.staminaloss >= minimum_stamina_damage)
		return

	var/final_adjustment = (minimum_stamina_damage - owner.staminaloss)
	owner.adjustStaminaLoss(final_adjustment) // we adjust instead of set for things like stamina regen timer

/// The proc we call when we permanently kill our victim due to being at maximum degradation. DNRs them, ghosts/kills them, and prints a series of highly dramatic messages,
/// befitting for a death such as this.
/datum/brain_trauma/severe/death_consequences/proc/and_so_your_story_ends()
	ADD_TRAIT(owner, TRAIT_DNR, TRAUMA_TRAIT) // youre gone bro
	final_death_delivered = TRUE

	// this is a sufficiently dramatic event for some dramatic to_chats
	var/visible_message
	var/self_message
	var/log_message

	if (owner.stat == DEAD)
		visible_message = span_revenwarning("The air around [owner] seems to ripple for a moment.")
		self_message = span_revendanger("The metaphorical \"tether\" binding you to your body finally gives way. You try holding on, but you soon find yourself \
		falling into a deep, deep abyss...")
		log_message = "has been permanently ghosted by their resonance instability quirk."
	else
		if (force_death_if_permakilled) // kill them - a violent and painful end
			visible_message = span_revenwarning("[owner] suddenly lets out a harrowing gasp and falls to one knee, clutching their head! The remainder of their \
			body goes limp soon after, failing to stand back up.")
			owner.death(gibbed = FALSE)
			log_message = "has been permanently killed by their resonance instability quirk."
		else // ghostize them - they simply stop thinking, forever
			visible_message = span_revenwarning("[owner] jerkily arches their head upwards, untensing and going slackjawed with dilated pupils. They \
			cease all action and simply stand there, swaying.")
			owner.ghostize(can_reenter_corpse = FALSE)
			log_message = "has been permanently ghosted by their resonance instability quirk."

		self_message = span_revendanger("Your mind suddenly clouds, and you lose control of all thought and function. You try to squeeze your eyes shut, but you forget \
		where they are only a split second later. You drift away from yourself, further and further, until it's impossible to return...")

	var/mob/dead/observer/owner_ghost = owner.get_ghost()
	var/mob/self_message_target = (owner_ghost ? owner_ghost : owner) // if youre ghosted, you still get the message

	visible_message += span_revenwarning(" <b>You sense something terrible has happened.</b>") // append crucial info and context clues
	self_message += span_danger(" You have been killed by your resonance degradation, which prevents you from returning to your body or even being revived. \
	You may roleplay this however you wish - this death may be temporary, permanent - you may or may not appear in soulcatchers - it's all up to you.")

	owner.investigate_log(log_message)
	owner.visible_message(visible_message, ignored_mobs = self_message_target) // finally, send it
	to_chat(self_message_target, self_message)

/datum/brain_trauma/severe/death_consequences/proc/get_health_analyzer_info()
	var/owner_organic = (owner.dna.species.reagent_flags & PROCESS_ORGANIC)
	var/message = span_bolddanger("\nSubject suffers from mortality-induced resonance instability.")
	if (final_death_delivered)
		message += span_purple("<i> Neural patterns are equivilant to the conciousness zero-point. Subject has likely succumbed.</i>")
		return message

	message += span_danger("\nCurrent degradation: [span_blue("[current_degradation]")]. Maximum possible degradation: [span_blue("[max_degradation]")].")
	if (base_degradation_reduction_per_second_while_alive)
		message += span_danger("\nWhile alive, subject will recover from degradation at a rate of [span_green("[base_degradation_reduction_per_second_while_alive] per second")].")
	if (base_degradation_per_second_while_dead)
		message += span_danger("\nWhile dead, subject will suffer degradation at a rate of [span_bolddanger("[base_degradation_reduction_per_second_while_alive] per second.")].")
		if (owner_organic && formaldehyde_death_degradation_mult != 1)
			message += span_danger(" In such an event, formaldehyde will alter the degradation by <b>[span_blue("[formaldehyde_death_degradation_mult]x")].")
		if (on_stasis_death_degradation_mult < 1)
			message += span_danger(" Stasis may be effective in slowing, or even stopping, degradation.")
	if (base_degradation_on_death)
		message += span_danger("\nDeath will incur a <b>[base_degradation_on_death]</b> degradation penalty.")
	if (owner_organic && rezadone_degradation_decrease)
		message += span_danger("\nRezadone will reduce degradation by [span_blue("[rezadone_degradation_decrease]")] per second when metabolized.")
	message += span_danger("\nAll degradation reduction can be [span_blue("expedited")] by [span_blue("resting, sleeping, or being buckled to something comfortable")].")

	if (permakill_if_at_max_degradation)
		message += span_revenwarning("\n\n<b><i>SUBJECT WILL BE PERMANENTLY KILLED IF DEGRADATION REACHES MAXIMUM!</i></b>")

	return message

/datum/brain_trauma/severe/death_consequences/proc/victim_properly_resting()
	if (owner.resting || owner.IsSleeping())
		return TRUE

	if (owner.buckled)
		for (var/typepath in buckled_to_recovery_mult_table)
			if (istype(owner.buckled, typepath))
				return TRUE

	return FALSE

/datum/brain_trauma/severe/death_consequences/proc/victim_ahealed(heal_flags)
	SIGNAL_HANDLER

	if ((heal_flags & HEAL_AFFLICTIONS) == HEAL_AFFLICTIONS)
		adjust_degradation(-INFINITY) // a good ol' regenerative extract can fix you up
	if ((heal_flags & (ADMIN_HEAL_ALL)) == ADMIN_HEAL_ALL) // but only god can actually revive you
		final_death_delivered = FALSE
		REMOVE_TRAIT(owner, TRAIT_DNR, TRAUMA_TRAIT)

/datum/brain_trauma/severe/death_consequences/proc/update_variables()
	var/datum/preferences/victim_prefs = owner.client?.prefs
	if (!victim_prefs)
		return

	max_degradation = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/max_degradation)
	current_degradation = clamp(victim_prefs.read_preference(/datum/preference/numeric/death_consequences/starting_degradation), 0, max_degradation - 1) // lets not let people instantly fucking die

	base_degradation_reduction_per_second_while_alive = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/living_degradation_recovery_per_second)
	base_degradation_per_second_while_dead = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/dead_degradation_per_second)
	base_degradation_on_death = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/degradation_on_death)

	var/min_crit_threshold_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/crit_threshold_reduction_min_percent_of_max)
	crit_threshold_min_degradation = (max_degradation * (min_crit_threshold_percent / 100))
	var/max_crit_threshold_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/crit_threshold_reduction_percent_of_max)
	crit_threshold_max_degradation = (max_degradation * (max_crit_threshold_percent / 100))
	max_crit_threshold_reduction = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/max_crit_threshold_reduction)

	var/min_stamina_damage_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/stamina_damage_min_percent_of_max)
	stamina_damage_minimum_degradation = (max_degradation * (min_stamina_damage_percent / 100))
	var/max_stamina_damage_percent = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/stamina_damage_percent_of_max)
	max_stamina_damage = victim_prefs.read_preference(/datum/preference/numeric/death_consequences/max_stamina_damage)
	stamina_damage_max_degradation = (max_degradation * (max_stamina_damage_percent / 100))

	permakill_if_at_max_degradation = victim_prefs.read_preference(/datum/preference/toggle/death_consequences/permakill_at_max)
	force_death_if_permakilled = victim_prefs.read_preference(/datum/preference/toggle/death_consequences/force_death_if_permakilled)

	update_effects()
