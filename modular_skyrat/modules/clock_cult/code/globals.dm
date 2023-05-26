GLOBAL_VAR_INIT(clock_power, 2500)
GLOBAL_VAR_INIT(max_clock_power, 2500) // Increases with every APC cogged
GLOBAL_VAR_INIT(clock_vitality, 0)
GLOBAL_VAR_INIT(max_clock_vitality, 200) // This one however is constant
GLOBAL_VAR_INIT(clock_installed_cogs, 0)

GLOBAL_LIST_EMPTY(clockwork_research)
GLOBAL_LIST_EMPTY(clockwork_research_unlocked_recipes)
GLOBAL_LIST_EMPTY(clockwork_research_unlocked_scriptures)


/// Returns a list of every initialized clockwork research datum
/proc/setup_clockwork_research()
	. = list()
	for(var/path in subtypesof(/datum/clockwork_research))
		. += new path

	return .
