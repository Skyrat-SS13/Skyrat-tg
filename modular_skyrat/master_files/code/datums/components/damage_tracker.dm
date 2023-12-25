/// This component tracks the original damage values of a mob when it is attached.
/datum/component/damage_tracker
	/// How much brute damage did the mob have on them?
	var/brute_damage = 0
	/// How much burn damage did the mob have on them?
	var/burn_damage = 0
	/// How much oxygen damage did the mob have on them?
	var/oxygen_damage = 0
	/// How much toxin damage did the mob have on them?
	var/toxin_damage = 0

	/// How much blood did the mob have?
	var/stored_blood_volume = 0

	/// Do we need to reapply the damage values when this component is removed?
	var/reapply_damage_on_removal = TRUE

/// Updates the stored damage variables for the parent mob. Returns `TRUE` when succesfully ran, otherwise returns `FALSE`
/datum/component/damage_tracker/proc/update_damage_values()
	var/mob/living/tracked_mob = parent
	if(!istype(tracked_mob))
		return FALSE

	brute_damage = tracked_mob.getBruteLoss()
	burn_damage = tracked_mob.getFireLoss()
	toxin_damage = tracked_mob.getToxLoss()
	oxygen_damage = tracked_mob.getOxyLoss()
	stored_blood_volume = tracked_mob.blood_volume

	return TRUE

/// Reapplies the stored damage variables to the parent mob. Returns `TRUE` when succesfully ran, otherwise returns `FALSE`
/datum/component/damage_tracker/proc/reapply_damage()
	var/mob/living/tracked_mob = parent
	if(!istype(tracked_mob))
		return FALSE

	tracked_mob.setBruteLoss(brute_damage)
	tracked_mob.setFireLoss(burn_damage)
	tracked_mob.setToxLoss(toxin_damage)
	tracked_mob.setOxyLoss(oxygen_damage)
	tracked_mob.blood_volume = stored_blood_volume

	return TRUE

/datum/component/damage_tracker/Initialize(...)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	update_damage_values()

/datum/component/damage_tracker/Destroy(force, silent)
	if(reapply_damage_on_removal)
		reapply_damage()

	return ..()

/// This does the same as it's parent, but it also tracks organ damage.
/datum/component/damage_tracker/human
	/// How much damage does the owner's heart currently have?
	var/heart_damage
	/// How much damage does the owner's liver currently have?
	var/liver_damage
	/// How much damage does the owner's lungs currently have?
	var/lung_damage
	/// How much damage does the owner's stomach currently have?
	var/stomach_damage
	/// How much damage does the owner's brain currently have?
	var/brain_damage
	/// How much damage does the owner's eyes currently have?
	var/eye_damage
	/// How much damage does the owner's ears currently have?
	var/ear_damage

	/// What brain traumas does the owner currently have?
	var/list/trauma_list = list()

/datum/component/damage_tracker/human/update_damage_values()
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	if(!. || !istype(human_parent))
		return FALSE

	var/list/current_trauma_list = human_parent.get_traumas()
	if(length(current_trauma_list))
		trauma_list = current_trauma_list.Copy()

	heart_damage = human_parent.check_organ_damage(/obj/item/organ/internal/heart)
	liver_damage = human_parent.check_organ_damage(/obj/item/organ/internal/liver)
	lung_damage = human_parent.check_organ_damage(/obj/item/organ/internal/lungs)
	stomach_damage = human_parent.check_organ_damage(/obj/item/organ/internal/stomach)
	brain_damage = human_parent.check_organ_damage(/obj/item/organ/internal/brain)
	eye_damage = human_parent.check_organ_damage(/obj/item/organ/internal/eyes)
	ear_damage = human_parent.check_organ_damage(/obj/item/organ/internal/ears)

	return TRUE

/datum/component/damage_tracker/human/reapply_damage()
	. = ..()
	var/mob/living/carbon/human/human_parent = parent
	if(!. || !istype(human_parent))
		return FALSE

	human_parent.setOrganLoss(ORGAN_SLOT_HEART, heart_damage)
	human_parent.setOrganLoss(ORGAN_SLOT_LIVER, liver_damage)
	human_parent.setOrganLoss(ORGAN_SLOT_LUNGS, lung_damage)
	human_parent.setOrganLoss(ORGAN_SLOT_STOMACH, stomach_damage)
	human_parent.setOrganLoss(ORGAN_SLOT_EYES, eye_damage)
	human_parent.setOrganLoss(ORGAN_SLOT_EARS, ear_damage)
	human_parent.setOrganLoss(ORGAN_SLOT_BRAIN, brain_damage)

	var/obj/item/organ/internal/brain/human_brain = human_parent.get_organ_by_type(/obj/item/organ/internal/brain)
	if(!human_brain)
		return FALSE

	var/list/current_trauma_list = human_parent.get_traumas()
	for(var/datum/brain_trauma/trauma_to_add as anything in trauma_list)
		if(trauma_to_add in current_trauma_list)
			continue // We don't need to torture the poor soul with the same brain trauma.

		human_brain.gain_trauma(trauma_to_add)

	return TRUE

/datum/component/damage_tracker/human/Initialize(...)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	return ..()

/// Returns the damage of the `organ_to_check`, if the organ isn't there, the proc returns `100`.
/mob/living/carbon/human/proc/check_organ_damage(obj/item/organ/organ_to_check)
	var/obj/item/organ/organ_to_track = get_organ_by_type(organ_to_check)
	if(!organ_to_track)
		return 100 //If the organ is missing, return max damage. we have this here so that if the SAD replaces an organ, it's broken.

	return organ_to_track.damage
