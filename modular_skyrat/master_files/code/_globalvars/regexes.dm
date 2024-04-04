//Any EOL char that isn't appropriate punctuation
GLOBAL_DATUM_INIT(has_no_eol_punctuation, /regex, regex(@"\w$"))

//All non-capitalized 'i' surrounded with whitespace (aka, 'hello >i< am a cat')
GLOBAL_DATUM_INIT(noncapital_i, /regex, regex(@"\b[i]\b", "g"))
