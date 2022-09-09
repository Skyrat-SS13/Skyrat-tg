/datum/dynamic_ruleset/midround/from_living/autotraitor
	antag_datum = /datum/antagonist/traitor/saboteur

// modular override of `/datum/dynamic_ruleset/midround/autotraitor/execute()`'s original function, keep as similar to the original ruleset's code as possible
/datum/dynamic_ruleset/midround/from_living/autotraitor/execute()
	var/mob/picked_mob = pick(candidates)
	assigned += picked_mob
	candidates -= picked_mob
	var/datum/antagonist/traitor/saboteur/new_traitor = new
	picked_mob.mind.add_antag_datum(new_traitor)
	message_admins("[ADMIN_LOOKUPFLW(picked_mob)] was selected by the [name] ruleset and has been made into a midround traitor.")
	log_game("DYNAMIC: [key_name(picked_mob)] was selected by the [name] ruleset and has been made into a midround traitor.")
	return TRUE
