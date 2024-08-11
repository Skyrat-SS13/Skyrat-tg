/// Heatsink Repair Surgery
/datum/surgery/heatsink
	name = "Heatsink Maintenance"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/weld_plating_slice,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/heatsink/repair,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A mechanical surgery procedure designed to repair an androids internal heatsink."

/datum/surgery/heatsink/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	var/obj/item/organ/internal/lungs/target_lungs = target.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(isnull(target_lungs) || !issynthetic(target) || target_lungs.damage < 10 )
		return FALSE
	return ..()

/datum/surgery_step/heatsink/repair
	name = "Tighten heatsink mounts (wrench)"
	implements = list(
		TOOL_WRENCH = 90,
		TOOL_RETRACTOR = 45,
	)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/ratchet_fast.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/heatsink/repair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to tighten the bolts on [target]'s heatsink..."),
		span_notice("[user] begins to tighten the bolts on [target]'s heatsink using [tool]."),
		span_notice("[user] begins to tighten the bolts on [target]'s heatsink."),
	)
	display_pain(target, "You feel a metal clank inside your chest as [user] starts to work.")

/datum/surgery_step/heatsink/repair/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/patient = target
		var/obj/item/organ/internal/lungs/heatsink = patient.get_organ_slot(ORGAN_SLOT_LUNGS)
		patient.setOrganLoss(ORGAN_SLOT_LUNGS, 0) // adjustOrganLoss didnt work here without runtimes spamming, setting to 0 as synths have no natural organ decay/regeneration
		if(heatsink.organ_flags & ORGAN_EMP)
			heatsink.organ_flags &= ~ORGAN_EMP
		display_results(
			user,
			target,
			span_notice("You successfully tighten [target]'s bolts on their heatsink."),
			span_notice("[user] successfully tightened [target]'s heatsink using [tool]."),
			span_notice("[user] finishes tightening [target]'s heatsink."),
		)
		display_pain(target, "Your internal errors clear for your temperature regulation.")
	return ..()

/datum/surgery_step/heatsink/repair/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/patient = target
		display_results(
			user,
			target,
			span_warning("You slip and barely catch the [tool] before it falls, failing to tighten [target]'s heatsink down!"),
			span_warning("[user]'s butterfingers barely catches the [tool] before it falls into [target]'s chest!"),
			span_warning("[user] screws up, nearly dropping the [tool] into [target]'s chest!"),
		)
		display_pain(target, "You feel a dull thud in your chest; it feels like a [tool] fell into your chest cavity!")
		patient.adjustOrganLoss(ORGAN_SLOT_LUNGS, 10) // better find your wrench!
	return FALSE
