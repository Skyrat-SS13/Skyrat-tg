/// Ensures sentences end in appropriate punctuation (a period if none exist)
/// and that all whitespace-bounded 'i' characters are capitalized.
/proc/autopunct_bare(input_text)
	if (findtext(input_text, GLOB.has_no_eol_punctuation))
		input_text += "."

	input_text = replacetext(input_text, GLOB.noncapital_i, "I")
	return input_text
