/datum/admins/proc/makeAssaultTeam()
	var/datum/game_mode/assaultops/temp = new
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for an assault team being sent in?", ROLE_ASSAULTOPS, temp)
	var/list/mob/dead/observer/chosen = list()
	var/mob/dead/observer/theghost = null
	var/numagents = 5

	if(candidates.len)
		var/agentcount = 0

		for(var/i = 0, i<numagents,i++)
			shuffle_inplace(candidates) //More shuffles means more randoms
			for(var/mob/j in candidates)
				if(!j || !j.client)
					candidates.Remove(j)
					continue

				theghost = j
				candidates.Remove(theghost)
				chosen += theghost
				agentcount++
				break
		//Making sure we have atleast 3 Nuke agents, because less than that is kinda bad
		if(agentcount < 3)
			return FALSE

		//Let's find the spawn locations
		var/leader_chosen = FALSE
		var/datum/team/assaultops/assault_team
		for(var/mob/c in chosen)
			var/mob/living/carbon/human/new_character=makeBody(c)
			if(!leader_chosen)
				leader_chosen = TRUE
				var/datum/antagonist/assaultops/N = new_character.mind.add_antag_datum(/datum/antagonist/assaultops/leader)
				assault_team = N.assault_team
			else
				new_character.mind.add_antag_datum(/datum/antagonist/assaultops,assault_team)
		return TRUE
	else
		return FALSE

/datum/antagonist/assaultops/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_SYNDICATE
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has assault op'ed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has assault op'ed [key_name(new_owner)].")

/datum/antagonist/assaultops/get_admin_commands()
	. = ..()
	.["Send to base"] = CALLBACK(src,.proc/admin_send_to_base)

/datum/antagonist/assaultops/proc/admin_send_to_base(mob/admin)
	owner.current.forceMove(pick(get_turf(GLOB.assaultop_start)))

