//
// .35 Sol Short
// Pistol caliber caseless round used almost exclusively by SolFed weapons
//

/obj/item/ammo_casing/c35sol
	name = ".35 Sol Short lethal bullet casing"
	desc = "A SolFed standard lethal pistol round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "pistol_round"

	caliber = CALIBER_SOL35SHORT
	projectile_type = /obj/projectile/bullet/c35sol

/obj/item/ammo_casing/c35sol/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/bullet/c35sol
	name = ".35 Sol Short bullet"
	damage = 25
	wound_bonus = 10 // Normal bullets are 20

/obj/item/ammo_box/c35sol
	name = "ammo box (.35 Sol Short lethal)"
	desc = "A box of .35 Sol Short pistol rounds, holds thirty-six bullets."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "pistol_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c35sol
	max_ammo = 36

// .35 Sol's equivalent to a rubber bullet

/obj/item/ammo_casing/c35sol/incapacitator
	name = ".35 Sol Short incapacitator bullet casing"
	desc = "A SolFed standard less-lethal pistol round. Exhausts targets on hit, has a tendency to bounce off walls at shallow angles."
	projectile_type = /obj/projectile/bullet/c35sol/incapacitator
	harmful = FALSE

/obj/projectile/bullet/c35sol/incapacitator
	name = ".35 Sol Short incapacitator bullet"
	damage = 5
	stamina = 30
	wound_bonus = -40

	weak_against_armour = TRUE

	// The stats of the ricochet are a nerfed version of detective revolver rubber ammo
	// This is due to the fact that there's a lot more rounds fired quickly from weapons that use this, over a revolver
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 5
	ricochets_max = 4
	ricochet_incidence_leeway = 50
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_box/c35sol/incapacitator
	name = "ammo box (.35 Sol Short incapacitator)"

	icon_state = "pistol_box_incap"

	ammo_type = /obj/item/ammo_casing/c35sol/incapacitator

// .35 Sol armor piercing, if there's less than 20 bullet armor on wherever these hit, it'll go completely through the target and out the other side

/obj/item/ammo_casing/c35sol/pierce
	name = ".35 Sol Short piercing bullet casing"
	desc = "A SolFed standard armor-piercing pistol round. Effective at penetrating armor and people, at expense of less injury than a standard bullet."
	projectile_type = /obj/projectile/bullet/c35sol/pierce
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4.5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.5)
	advanced_print_req = TRUE

/obj/projectile/bullet/c35sol/pierce
	name = ".35 Sol armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	wound_bonus = -30

	projectile_piercing = PASSMOB

	/// How many times has this bullet penetrated something?
	var/penetrations = 0

/obj/projectile/bullet/c35sol/pierce/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/poor_sap = target

		// If the target mob has enough armor to stop the bullet, or the bullet has already gone through two people, stop it on this hit
		if((poor_sap.run_armor_check(def_zone, BULLET, "", "", silent = TRUE) > 20) || (penetrations > 2))
			projectile_piercing = NONE

		else
			penetrations += 1

	return ..()

/obj/item/ammo_box/c35sol/pierce
	name = "ammo box (.35 Sol Short piercing)"

	icon_state = "pistol_box_ap"

	ammo_type = /obj/item/ammo_casing/c35sol/pierce

// .35 Sol ripper, similar to the detective revolver's dumdum rounds, causes slash wounds and is weak to armor

/obj/item/ammo_casing/c35sol/ripper
	name = ".35 Sol Short ripper bullet casing"
	desc = "A SolFed standard ripper pistol round. Causes slashing wounds on targets, but is weak to armor."
	caliber = "c34acp"
	projectile_type = /obj/projectile/bullet/c35sol/ripper
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	advanced_print_req = TRUE

/obj/projectile/bullet/c35sol/ripper
	name = ".35 Sol ripper bullet"
	damage = 15

	weak_against_armour = TRUE

	sharpness = SHARP_EDGED
	wound_bonus = 20
	bare_wound_bonus = 20
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)
	wound_falloff_tile = -3
	embed_falloff_tile = -15

/obj/item/ammo_box/c35sol/ripper
	name = "ammo box (.35 Sol Short ripper)"

	icon_state = "pistol_box_rip"

	ammo_type = /obj/item/ammo_casing/c35sol/ripper

//
// .40 Sol Long
// Rifle caliber caseless ammo that kills people good
//

/obj/item/ammo_casing/c40sol
	name = ".40 Sol Long lethal bullet casing"
	desc = "A SolFed standard lethal rifle round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "rifle_round"

	caliber = CALIBER_SOL40LONG
	projectile_type = /obj/projectile/bullet/c40sol

/obj/item/ammo_casing/c40sol/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/bullet/c40sol
	name = ".40 Sol Long bullet"
	damage = 40

/obj/item/ammo_box/c40sol
	name = "ammo box (.40 Sol Long lethal)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "rifle_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c40sol
	max_ammo = 30

// .40 Sol fragmentation rounds, embeds shrapnel in the target almost every time at close to medium range

/obj/item/ammo_casing/c40sol/fragmentation
	name = ".40 Sol Long fragmentation bullet casing"
	desc = "A SolFed standard fragmentation rifle round. Shatters upon impact, ejecting sharp shrapnel that can harm the target further."

	projectile_type = /obj/projectile/bullet/c40sol/fragmentation

	advanced_print_req = TRUE

/obj/projectile/bullet/c40sol/fragmentation
	name = ".40 Sol Long fragmentation bullet"
	damage = 25

	weak_against_armour = TRUE

	sharpness = SHARP_EDGED
	bare_wound_bonus = 30
	shrapnel_type = /obj/item/shrapnel/capmine
	embedding = list(embed_chance=110, fall_chance=3, jostle_chance=5, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)
	wound_falloff_tile = -2
	embed_falloff_tile = -5

/obj/item/ammo_box/c40sol/fragmentation
	name = "ammo box (.40 Sol Long fragmentation)"

	icon_state = "rifle_box_frag"

	ammo_type = /obj/item/ammo_casing/c40sol/fragmentation

// .40 Sol incendiary

/obj/item/ammo_casing/c40sol/incendiary
	name = ".40 Sol Long incendiary bullet casing"
	desc = "A SolFed standard incendiary rifle round."

	projectile_type = /obj/projectile/bullet/c40sol/incendiary

	advanced_print_req = TRUE

/obj/projectile/bullet/c40sol/incendiary
	name = ".40 Sol Long incendiary bullet"
	icon_state = "redtrac"

	damage = 25

/obj/projectile/bullet/c40sol/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(4)
		M.ignite_mob()

/obj/item/ammo_box/c40sol/incendiary
	name = "ammo box (.40 Sol Long incendiary)"

	icon_state = "rifle_box_incen"

	ammo_type = /obj/item/ammo_casing/c40sol/incendiary
