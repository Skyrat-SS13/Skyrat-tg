/datum/language/monkey
	name = "Chimpanzee"
	desc = "Ook ook ook."
	key = "1"
	space_chance = 100
	syllables = list("oop", "aak", "chee", "eek")
	default_priority = 80

	icon_state = "animal"

/datum/language/monkey/get_random_name(
	gender = NEUTER,
	name_count = 2,
	syllable_min = 2,
	syllable_max = 4,
	force_use_syllables = FALSE,
)
	return "monkey ([rand(1, 999)])"
