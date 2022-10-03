/obj/machinery/button
	icon = 'modular_skyrat/modules/aesthetics/buttons/icons/buttons.dmi'
	var/light_mask = "button-light-mask"

/obj/machinery/button/door/update_overlays()
	. = ..()
	if(!light_mask)
		return

	if(!(machine_stat & (NOPOWER|BROKEN)) && !panel_open)
		. += emissive_appearance(icon, light_mask, src, alpha = alpha)
