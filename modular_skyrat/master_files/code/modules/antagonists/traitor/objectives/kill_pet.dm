/datum/traitor_objective/kill_pet
	possible_heads = list(
		JOB_HEAD_OF_PERSONNEL = list(
			/mob/living/simple_animal/pet/dog/corgi/ian,
			/mob/living/simple_animal/pet/dog/corgi/puppy/ian
		),
		JOB_CAPTAIN = /mob/living/simple_animal/pet/fox/renault,
		JOB_CHIEF_MEDICAL_OFFICER = /mob/living/simple_animal/pet/cat/runtime,
		JOB_CHIEF_ENGINEER = /mob/living/simple_animal/parrot/poly,
		// Non-heads like the warden, these are automatically medium-risk at minimum
		JOB_ROBOTICIST = /mob/living/simple_animal/pet/dog/corgi/borgi,
		JOB_STATION_ENGINEER = /mob/living/simple_animal/pet/poppy,
	)

/datum/traitor_objective/kill_pet/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()
	// Dust Poppy, the safety inspector
	if(istype(target_pet, /mob/living/simple_animal/pet/poppy))
		name = "Dust the engineering department's esteemed safety inspector and beloved pet, Poppy"
		description = "A couple of troublemakers in the engineering department have spilled the milk, make them and their colleagues pay for the consequences by throwing Poppy, the safty inspector into the Super Matter engine. "
		qdel(GetComponent(/datum/component/traitor_objective_register))
		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_PARENT_QDELETING)) // Until dusting gets its own component, this has to make do

	// Emag E-N so it overloads
	if(istype(target_pet, /mob/living/simple_animal/pet/dog/corgi/borgi))
		name = "Emag the roboticist's most-prized borgi, E-N"
		description = "We received an untracable contract from someone addressed 'ianfan2489@solgov.nt', they want the robotic clone of Ian dead- and it has to be dramatic. Shortcircuit E-N's safety with a Cryptographic Sequencer and run like hell. "
		qdel(GetComponent(/datum/component/traitor_objective_register))
		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_ATOM_EMAG_ACT))
