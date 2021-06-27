//Medigun Cells/
/obj/item/stock_parts/cell/medigun/ //This is the cell that mediguns from cargo will come with//
	name = "Basic Medigun Cell"
	maxcharge = 1200
	chargerate = 80

/obj/item/stock_parts/cell/medigun/upgraded
	name = "Upgraded Medigun Cell"
	maxcharge = 1500
	chargerate = 160

/obj/item/stock_parts/cell/medigun/experimental //This cell type is meant to be used in self charging mediguns like CMO and ERT one.//
	name = "Experiemental Medigun Cell"
	maxcharge = 1800
	chargerate = 100
//End of cells

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

//T1 Healing Projectiles//
//The Basic Brute Heal Projectile//
/obj/item/ammo_casing/energy/medical/brute1
	projectile_type = /obj/projectile/energy/medical/brute1
	select_name = "Brute I"

/obj/projectile/energy/medical/brute1
	name = "brute heal shot"

/obj/projectile/energy/medical/brute1/on_hit(mob/living/target)
	.=..()
	target.adjustBruteLoss(-5)
//The Basic Burn Heal//
/obj/item/ammo_casing/energy/medical/burn1
	projectile_type = /obj/projectile/energy/medical/burn1
	select_name = "Burn I"

/obj/projectile/energy/medical/burn1
	name = "burn heal shot"

/obj/projectile/energy/medical/burn1/on_hit(mob/living/target)
	.=..()
	target.adjustFireLoss(-5)
//Basic Toxin Heal//
/obj/item/ammo_casing/energy/medical/toxin1
	projectile_type = /obj/projectile/energy/medical/toxin1
	select_name = "Toxin I"

/obj/projectile/energy/medical/toxin1
	name = "toxin heal shot"

/obj/projectile/energy/medical/toxin1/on_hit(mob/living/target)
	.=..()
	target.adjustToxLoss(-2.5) //Toxin is treatable, but inefficent//
//T2 Healing Projectiles//
//Tier II Brute Projectile//
/obj/item/ammo_casing/energy/medical/brute2
	projectile_type = /obj/projectile/energy/medical/brute2
	select_name = "Brute II"

/obj/projectile/energy/medical/brute2
	name = "strong brute heal shot"

/obj/projectile/energy/medical/brute2/on_hit(mob/living/target)
	.=..()
	target.adjustBruteLoss(-7.5)
//Tier II Burn Projectile//
/obj/item/ammo_casing/energy/medical/burn2
	projectile_type = /obj/projectile/energy/medical/burn2
	select_name = "Burn II"

/obj/projectile/energy/medical/burn2
	name = "strong burn heal shot"

/obj/projectile/energy/medical/burn2/on_hit(mob/living/target)
	.=..()
	target.adjustFireLoss(-7.5)
//Tier II Oxy Projectile//
/obj/item/ammo_casing/energy/medical/oxy2
	projectile_type = /obj/projectile/energy/medical/oxy2
	select_name = "Oxygen II"

/obj/projectile/energy/medical/oxy2
	name = "strong oxygen heal shot"

/obj/projectile/energy/medical/oxy2/on_hit(mob/living/target)
	.=..()
	target.adjustOxyLoss(-10)
//Tier II Toxin Projectile//
/obj/item/ammo_casing/energy/medical/toxin2
	projectile_type = /obj/projectile/energy/medical/toxin2
	select_name = "Toxin II"

/obj/projectile/energy/medical/toxin2
	name = "strong toxin heal shot"

/obj/projectile/energy/medical/toxin2/on_hit(mob/living/target)
	.=..()
	target.adjustToxLoss(-3.5)
//T3 Healing Projectiles//
//Tier III Brute Projectile//
/obj/item/ammo_casing/energy/medical/brute3
	projectile_type = /obj/projectile/energy/medical/brute3
	select_name = "Brute III"

/obj/projectile/energy/medical/brute3
	name = "powerful brute heal shot"

/obj/projectile/energy/medical/brute3/on_hit(mob/living/target)
	.=..()
	target.adjustBruteLoss(-10)
//Tier III Burn Projectile//
/obj/item/ammo_casing/energy/medical/burn3
	projectile_type = /obj/projectile/energy/medical/burn3
	select_name = "Burn III"

/obj/projectile/energy/medical/burn3
	name = "powerful burn heal shot"

/obj/projectile/energy/medical/burn3/on_hit(mob/living/target)
	.=..()
	target.adjustFireLoss(-10)
//Tier III Oxy Projectile//
/obj/item/ammo_casing/energy/medical/oxy3
	projectile_type = /obj/projectile/energy/medical/oxy3
	select_name = "Oxygen III"

/obj/projectile/energy/medical/oxy3
	name = "powerful oxygen heal shot"

/obj/projectile/energy/medical/oxy3/on_hit(mob/living/target)
	.=..()
	target.adjustOxyLoss(-15)
//Tier III Toxin Projectile//
/obj/item/ammo_casing/energy/medical/toxin3
	projectile_type = /obj/projectile/energy/medical/toxin3
	select_name = "Toxin III"

/obj/projectile/energy/medical/toxin3
	name = "powerful toxin heal shot"

/obj/projectile/energy/medical/toxin3/on_hit(mob/living/target)
	.=..()
	target.adjustToxLoss(-5)

//End of Basic Tiers of cells.//
