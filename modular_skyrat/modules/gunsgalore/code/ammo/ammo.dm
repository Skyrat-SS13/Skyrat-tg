//NEW CARTRIDGES
/obj/item/ammo_casing/realistic
	icon = 'modular_skyrat/modules/gunsgalore/icons/ammo/ammo.dmi'

//GERMAN
//7.92x33mm Kurz
/obj/item/ammo_casing/realistic/a792x33
	name = "7.92x33 bullet casing"
	desc = "A 7.92x33mm Kurz bullet casing."
	icon_state = "792x33-casing"
	caliber = "a792x33"
	projectile_type = /obj/projectile/bullet/a792x33

/obj/projectile/bullet/a792x33
	name = "7.92x33 bullet"
	damage = 32
	wound_bonus = 10
	wound_falloff_tile = 0
//

//7.92x57mm Mauser
/obj/item/ammo_casing/realistic/a792x57
	name = "7.92x57 bullet casing"
	desc = "A 7.92x57mm Mauser bullet casing."
	icon_state = "792x57-casing"
	caliber = "a792x57"
	projectile_type = /obj/projectile/bullet/a792x57

/obj/projectile/bullet/a792x57
	name = "7.92x57 bullet"
	damage = 35
	armour_penetration = 5
	wound_bonus = 15
	wound_falloff_tile = 0
//

//RUSSIAN - NRI
//7.62x25 tokarev
/obj/item/ammo_casing/realistic/a762x25
	name = "7.62x25 bullet casing"
	desc = "A 7.62x25 Tokarev bullet casing."
	icon_state = "762x25-casing"
	caliber = "a762x25"
	projectile_type = /obj/projectile/bullet/a762x25

/obj/projectile/bullet/a762x25
	name = "7.62x25 bullet"
	damage = 20
	wound_falloff_tile = 0
//

//NRI Propietary ammo
/obj/item/ammo_casing/realistic/a762x39
	name = "5.6x40mm bullet casing"
	desc = "A 5.6x40mm bullet casing."
	icon_state = "762x39-casing"
	caliber = "a762x39"
	projectile_type = /obj/projectile/bullet/a762x39

/obj/projectile/bullet/a762x39
	name = "5.6mm bullet"
	damage = 38
	wound_bonus = 35
	armour_penetration = 40
	wound_falloff_tile = 0

/obj/item/ammo_casing/realistic/a762x39/ricochet
	name = "5.6x40mm marksman bullet casing"
	desc = "A 5.6x40mm marksman bullet casing.\
	<br><br>\
	<i>MARKSMAN: High ricochet and autoaim chance.</i>"
	projectile_type = /obj/projectile/bullet/a762x39/ricochet

/obj/projectile/bullet/a762x39/ricochet
	name = "5.6mm marksman bullet"
	damage = 30
	wound_bonus = 25
	armour_penetration = 25
	ricochets_max = 2
	ricochet_chance = 100
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 15
	ricochet_incidence_leeway = 40
	ricochet_decay_damage = 1
	ricochet_shoots_firer = FALSE

/obj/item/ammo_casing/realistic/a762x39/fire
	name = "5.6x40mm incendiary bullet casing"
	desc = "A 5.6x40mm incendiary bullet casing.\
	<br><br>\
	<i>TARGETED INCENDIARY: Leaves no trail when shot, sets targets aflame.</i>"
	projectile_type = /obj/projectile/bullet/incendiary/a762x39

/obj/projectile/bullet/incendiary/a762x39
	name = "5.6mm incendiary bullet"
	damage = 30
	wound_bonus = 25
	armour_penetration = 30
	wound_falloff_tile = -5
	fire_stacks = 2
	leaves_fire_trail = FALSE

/obj/item/ammo_casing/realistic/a762x39/xeno
	name = "5.6x40mm anti-acid bullet casing"
	desc = "A 5.6x40mm anti-acid bullet casing. Special chemical treatment and an additional layer of water-absorbent materials dissipates and absorbs water from the target's body, making any acid-blooded target melt from the inside.\
	<br><br>\
	<i>XENO BUSTER: Deals huge additional damage against Xenomorphs.</i>"
	projectile_type = /obj/projectile/bullet/a762x39/xeno

/obj/projectile/bullet/a762x39/xeno
	name = "5.6mm anti-acid bullet"
	damage = 25
	wound_bonus = 15
	armour_penetration = 0
		/// Bonus force dealt against certain mobs
	var/faction_bonus_force = 25
		/// List of mobs we deal bonus damage to
	var/list/nemesis_path = /mob/living/carbon/alien

/obj/projectile/bullet/a762x39/xeno/prehit_pierce(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, nemesis_path))
		damage += faction_bonus_force
	.=..()

/obj/item/ammo_casing/realistic/a762x39/ap
	name = "5.6x40mm armor-piercing bullet casing"
	desc = "A 5.6x40mm armor-piercing bullet casing.\
	<br><br>\
	<i>ARMOR-PIERCING: Practically ignores armor. Reduced damage and wounding chance.</i>"
	projectile_type = /obj/projectile/bullet/a762x39

/obj/projectile/bullet/a762x39/ap
	name = "5.6mm armor-piercing bullet"
	damage = 30
	wound_bonus = 15
	armour_penetration = 60
	wound_falloff_tile = 0

/obj/item/ammo_casing/realistic/a762x39/emp
	name = "5.6x40mm ion bullet casing"
	desc = "A 5.6x40mm ion bullet casing.\
	<br><br>\
	<i>ION: EMPs on hit. Reduced conventional damage.</i>"
	projectile_type = /obj/projectile/bullet/a762x39/emp

/obj/projectile/bullet/a762x39/emp
	name = "5.6mm ion bullet"
	damage = 25
	wound_bonus = 15
	armour_penetration = 15
	var/emp_radius = 0

/obj/projectile/bullet/a762x39/emp/on_hit(atom/target, blocked = FALSE)
	..()
	empulse(target, emp_radius, emp_radius)
	return BULLET_ACT_HIT

/obj/item/ammo_casing/realistic/a762x39/rubber
	name = "5.6x40mm rubber bullet casing"
	desc = "A 5.6x40mm rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/a762x39/rubber
	harmful = FALSE

/obj/projectile/bullet/a762x39/rubber
	name = "5.6mm rubber bullet"
	damage = 12
	armour_penetration = 10
	stamina = 38
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50
