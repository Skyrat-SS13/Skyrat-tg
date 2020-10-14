/obj/machinery/airalarm
	icon = 'modular_skyrat/modules/aesthetics/airalarm/icons/airalarm.dmi'
	var/light_mask = "alarm-light-mask"

/obj/item/wallframe/airalarm
	icon = 'icons/obj/monitors.dmi'

/obj/machinery/airalarm/update_overlays()
	. = ..()
	if(!light_mask)
		return

	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(!(machine_stat & BROKEN) && powered())
		SSvis_overlays.add_vis_overlay(src, icon, light_mask, EMISSIVE_LAYER, EMISSIVE_PLANE)
