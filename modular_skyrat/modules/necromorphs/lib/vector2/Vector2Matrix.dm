/* Adds vector2 support to matrix procs.
*/

/matrix/Translate(x, y)
	if(istype(x, /vector2))
		var vector2/v = x
		return ..(v.x, v.y)
	return ..()

/matrix/Scale(x, y)
	if(istype(x, /vector2))
		var vector2/v = x
		return ..(v.x, v.y)
	return ..()
