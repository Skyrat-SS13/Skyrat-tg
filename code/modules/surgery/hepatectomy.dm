/datum/surgery/hepatectomy
	name = "Hepatectomy"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	organ_to_manipulate = ORGAN_SLOT_LIVER
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/hepatectomy,
		/datum/surgery_step/close,
	)

/datum/surgery/hepatectomy/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/internal/liver/target_liver = target.get_organ_slot(ORGAN_SLOT_LIVER)
	if(isnull(target_liver) || target_liver.damage < 50 || target_liver.operated)
		return FALSE
	return ..()

////hepatectomy, removes damaged parts of the liver so that the liver may regenerate properly
//95% chance of success, not 100 because organs are delicate
/datum/surgery_step/hepatectomy
	name = "remove damaged liver section (scalpel)"
	implements = list(
		TOOL_SCALPEL = 95,
		/obj/item/melee/energy/sword = 65,
		/obj/item/knife = 45,
		/obj/item/shard = 35)
	time = 52
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/organ1.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'

/datum/surgery_step/hepatectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to cut out a damaged piece of [target]'s liver..."),
		span_notice("[user] begins to make an incision in [target]."),
		span_notice("[user] begins to make an incision in [target]."),
	)
	display_pain(target, "Your abdomen burns in horrific stabbing pain!", mood_event_type = /datum/mood_event/surgery)

/datum/surgery_step/hepatectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/human_target = target
	var/obj/item/organ/internal/liver/target_liver = target.get_organ_slot(ORGAN_SLOT_LIVER)
	human_target.setOrganLoss(ORGAN_SLOT_LIVER, 10) //not bad, not great
	if(target_liver)
		target_liver.operated = TRUE
	display_results(
		user,
		target,
		span_notice("You successfully remove the damaged part of [target]'s liver."),
		span_notice("[user] successfully removes the damaged part of [target]'s liver."),
		span_notice("[user] successfully removes the damaged part of [target]'s liver."),
	)
	display_pain(target, "The pain receeds slightly.", mood_event_type = /datum/mood_event/surgery/success)
	return ..()

/datum/surgery_step/hepatectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/human_target = target
	human_target.adjustOrganLoss(ORGAN_SLOT_LIVER, 15)
	display_results(
		user,
		target,
		span_warning("You cut the wrong part of [target]'s liver!"),
		span_warning("[user] cuts the wrong part of [target]'s liver!"),
		span_warning("[user] cuts the wrong part of [target]'s liver!"),
	)
	display_pain(target, "You feel a sharp stab inside your abdomen!", mood_event_type = /datum/mood_event/surgery/failure)
