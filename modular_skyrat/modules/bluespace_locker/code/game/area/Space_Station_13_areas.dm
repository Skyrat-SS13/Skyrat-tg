/area
    var/atom/global_turf_object = null // For BS lockers

/area/bluespace_locker
	name = "Bluespace Locker"
	icon_state = "away"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	area_flags = NOTELEPORT
