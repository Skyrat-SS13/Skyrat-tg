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

// 4.6x30mm

/obj/projectile/bullet/c46x30mm_rubber
	name = "4.6x30mm rubber bullet"
	damage = 5
	stamina = 15
	wound_bonus = -25

// .45

/obj/projectile/bullet/c45_rubber
	name = ".45 rubber bullet"
	damage = 10
	stamina = 20
	wound_bonus = -25
	wound_falloff_tile = -10

// 5.56

/obj/projectile/bullet/a556/rubber
	name = "5.56mm rubber bullet"
	damage = 10
	armour_penetration = 10
	stamina = 30
	wound_bonus = -50
