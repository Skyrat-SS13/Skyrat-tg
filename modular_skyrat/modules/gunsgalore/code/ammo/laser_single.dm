/*
*	SINGLE LASER
*	Has an unique sprite
*	Low-powered laser for rapid fire
*	Pea-shooter tier.
*/


/obj/item/ammo_casing/energy/laser/single
	projectile_type = /obj/projectile/beam/laser/single
	e_cost = 50
	select_name = "lethal"

/obj/projectile/beam/laser/single
	name = "laser bolt"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "single_laser"
	damage = 15
	eyeblur = 1
	light_range = 5
	light_power = 0.75
	speed = 0.5
	armour_penetration = 10

/obj/item/ammo_casing/caseless/laser
	name = "type I plasma projectile"
	desc = "A chemical mixture that once triggered, creates a deadly projectile, melting it's own casing in the process."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "plasma_shell"
	worn_icon_state = "shell"
	caliber = "Beam Shell"
	custom_materials = list(/datum/material/iron=4000,/datum/material/plasma=250)
	projectile_type = /obj/projectile/beam/laser/single
