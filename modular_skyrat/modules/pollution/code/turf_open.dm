/turf/proc/pollute_turf(pollution_type, amount, cap)
	return

/turf/proc/pollute_turf_list(list/pollutions, cap)
	return

/turf/open/pollute_turf(pollution_type, amount, cap)
	// Don't add pollution when the subsystem is off.
	if(!SSpollution.can_fire)
		return

	if(!pollution)
		pollution = new(src)
	if(cap && pollution.total_amount >= cap)
		return
	pollution.add_pollutant(pollution_type, amount)

/turf/open/pollute_turf_list(list/pollutions, cap)
	// Don't add pollution when the subsystem is off.
	if(!SSpollution.can_fire)
		return

	if(!pollution)
		pollution = new(src)
	if(cap && pollution.total_amount >= cap)
		return
	pollution.add_pollutant_list(pollutions)

/turf/open/space/pollute_turf(pollution_type, amount, cap)
	return

/turf/open/space/pollute_turf_list(list/pollutions, cap)
	return
