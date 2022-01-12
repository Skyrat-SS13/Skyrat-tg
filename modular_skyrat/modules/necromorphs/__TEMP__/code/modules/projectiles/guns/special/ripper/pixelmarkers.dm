/obj/effect/pixelmarker
	icon = 'icons/debug/pixelmarkers.dmi'
	var/lifetime = 0.3
	anchored = TRUE
	alpha = 200

/obj/effect/pixelmarker/New(var/location, var/_lifetime, var/newcolor = "#FFFFFF")
	if (_lifetime)
		lifetime = _lifetime

	color = newcolor
	.=..()

/obj/effect/pixelmarker/Initialize()
	..()
	spawn(lifetime)
		qdel(src)

//Sets the pixelmarker to be on the target pixel exactly
/obj/effect/pixelmarker/set_global_pixel_loc(var/vector2/coords)
	..(coords + get_new_vector(16, 16))




/obj/effect/pixelmarker/tile
	icon_state = "white"


/proc/pixelmark(var/vector2/coords, var/iconstate = "ax")
	var/zlevel = 1
	if (usr)
		zlevel	= usr.z

	var/turf/T = get_turf_at_pixel_coords(coords, zlevel)
	var/obj/effect/pixelmarker/P = new /obj/effect/pixelmarker(T, 3 SECOND)
	P.icon_state = iconstate
	if (coords)
		P.set_global_pixel_loc(coords)