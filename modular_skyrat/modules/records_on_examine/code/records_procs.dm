/datum/mind/proc/handle_exploitables()

	if (has_exploitables_override)
		if (!can_see_exploitables)
			can_see_exploitables = TRUE
		handle_exploitables_menu()
		return

	if (!antag_datums)
		can_see_exploitables = FALSE
		handle_exploitables_menu()
		return

	can_see_exploitables = FALSE
	for(var/datum/antagonist/antag_datum in src?.antag_datums)
		if (antag_datum.view_exploitables)
			can_see_exploitables = TRUE
			break

	handle_exploitables_menu()

/datum/mind/proc/handle_exploitables_menu()

	if (has_exploitables_override)
		if (!has_exploitable_menu)
			add_verb(current, /mob/proc/view_exploitables_verb)
			has_exploitable_menu = TRUE
			to_chat(current, span_danger("You now have access to the View-Crew-Exploitables verb, which shows all crew who currently have exploitable info and a link to view it!"))
		return

	if(!has_exploitable_menu && can_see_exploitables)
		add_verb(current, /mob/proc/view_exploitables_verb)
		has_exploitable_menu = TRUE
		to_chat(current, span_danger("You now have access to the View-Crew-Exploitables verb, which shows all crew who currently have exploitable info and a link to view it!"))

	else if(has_exploitable_menu && !can_see_exploitables)
		remove_verb(current, /mob/proc/view_exploitables_verb)
		has_exploitable_menu = FALSE


