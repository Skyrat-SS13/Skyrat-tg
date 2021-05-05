/obj/item/circuitboard/machine/rodstopper
	name = "Rodstopper (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rodstopper
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/sheet/plasteel = 1)

/obj/machinery/rodstopper
	name = "rodstopper"
	desc = "An advanced machine which can halt immovable rods."
	icon = 'modular_skyrat/modules/rod-stopper/icons/rodstopper.dmi'
	icon_state = "rodstopper"
	density = TRUE
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/rodstopper
	layer = BELOW_OBJ_LAYER

/datum/design/board/rodstopper
	name = "Machine Design (Rodstopper)"
	desc = "The only thing that can halt a looping rod (When the Research Director is being lazy)."
	id = "rodstopper"
	materials = list(/datum/material/glass = 500, /datum/material/bluespace = 1000)
	build_path = /obj/item/circuitboard/machine/rodstopper
	category = list("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/techweb_node/anomaly
	design_ids = list("reactive_armour", "anomaly_neutralizer", "rodstopper")
