/datum/antagonist/mutant
	name = "\improper Mutated Abomination"
	job_rank = ROLE_MUTANT
	roundend_category = "mutants"
	antagpanel_category = "Mutant"
	show_in_antagpanel = TRUE
	antag_hud_name = "mutant"
	hud_icon = 'modular_skyrat/modules/mutants/icons/antag_hud.dmi'
	antag_memory = "You are a mutated abomination. You yearn for flesh. Your mind is torn apart, you do not remember who you are. \
	All you know is that you want to kill. \
	You retain some capability to reason. \
	Being friendly or helping crew will result in punishment. \
	Attacking your fellow zombies will result in punishment. \
	Hindering your fellow zombies will result in punishment."

/datum/antagonist/mutant/on_gain()
	. = ..()
	var/component = owner.current?.GetComponent(/datum/component/mutant_infection)
	if(!component)
		owner.current?.AddComponent(/datum/component/mutant_infection)
