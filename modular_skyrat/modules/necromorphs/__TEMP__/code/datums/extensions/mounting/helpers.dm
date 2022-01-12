/*
	Its bad that wallrun and wallmount aren't the same system, that needs to be fixed. For now, this dirty abstraction layer will do

	There will be colon access, they share proc and variable names
*/
/atom/proc/handle_existing_mounts(var/override = TRUE)
	var/list/matches = get_extensions_of_types(src, list(/datum/extension/wallrun, /datum/extension/mount))
	for (var/datum/extension/E in matches)
		if (E:mountpoint) //If set, this means it's mounted
			if (!override)
				return FALSE	//Without override, we fail on any existing mounts

			//Unmount it
			E:unmount()
	return TRUE