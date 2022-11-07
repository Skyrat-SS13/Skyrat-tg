/*
*	BOUNCE LASER
*	A laser that will always ricochet.
*/

/obj/item/ammo_casing/energy/laser/bounce
	projectile_type = /obj/projectile/beam/laser/bounce
	select_name = "lethal"
	e_cost = 100

/obj/projectile/beam/laser/bounce
	name = "energy arc"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "bouncebeam_red"
	damage = 20
	damage_type = BURN
	armor_flag = LASER
	light_range = 5
	light_power = 0.75
	speed = 1.4
	ricochets_max = 6
	ricochet_incidence_leeway = 170
	ricochet_chance = 130
	ricochet_decay_damage = 0.9

// Allows the projectile to reflect on walls like how bullets ricochet.
/obj/projectile/beam/laser/bounce/check_ricochet_flag(atom/A)
	return TRUE

/obj/item/ammo_casing/caseless/laser/bounce
	name = "type III reflective projectile (lethal)"
	desc = "A chemical mixture that once triggered, creates a deadly bouncing projectile, melting it's own casing in the process."
	icon_state = "bounce_shell"
	worn_icon_state = "shell"
	caliber = "Beam Shell"
	custom_materials = list(/datum/material/iron=4000,/datum/material/plasma=250)
	projectile_type = /obj/projectile/beam/laser/bounce
