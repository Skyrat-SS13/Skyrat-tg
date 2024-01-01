// A surgery that repairs the patient's NIF
/datum/surgery/repair_nif
	name = "Repair NIF"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/repair_nif,
		/datum/surgery_step/close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_HEAD)
	desc = "A surgical procedure that restores the integrity of an installed NIF."

/datum/surgery/repair_nif/can_start(mob/user, mob/living/patient)
	var/mob/living/carbon/human/nif_patient = patient
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = nif_patient.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)

	if(!nif_patient || !installed_nif)
		return FALSE

	return ..()

/datum/surgery_step/repair_nif
	name = "repair installed NIF (multitool)"
	repeatable = FALSE
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 35,
		TOOL_SCREWDRIVER = 15,
	)
	time = 12 SECONDS

/datum/surgery_step/repair_nif/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to restore the integrity of [target]'s NIF..."),
		"[user] begins to fix [target]'s NIF.",
		"[user] begins to perform repairs on [target]'s NIF."
	)

/datum/surgery_step/repair_nif/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You succeed in restoring the integrity of [target]'s NIF."),
		"[user] successfully repairs [target]'s NIF!",
		"[user] completes the repair on [target]'s NIF."
	)

	var/mob/living/carbon/human/nif_patient = target
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = nif_patient.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)


	installed_nif.durability = installed_nif.max_durability
	installed_nif.send_message("Restored to full integrity!")

	return ..()

/datum/surgery_step/repair_nif/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_slot(ORGAN_SLOT_BRAIN))
		display_results(user, target, span_warning("You screw up, causing [target] brain damage!"),
			span_warning("[user] screws up, while trying to repair [target]'s NIF!"),
			"[user] fails to complete the repair on [target]'s NIF.")

		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
	return FALSE

