/datum/station_trait/nebula/hostile/
	/// Radiation storms are disabled by default
	var/storms_enabled

/// Allows an admin to turn on/off the radiation storms.
/datum/station_trait/nebula/hostile/proc/toggle_storms()
	storms_enabled = !storms_enabled
	message_admins("Radiation storms have been [storms_enabled ? "enabled" : "disabled"]!")
