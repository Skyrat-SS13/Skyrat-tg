/datum/space_level
	var/name = "NAME MISSING"
	var/list/neigbours = list()
	var/list/traits
	var/z_value = 1 //actual z placement
	var/linkage = SELFLOOPING
	var/xi
	var/yi   //imaginary placements on the grid
	var/datum/overmap_object/related_overmap_object
	var/is_overmap_controllable = FALSE
	var/parallax_direction_override
	///Extensions for z levels as overmap objects
	var/list/all_extensions = list()
	/// Weather controller for this level
	var/datum/weather_controller/weather_controller
	/// Linked day and night controller, expect this to apply to all related_levels
	var/datum/day_night_controller/day_night_controller
	/// An override of rock colors on this level
	var/rock_color = COLOR_ASTEROID_ROCK
	/// An override of plant colors on this level
	var/plant_color = COLOR_DARK_MODERATE_LIME_GREEN
	/// An override of grass colors on this level
	var/grass_color = COLOR_DARK_MODERATE_LIME_GREEN
	/// An override of water colors on this level
	var/water_color = COLOR_WHITE
	/// A list of all ore nodes on this level
	var/list/ore_nodes = list()

/datum/space_level/New(new_z, new_name, list/new_traits = list())
	z_value = new_z
	name = new_name
	traits = new_traits
	set_linkage(new_traits[ZTRAIT_LINKAGE])

///If something requires a level to have a weather controller, use this
/datum/space_level/proc/AssertWeatherController()
	if(!weather_controller)
		new /datum/weather_controller(list(src))
