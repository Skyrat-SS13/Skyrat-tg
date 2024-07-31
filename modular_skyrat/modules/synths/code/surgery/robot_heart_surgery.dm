/// Hydraulic Pump Surgery
/datum/surgery/hydraulic_maintenance
	name = "Hydraulic Pump Maintenance"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/hydraulic/repair,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	desc = "A mechanical surgery procedure designed to repair an androids internal hydraulic pump."

/datum/surgery/hydraulic_maintenance/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/heart/hydraulic_pump = target.get_organ_slot(ORGAN_SLOT_HEART)
	if(isnull(hydraulic_pump) || !issynthetic(target) || hydraulic_pump.damage < 10)
		return FALSE
	return ..()

/datum/surgery_step/hydraulic/repair
	name = "tighten seals (screwdriver or wrench)"
	implements = list(
		TOOL_SCREWDRIVER = 90,
		TOOL_WRENCH = 90,
		TOOL_WIRECUTTER = 35,
		/obj/item/stack/package_wrap = 15,
	)
	preop_sound = 'sound/items/ratchet_slow.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/hydraulic/repair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to tighten the clamps around [target]'s hydraulic pump..."),
		span_notice("[user] begins to repair [target]'s hydraulic pump with [tool]!"),
		span_notice("[user] begins to repair [target]'s hydraulic pump!"),
	)
	display_pain(target, "The pain in your chest is unbearable! You can barely take it anymore!")

/datum/surgery_step/hydraulic/repair/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/patient = target
	var/obj/item/organ/internal/heart/hydraulic = patient.get_organ_slot(ORGAN_SLOT_HEART)
	patient.setOrganLoss(ORGAN_SLOT_HEART, 0) // adjustOrganLoss didnt work here without runtimes spamming, setting to 0 as synths have no natural organ decay/regeneration
	if(hydraulic.organ_flags & ORGAN_EMP)
		hydraulic.organ_flags &= ~ORGAN_EMP
	display_results(
		user,
		target,
		span_notice("You successfully repair [target]'s hydraulic pump."),
		span_notice("[user] finishes clamping tubing down around [target]'s hydraulic pump with [tool]."),
		span_notice("[user] finishes clamping tubing down around [target]'s hydraulic pump."),
	)
	display_pain(target, "The warnings, but your pump is as strong as ever!")
	return ..()

/datum/surgery_step/hydraulic/repair/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/patient = target
		display_results(
			user,
			target,
			span_warning("You screw up and slip your [tool] into their pump, tearing part of the pump off!"),
			span_warning("[user] screws up, causing high pressure oil to spurt out of [target]'s chest profusely!"),
			span_warning("[user] completes the surgery, but is that oil supposed to be squirting out of [target]'s chest like that?"),
		)
		display_pain(target, "Your chest burns; you feel oil flooding your chest cavity!")
		patient.adjustOrganLoss(ORGAN_SLOT_HEART, 20)
	return FALSE
