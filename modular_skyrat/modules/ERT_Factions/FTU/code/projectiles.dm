/obj/projectile/bullet/pulse/mm65
	name = "6.5mm XJ pulse flechette"
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/projectiles.dmi'
	icon_state = "pulsebullet"
	damage = 18 //Applied Twice, once BRUTE, once BURN
	speed = 0.7
	wound_bonus = 25
	embedding = list(embed_chance=30, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	armour_penetration = 40
	damage_type = BRUTE //Additionally Deals BURN in on_hit

/obj/projectile/bullet/pulse/mm65/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	//We don't want the burn damage to go through if the bullet itself is stopped
	if (blocked == 100)
		return .

	//Strictly only to things that are living
	if(isliving(target))
		var/mob/living/victim = target
		victim.apply_damage(damage, BURN, def_zone, blocked, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness)
		victim.apply_damage((damage*PROJECTILE_TISSUE_DAMAGE_STAMINA_MULTIPLIER), STAMINA, def_zone, blocked)


/obj/item/ammo_casing/pulse/mm65
	name = "6.5mm biodegradable flechette"
	desc = "A biodegradable 6.5mm pulse flechette, it seems to be encased in some sort of inert battery."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = "6.5mm"
	projectile_type = /obj/projectile/bullet/pulse/mm65


/obj/projectile/bullet/pulse/mm72
	name = "7.2mm XJ accelerated pulse flechette"
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/projectiles.dmi'
	icon_state = "pulsebullet_mg"
	damage = 11 //Applied Twice, once BRUTE, once BURN
	speed = 0.8
	wound_bonus = 60
	embedding = list(embed_chance=80, fall_chance=1, jostle_chance=20, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=0.8, rip_time=20)
	armour_penetration = 60
	damage_type = BRUTE //Additionally Deals BURN in on_hit

/obj/projectile/bullet/pulse/mm72/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	//We don't want the burn damage to go through if the bullet itself is stopped
	if (blocked == 100)
		return .

	//Strictly only to things that are living
	if(isliving(target))
		var/mob/living/victim = target
		victim.apply_damage(damage, BURN, def_zone, blocked, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness)
		victim.apply_damage((damage*PROJECTILE_TISSUE_DAMAGE_STAMINA_MULTIPLIER), STAMINA, def_zone, blocked)


/obj/item/ammo_casing/pulse/mm72
	name = "7.2mm biodegradable flechette"
	desc = "A biodegradable 7.2mm pulse flechette, it seems to be encased in some sort of inert battery with a heavy base."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = "7.2mm"
	projectile_type = /obj/projectile/bullet/pulse/mm72


/obj/projectile/bullet/pulse/mm12/saphe
	name = "12.7x35mm Saboted AP-HE bullet"
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/projectiles.dmi'
	icon_state = "pulsebullet"
	damage = 65
	speed = 1.25  //Heavy ass round
	wound_bonus = 90
	embedding = list(embed_chance=10, fall_chance=1, jostle_chance=6, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=5, rip_time=80)
	armour_penetration = 40
	damage_type = BRUTE

/obj/item/ammo_casing/pulse/mm12
	name = "12.7x35mm biodegradable sabot"
	desc = "A biodegradable .50 pulse sabot, it seems to be encased in some sort of inert battery."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = "12mm SAP-HE"
	projectile_type = /obj/projectile/bullet/pulse/mm12/saphe
