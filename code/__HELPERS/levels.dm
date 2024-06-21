/**
 * - is_valid_z_level
 *
 * Checks if source_loc and checking_loc is both on the station, or on the same z level.
 * This is because the station's several levels aren't considered the same z, so multi-z stations need this special case.
 *
 * Args:
 * source_loc - turf of the source we're comparing.
 * checking_loc - turf we are comparing to source_loc.
 *
 * returns TRUE if connection is valid, FALSE otherwise.
 */
/proc/is_valid_z_level(turf/source_loc, turf/checking_loc)
	// if we're both on "station", regardless of multi-z, we'll pass by.
	if(is_station_level(source_loc.z) && is_station_level(checking_loc.z))
		return TRUE
	if(source_loc.z == checking_loc.z)
		return TRUE
	return FALSE

/**
 * Checks if the passed non-area atom is on a "planet".
 *
 * A planet is defined as anything with planetary atmos that has gravity, with some hardcoded exceptions.
 *
 * * Nullspace counts as "not a planet", so you may want to check that separately.
 * * The mining z-level (Lavaland) is always considered a planet.
 * * The station z-level is considered a planet if the map config says so.
 * * Central Command is always not a planet.
 * * Syndicate recon outpost is always on a planet.
 *
 * Returns TRUE if we are on a planet.
 * Returns FALSE if we are not in a planet, or otherwise, "in space".
 */
/proc/is_on_a_planet(atom/what)
	ASSERT(!isarea(what))

	var/turf/open/what_turf = get_turf(what)
	if(isnull(what_turf))
		// Nullspace is, well, not a planet?
		return FALSE

	if(is_mining_level(what_turf.z))
		// Always assume Lavaland / mining level is a planet. (Astroid mining crying right now)
		return TRUE

	if(is_station_level(what_turf.z))
		// Station levels rely on the map config, I.E. Icebox is planetary but Meta is not
		return SSmapping.is_planetary()

	if(is_centcom_level(what_turf.z))
		// Central Command is definitely in space
		return FALSE

	if(what.onSyndieBase())
		// Syndicate recon outpost is on some moon or something
		return TRUE

	// Finally, more specific checks are ran for edge cases, such as lazyily loaded map templates or away missions. Not perfect.
	return istype(what_turf) && what_turf.planetary_atmos && what_turf.has_gravity()
