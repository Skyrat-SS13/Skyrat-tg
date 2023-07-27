/obj/item/ammo_casing
	/// Can this bullet casing be printed at an ammunition workbench?
	var/can_be_printed = TRUE
	/// If it can be printed, does this casing require an advanced ammunition datadisk? Mainly for specialized ammo.
	/// Rubbers aren't advanced. Standard ammo (or FMJ if you're particularly pedantic) isn't advanced.
	/// Think more specialized or weird, niche ammo, like armor-piercing, incendiary, hollowpoint, or God forbid, phasic.
	var/advanced_print_req = FALSE

// whatever goblin decided to spread out bullets over like 3 files and god knows however many overrides i wish you a very stubbed toe

/*
*	.460 Ceres
*/

/obj/item/ammo_casing/c45/rubber
	name = ".460 Ceres rubber bullet casing"
	desc = "A .460 bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c45/rubber
	harmful = FALSE

/obj/projectile/bullet/c45/rubber
	name = ".460 Ceres rubber bullet"
	damage = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/c45/hp
	name = ".460 Ceres hollow-point bullet casing"
	desc = "A .460 hollow-point bullet casing. Very lethal against unarmored opponents. Suffers against armor."
	projectile_type = /obj/projectile/bullet/c45/hp
	advanced_print_req = TRUE

/obj/projectile/bullet/c45/hp
	name = ".460 Ceres hollow-point bullet"
	damage = 40
	weak_against_armour = TRUE

/*
*	8mm Usurpator
*/

/obj/projectile/bullet/c46x30mm_rubber
	name = "8mm Usurpator rubber bullet"
	damage = 3
	stamina = 17
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/c46x30mm/rubber
	name = "8mm Usurpator rubber bullet casing"
	desc = "An 8mm Usurpator rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c46x30mm_rubber
	harmful = FALSE

/*
*	.277 Aestus
*/

/obj/item/ammo_casing/a556/rubber
	name = ".277 rubber bullet casing"
	desc = "A .277 rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	caliber = CALIBER_A556
	projectile_type = /obj/projectile/bullet/a556/rubber
	harmful = FALSE

/obj/projectile/bullet/a556/rubber
	name = ".277 rubber bullet"
	damage = 10
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

/obj/item/ammo_casing/a556/ap
	name = ".277 Aestus armor-piercing bullet casing"
	desc = "A .277 armor-piercing bullet casing.\
	<br><br>\
	<i>ARMOR PIERCING: Increased armor piercing capabilities. What did you expect?"
	caliber = CALIBER_A556
	projectile_type = /obj/projectile/bullet/a556/ap
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/a556/ap
	name = ".277 armor-piercing bullet"
	armour_penetration = 60

/*
*	.244 Acia
*/

/obj/item/ammo_casing/a762/rubber
	name = ".244 Acia rubber bullet casing"
	desc = "A .244 rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	icon_state = "762-casing"
	caliber = CALIBER_A762
	projectile_type = /obj/projectile/bullet/a762/rubber
	harmful = FALSE

/obj/projectile/bullet/a762/rubber
	name = ".244 rubber bullet"
	damage = 15
	stamina = 55
	ricochets_max = 5
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/a762/ap
	name = ".244 Acia armor-piercing bullet casing"
	desc = "A .244 armor-piercing bullet casing.\
	<br><br>\
	<i>ARMOR-PIERCING: Improved armor-piercing capabilities, in return for less outright damage.</i>"
	projectile_type = /obj/projectile/bullet/a762/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/projectile/bullet/a762/ap
	name = ".244 armor-piercing bullet"
	damage = 50
	armour_penetration = 60

/*
*	.34 ACP
*/

// Why? Blame CFA, they want their bullets to be *proprietary*
/obj/item/ammo_casing/c34
	name = ".34 bullet casing"
	desc = "A .34 bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34

/obj/projectile/bullet/c34
	name = ".34 bullet"
	damage = 15
	wound_bonus = 0

/obj/item/ammo_casing/c34/rubber
	name = ".34 rubber bullet casing"
	desc = "A .34 rubber bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34/rubber
	harmful = FALSE

/obj/projectile/bullet/c34/rubber
	name = ".34 rubber bullet"
	damage = 5
	stamina = 20
	wound_bonus = -75
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/c34/ap
	name = ".34 armor-piercing bullet casing"
	desc = "A .34 armor-piercing bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c34/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/projectile/bullet/c34/ap
	name = ".34 armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	wound_bonus = -75

/obj/item/ammo_casing/c34_incendiary
	name = ".34 incendiary bullet casing"
	desc = "A .34 incendiary bullet casing."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/incendiary/c34_incendiary
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/projectile/bullet/incendiary/c34_incendiary
	name = ".34 incendiary bullet"
	damage = 8
	fire_stacks = 1
	wound_bonus = -90

/*
*	4.2x30mm
*/

/obj/item/ammo_casing/c42x30mm
	name = "4.2x30mm bullet casing"
	desc = "A 4.2x30mm bullet casing."
	caliber = CALIBER_42X30MM
	projectile_type = /obj/projectile/bullet/c42x30mm

/obj/item/ammo_casing/c42x30mm/ap
	name = "4.2x30mm armor-piercing bullet casing"
	desc = "A 4.2x30mm armor-piercing bullet casing."
	projectile_type = /obj/projectile/bullet/c42x30mm/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c42x30mm/inc
	name = "4.2x30mm incendiary bullet casing"
	desc = "A 4.2x30mm incendiary bullet casing."
	projectile_type = /obj/projectile/bullet/incendiary/c42x30mm
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/projectile/bullet/c42x30mm
	name = "4.2x30mm bullet"
	damage = 20
	wound_bonus = -5
	bare_wound_bonus = 5
	embed_falloff_tile = -4

/obj/projectile/bullet/c42x30mm/ap
	name = "4.2x30mm armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	embedding = null

/obj/projectile/bullet/incendiary/c42x30mm
	name = "4.2x30mm incendiary bullet"
	damage = 10
	fire_stacks = 1

/obj/projectile/bullet/c42x30mm_rubber
	name = "4.2x30mm rubber bullet"
	damage = 3
	stamina = 17
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	wound_bonus = -50

/obj/item/ammo_casing/c42x30mm/rubber
	name = "4.2x30mm rubber bullet casing"
	desc = "A 4.2x30mm rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c42x30mm_rubber
	harmful = FALSE

/*
*	12mm Magnum
*/

/obj/item/ammo_casing/c12mm
	name = "12mm Magnum bullet casing"
	desc = "A 12mm Magnum bullet casing."
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/c12mm

/obj/item/ammo_casing/c12mm/ap
	name = "12mm Magnum armor-piercing bullet casing"
	desc = "A 12mm Magnum bullet casing with a titanium core."
	custom_materials = AMMO_MATS_AP
	projectile_type = /obj/projectile/bullet/c12mm/ap
	advanced_print_req = TRUE

/obj/item/ammo_casing/c12mm/hp
	name = "12mm Magnum hollow-point bullet casing"
	desc = "A 12mm Magnum bullet casing with a hollow tip that fragments on contact."
	projectile_type = /obj/projectile/bullet/c12mm/hp
	advanced_print_req = TRUE

/obj/item/ammo_casing/c12mm/fire
	name = "12mm Magnum incendiary bullet casing"
	desc = "A 12mm Magnum bullet casing with a magnesium coated tip meant for setting things on fire."
	custom_materials = AMMO_MATS_TEMP
	projectile_type = /obj/projectile/bullet/incendiary/c12mm
	advanced_print_req = TRUE

/obj/item/ammo_casing/c12mm/rubber
	name = "12mm Magnum rubber bullet casing"
	desc = "A low powder load 12mm Magnum bullet casing with a flat rubber tip. Headshots heavily discouraged."
	projectile_type = /obj/projectile/bullet/c12mm/rubber
	harmful = FALSE

/obj/projectile/bullet/c12mm
	name = "12mm bullet"
	damage = 40

/obj/projectile/bullet/c12mm/ap
	name = "12mm armor-piercing bullet"
	damage = 37
	armour_penetration = 40

/obj/projectile/bullet/c12mm/hp
	name = "12mm hollow-point bullet"
	damage = 60
	weak_against_armour = TRUE

/obj/projectile/bullet/incendiary/c12mm
	name = "12mm incendiary bullet"
	damage = 20
	fire_stacks = 2

/obj/projectile/bullet/c12mm/rubber
	name = "12mm Magnum rubber ball"
	damage = 10
	stamina = 40
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/*
*	6.8x43mm
*/

/obj/item/ammo_casing/a68
	name = "6.8mm bullet casing"
	desc = "A 6.8mm bullet casing."
	icon_state = "762-casing"
	caliber = CALIBER_A68
	projectile_type = /obj/projectile/bullet/a68

/obj/projectile/bullet/a68
	name = "6.8 bullet"
	damage = 55
	armour_penetration = 10
	wound_bonus = -45
	wound_falloff_tile = 0
