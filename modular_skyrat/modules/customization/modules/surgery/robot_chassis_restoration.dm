/datum/surgery/positronic_restoration
	name = "Posibrain Reboot (Revival)"
	steps = list(
	/datum/surgery_step/mechanic_unwrench,
	/datum/surgery_step/pry_off_plating/fullbody,
	/datum/surgery_step/cut_wires/fullbody,
	/datum/surgery_step/replace_wires/fullbody,
	/datum/surgery_step/prepare_electronics,
	/datum/surgery_step/add_plating/fullbody,
	/datum/surgery_step/weld_plating/fullbody,
	/datum/surgery_step/finalize_positronic_restoration)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYPART_ROBOTIC
	desc = "A surgical procedure that reboots a positronic brain."

/datum/surgery/robot_chassis_restoration/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	if(target.stat != DEAD)
		return FALSE
	if(target.suiciding)
		return FALSE
	var/obj/item/organ/brain/target_brain = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE
	return TRUE

/datum/surgery_step/pry_off_plating/fullbody
	time = 120

/datum/surgery_step/pry_off_plating/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to pry open compromised panels on [target]'s braincase..."),
			span_notice("[user] begins to pry open compromised panels on [target]'s braincase."))

/datum/surgery_step/cut_wires/fullbody
	time = 120

/datum/surgery_step/cut_wires/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to trim [target]'s nonfunctional wires..."),
			span_notice("[user] begins to cut [target]'s loose wires."))

/datum/surgery_step/weld_plating/fullbody
	time = 120

/datum/surgery_step/weld_plating/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to slice compromised panels from [target]'s braincase..."),
			span_notice("[user] begins to slice compromised panels from [target]'s braincase."))

/datum/surgery_step/replace_wires/fullbody
	time = 72
	cableamount = 15

/datum/surgery_step/replace_wires/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to replace [target]'s wiring..."),
			span_notice("[user] begins to replace [target]'s wiring."))

/datum/surgery_step/add_plating/fullbody
	time = 120
	ironamount = 15

/datum/surgery_step/add_plating/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to add new panels to [target]'s braincase..."),
			span_notice("[user] begins to add new panels to [target]'s braincase."))

/datum/surgery_step/finalize_positronic_restoration
	name = "finalize positronic restoration (multitool)"
	implements = list(
		TOOL_MULTITOOL = 100,
	)
	repeatable = FALSE
	time = 120

/datum/surgery_step/finalize_positronic_restoration/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to force a reboot in [target]'s posibrain..."),
			span_notice("[user] begins to force a reboot in [target]'s posibrain."))
	target.notify_ghost_cloning("Someone is trying to reboot your posibrain.", source = target)

/datum/surgery_step/finalize_positronic_restoration/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	target.cure_husk()
	target.grab_ghost()
	target.updatehealth()
	target.setOrganLoss(ORGAN_SLOT_BRAIN, target.getOrganLoss(ORGAN_SLOT_BRAIN) - 200)
	if(target.revive(full_heal = FALSE, admin_revive = FALSE))
		return TRUE
	else
		target.emote("chime")
		target.visible_message(span_notice("...[target] reactivates, their chassis coming online!"))
		to_chat(target, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))
		return FALSE

