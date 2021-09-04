/turf/open/overmap
	icon = 'icons/overmap/overmap_turfs.dmi'
	plane = FLOOR_PLANE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/turf/open/overmap/Initalize_Atmos(times_fired)
	return

/turf/open/overmap/Assimilate_Air()
	return

/turf/open/overmap/map
	icon_state = "map"
	base_icon_state = "map"

//Since update_overlays() is unfriendly to arguments
/turf/open/overmap/map/proc/set_coords_overlays(lowx, lowy, highx, highy)
	. = list()
	if(lowx)
		. += get_number_overlay("lowx", lowx)
	if(lowy)
		. += get_number_overlay("lowy", lowy)
	if(highx)
		. += get_number_overlay("highx", highx)
	if(highy)
		. += get_number_overlay("highy", highy)
	if(lowx && lowy)
		. += mutable_appearance(icon, "lowstrike")
	if(highx && highy)
		. += mutable_appearance(icon, "highstrike")
	overlays = .

/turf/open/overmap/map/proc/get_number_overlay(suffix, number)
	var/number_text = num2text(number)
	if(length(number_text) < 2) //Add a zero to the front if it's 1 digit
		number_text = "0[number_text]"
	var/pos1 = copytext(number_text,1,2)
	var/pos2 = copytext(number_text,2,3)
	. = list()
	. += mutable_appearance(icon, "[suffix]_1_[pos1]")
	. += mutable_appearance(icon, "[suffix]_2_[pos2]")

/turf/open/overmap/border
	name = "border"
	icon_state = "black"
	base_icon_state = "black"
	opacity = TRUE
