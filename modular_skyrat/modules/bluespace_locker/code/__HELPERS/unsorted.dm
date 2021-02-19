// Like get_turf, but if inside a bluespace locker it returns the turf the bluespace locker is on
// possibly could be adapted for other stuff, i dunno
// ported from yogs along with the BS locker 
/proc/get_turf_global(atom/A, recursion_limit = 5)
	var/turf/T = get_turf(A)
	if(recursion_limit <= 0)
		return T
	if(T.loc)
		var/area/R = T.loc
		if(R.global_turf_object)
			return get_turf_global(R.global_turf_object, recursion_limit - 1)
	return T
