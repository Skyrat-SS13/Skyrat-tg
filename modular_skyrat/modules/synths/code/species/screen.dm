/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/human = owner
	var/new_ipc_screen = tgui_input_list(usr, "Choose your character's screen:", "Monitor Display", GLOB.sprite_accessories[MUTANT_SYNTH_SCREEN])

	if(!new_ipc_screen)
		return

	human.dna.species.mutant_bodyparts[MUTANT_SYNTH_SCREEN][MUTANT_INDEX_NAME] = new_ipc_screen
	human.update_body()
