/mob/proc/get_top_level_mob()
	if(istype(loc, /mob) && loc != src)
		var/mob/M = loc
		return M.get_top_level_mob()
	return src
