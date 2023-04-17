GLOBAL_LIST_INIT(clockwork_research, setup_clockwork_research())
GLOBAL_LIST_EMPTY(clockwork_research_unlocked_recipes)


/proc/setup_clockwork_research()
	. = list()
	for(var/path in subtypesof(/datum/clockwork_research))
		. += new path

	return .


/datum/clockwork_research
	/// Name of the research node
	var/name = ""
	/// Desc of the research
	var/desc = ""
	/// List of tinker cache items it unlocks
	var/list/unlocked_recipes = list()
	/// What tier this is
	var/tier = 1
	/// If this is a starting research
	var/starting = FALSE
	/// If this has been researched
	var/researched = FALSE

/datum/clockwork_research/proc/on_research()
	for(var/recipe in unlocked_recipes)
		GLOB.researched_tinkerers_cache_recipes += recipe


/datum/clockwork_research/start
	name = "Starting Research"
	desc = "What the fuck?"
	tier = 0
	starting = TRUE
	researched = TRUE

/datum/clockwork_research/gun
	name = "Gun Research"
	desc = "Fuck em up?"
	tier = 1
	unlocked_recipes = list(
		/datum/tinker_cache_item/clockwork_rifle,
		/datum/tinker_cache_item/clockwork_rifle_ammo,
	)

