obj/item/stock_parts/cell/medigun/basic
	name = "Basic Medigun Cell"
	maxcharge = 1200
	chargerate = 100

/obj/item/ammo_casing/energy/medical
	projectile_type = /obj/projectile/energy/medical/default
	select_name = "Default"
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 60
	harmful = FALSE

/obj/projectile/energy/medical
	name = "medical heal shot"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "electro_bolt"
	damage = 0

/obj/item/ammo_casing/energy/medical/default
	name = "oxygen heal shot"

/obj/projectile/energy/medical/default/on_hit(mob/living/target)
	.=..()
	target.adjustOxyLoss(-5)

//The Basic Brute Heal Projectile//
/obj/item/ammo_casing/energy/medical/brute1
	projectile_type = /obj/projectile/energy/medical/brute1
	select_name = "Brute"

/obj/projectile/energy/medical/brute1
	name = "brute heal shot"

/obj/projectile/energy/medical/brute1/on_hit(mob/living/target)
	.=..()
	target.adjustBruteLoss(-5)
//The Basic Burn Heal//
/obj/item/ammo_casing/energy/medical/burn1
	projectile_type = /obj/projectile/energy/medical/burn1
	select_name = "Burn"

/obj/projectile/energy/medical/burn1
	name = "burn heal shot"

/obj/projectile/energy/medical/burn/on_hit(mob/living/target)
	.=..()
	target.adjustFireLoss(-5)
