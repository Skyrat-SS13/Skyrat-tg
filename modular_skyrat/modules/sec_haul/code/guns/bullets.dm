/////////////////////////////////////////10MM
/obj/item/ammo_casing/b10mm
	name = "10mm bullet casing"
	desc = "A 10mm bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = "10mm"
	projectile_type = /obj/projectile/bullet/b10mm

/obj/projectile/bullet/b10mm
	name = "10mm bullet"
	damage = 30

/obj/item/ammo_casing/b10mm/hp
	name = "10mm HP bullet casing"
	desc = "A 10mm hollowpoint bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = "10mm"
	projectile_type = /obj/projectile/bullet/b10mm/hp

/obj/projectile/bullet/b10mm/hp
	name = "10mm hollowpoint bullet"
	damage = 27
	wound_bonus = 30
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	armour_penetration = -30

/obj/item/ammo_casing/b10mm/rubber
	name = "10mm rubber bullet casing"
	desc = "A 10mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = "10mm"
	projectile_type = /obj/projectile/bullet/b10mm/rubber

/obj/projectile/bullet/b10mm/rubber
	name = "10mm rubber bullet"
	damage = 10
	stamina = 35
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = SHARP_NONE
	embedding = null

/obj/item/ammo_casing/b10mm/ihdf
	name = "10mm IHDF bullet casing"
	desc = "A 10mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = "10mm"
	projectile_type = /obj/projectile/bullet/b10mm/ihdf

/obj/projectile/bullet/b10mm/ihdf
	name = "10mm ihdf bullet"
	damage = 40
	damage_type = STAMINA

///////////////////////////////////9MM
/obj/item/ammo_casing/b9mm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/b9mm

/obj/projectile/bullet/b9mm
	name = "9mm bullet"
	damage = 20

/obj/item/ammo_casing/b9mm/hp
	name = "9mm HP bullet casing"
	desc = "A 9mm hollowpoint bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/b9mm/hp

/obj/projectile/bullet/b9mm/hp
	name = "9mm hollowpoint bullet"
	damage = 20
	wound_bonus = 30
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	armour_penetration = -30

/obj/item/ammo_casing/b9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/b9mm/rubber

/obj/projectile/bullet/b9mm/rubber
	name = "9mm rubber bullet"
	damage = 5
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = SHARP_NONE
	embedding = null

/obj/item/ammo_casing/b9mm/ihdf
	name = "9mm IHDF bullet casing"
	desc = "A 9mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/b9mm/ihdf

/obj/projectile/bullet/b9mm/ihdf
	name = "9mm ihdf bullet"
	damage = 35
	damage_type = STAMINA





/obj/item/ammo_casing/b577
	name = ".577 Snider bullet casing"
	desc = "A .577 Sniderbullet casing."
	caliber = ".577 Snider"
	projectile_type = /obj/projectile/bullet/b577

/obj/projectile/bullet/b577
	name = "577 bullet"
	damage = 40
	wound_bonus = 10
	bare_wound_bonus = 15
