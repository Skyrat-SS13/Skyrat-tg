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
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4.5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.5)

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
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4.5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.5)
	advanced_print_req = TRUE

/obj/projectile/bullet/a762/ap
	name = ".244 armor-piercing bullet"
	damage = 50
	armour_penetration = 60
