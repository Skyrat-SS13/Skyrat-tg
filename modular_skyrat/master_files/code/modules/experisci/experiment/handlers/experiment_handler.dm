/**
 * Attempts to get rnd servers that are on the station z-level, also checks if provided turf is on the station z-level
 *
 * Arguments:
 * * turf_to_check_for_servers - The turf to check if its on the station z-level
 */
/datum/component/experiment_handler/get_available_servers(turf/turf_to_check_for_servers = null)
	var/list/local_servers = list()
	for(var/obj/machinery/rnd/server/server in SSresearch.servers)
		local_servers += server
	return local_servers
