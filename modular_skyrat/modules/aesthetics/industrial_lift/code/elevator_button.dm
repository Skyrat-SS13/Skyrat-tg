/obj/machinery/button/elevator
	name = "elevator button"
	desc = "Go back. Go back. Go back. Can you operate the elevator."
	icon_state = "elevhall"
	skin = "elevhall"
	light_color = LIGHT_COLOR_DARK_BLUE
	light_mask = "hall-light-mask"
	device_type = /obj/item/assembly/control/elevator
	req_access = list()
	id = 1

/obj/machinery/button/elevator/Initialize(mapload, ndir, built)
	. = ..()
	// Kind of a cop-out
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Call Elevator")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/button/elevator, 22)
