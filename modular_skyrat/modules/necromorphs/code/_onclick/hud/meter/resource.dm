/*
	A resource meter is paired with a /datum/extension/resource instance
	It displays the values of that extension
*/
/atom/movable/screen/meter/resource
	name = "resource meter"
	var/datum/extension/resource/resource_holder
	screen_loc = "CENTER,TOP:-16"	//Future TODO: Allow some dynamic positioning to accomodate multiple resource meters


/atom/movable/screen/meter/resource/cache_data(var/atom/holder, var/datum/hud/H, var/datum/extension/resource/R)
	resource_holder = R
	.=..()

/atom/movable/screen/meter/resource/get_data()
	if (resource_holder)
		return resource_holder.get_report()
	else
		return DEFAULT_METER_DATA



/*
	Subtypes
*/
/atom/movable/screen/meter/resource/essence
	name = "essence meter"
	rounding = 0.01

	remaining_color = COLOR_NECRO_DARK_YELLOW
	delta_color	=	COLOR_WHITE

	//Nice, wide and consistent per-point,
	size_pixels = list("0" = 6)
