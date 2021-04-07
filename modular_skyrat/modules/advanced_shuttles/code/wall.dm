/*
/area/shuttle
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
*/

/obj/docking_port/mobile/arrivals

/turf/closed/wall/mineral/titanium/shuttle_wall
	name = "shuttle wall"
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/shuttle.dmi'
	icon_state = ""
	base_icon_state = ""
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null
	fixed_underlay = list("space" = TRUE)

/turf/closed/wall/mineral/titanium/shuttle_wall/Initialize(mapload)
	. = ..()
	var/mutable_appearance/underlay_appearance = mutable_appearance(layer = TURF_LAYER, plane = FLOOR_PLANE)
	underlay_appearance.icon = 'icons/turf/space.dmi'
	underlay_appearance.icon_state = "1"
	underlays = list(underlay_appearance)

/turf/closed/wall/mineral/titanium/shuttle_wall/mining
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/shuttle_mining.dmi'

/turf/closed/wall/mineral/titanium/shuttle_wall/pod
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/pod.dmi'

/turf/closed/wall/mineral/titanium/shuttle_wall/ferry
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/erokez.dmi'
	icon_state = "18,2"

/turf/closed/wall/mineral/titanium/shuttle_wall/evac
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/evac_shuttle.dmi'
	icon_state = "9,1"

/turf/closed/wall/mineral/titanium/shuttle_wall/arrivals
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/wagon.dmi'
	icon_state = "3,1"

/////////////////////////////////////////////WINDOWS//////////////////////////////////////////////////////////
/turf/closed/wall/mineral/titanium/shuttle_wall/window
	opacity = FALSE

/turf/closed/wall/mineral/titanium/shuttle_wall/window/pod
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/pod.dmi'
	icon_state = "3,1"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/ferry
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/erokez.dmi'
	icon_state = "18,2"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/arrivals
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/wagon.dmi'
	icon_state = "3,1"

/turf/closed/wall/mineral/titanium/shuttle_wall/window/evac
	icon = 'modular_skyrat/modules/advanced_shuttles/icons/evac_shuttle.dmi'
	icon_state = "9,1"
