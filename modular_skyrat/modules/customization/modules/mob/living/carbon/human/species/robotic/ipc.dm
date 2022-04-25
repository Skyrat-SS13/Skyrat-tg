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
	)
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"ipc_antenna" = ACC_RANDOM,
		"ipc_screen" = ACC_RANDOM,
		"ipc_chassis" = ACC_RANDOM
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	hair_alpha = 210
	sexes = 0
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/mutant/ipc,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/mutant/ipc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/mutant/ipc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/mutant/ipc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/robot/mutant/ipc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/robot/mutant/ipc,
	)
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
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis]
	if(chassis_of_choice)
		examine_limb_id = chassis_of_choice.icon_state
		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		C.update_body()

/datum/species/robotic/ipc/replace_body(mob/living/carbon/target, datum/species/new_species)
	..()
	var/chassis = target.dna.mutant_bodyparts["ipc_chassis"]
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis]
	if(!chassis)
		return
	for(var/obj/item/bodypart/iterating_bodypart as anything in target.bodyparts) //Override bodypart data as necessary
		iterating_bodypart.uses_mutcolor = chassis_of_choice.color_src ? TRUE : FALSE
		if(iterating_bodypart.uses_mutcolor)
			iterating_bodypart.should_draw_greyscale = TRUE
			iterating_bodypart.species_color = target.dna?.features["mcolor"]
		iterating_bodypart.limb_id = chassis_of_choice.icon_state
		iterating_bodypart.name = "\improper[chassis_of_choice.name] [parse_zone(iterating_bodypart.body_zone)]"
		iterating_bodypart.update_limb()

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
