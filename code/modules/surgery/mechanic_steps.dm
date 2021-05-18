//open shell
/datum/surgery_step/mechanic_open
	name = "unscrew shell"
	implements = list(
		TOOL_SCREWDRIVER = 100,
		TOOL_SCALPEL = 75, // med borgs could try to unskrew shell with scalpel
		/obj/item/kitchen/knife = 50,
		/obj/item = 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unscrew the shell of [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)].</span>")
	display_pain(target, "<span class='userdanger'>You can feel your [parse_zone(target_zone)] grow numb as the sensory panel is unscrewed.</span>") //SKYRAT EDIT ADD - SURGERY PAIN

/datum/surgery_step/mechanic_incise/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE

	return TRUE

//close shell
/datum/surgery_step/mechanic_close
	name = "screw shell"
	implements = list(
		TOOL_SCREWDRIVER = 100,
		TOOL_SCALPEL = 75,
		/obj/item/kitchen/knife = 50,
		/obj/item = 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to screw the shell of [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to screw the shell of [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to screw the shell of [target]'s [parse_zone(target_zone)].</span>")
	display_pain(target, "<span class='userdanger'>You feel the faint pricks of sensation return as your [parse_zone(target_zone)]'s panel is screwed in.</span>") //SKYRAT EDIT ADD - SURGERY PAIN

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE

	return TRUE

//prepare electronics
/datum/surgery_step/prepare_electronics
	name = "prepare electronics"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 10) // try to reboot internal controllers via short circuit with some conductor
	time = 24

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to prepare electronics in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)].</span>")
	display_pain(target, "<span class='userdanger'>You can feel a faint buzz in your [parse_zone(target_zone)] as the electronics reboot.</span>") //SKYRAT EDIT ADD - SURGERY PAIN
//unwrench
/datum/surgery_step/mechanic_unwrench
	name = "unwrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 24

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unwrench some bolts in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)].</span>")
	display_pain(target, "<span class='userdanger'>You feel a jostle in your [parse_zone(target_zone)] as the bolts begin to loosen.</span>") //SKYRAT EDIT ADD - SURGERY PAIN

//wrench
/datum/surgery_step/mechanic_wrench
	name = "wrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 24

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to wrench some bolts in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)].</span>")
	display_pain(target, "<span class='userdanger'>You feel a jostle in your [parse_zone(target_zone)] as the bolts begin to tighten.</span>") //SKYRAT EDIT ADD - SURGERY PAIN

//open hatch
/datum/surgery_step/open_hatch
	name = "open the hatch"
	accept_hand = 1
	time = 10

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to open the hatch holders in [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)].</span>")
	display_pain(target, "<span class='userdanger'>The last faint pricks of tactile sensation fade from your [parse_zone(target_zone)] as the hatch is opened.</span>") //SKYRAT EDIT ADD - SURGERY PAIN
