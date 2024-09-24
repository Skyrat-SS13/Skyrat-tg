/obj/item/ammo_casing
	/// Can this bullet casing be printed at an ammunition workbench?
	var/can_be_printed = TRUE
	/// If it can be printed, does this casing require an advanced ammunition datadisk? Mainly for specialized ammo.
	/// Rubbers aren't advanced. Standard ammo (or FMJ if you're particularly pedantic) isn't advanced.
	/// Think more specialized or weird, niche ammo, like armor-piercing, incendiary, hollowpoint, or God forbid, phasic.
	var/advanced_print_req = FALSE

// whatever goblin decided to spread out bullets over like 3 files and god knows however many overrides i wish you a very stubbed toe

/*
*	.460 Ceres (renamed tgcode .45)
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
	embed_data = null
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
*	8mm Usurpator (renamed tg c46x30mm, used in the WT550)
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
	embed_data = null
	wound_bonus = -50

/obj/item/ammo_casing/c46x30mm/rubber
	name = "8mm Usurpator rubber bullet casing"
	desc = "An 8mm Usurpator rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/c46x30mm_rubber
	harmful = FALSE

/*
*	.277 Aestus (renamed tgcode .223, used in the M-90gl)
*/

/obj/item/ammo_casing/a223/rubber
	name = ".277 rubber bullet casing"
	desc = "A .277 rubber bullet casing.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"
	projectile_type = /obj/projectile/bullet/a223/rubber
	harmful = FALSE

/obj/projectile/bullet/a223/rubber
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
	embed_data = null
	wound_bonus = -50

/obj/item/ammo_casing/a223/ap
	name = ".277 Aestus armor-piercing bullet casing"
	desc = "A .277 armor-piercing bullet casing.\
	<br><br>\
	<i>ARMOR PIERCING: Increased armor piercing capabilities. What did you expect?"
	projectile_type = /obj/projectile/bullet/a223/ap
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_AP

/obj/projectile/bullet/a223/ap
	name = ".277 armor-piercing bullet"
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
	embed_data = null

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
