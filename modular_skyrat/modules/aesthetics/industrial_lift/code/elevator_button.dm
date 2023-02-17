/obj/machinery/button/elevator
	name = "elevator button"
	desc = "Go back. Go back. Go back. Can you operate the elevator."
	icon_state = "elevatorctrl"
	skin = "elevatorctrl"
	light_color = LIGHT_COLOR_DARK_BLUE
	light_mask = "elev-light-mask"
	device_type = /obj/item/assembly/control/elevator
	req_access = list()
	id = 1

/obj/machinery/button/elevator/Initialize(mapload, ndir, built)
	. = ..()
	// Kind of a cop-out
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Call Elevator")

/obj/machinery/button/elevator/update_overlays()
	. = ..()
	if(!light_mask)
		return

	if(!(machine_stat & (NOPOWER|BROKEN)) && !panel_open)
		. += emissive_appearance(icon, light_mask, src, alpha = alpha)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/button/elevator, 22)
