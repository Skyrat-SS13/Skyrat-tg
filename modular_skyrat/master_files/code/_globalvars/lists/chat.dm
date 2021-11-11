/// A global list for all the characters blacklisted from the automatic punctuation at the end of emotes and speeches.
GLOBAL_LIST_INIT(auto_punctuation_character_blacklist, list(".", ",", "!", "?", "\"", "~", "|", "_", "+", "-"))
/// A global list for all the characters that, when they're the first character of an emote, will make the space between the emote and the mob's name disappear.
GLOBAL_LIST_INIT(no_spacing_emote_characters, list(",", "'"))
