/datum/surgery/advanced/lobotomy
	desc = "An invasive surgical procedure which guarantees removal of deep-rooted brain traumas, but might cause a different, deeper trauma in return."

/datum/surgery_step/lobotomize/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You succeed in lobotomizing [target]."),
		span_notice("[user] successfully lobotomizes [target]!"),
		span_notice("[user] completes the surgery on [target]'s brain."),
	)
	display_pain(target, "Your head goes totally numb for a moment, the pain is overwhelming!")

	target.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	if(prob(75))
		target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
	return ..()

/datum/surgery/advanced/blessed_lobotomy
	name = "Blessed Lobotomy"
	desc = "We're not quite sure exactly how it works, but with the blessing of a chaplain combined with modern chemicals, this manages to remove soul-bound traumas once thought to be magic."
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = NONE
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/lobotomize/blessed,
		/datum/surgery_step/close,
	)

/datum/surgery/advanced/blessed_lobotomy/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return FALSE
	var/obj/item/organ/internal/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE
	return TRUE

/datum/surgery_step/lobotomize/blessed
	name = "perform blessed lobotomy (scalpel)"
	chems_needed = list(
		/datum/reagent/water/holywater,
		/datum/reagent/medicine/neurine,
	)

/datum/surgery_step/lobotomize/blessed/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You succeed in lobotomizing [target]."),
		span_notice("[user] successfully lobotomizes [target]!"),
		span_notice("[user] completes the surgery on [target]'s brain."),
	)
	display_pain(target, "Your head goes totally numb for a moment, the pain is overwhelming! You begin to see the light... ")

	target.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
	playsound(source = get_turf(target), soundin = 'sound/magic/repulse.ogg', vol = 75, vary = TRUE, falloff_distance = 2)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	if(prob(75))
		target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
	return ..()
