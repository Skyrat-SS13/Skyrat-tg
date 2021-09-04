/obj/machinery/shield_generator
	name = "shield generator"
	desc = "A powerful device which can generate a giant protective shield."
	icon = 'icons/obj/machines/shield_gen.dmi'
	icon_state = "shield_gen_on"
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 60
	density = TRUE
	circuit = /obj/item/circuitboard/machine/shield_generator
	light_color = LIGHT_COLOR_CYAN
	light_power = 2
	var/extension_type = /datum/shuttle_extension/shield
	var/datum/shuttle_extension/shield/extension

/obj/machinery/shield_generator/Initialize()
	. = ..()
	extension = new extension_type()
	extension.ApplyToPosition(get_turf(src))
	power_change()

/obj/machinery/shield_generator/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	extension.ApplyToPosition(get_turf(src))

/obj/machinery/shield_generator/Destroy()
	extension.RemoveExtension()
	QDEL_NULL(extension)
	return ..()

/obj/machinery/shield_generator/power_change()
	. = ..()
	if(machine_stat & NOPOWER)
		if(extension)
			extension.turn_off(TRUE)
		icon_state = "shield_gen_off"
		set_light(0)
	else
		icon_state = "shield_gen_on"
		set_light(2.5)

/obj/item/circuitboard/machine/shield_generator
	name = "Shield Generator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/shield_generator
	req_components = list(/obj/item/stock_parts/capacitor = 10,
							/obj/item/stock_parts/manipulator  = 5)
