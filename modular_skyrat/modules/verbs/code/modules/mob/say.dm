/mob/proc/get_top_level_mob()
	if(istype(src.loc,/mob)&&src.loc!=src)
		var/mob/M=src.loc
		return M.get_top_level_mob()
	return src

/proc/get_top_level_mob(var/mob/S)
	if(istype(S.loc,/mob)&&S.loc!=S)
		var/mob/M=S.loc
		return M.get_top_level_mob()
	return S

#define ENCODE_HTML_EPHASIS(input, char, html, varname) \
	var/static/regex/##varname = regex("[char]{2}(.+?)[char]{2}", "g");\
	input = varname.Replace_char(input, "<[html]>$1</[html]>")

/atom/movable/proc/say_emphasis(input)
	ENCODE_HTML_EPHASIS(input, "\\|", "i", italics)
	ENCODE_HTML_EPHASIS(input, "\\+", "b", bold)
	ENCODE_HTML_EPHASIS(input, "_", "u", underline)
	return input

#undef ENCODE_HTML_EPHASIS
