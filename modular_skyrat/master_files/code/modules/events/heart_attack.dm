/datum/round_event_control/heart_attack/generate_candidates()
	heart_attack_candidates.Cut()
	for(var/mob/living/carbon/human/candidate in shuffle(GLOB.player_list))
		if(candidate.stat == DEAD || HAS_TRAIT(candidate, TRAIT_CRITICAL_CONDITION) || !candidate.can_heartattack() || (/datum/disease/heart_failure in candidate.diseases) || candidate.undergoing_cardiac_arrest())
			continue
		if(!(candidate.mind.assigned_role.job_flags & JOB_CREW_MEMBER))//only crewmembers can get one, a bit unfair for some ghost roles and it wastes the event
			continue
		var/turf/candidate_turf = get_turf(candidate)
		if(!is_station_level(candidate_turf.z))
			continue
		if(candidate.satiety <= -60 && !candidate.has_status_effect(/datum/status_effect/exercised)) //Multiple junk food items recently //No foodmaxxing for the achievement
			heart_attack_candidates[candidate] = 3
		else
			heart_attack_candidates[candidate] = 1
