/datum/traitor_objective/kill_pet/medium_risk
	possible_heads = list(
		JOB_HEAD_OF_PERSONNEL = list(
			/mob/living/simple_animal/pet/dog/corgi/ian,
			/mob/living/simple_animal/pet/dog/corgi/puppy/ian
		),
		JOB_CAPTAIN = /mob/living/simple_animal/pet/fox/renault,
		JOB_CHIEF_MEDICAL_OFFICER = /mob/living/simple_animal/pet/cat/runtime,
		JOB_CHIEF_ENGINEER = /mob/living/simple_animal/parrot/poly,
		// Non-heads like the warden
		JOB_ROBOTICIST = /mob/living/simple_animal/pet/dog/corgi/borgi,
		JOB_STATION_ENGINEER = /mob/living/simple_animal/pet/poppy,
	)

/datum/traitor_objective/kill_pet/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()
	// Dust Poppy, the safety inspector
	if(istype(target_pet, /mob/living/simple_animal/pet/poppy))
		name = "Dust the Chief Engineer's beloved Poppy, the safety inspector"
		description = "The Chief Engineer has particularly annoyed us by sending us spam emails, throw Poppy into the Super Matter, that will show the station. "
		qdel(GetComponent(/datum/component/traitor_objective_register))
		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_PARENT_QDELETING)) // Until dusting gets its own component, this has to make do

	// Emag E-N so it overloads
	if(istype(target_pet, /mob/living/simple_animal/pet/dog/corgi/borgi))
		name = "Emag the Research Director's beloved E-N"
		description = "The Research Director has particularly annoyed us by sending us spam emails, destroy E-N with a Cryptographic Sequencer, that'll show 'em. "
		qdel(GetComponent(/datum/component/traitor_objective_register))
		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_ATOM_EMAG_ACT))


