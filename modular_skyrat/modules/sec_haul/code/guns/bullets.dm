/*
*	9x25mm Mk.12
*/

/obj/item/ammo_casing/c9mm
	name = "9x25mm Mk.12 bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing."

/obj/item/ammo_casing/c9mm/ap
	name = "9x25mm Mk.12 armor-piercing bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires an armor-piercing projectile."
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/hp
	name = "9x25mm Mk.12 hollow-point bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a hollow-point projectile. Very lethal to unarmored opponents."
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/fire
	name = "9x25mm Mk.12 incendiary bullet casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This incendiary round leaves a trail of fire and ignites its target."
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c9mm/ihdf
	name = "9x25mm Mk.12 IHDF casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a bullet of 'Intelligent High-Impact Dispersal Foam', which is best compared to a riot-grade foam dart."
	projectile_type = /obj/projectile/bullet/c9mm/ihdf
	harmful = FALSE

/obj/projectile/bullet/c9mm/ihdf
	name = "9x25mm IHDF bullet"
	damage = 30
	damage_type = STAMINA
	embed_type = /datum/embed_data/c9mm_ihdf

/datum/embed_data/c9mm_ihdf
	embed_chance = 0
	fall_chance = 3
	jostle_chance = 4
	pain_mult = 5
	pain_stam_pct = 0.4
	ignore_throwspeed_threshold = TRUE
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/item/ammo_casing/c9mm/rubber
	name = "9x25mm Mk.12 rubber casing"
	desc = "A modern 9x25mm Mk.12 bullet casing. This less than lethal round sure hurts to get shot by, but causes little physical harm."
	projectile_type = /obj/projectile/bullet/c9mm/rubber
	harmful = FALSE

/obj/projectile/bullet/c9mm/rubber
	name = "9x25mm rubber bullet"
	icon_state = "pellet"
	damage = 18
	stamina = 32
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 180
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/obj/projectile/bullet/c9mm
	damage = 25
/*
*	10mm Auto
*/

/obj/item/ammo_casing/c10mm/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c10mm/hp
	advanced_print_req = TRUE

/obj/item/ammo_casing/c10mm/fire
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c10mm/reaper
	can_be_printed = FALSE
	// it's a hitscan 50 damage 40 AP bullet designed to be fired out of a gun with a 2rnd burst and 1.25x damage multiplier
	// Let's Not

/obj/item/ammo_casing/c10mm/rubber
	name = "10mm rubber bullet casing"
	desc = "A 10mm rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c10mm/rubber
	harmful = FALSE

/obj/projectile/bullet/c10mm
	damage = 30

/obj/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = 10
	stamina = 40
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/obj/item/ammo_casing/c10mm/ihdf
	name = "10mm IHDF bullet casing"
	desc = "A 10mm intelligent high-impact dispersal foam bullet casing."
	projectile_type = /obj/projectile/bullet/c10mm/ihdf
	harmful = FALSE

/obj/projectile/bullet/c10mm/ihdf
	name = "10mm IHDF bullet"
	damage = 40
	damage_type = STAMINA
	embed_type = /datum/embed_data/c10mm_ihdf

/datum/embed_data/c10mm_ihdf
	embed_chance = 0
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

// .38 Detective Bullets Override

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 30

/obj/projectile/bullet/c38/match/bouncy
	name = ".38 Rubber bullet"
	damage = 15
	stamina = 35
	weak_against_armour = TRUE
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_data = null

// premium .38 ammo from cargo, weak against armor, lower base damage, but excellent at embedding and causing slice wounds at close range
/obj/projectile/bullet/c38/dumdum
	name = ".38 DumDum bullet"
	damage = 20
	weak_against_armour = TRUE
	ricochets_max = 0
	sharpness = SHARP_EDGED
	wound_bonus = 35
	bare_wound_bonus = 30
	embed_type = /datum/embed_data/dumdum
	wound_falloff_tile = -8
	embed_falloff_tile = -20

/datum/embed_data/dumdum
	embed_chance = 90
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS
