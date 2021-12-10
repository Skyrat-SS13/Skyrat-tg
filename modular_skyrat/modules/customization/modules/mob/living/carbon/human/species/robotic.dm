/datum/species/robotic
	say_mod = "beeps"
	default_color = "#00FF00"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	inherent_traits = list(
		TRAIT_CAN_STRIP,
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
		TRAIT_OXYIMMUNE
	)
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	burnmod = 1.5 // Every 0.1% is 10% above the base.
	brutemod = 1.6
	coldmod = 1.2
	heatmod = 2
	siemens_coeff = 1.4 //Not more because some shocks will outright crit you, which is very unfun
	payday_modifier = 0.5 //Robots are cheep labor
	species_language_holder = /datum/language_holder/machine
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutantbrain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutantheart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	exotic_blood = /datum/reagent/fuel/oil
	learnable_languages = list(/datum/language/common, /datum/language/machine)

/datum/species/robotic/spec_life(mob/living/carbon/human/H)
	if(H.stat == SOFT_CRIT || H.stat == HARD_CRIT)
		H.adjustFireLoss(1) //Still deal some damage in case a cold environment would be preventing us from the sweet release to robot heaven
		H.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(H, span_warning("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, TRUE, H)

/datum/species/robotic/spec_revival(mob/living/carbon/human/H)
	playsound(H.loc, 'sound/machines/chime.ogg', 50, 1, -1)
	H.visible_message(span_notice("[H]'s monitor lights up."), span_notice("All systems nominal. You're back online!"))

/datum/species/robotic/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	var/obj/item/organ/appendix/appendix = C.getorganslot(ORGAN_SLOT_APPENDIX)
	if(appendix)
		appendix.Remove(C)
		qdel(appendix)

/datum/species/robotic/random_name(gender,unique,lastname)
	var/randname = pick(GLOB.posibrain_names)
	randname = "[randname]-[rand(100, 999)]"
	return randname

/datum/species/robotic/ipc
	name = "I.P.C."
	id = SPECIES_IPC
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		EYECOLOR,
		LIPS,
		HAIR,
		NOEYESPRITES,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		REVIVES_BY_HEALING
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"ipc_screen" = ACC_RANDOM,
		"ipc_chassis" = ACC_RANDOM
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/ipc_parts.dmi'
	hair_alpha = 210
	sexes = 0
	var/datum/action/innate/monitor_change/screen
	var/saved_screen = "Blank"

/datum/species/robotic/ipc/spec_revival(mob/living/carbon/human/H)
	. = ..()
	//TODO: fix this
	/*H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = "BSOD"
	sleep(3 SECONDS)*/
	H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = saved_screen

/datum/species/robotic/ipc/spec_death(gibbed, mob/living/carbon/human/H)
	. = ..()
	saved_screen = H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME]
	//TODO: fix this
	/*H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = "BSOD"
	sleep(3 SECONDS)*/
	H.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = "Blank"

/datum/species/robotic/ipc/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	if(!screen)
		screen = new
		screen.Grant(C)
	var/chassis = C.dna.mutant_bodyparts["ipc_chassis"]
	if(!chassis)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis[MUTANT_INDEX_NAME]]
	if(chassis_of_choice)
		limbs_id = chassis_of_choice.icon_state
		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		C.update_body()

/datum/species/robotic/ipc/on_species_loss(mob/living/carbon/human/C)
	. = ..()
	if(screen)
		screen.Remove(C)
	..()

/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/H = owner
	var/new_ipc_screen = input(usr, "Choose your character's screen:", "Monitor Display") as null|anything in GLOB.sprite_accessories["ipc_screen"]
	if(!new_ipc_screen)
		return
	H.dna.species.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = new_ipc_screen
	H.update_body()

/datum/species/robotic/synthliz
	name = "Synthetic Lizardperson"
	id = SPECIES_SYNTHLIZ
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS,EYECOLOR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		REVIVES_BY_HEALING
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"legs" = "Digitigrade Legs",
		"taur" = "None",
		"wings" = "None"
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/synthliz_parts_greyscale.dmi'

/datum/species/robotic/synthliz/get_random_body_markings(list/passed_features)
	var/name = pick("Synth Pecs Lights", "Synth Scutes", "Synth Pecs")
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/robotic/synthetic_mammal
	name = "Synthetic Anthromorph"
	id = SPECIES_SYNTHMAMMAL
	say_mod = "states"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	default_color = "#4B4B4B"
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		MUTCOLORS,EYECOLOR,
		LIPS,HAIR,
		ROBOTIC_LIMBS,
		NOTRANSSTING,
		REVIVES_BY_HEALING,
		FACEHAIR
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"horns" = "None",
		"ears" = ACC_RANDOM,
		"legs" = ACC_RANDOM,
		"taur" = "None",
		"fluff" = "None",
		"wings" = "None",
		"head_acc" = "None",
		"neck_acc" = "None"
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'

/datum/species/robotic/synthetic_mammal/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,7)
	switch(random)
		if(1)
			main_color = "#FFFFFF"
			second_color = "#333333"
			third_color = "#333333"
		if(2)
			main_color = "#FFFFDD"
			second_color = "#DD6611"
			third_color = "#AA5522"
		if(3)
			main_color = "#DD6611"
			second_color = "#FFFFFF"
			third_color = "#DD6611"
		if(4)
			main_color = "#CCCCCC"
			second_color = "#FFFFFF"
			third_color = "#FFFFFF"
		if(5)
			main_color = "#AA5522"
			second_color = "#CC8833"
			third_color = "#FFFFFF"
		if(6)
			main_color = "#FFFFDD"
			second_color = "#FFEECC"
			third_color = "#FFDDBB"
		if(7) //Oh no you've rolled the sparkle dog
			main_color = "#[random_color()]"
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

/datum/species/robotic/synthetic_mammal/get_random_body_markings(list/passed_features)
	var/name = "None"
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/robotic/synthetic_human
	name = "Synthetic Humanoid"
	id = SPECIES_SYNTHHUMAN
	say_mod = "states"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	species_traits = list(
		ROBOTIC_DNA_ORGANS,
		EYECOLOR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		REVIVES_BY_HEALING,
		FACEHAIR,
		NOTRANSSTING
	)
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)
	use_skintones = TRUE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	species_language_holder = /datum/language_holder/machine
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/synthhuman_parts_greyscale.dmi'
