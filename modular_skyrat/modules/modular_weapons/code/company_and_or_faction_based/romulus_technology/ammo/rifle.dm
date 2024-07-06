/obj/item/ammo_casing/caflechette
	name = "flechette steel penetrator"
	desc = "A Romfed standard rifle flechette."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40sol"

	caliber = CALIBER_FLECHETTE
	projectile_type = /obj/projectile/bullet/caflechette
	custom_materials = AMMO_MATS_SHOTGUN_FLECH
	advanced_print_req = TRUE

/obj/item/ammo_casing/caflechette/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)


/obj/projectile/bullet/caflechette
	name = "flechette penetrator"
	damage = 15
	armour_penetration = 100
	wound_bonus = -10
	bare_wound_bonus = -20
	embedding = list(embed_chance=20, pain_chance=70, fall_chance=80, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=2)


/obj/item/ammo_casing/caflechette/ripper
	name = "flechette dart"
	desc = "A Romfed standard rifle flechette."
	projectile_type = /obj/projectile/bullet/caflechette/ripper
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/projectile/bullet/caflechette/ripper
	name = "flechette dart"
	damage = 10
	wound_bonus = 15
	bare_wound_bonus = 5
	embedding = list(embed_chance=150, pain_chance=70, fall_chance=80, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=2)

/obj/item/ammo_casing/caflechette/ballpoint
	name = "steel ball"
	desc = "A bullet casing with a large metallic ball as a projectile."
	projectile_type = /obj/projectile/bullet/caflechette/ballpoint
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/projectile/bullet/caflechette/ballpoint
	name = "high velocity steel ball"
	damage = 10
	wound_bonus = -50
	bare_wound_bonus = -80
	embedding = NO_EMBED
	stamina = 25
	sharpness = NONE
	shrapnel_type = NONE

/obj/item/ammo_casing/caflechette/magnesium
	name = "magnesium dart"
	projectile_type = /obj/projectile/bullet/caflechette/magnesium
	custom_materials = AMMO_MATS_SHOTGUN_PLASMA

/obj/projectile/bullet/caflechette/magnesium
	name = "high velocity magnesium rod"
	damage = 5
	wound_bonus = 15
	bare_wound_bonus = 5
	embedding = list(embed_chance=40, pain_chance=10, fall_chance=80, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=8)

/obj/projectile/bullet/caflechette/magnesium/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(12)
		M.ignite_mob()
