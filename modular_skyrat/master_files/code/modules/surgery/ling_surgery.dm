/datum/surgery/parastic_extraction
	name = "Parasitic Extraction"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/parastic_extraction,
		/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery/parastic_extraction/can_start(mob/user, mob/living/carbon/target)
	if(target.mind.has_antag_datum(/datum/antagonist/changeling) && HAS_TRAIT(user, TRAIT_ROD_SUPLEX)) //Good enough to limit it to those with the RD skillchip.
		return TRUE
	return FALSE

/datum/surgery_step/parastic_extraction
	name = "parasitic extraction"
	implements = list(
		TOOL_SCALPEL = 95,
		/obj/item/melee/transforming/energy/sword = 65,
		/obj/item/kitchen/knife = 45,
		/obj/item/shard = 35)
	time = 200

/datum/surgery_step/parastic_extraction/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to make an incision in [target]'s parasitic vine..."),
		span_notice("[user] begins to make an incision in [target]."),
		span_notice("[user] begins to make an incision in [target]."))

/datum/surgery_step/parastic_extraction/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(target.mind.has_antag_datum(/datum/antagonist/changeling))
		display_results(user, target, span_notice("You successfully neutralize the parasite in [target] as it wriggles weakly."),
			span_notice("Successfully neutralizes [target]'s parasite."),
			"")
		to_chat(target, span_userdanger("Our genes scream out as we are disconnected and kill- AGHHHHHH-... you come to the realisation that you were never yourself."))
		target.mind.remove_antag_datum(/datum/antagonist/changeling)
	return ..()

/datum/surgery_step/parastic_extraction/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		display_results(user, target, span_warning("You screw up, failing to excise [human_target]'s parasite!"),
			span_warning("[user] screws up!"),
			span_warning("[user] screws up!"))
		human_target.losebreath += 4
		human_target.adjustOrganLoss(ORGAN_SLOT_LUNGS, 10)
	return FALSE
