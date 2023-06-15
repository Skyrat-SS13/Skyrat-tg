// Subsystems are less integrally important to the ship and have lesser effects on breaking

/datum/outbound_ship_system/lighting
	name = "Lighting"
	subsystem = TRUE
	machine_type = /obj/machinery/outbound_expedition/shuttle_light_controller

/datum/outbound_ship_system/lighting/on_fail()
	. = ..()
	var/obj/machinery/power/apc/auto_name/directional/north/vanguard_shuttle/vanguard_apc = locate() in GLOB.areas_by_type[/area/awaymission/outbound_expedition/shuttle]
	vanguard_apc.light_gen_alive = FALSE

/obj/machinery/outbound_expedition/shuttle_light_controller
	name = "light collator"
	desc = "A generator that keeps the lights on, literally."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "bus"

/obj/machinery/outbound_expedition/shuttle_light_controller/Initialize(mapload)
	. = ..()
	GLOB.outbound_ship_systems += src

/obj/machinery/outbound_expedition/shuttle_light_controller/Destroy()
	GLOB.outbound_ship_systems -= src
	return ..()

/obj/machinery/outbound_expedition/shuttle_light_controller/on_system_fail(datum/outbound_ship_system/failed_system)
	. = ..()
	update_icon_state()

/obj/machinery/outbound_expedition/shuttle_light_controller/update_icon_state()
	if(failed)
		icon_state = "bus_off"
	return ..()

/obj/machinery/power/apc/auto_name/directional/north/vanguard_shuttle
	/// Is the light controller destroyed?
	var/light_gen_alive = TRUE

/obj/machinery/power/apc/auto_name/directional/north/vanguard_shuttle/Initialize(mapload, ndir)
	. = ..()
	req_access = null

/obj/machinery/power/apc/auto_name/directional/north/vanguard_shuttle/screwdriver_act(mob/living/user, obj/item/W)
	to_chat(user, span_notice("You can't unscrew this!"))

/obj/machinery/power/apc/auto_name/directional/north/vanguard_shuttle/process()
	. = ..()
	if(!light_gen_alive && (lighting != APC_CHANNEL_OFF))
		lighting = APC_CHANNEL_OFF
		update()
		update_appearance()

/datum/outbound_ship_system/gravity
	name = "Gravity"
	subsystem = TRUE
	machine_type = /obj/machinery/outbound_expedition/shuttle_grav_gen

/datum/outbound_ship_system/gravity/on_fail()
	. = ..()
	var/area/awaymission/outbound_expedition/shuttle/shuttle_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/shuttle]
	shuttle_area.has_gravity = FALSE

// Gravity mcguffin. Does nothing until destroyed, then no gravity
/obj/machinery/outbound_expedition/shuttle_grav_gen
	name = "gravity generator"
	desc = "A highly experimental, compacted generator for creating localized gravity in small spaces."
	icon = 'icons/obj/machines/field_generator.dmi'
	icon_state = "Field_Gen"

/obj/machinery/outbound_expedition/shuttle_grav_gen/Initialize(mapload)
	. = ..()
	GLOB.outbound_ship_systems += src
	overlays += "+on"

/obj/machinery/outbound_expedition/shuttle_grav_gen/Destroy()
	GLOB.outbound_ship_systems -= src
	return ..()

/obj/machinery/outbound_expedition/shuttle_grav_gen/on_system_fail(datum/outbound_ship_system/failed_system)
	. = ..()
	overlays -= "+on"
