/datum/language/drone
	name = "Drone"
	desc = "A heavily encoded damage control coordination stream, with special flags for hats."
	spans = list(SPAN_ROBOT)
	key = "d"
	flags = NO_STUTTER
	syllables = list(".", "|")
	// ...|..||.||||.|.||.|.|.|||.|||
	space_chance = 0
	sentence_chance = 0
	default_priority = 20

	icon_state = "drone"
	always_use_default_namelist = TRUE // Nonsense language
