//
// .40 Sol Long
// Rifle caliber caseless ammo that kills people good
//

/obj/item/ammo_casing/c40sol
	name = ".40 Sol Long lethal bullet casing"
	desc = "A SolFed standard caseless lethal rifle round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40sol"

	caliber = CALIBER_SOL40LONG
	projectile_type = /obj/projectile/bullet/c40sol

	is_cased_ammo = FALSE

/obj/item/ammo_casing/c40sol/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/bullet/c40sol
	name = ".40 Sol Long bullet"
	damage = 35

/obj/item/ammo_box/c40sol
	name = "ammo box (.40 Sol Long lethal)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "40box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	caliber = CALIBER_SOL40LONG
	ammo_type = /obj/item/ammo_casing/c40sol
	max_ammo = 30

// .40 Sol fragmentation rounds, embeds shrapnel in the target almost every time at close to medium range. Teeeechnically less lethals.

/obj/item/ammo_casing/c40sol/fragmentation
	name = ".40 Sol Long fragmentation bullet casing"
	desc = "A SolFed standard caseless fragmentation rifle round. Shatters upon impact, ejecting sharp shrapnel that can potentially incapacitate targets."

	icon_state = "40sol_disabler"

	projectile_type = /obj/projectile/bullet/c40sol/fragmentation

	advanced_print_req = TRUE

/obj/projectile/bullet/c40sol/fragmentation
	name = ".40 Sol Long fragmentation bullet"
	damage = 20
	stamina = 15

	weak_against_armour = TRUE

	sharpness = SHARP_EDGED
	bare_wound_bonus = 30
	shrapnel_type = /obj/item/shrapnel/stingball
	embedding = list(embed_chance=110, fall_chance=3, jostle_chance=5, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)
	wound_falloff_tile = -2
	embed_falloff_tile = -5

/obj/item/ammo_box/c40sol/fragmentation
	name = "ammo box (.40 Sol Long fragmentation)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets. The blue stripe indicates this should hold less lethal ammunition."

	icon_state = "40box_disabler"

	ammo_type = /obj/item/ammo_casing/c40sol/fragmentation

// .40 Sol armor piercing, if there's less than 20 bullet armor on wherever these hit, it'll go completely through the target and out the other side

/obj/item/ammo_casing/c40sol/pierce
	name = ".40 Sol Long piercing bullet casing"
	desc = "A SolFed standard caseless armor-piercing pistol round. Effective at penetrating armor and people, at expense of less injury than a standard bullet."

	icon_state = "40sol_pierce"

	projectile_type = /obj/projectile/bullet/c40sol/pierce
	advanced_print_req = TRUE

/obj/projectile/bullet/c40sol/pierce
	name = ".40 Sol armor-piercing bullet"
	damage = 25
	armour_penetration = 40
	wound_bonus = -30

	projectile_piercing = PASSMOB

/obj/projectile/bullet/c40sol/pierce/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/poor_sap = target

		// If the target mob has enough armor to stop the bullet, or the bullet has already gone through two people, stop it on this hit
		if((poor_sap.run_armor_check(def_zone, BULLET, "", "", silent = TRUE) > 20) || (pierces > 2))
			projectile_piercing = NONE

	return ..()

/obj/item/ammo_box/c40sol/pierce
	name = "ammo box (.40 Sol Short piercing)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets. The yellow stripe indicates this should hold armor piercing ammunition."

	icon_state = "40box_pierce"

	ammo_type = /obj/item/ammo_casing/c40sol/pierce

// .40 Sol incendiary

/obj/item/ammo_casing/c40sol/incendiary
	name = ".40 Sol Long incendiary bullet casing"
	desc = "A SolFed standard caseless incendiary rifle round. Leaves no flaming trail, only igniting targets on impact."

	icon_state = "40sol_flame"

	projectile_type = /obj/projectile/bullet/c40sol/incendiary

	advanced_print_req = TRUE

/obj/projectile/bullet/c40sol/incendiary
	name = ".40 Sol Long incendiary bullet"
	icon_state = "redtrac"

	damage = 25

/obj/projectile/bullet/c40sol/incendiary/on_hit(atom/target, blocked = FALSE)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/gaslighter = target
		gaslighter.adjust_fire_stacks(4)
		gaslighter.ignite_mob()

/obj/item/ammo_box/c40sol/incendiary
	name = "ammo box (.40 Sol Long incendiary)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets. The orange stripe indicates this should hold incendiary ammunition."

	icon_state = "40box_flame"

	ammo_type = /obj/item/ammo_casing/c40sol/incendiary
