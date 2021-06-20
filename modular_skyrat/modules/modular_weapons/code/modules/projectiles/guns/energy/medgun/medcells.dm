obj/item/stock_parts/cell/medigun/basic
	name = "Basic Medigun Cell"
	maxcharge = 2400
	chargerate = 30

/obj/item/ammo_casing/energy/medical/brute1
	projectile_type = /obj/projectile/energy/medical/brute1
	select_name = "brute"
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 60
	harmful = FALSE

//The Basic Brute Heal Projectile//
/obj/projectile/energy/medical/brute1
	name = "brute heal shot"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "electro_bolt"
	damage = 0

/obj/projectile/energy/medical/brute1/on_hit(mob/living/target)
	.=..()
	target.adjustBruteLoss(-5)
//The Basic Brun Heal//
/obj/projectile/energy/medical/burn1
	name = "burn heal shot"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "electro_bolt"
	damage = 0

/obj/projectile/energy/medical/burn1/on_hit(mob/living/target)
	.=..()
	target.adjustFireLoss(-5)
//The Basic Toxin Heal Projectile//
/obj/projectile/energy/medical/tox1
	name = "toxin heal shot"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "electro_bolt"
	damage = 0

/obj/projectile/energy/medical/tox1/on_hit(mob/living/target)
	.=..()
	target.adjustToxLoss(-5)
