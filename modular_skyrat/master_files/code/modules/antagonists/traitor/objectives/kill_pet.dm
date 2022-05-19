////
//	This is a modular hook on the kill_pet.dm, the `possible_heads` variable needs to be upkept according to the upstream file, or they will not occur.
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
		// They are also the only two modular additions so far
		JOB_ROBOTICIST = /mob/living/simple_animal/pet/dog/corgi/borgi,
		JOB_STATION_ENGINEER = /mob/living/simple_animal/pet/poppy,
	)

	// This variable is for the emag E-N objective. The obj details are below the next block
	var/obj/item/card/emag/one_shot/one_shot_emag


////
//	Objective overwrites
/datum/traitor_objective/kill_pet/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()
	// Dust Poppy the safety inspector
	if(istype(target_pet, /mob/living/simple_animal/pet/poppy))
		name = "Dust the engineering department's esteemed safety inspector and beloved pet, Poppy"
		description = "A couple of troublemakers in the engineering department have spilled the milk, make them and their colleagues pay for the consequences by throwing Poppy the Safety Inspector into the supermatter engine "
		telecrystal_reward = 4

		// Cleaning up the original success_signals which are `list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH)`
		for(var/datum/component/traitor_objective_register/old_objective as anything in GetComponents(/datum/component/traitor_objective_register))
			if(old_objective.target == target_pet)
				qdel(old_objective)
		// Adding our own signal component, targeting `target_pet`
		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_PARENT_QDELETING)) // Until dusting gets its own component, this has to make do

	// Emag E-N so it overloads
	if(istype(target_pet, /mob/living/simple_animal/pet/dog/corgi/borgi))
		name = "Emag the roboticist's most-prized borgi, E-N"
		description = "We received an untracable contract from someone addressed 'ianfan2489@solfed.nt', they want the robotic clone of Ian dead- and it has to be dramatic. We will supply you with a cryptographic sequencer from our basic loadout options to shortcircuit E-N's safety, it will give you a single attempt to use it. Oh, and remember to run like hell when you do... "
		telecrystal_reward = 3 // Because these are more complicated than 'kill the pet', the reward is bigger
		telecrystal_penalty = 3 // Same cost as an emag on sale

		for(var/datum/component/traitor_objective_register/old_objective as anything in GetComponents(/datum/component/traitor_objective_register))
			if(old_objective.target == target_pet)
				qdel(old_objective)

		AddComponent(/datum/component/traitor_objective_register, target_pet, \
			succeed_signals = list(COMSIG_ATOM_EMAG_ACT))

////
//	Objective item (for emagging E-N)
/obj/item/card/emag/one_shot
	name = "cryptographic sequencer"
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_DETECTIVE, JOB_HEAD_OF_SECURITY)
	special_desc = "Upon inspection you can instantly tell this is a real cryptographic sequencer commonly traded in bulk for cheap at countless blackmarkets. They are known for their unreliability and breaking after just one use from their shoddy construction."
	///How many uses does it have left?
	var/charges = 1
	///Who summoned this?
	var/caller

/obj/item/card/emag/one_shot/examine(mob/user)
	. = ..()
	if(user == caller)
		. += span_notice("It looks cheapo, they did say it gives just one shot...")
	else
		. += span_notice("It looks flimsy and identical to the \"Donk Co.\" toy.")

/obj/item/card/emag/one_shot/can_emag(atom/target, mob/user)
	if(charges <= 0)
		balloon_alert(user, "unresponsive!")
		return FALSE
	use_charge(user)
	return TRUE

/obj/item/card/emag/one_shot/proc/use_charge(mob/user)
	balloon_alert(user, "out of charges!")
	charges --


////
//	Handle the UI button, this is currently just generated by a modular objective
/datum/traitor_objective/kill_pet/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(istype(target_pet, /mob/living/simple_animal/pet/dog/corgi/borgi)) // Target has to be E-N
		if(!one_shot_emag)
			buttons += add_ui_button("", "Pressing this will materialize a single-use cryptographic sequencer in your hand, which you can use to shortcircuit E-N.", "bolt", "summon_emag")
	return buttons

/datum/traitor_objective/kill_pet/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if("summon_emag")
			if(one_shot_emag)
				return
			one_shot_emag = new(user.drop_location())
			one_shot_emag.caller = user
			user.put_in_hands(one_shot_emag)
			one_shot_emag.balloon_alert(user, "the card materializes in your hand")
			// No penalty for losing this objective item, it is up to the traitor if this is the emag they use or another
