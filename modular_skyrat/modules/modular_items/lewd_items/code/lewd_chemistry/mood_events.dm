///To notify, but not harm the player in terms of mood. Used for camphor, pentacamphor, succubus milk, and incubus draft.
/datum/mood_event/minor_overdose
	timeout = 5 MINUTES

/datum/mood_event/minor_overdose/add_effects(drug_name)
	description = "<span class='warning'>I think I took a bit too much [drug_name]...</span>\n"
