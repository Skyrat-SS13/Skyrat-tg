//9mm Magazines
/obj/item/ammo_box/magazine/m9mm
	custom_premium_price = 50

/obj/item/ammo_box/magazine/m9mm/rubber
	name = "pistol magazine (9x25mm Rubber)"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/m9mm/ihdf
	name = "pistol magazine (9x25mm Intelligent Dispersal Foam)"
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf

//I dont know where to put this - Pending better modularisation in next PR

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
	wound_bonus = 30
	bare_wound_bonus = 30
	embed_type = /datum/embed_data/dumdum
	wound_falloff_tile = -5
	embed_falloff_tile = -20

/datum/embed_data/dumdum
	embed_chance = 85
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

//10mm Cylinder
/obj/item/ammo_box/magazine/internal/cylinder/nt_sec
	name = "\improper 10mm revolver cylinder"
	desc = "how did you get this"
	max_ammo = 6
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	caliber = CALIBER_10MM

//10mm Stuff
/obj/item/ammo_box/c10mm/speedloader
	name = "speed loader (10mm Auto)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm
	ammo_band_color = "#795a58"
	max_ammo = 6
	item_flags = NO_MAT_REDEMPTION
	icon_state = "38"
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_band_icon = "+38_ammo_band"

	custom_premium_price = 50

/obj/item/ammo_box/c10mm/speedloader/rubber

	name = "speed loader (10mm Auto Rubber)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	ammo_band_color = "#792a59"

