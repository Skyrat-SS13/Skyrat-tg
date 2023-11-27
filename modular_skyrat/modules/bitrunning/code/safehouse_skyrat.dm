/datum/map_template/safehouse_skyrat
	name = "virtual domain: safehouse (skyrat)"

	returns_created_atoms = TRUE
	/// The map file to load
	var/filename = "den.dmm"

/datum/map_template/safehouse_skyrat/New()
	mappath = "_maps/skyrat/safehouses/" + filename
	..(path = mappath)
