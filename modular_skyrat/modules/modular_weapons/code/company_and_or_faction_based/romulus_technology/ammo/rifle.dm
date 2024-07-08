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
	damage = 18
	armour_penetration = 100
	wound_bonus = 10
	bare_wound_bonus = 10
	embed_type = /datum/embed_data/caflechette
	dismemberment = 0

/datum/embed_data/caflechette
	embed_chance = 55
	pain_chance = 70
	fall_chance = 30
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 2 SECONDS

/obj/item/ammo_casing/caflechette/ripper
	name = "flechette dart"
	desc = "A Romfed standard rifle flechette."
	projectile_type = /obj/projectile/bullet/caflechette/ripper
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/projectile/bullet/caflechette/ripper
	name = "flechette dart"
	damage = 10
	wound_bonus = 25
	bare_wound_bonus = 35
	embedding = list(embed_chance=200, pain_chance=70, fall_chance=1, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time= 5 SECONDS)
	embed_type /datum/embed_data/ripper

/datum/embed_data/ripper
	embed_chance = 200
	pain_chance = 70
	fall_chance = 1
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 5 SECONDS

/obj/item/ammo_casing/caflechette/ballpoint
	name = "steel ball"
	desc = "A bullet casing with a large metallic ball as a projectile."
	projectile_type = /obj/projectile/bullet/caflechette/ballpoint
	custom_materials = AMMO_MATS_SHOTGUN_TIDE

/obj/projectile/bullet/caflechette/ballpoint
	name = "high velocity steel ball"
	damage = 10
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	wound_bonus = 0
	bare_wound_bonus = 20

	shrapnel_type = /obj/item/shrapnel/stingball
	embed_type = /datum/embed_data/ballpoint
	embedding = list(
		embed_chance = 30,
		fall_chance = 5,
		jostle_chance = 5,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.4,
		pain_mult = 2,
		jostle_pain_mult = 3,
		rip_time = 2 SECONDS,
	)
	stamina = 30
	ricochet_chance = 50
	ricochets_max = 3
	ricochet_auto_aim_angle = 90
	ricochet_auto_aim_range = 5

/datum/embed_data/ballpoint
	embed_chance = 30
	fall_chance = 5
	jostle_chance = 5
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 2
	jostle_pain_mult = 3
	rip_time = 2 SECONDS

/obj/item/ammo_casing/caflechette/magnesium
	name = "magnesium dart"
	projectile_type = /obj/projectile/bullet/caflechette/magnesium
	custom_materials = AMMO_MATS_SHOTGUN_PLASMA

/obj/projectile/bullet/caflechette/magnesium
	name = "high velocity magnesium rod"
	damage = 5
	wound_bonus = 15
	bare_wound_bonus = 5
	embed_type = /datum/embed_data/magnesium
	embedding = list(embed_chance=50, pain_chance=10, fall_chance=10, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=10)

/datum/embed_data/magnesium
	embed_chance = 50
	pain_chance = 10
	fall_chance = 10
	jostle_chance = 80
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.9
	pain_mult = 2
	rip_time = 10 SECONDS

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
