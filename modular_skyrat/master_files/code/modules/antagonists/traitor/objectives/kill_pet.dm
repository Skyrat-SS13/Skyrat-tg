/datum/traitor_objective/kill_pet
	. = ..()
	var/list/possible_heads_addition = list(
		JOB_RESEARCH_DIRECTOR = /mob/living/simple_animal/pet/dog/corgi/borgi,
	//	JOB_CHIEF_ENGINEER = /mob/living/simple_animal/pet/poppy,
	)

	possible_heads += possible_heads_addition

/datum/traitor_objective/kill_pet/generate_objective()
	. = ..()
	// Emag E-N so it overloads
	if(target_pet == /mob/living/simple_animal/pet/dog/corgi/borgi)
		description = "The %DEPARTMENT HEAD% has particularly annoyed us by sending us spam emails, destroy %PET% with a Cryptographic Sequencer, that'll show 'em. "
		qdel(target_pet.GetComponent(/datum/component/traitor_objective_register))
		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_ATOM_EMAG_ACT))

	// Dust Poppy, the safety inspector
//	if(target_pet == /mob/living/simple_animal/pet/poppy)
//		description = "The %DEPARTMENT HEAD% has particularly annoyed us by sending us spam emails, throw %PET% into the Super Matter and dust 'em as a warning. "
