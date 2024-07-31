/// Bioreactor Maintenance
/datum/surgery/bioreactor
	name = "Bioreactor Maintenance"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	organ_to_manipulate = ORGAN_SLOT_STOMACH
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/bioreactor/repair,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	desc = "A mechanical surgery procedure designed to repair an androids internal bioreactor."

/datum/surgery/bioreactor/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/stomach/bioreactor = target.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(isnull(bioreactor) || !issynthetic(target) || bioreactor.damage < 10)
		return FALSE
	return ..()

/datum/surgery_step/bioreactor/repair
	name = "perform bioreactor maintenance (screwdriver)"
	implements = list(
		TOOL_SCREWDRIVER = 95,
		TOOL_SCALPEL = 45,
		/obj/item/melee/energy/sword = 35,
		/obj/item/knife = 25,
		/obj/item/shard = 5,
	)
	preop_sound = 'sound/items/ratchet_slow.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/bioreactor/repair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to patch the damaged section of [target]'s bioreactor..."),
		span_notice("[user] begins to delicately repair [target]'s bioreactor using [tool]."),
		span_notice("[user] begins to delicately repair [target]'s bioreactor."),
	)
	display_pain(target, "You feel a horrible stab in your gut!")

/datum/surgery_step/bioreactor/repair/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/patient = target
	var/obj/item/organ/internal/stomach/bioreactor = target.get_organ_slot(ORGAN_SLOT_STOMACH)
	patient.setOrganLoss(ORGAN_SLOT_STOMACH, 0) // adjustOrganLoss didnt work here without runtimes spamming, setting to 0 as synths have no natural organ decay/regeneration
	if(bioreactor.organ_flags & ORGAN_EMP)
		bioreactor.organ_flags &= ~ORGAN_EMP
	display_results(
		user,
		target,
		span_notice("You successfully repair the damaged part of [target]'s bioreactor."),
		span_notice("[user] successfully repairs the damaged part of [target]'s bioreactor using [tool]."),
		span_notice("[user] successfully repairs the damaged part of [target]'s bioreactor."),
	)
	display_pain(target, "The errors clear from your bioreactor.")
	return ..()

/datum/surgery_step/bioreactor/repair/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/patient = target
	patient.adjustOrganLoss(ORGAN_SLOT_STOMACH, 15)
	display_results(
		user,
		target,
		span_warning("You slip and puncture [target]'s bioreactor!"),
		span_warning("[user] slips and punctures [target]'s bioreactor with the [tool]!"),
		span_warning("[user] slips and punctures [target]'s bioreactor!"),
	)
	display_pain(target, "Your midsection throws additional errors; that's not right!")
