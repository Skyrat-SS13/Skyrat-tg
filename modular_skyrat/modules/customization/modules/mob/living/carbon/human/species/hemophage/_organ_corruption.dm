#define BASE_TIME_BEFORE_CORRUPTION 60 SECONDS
#define GENERIC_CORRUPTED_ORGAN_COLOR "#333333"

/// Component for Hemophage tumor-induced organ corruption, for the organs
/// that need to receive the `ORGAN_TUMOR_CORRUPTED` flag, to corrupt
/// them properly.
/datum/component/organ_corruption
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// The type of organ affected by this specific type of organ corruption.
	var/corruptable_organ_type = /obj/item/organ/internal
	/// If this type of organ has a unique sprite for what its corrupted
	/// version should look like, this will be the icon file it will be pulled
	/// from.
	var/corrupted_icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	/// If this type of organ has a unique sprite for what its corrupted
	/// version should look like, this will be the icon state it will be pulled
	/// from.
	var/corrupted_icon_state = null
	/// The timer associated with the corruption process, if any.
	var/corruption_timer_id = null
	/// The prefix added to the organ once it is successfully corrupted.
	var/corrupted_prefix = "corrupted"


/datum/component/organ_corruption/Initialize(time_to_corrupt = BASE_TIME_BEFORE_CORRUPTION)
	if(!istype(parent, corruptable_organ_type))
		return COMPONENT_INCOMPATIBLE

	if(time_to_corrupt <= 0)
		corrupt_organ(parent)
		return

	corruption_timer_id = addtimer(CALLBACK(src, PROC_REF(corrupt_organ), parent), time_to_corrupt, TIMER_STOPPABLE)


/datum/component/organ_corruption/RegisterWithParent()
	if(corruption_timer_id)
		RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(clear_corruption_timer))
		RegisterSignal(parent, COMSIG_ORGAN_REMOVED, PROC_REF(clear_corruption_timer))


/datum/component/organ_corruption/UnregisterFromParent()
	. = ..()

	UnregisterSignal(parent, list(COMSIG_ORGAN_IMPLANTED, COMSIG_ORGAN_REMOVED))

	clear_corruption_timer()


/// Handles clearing the timer for corrupting an organ if the organ is `QDELETING`.
/datum/component/organ_corruption/proc/clear_corruption_timer()
	SIGNAL_HANDLER

	if(corruption_timer_id)
		deltimer(corruption_timer_id)

	UnregisterSignal(parent, list(COMSIG_QDELETING, COMSIG_ORGAN_REMOVED))


/**
 * Handles corrupting the organ, adding any sort of behavior on it as needed.
 *
 * Arguments:
 * * corruption_target - The organ that will get corrupted.
 */
/datum/component/organ_corruption/proc/corrupt_organ(obj/item/organ/internal/corruption_target)
	SHOULD_CALL_PARENT(TRUE)
	if(!corruption_target)
		return FALSE

	corruption_timer_id = null
	corruption_target.organ_flags |= ORGAN_TUMOR_CORRUPTED
	corruption_target.name = "[corrupted_prefix] [corruption_target.name]"

	if(corrupted_icon_state && corrupted_icon)
		corruption_target.icon = corrupted_icon
		corruption_target.icon_state = corrupted_icon_state
		corruption_target.update_appearance()

	else
		corruption_target.color = GENERIC_CORRUPTED_ORGAN_COLOR

	RegisterSignal(corruption_target, COMSIG_ORGAN_IMPLANTED, PROC_REF(register_signals_on_organ_owner))
	RegisterSignal(corruption_target, COMSIG_ORGAN_REMOVED, PROC_REF(unregister_signals_from_organ_loser), override = TRUE)

	return TRUE


/**
 * Handles registering signals on the (new) organ owner, if it was to ever be
 * taken out and put into someone else.
 */
/datum/component/organ_corruption/proc/register_signals_on_organ_owner(obj/item/organ/implanted_organ, mob/living/carbon/receiver)
	SIGNAL_HANDLER
	SHOULD_CALL_PARENT(TRUE)

	if(implanted_organ != parent)
		return FALSE

	RegisterSignal(receiver, COMSIG_PULSATING_TUMOR_REMOVED, PROC_REF(on_tumor_removed))

	return TRUE


/**
 * Handles unregistering the signals that were registered on the `loser` from
 * having this organ in their body.
 */
/datum/component/organ_corruption/proc/unregister_signals_from_organ_loser(obj/item/organ/target, mob/living/carbon/loser)
	SIGNAL_HANDLER
	SHOULD_CALL_PARENT(TRUE)

	if(target != parent)
		return FALSE

	return TRUE



/datum/component/organ_corruption/proc/on_tumor_removed()
	SIGNAL_HANDLER

	if(!corruption_timer_id)
		return

	qdel(src)


#undef BASE_TIME_BEFORE_CORRUPTION
#undef GENERIC_CORRUPTED_ORGAN_COLOR
