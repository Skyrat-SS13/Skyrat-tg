/datum/species/ipc
	name = "I.P.C."
	id = "ipc"
	say_mod = "beeps"
	default_color = "00FF00"
	species_traits = list(MUTCOLORS_PARTSONLY,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,HAIR,NOEYESPRITES)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	default_features = null
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("ipc_antenna" = ACC_RANDOM, "ipc_screen" = ACC_RANDOM, "ipc_chassis" = ACC_RANDOM)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/modules/customization/icons/mob/species/ipc_parts.dmi'
	hair_alpha = 210
	sexes = 0
	var/datum/action/innate/monitor_change/screen

/datum/species/ipc/on_species_gain(mob/living/carbon/human/C)
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

/datum/species/ipc/on_species_loss(mob/living/carbon/human/C)
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
