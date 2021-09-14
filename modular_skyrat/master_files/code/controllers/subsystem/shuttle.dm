/datum/controller/subsystem/shuttle/proc/init_sold_shuttles()
	for(var/type in subtypesof(/datum/sold_shuttle))
		var/datum/sold_shuttle/sold_shuttle = type
		if(initial(sold_shuttle.shuttle_id))
			sold_shuttles += new sold_shuttle()

/datum/controller/subsystem/shuttle/proc/get_sold_shuttles_cache(dock_id, shuttle_types)
	var/cache_key = "[dock_id]-[shuttle_types]"
	if(!sold_shuttles_cache[cache_key])
		var/list/new_cache_list = list()
		for(var/i in sold_shuttles)
			var/datum/sold_shuttle/sold_shuttle = i
			if(!sold_shuttle.allowed_docks[dock_id])
				continue
			if(shuttle_types & sold_shuttle.shuttle_type)
				new_cache_list += sold_shuttle
		sold_shuttles_cache[cache_key] = new_cache_list
	return sold_shuttles_cache[cache_key]
