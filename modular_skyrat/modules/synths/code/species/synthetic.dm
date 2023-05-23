/datum/species/synthetic
	name = "Synthetic Humanoid"
	id = SPECIES_SYNTH
	say_mod = "beeps"
	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	inherent_traits = list(
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_NOCLONELOSS,
		TRAIT_GENELESS,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NO_HUSK,
		TRAIT_OXYIMMUNE,
		TRAIT_LITERATE,
	)
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"snout" = "None",
		MUTANT_SYNTH_ANTENNA = "None",
		MUTANT_SYNTH_SCREEN = "None",
		MUTANT_SYNTH_CHASSIS = "Default Chassis",
		MUTANT_SYNTH_HEAD = "Default Head",
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	payday_modifier = 0.75 // Matches the rest of the pay penalties the non-human crew have
	species_language_holder = /datum/language_holder/machine
	mutant_organs = list(/obj/item/organ/internal/cyberimp/arm/power_cord)
	mutantbrain = /obj/item/organ/internal/brain/synth
	mutantstomach = /obj/item/organ/internal/stomach/synth
	mutantears = /obj/item/organ/internal/ears/synth
	mutanttongue = /obj/item/organ/internal/tongue/synth
	mutanteyes = /obj/item/organ/internal/eyes/synth
	mutantlungs = /obj/item/organ/internal/lungs/synth
	mutantheart = /obj/item/organ/internal/heart/synth
	mutantliver = /obj/item/organ/internal/liver/synth
	mutantappendix = null
	exotic_blood = /datum/reagent/fuel/oil
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/synth,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/synth,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/synth,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/synth,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/synth,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/synth,
	)
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	burnmod = 1.3 // Every 0.1 is 10% above the base.
	brutemod = 1.3
	coldmod = 1.2
	heatmod = 2 // TWO TIMES DAMAGE FROM BEING TOO HOT?! WHAT?! No wonder lava is literal instant death for us.
	siemens_coeff = 1.4 // Not more because some shocks will outright crit you, which is very unfun
	/// The innate action that synths get, if they've got a screen selected on species being set.
	var/datum/action/innate/monitor_change/screen
	/// This is the screen that is given to the user after they get revived. On death, their screen is temporarily set to BSOD before it turns off, hence the need for this var.
	var/saved_screen = "Blank"
	wing_types = list(/obj/item/organ/external/wings/functional/robotic)

/datum/species/synthetic/spec_life(mob/living/carbon/human/human)
	if(human.stat == SOFT_CRIT || human.stat == HARD_CRIT)
		human.adjustFireLoss(1) //Still deal some damage in case a cold environment would be preventing us from the sweet release to robot heaven
		human.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(human, span_warning("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, TRUE, human)

/datum/species/synthetic/spec_revival(mob/living/carbon/human/transformer)
	switch_to_screen(transformer, "Console")
	addtimer(CALLBACK(src, PROC_REF(switch_to_screen), transformer, saved_screen), 5 SECONDS)
	playsound(transformer.loc, 'sound/machines/chime.ogg', 50, TRUE)
	transformer.visible_message(span_notice("[transformer]'s [screen ? "monitor lights up" : "eyes flicker to life"]!"), span_notice("All systems nominal. You're back online!"))

/datum/species/synthetic/spec_death(gibbed, mob/living/carbon/human/transformer)
	. = ..()
	saved_screen = screen
	switch_to_screen(transformer, "BSOD")
	addtimer(CALLBACK(src, PROC_REF(switch_to_screen), transformer, "Blank"), 5 SECONDS)

/datum/species/synthetic/on_species_gain(mob/living/carbon/human/transformer)
	. = ..()

	var/screen_mutant_bodypart = transformer.dna.mutant_bodyparts[MUTANT_SYNTH_SCREEN]
	var/obj/item/organ/internal/eyes/eyes = transformer.get_organ_slot(ORGAN_SLOT_EYES)

	if(!screen && screen_mutant_bodypart && screen_mutant_bodypart[MUTANT_INDEX_NAME] && screen_mutant_bodypart[MUTANT_INDEX_NAME] != "None")

		if(eyes)
			eyes.eye_icon_state = "None"

		screen = new
		screen.Grant(transformer)

		return

	if(eyes)
		eyes.eye_icon_state = initial(eyes.eye_icon_state)


/datum/species/synthetic/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	var/list/chassis = target.dna.mutant_bodyparts[MUTANT_SYNTH_CHASSIS]
	var/list/head = target.dna.mutant_bodyparts[MUTANT_SYNTH_HEAD]
	if(!chassis && !head)
		return

	var/datum/sprite_accessory/synth_chassis/chassis_of_choice = GLOB.sprite_accessories[MUTANT_SYNTH_CHASSIS][chassis[MUTANT_INDEX_NAME]]
	var/datum/sprite_accessory/synth_head/head_of_choice = GLOB.sprite_accessories[MUTANT_SYNTH_HEAD][head[MUTANT_INDEX_NAME]]
	if(!chassis_of_choice && !head_of_choice)
		return

	examine_limb_id = chassis_of_choice.icon_state

	if(chassis_of_choice.color_src || head_of_choice.color_src)
		species_traits += MUTCOLORS

	// We want to ensure that the IPC gets their chassis and their head correctly.
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.limb_id != SPECIES_SYNTH && initial(limb.base_limb_id) != SPECIES_SYNTH) // No messing with limbs that aren't actually synthetic.
			continue

		if(limb.body_zone == BODY_ZONE_HEAD)
			if(head_of_choice.color_src && head[MUTANT_INDEX_COLOR_LIST] && length(head[MUTANT_INDEX_COLOR_LIST]))
				limb.variable_color = head[MUTANT_INDEX_COLOR_LIST][1]
			limb.change_appearance(head_of_choice.icon, head_of_choice.icon_state, !!head_of_choice.color_src, head_of_choice.dimorphic)
			continue

		if(chassis_of_choice.color_src && chassis[MUTANT_INDEX_COLOR_LIST] && length(chassis[MUTANT_INDEX_COLOR_LIST]))
			limb.variable_color = chassis[MUTANT_INDEX_COLOR_LIST][1]
		limb.change_appearance(chassis_of_choice.icon, chassis_of_choice.icon_state, !!chassis_of_choice.color_src, limb.body_part == CHEST && chassis_of_choice.dimorphic)
		limb.name = "\improper[chassis_of_choice.name] [parse_zone(limb.body_zone)]"


/datum/species/synthetic/on_species_loss(mob/living/carbon/human/human)
	. = ..()

	var/obj/item/organ/internal/eyes/eyes = human.get_organ_slot(ORGAN_SLOT_EYES)

	if(eyes)
		eyes.eye_icon_state = initial(eyes.eye_icon_state)

	if(screen)
		screen.Remove(human)

/**
 * Simple proc to switch the screen of a monitor-enabled synth, while updating their appearance.
 *
 * Arguments:
 * * transformer - The human that will be affected by the screen change (read: IPC).
 * * screen_name - The name of the screen to switch the ipc_screen mutant bodypart to.
 */
/datum/species/synthetic/proc/switch_to_screen(mob/living/carbon/human/tranformer, screen_name)
	if(!screen)
		return

	tranformer.dna.mutant_bodyparts[MUTANT_SYNTH_SCREEN][MUTANT_INDEX_NAME] = screen_name
	tranformer.update_body()

/datum/species/synthetic/random_name(gender, unique, lastname)
	var/randname = pick(GLOB.posibrain_names)
	randname = "[randname]-[rand(100, 999)]"
	return randname

/datum/species/synthetic/get_types_to_preload()
	return ..() - typesof(/obj/item/organ/internal/cyberimp/arm/power_cord) // Don't cache things that lead to hard deletions.


/datum/species/synthetic/prepare_human_for_preview(mob/living/carbon/human/beepboop)
	beepboop.dna.mutant_bodyparts[MUTANT_SYNTH_SCREEN] = list(MUTANT_INDEX_NAME = "Console", MUTANT_INDEX_COLOR_LIST = list(COLOR_WHITE, COLOR_WHITE, COLOR_WHITE))
	regenerate_organs(beepboop, src, visual_only = TRUE)
	beepboop.update_body(TRUE)
