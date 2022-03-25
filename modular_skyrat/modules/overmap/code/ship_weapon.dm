/obj/machinery/ship_weapon
	name = "mining laser"
	desc = "A powerful laser specialized in drilling and breaking down large rocks."
	icon = 'modular_skyrat/modules/overmap/icons/mining_laser.dmi'
	icon_state = "mining_laser"
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 60
	circuit = /obj/item/circuitboard/machine/ship_weapon
	var/extension_type = /datum/shuttle_extension/weapon
	var/datum/shuttle_extension/weapon/extension

	var/projectile_type = /datum/overmap_object/projectile
	var/firing_sound = 'sound/weapons/lasercannonfire.ogg'
	var/firing_cooldown = 3 SECONDS
	var/visual_firing_effect = /obj/effect/temp_visual/ship_weapon_fire

/obj/machinery/ship_weapon/Initialize()
	. = ..()
	extension = new extension_type(src)
	extension.ApplyToPosition(get_turf(src))
	AddComponent(/datum/component/simple_rotation)

/obj/machinery/ship_weapon/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	extension.ApplyToPosition(get_turf(src))

/obj/machinery/ship_weapon/proc/PostFire()
	playsound(src, firing_sound, 65, TRUE)
	var/turf/effect_spot = get_turf(src)
	effect_spot = get_step(effect_spot, dir)
	var/obj/effect = new visual_firing_effect(effect_spot)
	effect.dir = dir

/obj/machinery/ship_weapon/Destroy()
	extension.RemoveExtension()
	QDEL_NULL(extension)
	return ..()

/obj/item/circuitboard/machine/ship_weapon
	name = "Broken Ship Weapon (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/ship_weapon
	req_components = list(/obj/item/stock_parts/micro_laser = 5,
							/obj/item/stock_parts/manipulator  = 2)

/obj/machinery/ship_weapon/mining_laser
	name = "mining laser"
	desc = "A powerful laser specializing in drilling and breaking down large rocks"
	projectile_type = /datum/overmap_object/projectile/damaging/mining
	circuit = /obj/item/circuitboard/machine/ship_weapon/mining_laser

/obj/item/circuitboard/machine/ship_weapon/mining_laser
	name = "Ship Mining Laser (Machine Board)"
	build_path = /obj/machinery/ship_weapon/mining_laser

/obj/effect/temp_visual/ship_weapon_fire
	icon = 'modular_skyrat/modules/overmap/icons/mining_laser.dmi'
	icon_state = "laser_fire"
	light_color = LIGHT_COLOR_FIRE
	light_system = MOVABLE_LIGHT
	light_power = 1.5
	light_range = 3
