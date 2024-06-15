/datum/surgery/lipoplasty
	name = "Lipoplasty"
	possible_locs = list(BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/cut_fat,
		/datum/surgery_step/remove_fat,
		/datum/surgery_step/close,
	)

/datum/surgery/lipoplasty/can_start(mob/user, mob/living/carbon/target)
	if(!HAS_TRAIT_FROM(target, TRAIT_FAT, OBESITY) || target.nutrition < NUTRITION_LEVEL_WELL_FED)
		return FALSE
	return ..()


//cut fat
/datum/surgery_step/cut_fat
	name = "cut excess fat (circular saw)"
	implements = list(
		TOOL_SAW = 100,
		/obj/item/shovel/serrated = 75,
		/obj/item/hatchet = 35,
		/obj/item/knife/butcher = 25)
	time = 64
	preop_sound = list(
		/obj/item/circular_saw = 'sound/surgery/saw.ogg',
		/obj/item = 'sound/surgery/scalpel1.ogg',
	)

/datum/surgery_step/cut_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message(span_notice("[user] begins to cut away [target]'s excess fat."), span_notice("You begin to cut away [target]'s excess fat..."))
	display_results(
		user,
		target,
		span_notice("You begin to cut away [target]'s excess fat..."),
		span_notice("[user] begins to cut away [target]'s excess fat."),
		span_notice("[user] begins to cut [target]'s [target_zone] with [tool]."),
	)
	display_pain(target, "You feel a stabbing in your [target_zone]!", mood_event_type = /datum/mood_event/surgery)

/datum/surgery_step/cut_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	display_results(
		user,
		target,
		span_notice("You cut [target]'s excess fat loose."),
		span_notice("[user] cuts [target]'s excess fat loose!"),
		span_notice("[user] finishes the cut on [target]'s [target_zone]."),
	)
	display_pain(target, "The fat in your [target_zone] comes loose, dangling and hurting like hell!", mood_event_type = /datum/mood_event/surgery/success)
	return TRUE

/datum/surgery_step/cut_fat/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	display_pain(target, mood_event_type = /datum/mood_event/surgery/failure)
	return ..()

//remove fat
/datum/surgery_step/remove_fat
	name = "remove loose fat (retractor)"
	implements = list(
		TOOL_RETRACTOR = 100,
		TOOL_SCREWDRIVER = 45,
		TOOL_WIRECUTTER = 35)
	time = 32
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'

/datum/surgery_step/remove_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to extract [target]'s loose fat..."),
		span_notice("[user] begins to extract [target]'s loose fat!"),
		span_notice("[user] begins to extract something from [target]'s [target_zone]."),
	)
	display_pain(target, "You feel an oddly painless tugging on your loose fat!")

/datum/surgery_step/remove_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You extract [target]'s fat."),
		span_notice("[user] extracts [target]'s fat!"),
		span_notice("[user] extracts [target]'s fat!"),
	)
	target.overeatduration = 0 //patient is unfatted
	var/removednutriment = target.nutrition
	target.set_nutrition(NUTRITION_LEVEL_WELL_FED)
	removednutriment -= NUTRITION_LEVEL_WELL_FED //whatever was removed goes into the meat
	var/mob/living/carbon/human/human = target
	var/typeofmeat = /obj/item/food/meat/slab/human

	if(target.flags_1 & HOLOGRAM_1)
		typeofmeat = null
	else if(human.dna && human.dna.species)
		typeofmeat = human.dna.species.meat

	if(typeofmeat)
		var/obj/item/food/meat/slab/human/newmeat = new typeofmeat
		newmeat.name = "fatty meat"
		newmeat.desc = "Extremely fatty tissue taken from a patient."
		newmeat.subjectname = human.real_name
		newmeat.subjectjob = human.job
		newmeat.reagents.add_reagent (/datum/reagent/consumable/nutriment, (removednutriment / 15)) //To balance with nutriment_factor of nutriment
		newmeat.forceMove(target.loc)
	return ..()
