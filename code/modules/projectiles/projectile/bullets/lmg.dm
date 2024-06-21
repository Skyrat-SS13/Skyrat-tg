// C3D (Borgs)

/obj/projectile/bullet/c3d
	damage = 20

// Mech LMG

/obj/projectile/bullet/lmg
	damage = 20

// Mech FNX-99

/obj/projectile/bullet/incendiary/fnx99
	damage = 20

// Turrets

/obj/projectile/bullet/manned_turret
	damage = 20

/obj/projectile/bullet/manned_turret/hmg
	icon_state = "redtrac"

/obj/projectile/bullet/syndicate_turret
	damage = 20

// 7mm (SAW)

/obj/projectile/bullet/a7mm
	name = "7mm bullet"
	damage = 30
	armour_penetration = 5
	wound_bonus = -50
	wound_falloff_tile = 0

/obj/projectile/bullet/a7mm/ap
	name = "7mm armor-piercing bullet"
	damage = 25
	armour_penetration = 75

/obj/projectile/bullet/a7mm/hp
	name = "7mm hollow-point bullet"
	damage = 50
	sharpness = SHARP_EDGED
	weak_against_armour = TRUE
	wound_bonus = -40
	bare_wound_bonus = 30
	wound_falloff_tile = -8

/obj/projectile/bullet/incendiary/a7mm
	name = "7mm incendiary bullet"
	damage = 15
	fire_stacks = 3

/obj/projectile/bullet/a7mm/match
	name = "7mm match bullet"
	ricochets_max = 2
	ricochet_chance = 60
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 55

/obj/projectile/bullet/a7mm/bouncy
	name = "7mm rubber bullet"
	damage = 20
	ricochets_max = 40
	ricochet_chance = 500 // will bounce off anything and everything, whether they like it or not
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 0
	ricochet_decay_chance = 0.9
