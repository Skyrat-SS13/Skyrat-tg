//  Integrated Circuits helpers
/// isnum() returns TRUE for NaN. Also, NaN != NaN. Checkmate, BYOND.
#define isnan(x) ( (x) != (x) )

#define isinf(x) (isnum((x)) && (((x) == text2num("inf")) || ((x) == text2num("-inf"))))

/// NaN isn't a number, damn it. Infinity is a problem too.
#define isnum_safe(x) ( isnum((x)) && !isnan((x)) && !isinf((x)) )

/// Encodes a string to hex
/proc/strtohex(str)
	if(!istext(str)||!str)
		return
	var/r
	var/c
	for(var/i = 1 to length(str))
		c = text2ascii(str,i)
		r += num2hex(c, 2)
	return r
