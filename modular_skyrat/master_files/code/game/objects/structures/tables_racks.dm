// Lets cyborgs move dragged objects onto tables
/obj/structure/table/attack_robot(mob/user, list/modifiers)
	if(!in_range(src, user))
		return
	return attack_hand(user, modifiers)

//Most of this is code that allows stasis and numbing to work on surgery tables.
/obj/structure/table/optable
	/// Is the table able to put patients in stasis?
	var/stasis_capable = FALSE
	/// Is the Operating table able to preform numbing?
	var/numbing_capable = TRUE
	/// Is the patient already numbed?

/// Used to numb a patient and apply stasis to them if enabled.
/obj/structure/table/optable/proc/chill_out(mob/living/target)
	var/freq = rand(24750, 26550)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = freq)

	if(stasis_capable)
		target.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT) //Numbing is covered by this.
		target.extinguish_mob()
		ADD_TRAIT(target, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)
		return

	// If stasis isn't an option, only numbing is applied
	ADD_TRAIT(target, TRAIT_NUMBED, REF(src))

///Used to remove the effects of stasis and numbing when a patient is unbuckled
/obj/structure/table/optable/proc/thaw_them(mob/living/target)
	if(stasis_capable)
		target.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
		REMOVE_TRAIT(target, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)
		return

	REMOVE_TRAIT(target, TRAIT_NUMBED, REF(src))

/obj/structure/table/optable/post_buckle_mob(mob/living/patient)
	mark_patient(potential_patient = patient)
	if(numbing_capable)
		chill_out(patient)

/obj/structure/table/optable/post_unbuckle_mob(mob/living/patient)
	unmark_patient(potential_patient = patient)
	if(numbing_capable)
		thaw_them(patient)

/obj/structure/table/reinforced/Initialize()
	. = ..()
	AddElement(/datum/element/liquids_height, 20)
