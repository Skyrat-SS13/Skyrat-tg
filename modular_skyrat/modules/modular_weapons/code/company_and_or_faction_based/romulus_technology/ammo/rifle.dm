/obj/item/ammo_casing/caflechette
	name = "flechette dart"
	desc = "A SolFed standard caseless lethal rifle round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40sol"

	caliber = CALIBER_FLECHETTE
	projectile_type = /obj/projectile/bullet/caflechette


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
	desc = "A SolFed standard caseless lethal rifle round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40sol"

	caliber = CALIBER_FLECHETTE
	projectile_type = /obj/projectile/bullet/caflechette/ripper

/obj/projectile/bullet/caflechette/ripper
	name = "flechette penetrator"
	damage = 10
	wound_bonus = 15
	bare_wound_bonus = 5
	embedding = list(embed_chance=150, pain_chance=70, fall_chance=80, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=2)

