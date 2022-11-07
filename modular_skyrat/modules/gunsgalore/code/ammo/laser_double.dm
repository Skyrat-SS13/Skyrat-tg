/*
*	DOUBLE LASER
*	Visually, this fires two lasers. In code, it's just one.
*	It's fast and great for turrets.
*/

/obj/item/ammo_casing/energy/laser/double
	projectile_type = /obj/projectile/beam/laser/double
	e_cost = 100
	select_name = "lethal"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/projectile/beam/laser/double
	name = "laser bolt"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "double_laser"
	damage = 40
	eyeblur = 1
	light_range = 5
	light_power = 0.75
	speed = 0.5
	armour_penetration = 10

/obj/item/ammo_casing/caseless/laser/double
	name = "type II plasma projectile"
	desc = "A chemical mixture that once triggered, creates a deadly projectile, melting it's own casing in the process."
	icon_state = "plasma_shell2"
	worn_icon_state = "shell"
	caliber = "Beam Shell"
	custom_materials = list(/datum/material/iron=4000,/datum/material/plasma=500)
	projectile_type = /obj/projectile/beam/laser/double
