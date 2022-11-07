/*
*	KNOCKDOWN BOLT
*	A taser that had the same stamina impact as a disabler, but a five-second knockdown and taser hitter effects.
*/

/obj/item/ammo_casing/energy/electrode/knockdown
	projectile_type = /obj/projectile/energy/electrode/knockdown
	select_name = "knockdown"
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 200
	harmful = FALSE

/obj/projectile/energy/electrode/knockdown
	name = "electrobolt"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "electro_bolt"
	knockdown = 50
	stamina = 30
	range = 6
