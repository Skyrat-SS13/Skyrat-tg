/datum/mind/proc/handle_exploitables_menu()
	//Only returns true if no datums are present in the mind. Without this, the for loop would end prematurely, as it would be null.
	if (!antag_datums)
		if (has_exploitable_menu)
			remove_verb(current, /mob/proc/view_exploitables_verb)
			has_exploitable_menu = FALSE
			return
		return
	//Remove the verb and set the tracker to false if this datum has no exploitables, but dont break, so it can be overridden if another datum is found with exploitables.
	for(var/datum/antagonist/antag_datum in src?.antag_datums)
		if (!(antag_datum.view_exploitables) && has_exploitable_menu)
			remove_verb(current, /mob/proc/view_exploitables_verb)
			has_exploitable_menu = FALSE
			continue
		//We don't need to keep trying if we find a datum with exploitables. Players are allowed to view exploitables if they have at least one datum with the var. So, break.
		if (antag_datum.view_exploitables)
			if (!has_exploitable_menu)
				add_verb(current, /mob/proc/view_exploitables_verb)
				has_exploitable_menu = TRUE
				break
			break
