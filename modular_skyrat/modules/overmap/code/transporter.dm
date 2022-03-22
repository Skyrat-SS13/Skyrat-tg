/obj/machinery/transporter
	name = "transporter pad"
	desc = "Machine which sends matter and energy from one place to another."
	icon = 'modular_skyrat/modules/overmap/icons/transporter.dmi'
	icon_state = "transporter_on"
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 60
	density = FALSE
	circuit = /obj/item/circuitboard/machine/transporter
	light_color = LIGHT_COLOR_CYAN
	light_power = 1
	var/extension_type = /datum/shuttle_extension/transporter
	var/datum/shuttle_extension/transporter/extension

/obj/machinery/transporter/Initialize()
	. = ..()
	extension = new extension_type(src)
	extension.ApplyToPosition(get_turf(src))
	power_change()

/obj/machinery/transporter/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	extension.ApplyToPosition(get_turf(src))

/obj/machinery/transporter/Destroy()
	extension.RemoveExtension()
	QDEL_NULL(extension)
	return ..()

/obj/machinery/transporter/power_change()
	. = ..()
	if(machine_stat & NOPOWER)
		icon_state = "transporter_off"
		set_light(0)
	else
		icon_state = "transporter_on"
		set_light(2.5)

/obj/item/circuitboard/machine/transporter
	name = "Transporter Pad (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/transporter
	req_components = list(/obj/item/stock_parts/micro_laser = 2,
							/obj/item/stock_parts/manipulator  = 4)
