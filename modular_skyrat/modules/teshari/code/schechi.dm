/datum/language/schechi
	name = "Schechi"
	desc = "The very structurally loose creole tongue of the Teshari, host to hundreds of dialects almost different enough to resemble their own languages. \
	Originally developed on Sirisai, Schechi has made its way across the Teshari diaspora as a commonly agreed upon way for entirely different packs to communicate."
	key = "F"
	space_chance = 40
	syllables = list(
		"i", "ii", "si", "aci", "hi", "ni", "li", "schi", "tari",
		"e", "she", "re", "me", "ne",  "te", "se", "le", "ai",
		"a", "ra", "ca", "scha", "tara", "sa", "la", "na", "ce",
		"re", "se", "shi", "ti", "le", "la", "lu", "tu", "shu",
	)
	icon = 'modular_skyrat/master_files/icons/misc/language.dmi'
	icon_state = "schechi"
	default_priority = 90

/datum/language/schechi/get_random_name(
	gender = NEUTER,
	name_count = default_name_count,
	syllable_min = default_name_syllable_min,
	syllable_max = default_name_syllable_max,
	force_use_syllables = FALSE,
)
	if(force_use_syllables)
		return ..()

	var/newname = ""
	for(var/i in 1 to rand(2, 3))
		newname += pick(list("chi", "chu", "ka", "ki", "kyo", "ko", "la", "li", "mi", "ni", "nu", "nyu", "se", "ri", "ro", "ru", "ryu", "sa", "si", "syo"))
	return capitalize(newname)
