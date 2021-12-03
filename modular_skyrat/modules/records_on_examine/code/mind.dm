/datum/mind/proc/handle_exploitables_menu()
	//Only returns true if no datums are present in the mind. Without this, the for loop would end prematurely, as it would be null.
	if (!antag_datums)
		if (has_exploitable_menu)
			remove_verb(current, /mob/proc/view_exploitables_verb)
			has_exploitable_menu = FALSE
		return
	var/should_see_exploitables = FALSE
	for(var/datum/antagonist/antag_datum in src?.antag_datums)
		// Players are allowed to view exploitables if they have at least one antag_datum datum with view_exploitables set to TRUE.
		if (antag_datum.view_exploitables)
			should_see_exploitables = TRUE
			break
	if(!has_exploitable_menu && should_see_exploitables)
		add_verb(current, /mob/proc/view_exploitables_verb)
		has_exploitable_menu = TRUE
		to_chat(current, span_danger("You now have access to the View-Crew-Exploitables verb, which shows all crew who currently have exploitable info and a link to view it!"))

	else if(has_exploitable_menu && !should_see_exploitables)
		remove_verb(current, /mob/proc/view_exploitables_verb)
		has_exploitable_menu = FALSE
