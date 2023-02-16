/obj/machinery/button/elevator
	name = "elevator button"
	desc = "Go back. Go back. Go back. Can you operate the elevator."
	icon = 'modular_skyrat/modules/aesthetics/industrial_lift/icons/industrial_lift.dmi'
	icon_state = "elevatorctrl"
	skin = "elevatorctrl"
	light_color = LIGHT_COLOR_DARK_BLUE
	light_power = 1
	light_power = 0.5
	luminosity = 1
	device_type = /obj/item/assembly/control/elevator
	req_access = list()
	id = 1

/obj/machinery/button/elevator/Initialize(mapload, ndir, built)
	. = ..()
	// Kind of a cop-out
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Call Elevator")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/button/elevator, 28)
