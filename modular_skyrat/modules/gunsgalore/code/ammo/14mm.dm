/obj/item/ammo_casing/c14mm
	name = "14mm bullet casing"
	desc = "A 14mm bullet casing. Badass."
	caliber = "14mm"
	projectile_type = /obj/projectile/bullet/c14mm

/obj/projectile/bullet/c14mm
	name = "14mm bullet"
	damage = 60
	embedding = list(embed_chance = 90, fall_chance = 3, jostle_chance = 4, ignore_throwspeed_threshold = TRUE, pain_stam_pct = 0.4, pain_mult = 5, jostle_pain_mult = 9, rip_time = 10)
	dismemberment = 50
	pierces = 1
	projectile_piercing = PASSCLOSEDTURF|PASSGRILLE|PASSGLASS
