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
<<<<<<< HEAD

=======
	always_use_default_namelist = TRUE // Nonsense language
>>>>>>> 0cc5cfb178e (Random Name Generation refactor, generate random names based on languages (for species without name lists, like Felinids and Podpeople) (#83021))
