/**
 * Checks antag datums for any datums with view_exploitables. If it finds one, sets can_see_exploitables to true, and if not, false.
 * Always calls handle_exploitables_menu. Also sets can_see_exploitables to true if has_exploitables_override is true and skips the rest.
 */
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
		if (!antag_datum.view_exploitables)
			continue
		else
			can_see_exploitables = TRUE
			break

	handle_exploitables_menu()

/**
 * Called by handle_exploitables(). Checks for a discrepency between has_exploitable_menu and can_see_exploitable, and gives/takes the verb accordingly (if can_see_exploitables is true/false).
 * Always makes sure the user has the exploitable menu if has_exploitables_override is true.
 */
/datum/mind/proc/handle_exploitables_menu()

	if (has_exploitables_override)
		if (!has_exploitable_menu)
			add_verb(current, /mob/proc/view_exploitables_verb)
			has_exploitable_menu = TRUE
			to_chat(current, span_danger(VIEW_CREW_EXPLOITABLES_GAIN_TEXT))
		return

	if(!has_exploitable_menu && can_see_exploitables)
		add_verb(current, /mob/proc/view_exploitables_verb)
		has_exploitable_menu = TRUE
		to_chat(current, span_danger(VIEW_CREW_EXPLOITABLES_GAIN_TEXT))

	else if(has_exploitable_menu && !can_see_exploitables)
		remove_verb(current, /mob/proc/view_exploitables_verb)
		has_exploitable_menu = FALSE


