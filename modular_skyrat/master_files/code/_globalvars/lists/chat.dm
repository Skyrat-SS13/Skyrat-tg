/**
 * Returns a boolean based on whether or not the string contains a comma or an apostrophe,
 * to be used for emotes to decide whether or not to have a space between the name of the user
 * and the emote.
 *
 * Requires the message to be HTML decoded beforehand. Not doing it here for performance reasons.
 *
 * Returns TRUE if there should be a space, FALSE if there shouldn't.
 */
/proc/should_have_space_before_emote(string)
	var/static/regex/no_spacing_emote_characters = regex(@"(,|')")
	return no_spacing_emote_characters.Find(string) ? FALSE : TRUE

/** Automatically punctuates a message based on whether or not it ends with punctuation already.
 *
 * Requires the message to be HTML decoded beforehand. Not doing it here for performance reasons.
 *
 * Also, yes, BYOND raw strings are cursed, tell me about it.
 *
 * Returns string, which was modified or not, punctuated.
 */
/proc/auto_punctuate(string)
	var/static/regex/auto_punctuation_character_blacklist = regex(@#(\.|\,|\!|\?|\~|\'|\"\||\_|\+|\-)#)
	if(!(auto_punctuation_character_blacklist.Find(string[length(string)])))
		string += "."
	return string
