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
		"ipc_chassis" = ACC_RANDOM,
		"ipc_head" = ACC_RANDOM
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

/datum/species/robotic/ipc/spec_revival(mob/living/carbon/human/transformer)
	. = ..()
	switch_to_screen(transformer, "Console")
	addtimer(CALLBACK(src, .proc/switch_to_screen, transformer, saved_screen), 5 SECONDS)

/datum/species/robotic/ipc/spec_death(gibbed, mob/living/carbon/human/transformer)
	. = ..()
	saved_screen = transformer.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME]
	switch_to_screen(transformer, "BSOD")
	addtimer(CALLBACK(src, .proc/switch_to_screen, transformer, "Blank"), 5 SECONDS)

/**
 * Simple proc to switch the screen of an IPC and ensuring it updates their appearance.
 *
 * Arguments:
 * * transformer - The human that will be affected by the screen change (read: IPC).
 * * screen_name - The name of the screen to switch the ipc_screen mutant bodypart to.
 */
/datum/species/robotic/ipc/proc/switch_to_screen(mob/living/carbon/human/tranformer, screen_name)
	tranformer.dna.mutant_bodyparts["ipc_screen"][MUTANT_INDEX_NAME] = screen_name
	tranformer.update_body()

/datum/species/robotic/ipc/on_species_gain(mob/living/carbon/human/transformer)
	. = ..()
	if(!screen)
		screen = new
		screen.Grant(transformer)
	var/chassis = transformer.dna.mutant_bodyparts["ipc_chassis"]
	var/head = transformer.dna.mutant_bodyparts["ipc_head"]
	if(!chassis && !head)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis["name"]]
	var/datum/sprite_accessory/ipc_head/head_of_choice = GLOB.sprite_accessories["ipc_head"][head["name"]]
	if(chassis_of_choice || head_of_choice)
		examine_limb_id = chassis_of_choice?.icon_state ? chassis_of_choice.icon_state : head_of_choice.icon_state
		// We want to ensure that the IPC gets their chassis and their head correctly.
		for(var/obj/item/bodypart/limb as anything in transformer.bodyparts)
			if(chassis && limb.body_part == CHEST)
				limb.limb_id = chassis_of_choice.icon_state != "none" ? chassis_of_choice.icon_state : "ipc"
				continue

			if(head && limb.body_part == HEAD)
				limb.limb_id = head_of_choice.icon_state != "none" ? head_of_choice.icon_state : "ipc"

		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		transformer.update_body()

/datum/species/robotic/ipc/replace_body(mob/living/carbon/target, datum/species/new_species)
	..()
	var/chassis = target.dna.mutant_bodyparts["ipc_chassis"]
	if(!chassis)
		return
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.sprite_accessories["ipc_chassis"][chassis["name"]]

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
