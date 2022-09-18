///NEW CARTRIDGES

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
	name = "5.6x40mm match bullet casing"
	desc = "A 5.6x40mm match bullet casing."
	special_desc = "MATCH: Ricochets everywhere. Like crazy."
	projectile_type = /obj/projectile/bullet/a762x39/ricochet

/obj/projectile/bullet/a762x39/ricochet
	name = "5.6mm match bullet"
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
	desc = "A 5.6x40mm incendiary bullet casing."
	special_desc = "TARGETED INCENDIARY: Leaves no trail when shot, sets targets aflame."
	projectile_type = /obj/projectile/bullet/incendiary/a762x39

/obj/projectile/bullet/incendiary/a762x39
	name = "5.6mm incendiary bullet"
	damage = 30
	wound_bonus = 25
	armour_penetration = 30
	wound_falloff_tile = -5
	fire_stacks = 2
	leaves_fire_trail = FALSE

/obj/item/ammo_casing/realistic/a762x39/ap
	name = "5.6x40mm armor-piercing bullet casing"
	desc = "A 5.6x40mm armor-piercing bullet casing."
	special_desc = "ARMOR PIERCING: Increased armor piercing capabilities. What did you expect?"
	projectile_type = /obj/projectile/bullet/a762x39

/obj/projectile/bullet/a762x39/ap
	name = "5.6mm armor-piercing bullet"
	damage = 30
	wound_bonus = 15
	armour_penetration = 60

/obj/item/ammo_casing/realistic/a762x39/emp
	name = "5.6x40mm ion bullet casing"
	desc = "A 5.6x40mm ion bullet casing."
	special_desc = "EMP: Produces an Electro-Magnetic Pulse on impact, damaging electronics severely."
	projectile_type = /obj/projectile/bullet/a762x39/emp

/obj/projectile/bullet/a762x39/emp
	name = "5.6mm ion bullet"
	damage = 25
	wound_bonus = 15
	armour_penetration = 15
	var/heavy_emp_radius = -1
	var/light_emp_radius = 0

/obj/projectile/bullet/a762x39/emp/on_hit(atom/target, blocked = FALSE)
	..()
	empulse(target, heavy_emp_radius, light_emp_radius)
	return BULLET_ACT_HIT

/obj/item/ammo_casing/realistic/a762x39/civilian
	name = "5.6x40mm civilian bullet casing"
	desc = "A 5.6x40mm civilian-grade surplus bullet casing."
	special_desc = "CIVILIAN: Non-military ammunition with a low powder load. Performs worse in every aspect in comparison to its military variant."
	projectile_type = /obj/projectile/bullet/a762x39/civilian

/obj/projectile/bullet/a762x39/civilian
	name = "5.6mm civilian bullet"
	damage = 30
	wound_bonus = 15
	armour_penetration = 10
	wound_falloff_tile = 3

/obj/item/ammo_casing/realistic/a762x39/civilian/rubber
	name = "5.6x40mm rubber bullet casing"
	desc = "A 5.6x40mm civilian-grade rubber bullet casing."
	special_desc = "RUBBER: Less than lethal ammo. Deals both stamina and brute damage."
	projectile_type = /obj/projectile/bullet/a762x39/rubber
	harmful = FALSE

/obj/projectile/bullet/a762x39/rubber
	name = "5.6mm rubber bullet"
	damage = 12
	armour_penetration = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/realistic/a762x39/civilian/hunting
	name = "5.6x40mm hunting bullet casing"
	desc = "A 5.6x40mm jacketed soft point bullet casing."
	special_desc = "HUNTING: Ammo purpose-built to deal more damage against simplemobs than other humans."
	projectile_type = /obj/projectile/bullet/a762x39/hunting

/obj/projectile/bullet/a762x39/hunting
	name = "5.6mm hunting bullet"
	damage = 20
	wound_bonus = 10
	armour_penetration = 10
	wound_falloff_tile = 3
		/// Bonus force dealt against certain mobs
	var/nemesis_bonus_force = 25
		/// List of mobs we deal bonus damage to
	var/list/nemesis_path = list(/mob/living/simple_animal)

/obj/projectile/bullet/a762x39/hunting/prehit_pierce(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, nemesis_path))
		damage += nemesis_bonus_force
	.=..()

/obj/item/ammo_casing/realistic/a762x39/civilian/blank
	name = "5.6x40mm blank bullet casing"
	desc = "A 5.6x40mm blank bullet casing."
	special_desc = "BLANK: Projectile-less ammunition that is usually employed in training exercises or Live-Action Roleplay. Potentially harmful."
	projectile_type = /obj/projectile/bullet/a762x39/blank
	///"Potentially."
	harmful = FALSE

/obj/projectile/bullet/a762x39/blank
	name = "hot gas"
	icon = 'icons/obj/weapons/guns/projectiles_muzzle.dmi'
	icon_state = "muzzle_bullet"
	damage = 5
	damage_type = BURN
	wound_bonus = -100
	armour_penetration = 0
	wound_falloff_tile = 15
	weak_against_armour = TRUE
	range = 0.01
	shrapnel_type = null
	sharpness = NONE
	embedding = null
