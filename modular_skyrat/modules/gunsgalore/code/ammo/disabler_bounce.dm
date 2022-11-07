/*
*	BOUNCE DISABLER
*	A disabler that will always ricochet.
*/


/obj/item/ammo_casing/energy/disabler/bounce
	projectile_type = /obj/projectile/beam/disabler/bounce
	select_name  = "disable"
	e_cost = 60
	fire_sound = 'sound/weapons/taser2.ogg'
	harmful = FALSE

/obj/effect/projectile/tracer/disabler/bounce
	name = "disabler"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "bouncebeam"

/obj/projectile/beam/disabler/bounce
	name = "disabler arc"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "bouncebeam"
	damage = 30
	damage_type = STAMINA
	armor_flag = ENERGY
	eyeblur = 1
	tracer_type = /obj/effect/projectile/tracer/disabler/bounce
	light_range = 5
	light_power = 0.75
	speed = 1.4
	ricochets_max = 6
	ricochet_incidence_leeway = 170
	ricochet_chance = 130
	ricochet_decay_damage = 0.9

// Allows the projectile to reflect on walls like how bullets ricochet.
/obj/projectile/beam/disabler/bounce/check_ricochet_flag(atom/A)
	return TRUE

/obj/item/ammo_casing/caseless/laser/bounce/disabler
	name = "type III reflective projectile (disabler)"
	desc = "A chemical mixture that once triggered, creates bouncing disabler projectile, melting it's own casing in the process."
	icon_state = "disabler_shell"
	projectile_type = /obj/projectile/beam/disabler/bounce
