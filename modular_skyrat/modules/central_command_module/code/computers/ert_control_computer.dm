
/obj/machinery/computer/ert_control
	name = "fleet asset control console"
	desc = "A console used for redeploying Nanotrasen Emergency Response assets."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/communications
	light_color = LIGHT_COLOR_BLUE

/obj/item/circuitboard/computer/ert_control
	name = "Fleet Control (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/ert_control

