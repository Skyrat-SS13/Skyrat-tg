/datum/surgery/advanced/bioware/ligament_reinforcement
	name = "Ligament Reinforcement"
	desc = "A surgical procedure which adds a protective tissue and bone cage around the connections between the torso and limbs, preventing dismemberment. \
		However, the nerve connections as a result are more easily interrupted, making it easier to disable limbs with damage."
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/incise,
		/datum/surgery_step/apply_bioware/reinforce_ligaments,
		/datum/surgery_step/close,
	)

	status_effect_gained = /datum/status_effect/bioware/ligaments/reinforced

/datum/surgery_step/apply_bioware/reinforce_ligaments
	name = "reinforce ligaments (hand)"

/datum/surgery_step/apply_bioware/reinforce_ligaments/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start reinforcing [target]'s ligaments."),
		span_notice("[user] starts reinforce [target]'s ligaments."),
		span_notice("[user] starts manipulating [target]'s ligaments."),
	)
	display_pain(target, "Your limbs burn with severe pain!")

/datum/surgery_step/apply_bioware/reinforce_ligaments/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(!.)
		return

	display_results(
		user,
		target,
		span_notice("You reinforce [target]'s ligaments!"),
		span_notice("[user] reinforces [target]'s ligaments!"),
		span_notice("[user] finishes manipulating [target]'s ligaments."),
	)
	display_pain(target, "Your limbs feel more secure, but also more frail.")
