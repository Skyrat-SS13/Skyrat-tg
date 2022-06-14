/datum/mind
	/// The standard way we check for access to exploitables, given to antags. If true, and handles_exploitables() is ran, the user will be given exploitables access + menu.
	var/can_see_exploitables = FALSE
	/// The nonstandard way we check for access to exploitables, given by admins and OPFOR. Acts like can_see_exploitables, but will always, unconditionally set it to true and succeed.
	var/has_exploitables_override = FALSE
	///Tracks if the target has the view_exploitables_verb verb. THIS MUST BE CHANGED IF THE VERB IS ADDED OR REMOVED OR ELSE STUFF BREAKS.
	var/has_exploitable_menu = FALSE
