/**
 * # species datum
 *
 * Datum that handles different species in the game.
 *
 * This datum handles species in the game, such as lizardpeople, mothmen, zombies, skeletons, etc.
 * It is used in [carbon humans][mob/living/carbon/human] to determine various things about them, like their food preferences, if they have biological genders, their damage resistances, and more.
 *
 */
/datum/species
	/// Adding a language type to this in the form of /datum/language will allow the language to be displayed in preferences for that species, even if it is a secret language.
	/// Currently used for ashtongue in ashwalkers.
	var/list/language_prefs_whitelist
