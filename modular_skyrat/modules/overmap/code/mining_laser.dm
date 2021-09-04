/obj/machinery/mining_laser
	name = "mining laser"
	desc = "A powerful laser specialized in drilling and breaking down large rocks."
	icon = 'icons/obj/machines/mining_laser.dmi'
	icon_state = "mining_laser"
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 60
	circuit = /obj/item/circuitboard/machine/mining_laser
	var/extension_type = /datum/shuttle_extension/weapon/mining_laser
	var/datum/shuttle_extension/weapon/extension

/obj/machinery/mining_laser/Initialize()
	. = ..()
	extension = new extension_type(src)
	extension.ApplyToPosition(get_turf(src))
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE)

/obj/machinery/mining_laser/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	extension.ApplyToPosition(get_turf(src))

/obj/machinery/mining_laser/proc/PostFire()
	playsound(src, 'sound/weapons/lasercannonfire.ogg', 65, TRUE)
	var/turf/effect_spot = get_turf(src)
	effect_spot = get_step(effect_spot, dir)
	var/obj/effect = new /obj/effect/temp_visual/mining_laser_fire(effect_spot)
	effect.dir = dir

/obj/machinery/mining_laser/Destroy()
	extension.RemoveExtension()
	QDEL_NULL(extension)
	return ..()

/obj/item/circuitboard/machine/mining_laser
	name = "Mining Laser (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/mining_laser
	req_components = list(/obj/item/stock_parts/micro_laser = 5,
							/obj/item/stock_parts/manipulator  = 2)

/obj/effect/temp_visual/mining_laser_fire
	icon = 'icons/obj/machines/mining_laser.dmi'
	icon_state = "laser_fire"
	light_color = LIGHT_COLOR_FIRE
	light_system = MOVABLE_LIGHT
	light_power = 1.5
	light_range = 3
