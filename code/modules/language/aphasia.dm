/datum/language/aphasia
	name = "Gibbering"
	desc = "It is theorized that any sufficiently brain-damaged person can speak this language."
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	key = "i"
	syllables = list("m","n","gh","h","l","s","r","a","e","i","o","u")
	space_chance = 20
	default_priority = 10
	icon_state = "aphasia"
	always_use_default_namelist = TRUE // Shouldn't generate names for this anyways
