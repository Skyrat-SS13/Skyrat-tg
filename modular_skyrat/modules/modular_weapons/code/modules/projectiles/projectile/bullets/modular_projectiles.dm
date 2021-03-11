////////////////////////
//ID: MODULAR_WEAPONS //
////////////////////////

// 32

/obj/projectile/bullet/c32
	name = ".32 bullet"
	damage = 15
	wound_bonus = -50

/obj/projectile/bullet/c32_rubber
	name = ".32 rubber bullet"
	damage = 5
	stamina = 20
	wound_bonus = -75

/obj/projectile/bullet/c32_ap
	name = ".32 armor-piercing bullet"
	damage = 10
	armour_penetration = 40
	wound_bonus = -10

/obj/projectile/bullet/incendiary/c32_incendiary
	name = ".32 incendiary bullet"
	damage = 8
	fire_stacks = 1
	wound_bonus = -90

// 10mm Magnum
/obj/item/ammo_casing/c10mm/rubber
	name = "10mm Magnum rubber bullet casing"
	desc = "A 10mm Magnum bullet casing. This fires a non-lethal projectile to cause compliance by pain and bruising. Don't aim for the head."
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/c10mm/rubber

/obj/projectile/bullet/c10mm/rubber
	name = "10mm Magnum rubber bullet"
	damage = 10
	stamina = 40
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null


// 4.6x30mm

/obj/projectile/bullet/c46x30mm_rubber
	name = "4.6x30mm rubber bullet"
	damage = 5
	stamina = 15
	wound_bonus = -25

/obj/item/ammo_casing/c46x30mm/rubber
	name = "4.6x30mm rubber bullet casing"
	desc = "A 4.6x30mm rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c46x30mm_rubber

// 5.56

/obj/projectile/bullet/a556/rubber
	name = "5.56mm rubber bullet"
	damage = 10
	armour_penetration = 10
	stamina = 30
	wound_bonus = -50	

/obj/item/ammo_casing/a556/rubber
	name = "5.56mm rubber bullet casing"
	desc = "A 5.56mm rubber ullet casing."
	caliber = CALIBER_A556
	projectile_type = /obj/projectile/bullet/a556/rubber

/obj/projectile/bullet/a556/ap
	name = "5.56mm AP bullet"
	armour_penetration = 60

/obj/item/ammo_casing/a556
	name = "5.56mm AP bullet casing"
	desc = "A 5.56mm AP bullet casing."
	caliber = CALIBER_A556
	projectile_type = /obj/projectile/bullet/a556/ap
