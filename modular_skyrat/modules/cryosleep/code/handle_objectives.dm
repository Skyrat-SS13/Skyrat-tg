/datum/component/handle_objectives
	///The atom that has this component
	var/atom/atom_parent

/datum/component/handle_objectives/Initialize(allowed_mobs_override = null)
	//needs to be an atom
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	atom_parent = parent
	RegisterSignal(atom_parent, COMSIG_HANDLE_OBJECTIVES, PROC_REF(handle_objectives))

/datum/component/handle_objectives/Destroy(force, silent)
	UnregisterSignal(atom_parent, COMSIG_HANDLE_OBJECTIVES)
	return ..()

/datum/component/handle_objectives/proc/handle_objectives(mob/target)
	var/mob/living/objective_target = target
	// Update any existing objectives involving this mob.
	for(var/datum/objective/objective in GLOB.objectives)
		// We don't want revs to get objectives that aren't for heads of staff. Letting
		// them win or lose based on cryo is silly so we remove the objective.
		if(istype(objective, /datum/objective/mutiny) && objective.target == objective_target.mind)
			objective.team.objectives -= objective
			qdel(objective)
			for(var/datum/mind/mind in objective.team.members)
				to_chat(mind.current, "<BR>[span_userdanger("Your target is no longer within reach. Objective removed!")]")
				mind.announce_objectives()

		else if(istype(objective.target) && objective.target == objective_target.mind)
			if(!istype(objective, /datum/objective/contract))
				return

			var/datum/opposing_force/affected_contractor = objective.owner.opposing_force
			var/datum/contractor_hub/affected_contractor_hub = affected_contractor.contractor_hub
			for(var/datum/syndicate_contract/affected_contract as anything in affected_contractor_hub.assigned_contracts)
				if(!(affected_contract.contract == objective))
					continue

				var/contract_id = affected_contract.id
				affected_contractor_hub.create_single_contract(objective.owner, affected_contract.payout_type)
				affected_contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED
				if (affected_contractor_hub.current_contract == objective)
					affected_contractor_hub.current_contract = null

				to_chat(objective.owner.current, "<BR>[span_userdanger("Contract target out of reach. Contract rerolled.")]")
				break

		else if(istype(objective.target) && objective.target == objective_target.mind)
			var/old_target = objective.target
			objective.target = null
			if(!objective)
				return

			objective.find_target()
			if(!objective.target && objective.owner)
				to_chat(objective.owner.current, "<BR>[span_userdanger("Your target is no longer within reach. Objective removed!")]")
				for(var/datum/antagonist/antag in objective.owner.antag_datums)
					antag.objectives -= objective

			if (!objective.team)
				objective.update_explanation_text()
				objective.owner.announce_objectives()
				to_chat(objective.owner.current, "<BR>[span_userdanger("You get the feeling your target is no longer within reach. Time for Plan [pick("A","B","C","D","X","Y","Z")]. Objectives updated!")]")

			else
				var/list/objectivestoupdate
				for(var/datum/mind/objective_owner in objective.get_owners())
					to_chat(objective_owner.current, "<BR>[span_userdanger("You get the feeling your target is no longer within reach. Time for Plan [pick("A","B","C","D","X","Y","Z")]. Objectives updated!")]")
					for(var/datum/objective/update_target_objective in objective_owner.get_all_objectives())
						LAZYADD(objectivestoupdate, update_target_objective)

				objectivestoupdate += objective.team.objectives
				for(var/datum/objective/update_objective in objectivestoupdate)
					if(update_objective.target != old_target || !istype(update_objective,objective.type))
						continue

					update_objective.target = objective.target
					update_objective.update_explanation_text()
					to_chat(objective.owner.current, "<BR>[span_userdanger("You get the feeling your target is no longer within reach. Time for Plan [pick("A","B","C","D","X","Y","Z")]. Objectives updated!")]")
					update_objective.owner.announce_objectives()

			qdel(objective)
