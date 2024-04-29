/**
 * Sorts the get_available_servers() returned list by closest server source location
 * Returns the closest server found as a single entity list.
 */
/datum/controller/subsystem/research/get_available_servers(turf/location)
	var/list/local_servers = ..()
	if(local_servers && (length(local_servers) > 1) && !is_station_level(location.z)) /// If there was more than 1 valid server located off-station, find closest server
		var/server_distance_closest = INFINITY
		var/server_distance_current = INFINITY
		var/obj/machinery/rnd/server/closest_server = local_servers[1]

		for (var/obj/machinery/rnd/server/individual_server as anything in local_servers)
			if(location.z != individual_server.z) /// Not on the same z level, skip
				continue
			server_distance_current = get_dist(location, get_turf(individual_server))
			if(server_distance_closest > server_distance_current) /// This is closer than the last server we tested
				server_distance_closest = server_distance_current
				closest_server = individual_server
		return list(closest_server)
	return local_servers
