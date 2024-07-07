#define AMMO_MATS_SHOTGUN list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4) // not quite as thick as a half-sheet

#define AMMO_MATS_SHOTGUN_FLECH list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2)

#define AMMO_MATS_SHOTGUN_HIVE list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1,\
									/datum/material/silver = SMALL_MATERIAL_AMOUNT * 1)

#define AMMO_MATS_SHOTGUN_TIDE list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 1,\
									/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 1)

#define AMMO_MATS_SHOTGUN_PLASMA list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,\
									/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 2)


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
	wound_bonus = 10
	bare_wound_bonus = 10
	embedding = list(embed_chance=55, pain_chance=70, fall_chance=40, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=2)
	dismemberment = 0

/obj/item/ammo_casing/caflechette/ripper
	name = "flechette dart"
	desc = "A Romfed standard rifle flechette."
	projectile_type = /obj/projectile/bullet/caflechette/ripper
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/projectile/bullet/caflechette/ripper
	name = "flechette dart"
	damage = 10
	armour_penetration = 100
	wound_bonus = 25
	bare_wound_bonus = 35
	embedding = list(embed_chance=150, pain_chance=70, fall_chance=20, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=2)

/obj/item/ammo_casing/caflechette/ballpoint
	name = "steel ball"
	desc = "A bullet casing with a large metallic ball as a projectile."
	projectile_type = /obj/projectile/bullet/caflechette/ballpoint
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/projectile/bullet/caflechette/ballpoint
	name = "high velocity steel ball"
	damage = 10
	armour_penetration = 25
	wound_bonus = -50
	bare_wound_bonus = -80
	embedding = list(embed_chance=10, pain_chance=50, fall_chance=90, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=3, pain_mult=2, rip_time=8)
	stamina = 30
	sharpness = NONE
	shrapnel_type = NONE
	ricochet_chance = 50
	ricochets_max = 3
	ricochet_auto_aim_angle = 90
	ricochet_auto_aim_range = 5

/obj/item/ammo_casing/caflechette/magnesium
	name = "magnesium dart"
	projectile_type = /obj/projectile/bullet/caflechette/magnesium
	custom_materials = AMMO_MATS_SHOTGUN_PLASMA

/obj/projectile/bullet/caflechette/magnesium
	name = "high velocity magnesium rod"
	damage = 5
	wound_bonus = 15
	bare_wound_bonus = 5
	embedding = list(embed_chance=50, pain_chance=10, fall_chance=10, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=8)

/obj/projectile/bullet/caflechette/magnesium/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(12)
		M.ignite_mob()

#undef AMMO_MATS_SHOTGUN

#undef AMMO_MATS_SHOTGUN_FLECH

#undef AMMO_MATS_SHOTGUN_HIVE

#undef AMMO_MATS_SHOTGUN_TIDE

#undef AMMO_MATS_SHOTGUN_PLASMA
