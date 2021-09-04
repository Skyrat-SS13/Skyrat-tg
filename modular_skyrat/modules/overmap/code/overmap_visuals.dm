/obj/effect/abstract/overmap
	glide_size = 3
	layer = OVERMAP_LAYER_LOWEST
	icon = 'icons/overmap/overmap.dmi'
	icon_state = "event"
	/// The overmap object this visual effect is representing
	var/datum/overmap_object/my_overmap_object
	/// If true value, then will force qdel on init (cant pass a hint due to the needed force)
	var/qdel_init

/obj/effect/abstract/overmap/Initialize()
	. = ..()
	if(qdel_init)
		qdel(src, TRUE)

/obj/effect/abstract/overmap/Destroy(force)
	if(!force)
		message_admins("Overmap visual deleted, assuming badminerry, deleting the associated object, at [ADMIN_VERBOSEJMP(loc)]")
		qdel(my_overmap_object)
		return //We return because qdelling our overmap object will delete this with a force
	my_overmap_object = null
	return ..()

/obj/effect/abstract/overmap/ruins
	icon_state = "event"
	layer = OVERMAP_LAYER_PLANET

/obj/effect/abstract/overmap/shuttle
	icon_state = "shuttle"
	animate_movement = NO_STEPS
	color = LIGHT_COLOR_CYAN
	layer = OVERMAP_LAYER_SHUTTLE
	var/shuttle_idle_state = "shuttle"
	var/shuttle_forward_state = "shuttle_forward"
	var/shuttle_backward_state = "shuttle_backwards"

/obj/effect/abstract/overmap/shuttle/Destroy(force)
	if(!force)
		message_admins("Overmap shuttle attempted to be deleted, ignoring the request, at [ADMIN_VERBOSEJMP(loc)]")
		return
	else
		return ..()

/obj/effect/abstract/overmap/shuttle/update_overlays()
	. = ..()
	var/datum/overmap_object/shuttle/my_shuttle = my_overmap_object
	if(my_shuttle.IsShieldFunctioning())
		var/mutable_appearance/mut = mutable_appearance(icon, "shield")
		mut.appearance_flags = RESET_COLOR|RESET_TRANSFORM
		. += mut
	if(my_shuttle.open_comms_channel)
		var/mutable_appearance/mut = mutable_appearance(icon, "radio")
		mut.appearance_flags = RESET_COLOR|RESET_TRANSFORM
		. += mut

/obj/effect/abstract/overmap/relaymove(mob/living/user, direction)
	my_overmap_object.relaymove(user, direction)

/obj/effect/abstract/overmap/shuttle/station
	color = COLOR_VERY_LIGHT_GRAY
	layer = OVERMAP_LAYER_STATION
	icon_state = "station"
	shuttle_idle_state = "station"
	shuttle_forward_state = "station"
	shuttle_backward_state = "station"

/obj/effect/abstract/overmap/shuttle/ship
	color = LIGHT_COLOR_ELECTRIC_CYAN
	layer = OVERMAP_LAYER_SHIP
	icon_state = "ship"
	shuttle_idle_state = "ship"
	shuttle_forward_state = "ship_forward"
	shuttle_backward_state = "ship_backwards"

/obj/effect/abstract/overmap/shuttle/planet
	icon_state = "globe"
	layer = OVERMAP_LAYER_PLANET
	shuttle_idle_state = "globe"
	shuttle_forward_state = "globe"
	shuttle_backward_state = "globe"
