/obj/projectile/bullet/advanced
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
	icon_state = "bullet"

/*
*	6.3mm
*	FLECHETTE | FRAGMENTING | DISSUASIVE
*/

/obj/item/ammo_casing/b6mm
	name = "6.3mm flechette casing"
	desc = "A spent flechette."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_6MM
	projectile_type = /obj/projectile/bullet/advanced/b6mm

/obj/projectile/bullet/advanced/b6mm
	name = "6.3mm flechette"
	damage = 10
	speed = 1
	embedding = list(embed_chance=10, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	armour_penetration = 50

/obj/item/ammo_casing/b6mm/rubber
	name = "6.3mm dissuasive pellet casing"
	desc = "A 6.3mm dissuasive pellet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_6MM
	projectile_type = /obj/projectile/bullet/advanced/b6mm/rubber
	harmful = FALSE

/obj/projectile/bullet/advanced/b6mm/rubber
	name = "6mm dissuasive pellet"
	icon_state = "bullet_r"
	damage = 2
	stamina = 15
	ricochets_max = 2
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/b6mm/ihdf
	name = "6.3mm frag casing"
	desc = "A 6.3mm fragmentation round casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = CALIBER_6MM
	projectile_type = /obj/projectile/bullet/advanced/b6mm/ihdf
	harmful = TRUE

/obj/projectile/bullet/advanced/b6mm/ihdf
	name = "6.3mm fragmentation pellet"
	icon_state = "bullet_i"
	damage = 15
	bare_wound_bonus = 50
	embedding = list(embed_chance=60, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/*
*	9x19mm
*	FMJ | JHP | IHDF | RUBBER
*/

/obj/item/ammo_casing/b9mm
	name = "9x19mm peacekeeper FMJ casing"
	desc = "A 9x19mm bullet casing with a low powder load to prevent breaches."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_9MMPEACE
	projectile_type = /obj/projectile/bullet/advanced/b9mm

/obj/projectile/bullet/advanced/b9mm
	name = "9x19mm FMJ bullet"
	damage = 15
	speed = 0.8

/obj/item/ammo_casing/b9mm/hp
	name = "9x19mm JHP bullet casing"
	desc = "A 9x19mm jacketed hollowpoint casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	projectile_type = /obj/projectile/bullet/advanced/b9mm/hp

/obj/projectile/bullet/advanced/b9mm/hp
	name = "9x19mm JHP bullet"
	icon_state = "bullet_h"
	damage = 20
	wound_bonus = 35
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/obj/item/ammo_casing/b9mm/ihdf
	name = "9mm IHDF bullet casing"
	desc = "A 9mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	projectile_type = /obj/projectile/bullet/advanced/b9mm/ihdf
	harmful = FALSE

/obj/projectile/bullet/advanced/b9mm/ihdf
	name = "9mm ihdf bullet"
	icon_state = "bullet_i"
	damage = 25
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/obj/item/ammo_casing/b9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	projectile_type = /obj/projectile/bullet/advanced/b9mm/rubber
	harmful = FALSE

/obj/projectile/bullet/advanced/b9mm/rubber
	name = "9mm rubber bullet"
	icon_state = "bullet_r"
	damage = 3
	stamina = 20
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/*
*	10x25mm
*	Auto | JHP | IHDF | RUBBER
*/

/obj/item/ammo_casing/b10mm
	name = "10mm auto casing"
	desc = "A 10mm Auto casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_10MMAUTO
	projectile_type = /obj/projectile/bullet/advanced/b10mm

/obj/projectile/bullet/advanced/b10mm
	name = "10mm auto bullet"
	damage = 27
	speed = 1
	wound_bonus = 5

/obj/item/ammo_casing/b10mm/hp
	name = "10mm auto JHP casing"
	desc = "A 10mm auto JHP bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_10MMAUTO
	projectile_type = /obj/projectile/bullet/advanced/b10mm/hp

/obj/projectile/bullet/advanced/b10mm/hp
	name = "10mm auto JHP bullet"
	icon_state = "bullet_h"
	damage = 30
	wound_bonus = 35
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/obj/item/ammo_casing/b10mm/rubber
	name = "10mm auto rubber bullet casing"
	desc = "A 10mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_10MMAUTO
	projectile_type = /obj/projectile/bullet/advanced/b10mm/rubber
	harmful = FALSE

/obj/projectile/bullet/advanced/b10mm/rubber
	name = "10mm Auto rubber bullet"
	icon_state = "bullet_r"
	damage = 5
	stamina = 25
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/b10mm/ihdf
	name = "10mm auto IHDF bullet casing"
	desc = "A 10mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = CALIBER_10MMAUTO
	projectile_type = /obj/projectile/bullet/advanced/b10mm/ihdf
	harmful = FALSE

/obj/projectile/bullet/advanced/b10mm/ihdf
	name = "10mm auto ihdf bullet"
	icon_state = "bullet_i"
	damage = 30
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/*
*	12.7x30mm
*	FMJ | JHP | BEANBAG
*/

/obj/item/ammo_casing/b12mm
	name = "12.7x30mm FMJ casing"
	desc = "A 12.7x30mm FMJ casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/advanced/b12mm

/obj/projectile/bullet/advanced/b12mm
	name = "12.7x30mm bullet"
	damage = 35
	wound_bonus = 30
	speed = 1

/obj/item/ammo_casing/b12mm/rubber
	name = "12.7x30mm beanbag slug casing"
	desc = "A 12.7x30mm beanbag slug casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/advanced/b12mm/rubber
	harmful = FALSE

/obj/projectile/bullet/advanced/b12mm/rubber
	name = "12.7x30mm beanbag slug"
	icon_state = "bullet_r"
	damage = 10
	stamina = 35
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null


/obj/item/ammo_casing/b12mm/hp
	name = "12.7x30mm JHP casing"
	desc = "A 12.7x30mm JHP bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/advanced/b12mm/hp

/obj/projectile/bullet/advanced/b12mm/hp
	name = "12mm hollowpoint bullet"
	icon_state = "bullet_h"
	damage = 35
	wound_bonus = 40
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/*
*	.577S
*	FMJ
*/

/obj/item/ammo_casing/b577
	name = ".577 Snider bullet casing"
	desc = "A .577 Snider bullet casing."
	caliber = CALIBER_B577
	projectile_type = /obj/projectile/bullet/advanced/b577

/obj/projectile/bullet/advanced/b577
	name = ".577S FMJ bullet"
	damage = 40
	wound_bonus = 15
	bare_wound_bonus = 30
	dismemberment = 15

//SMARTGUN
/obj/item/ammo_casing/smartgun
	name = "smartgun rail frame"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "smartgun"
	desc = "A smartgun rail."
	caliber = "smartgun"
	projectile_type = /obj/projectile/bullet/advanced/smartgun
	can_be_printed = FALSE

/obj/projectile/bullet/advanced/smartgun
	name = "smartgun rail"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
	icon_state = "smartgun"
	embedding = list(embed_chance=100, fall_chance=2, jostle_chance=0, ignore_throwspeed_threshold=TRUE, pain_stam_pct=20, pain_mult=4, rip_time=40)
	damage = 10
	stamina = 70
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = /obj/item/shrapnel/bullet/smartgun
	hitsound = 'modular_skyrat/modules/sec_haul/sound/rail.ogg'

/obj/projectile/bullet/advanced/smartgun/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.emote("scream")
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "tased", /datum/mood_event/tased)
		if((H.status_flags & CANKNOCKDOWN) && !HAS_TRAIT(H, TRAIT_STUNIMMUNE))
			addtimer(CALLBACK(H, /mob/living/carbon.proc/do_jitter_animation, jitter), 5)

/obj/item/shrapnel/bullet/smartgun
	name = "smartgun shredder"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
	icon_state = "smartgun_embed"
	embedding = null

/*
*	4.73x33mm CASELESS
*	FMJ | JHP | IHDF | RUBBER
*/

/obj/item/ammo_casing/caseless/b473
	name = "4.73x33mm FMJ bullet"
	desc = "A 4.73x33mm FMJ bullet."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_473MM
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect
	projectile_type = /obj/projectile/bullet/advanced/b473

/obj/projectile/bullet/advanced/b473
	name = "4.73x33mm FMJ bullet"
	damage = 20
	speed = 0.7

/obj/item/ammo_casing/caseless/b473/hp
	name = "4.73x33mm JHP bullet"
	desc = "A 4.73x33mm JHP bullet."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_473MM
	projectile_type = /obj/projectile/bullet/advanced/b473/hp

/obj/projectile/bullet/advanced/b473/hp
	name = "4.73x33mm JHP bullet"
	icon_state = "bullet_h"
	damage = 20
	wound_bonus = 30
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/obj/item/ammo_casing/caseless/b473/rubber
	name = "4.73x33mm rubber bullet"
	desc = "A 4.73x33mm rubber bullet."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_473MM
	projectile_type = /obj/projectile/bullet/advanced/b473/rubber
	harmful = FALSE

/obj/projectile/bullet/advanced/b473/rubber
	name = "4.73x33mm rubber bullet"
	icon_state = "bullet_r"
	damage = 5
	stamina = 20
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/caseless/b473/ihdf
	name = "4.73x33mm IHDF bullet"
	desc = "A 4.73x33mm intelligent high-impact dispersal foam bullet."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = CALIBER_473MM
	projectile_type = /obj/projectile/bullet/advanced/b473/ihdf
	harmful = FALSE

/obj/projectile/bullet/advanced/b473/ihdf
	name = "4.73x33mm ihdf bullet"
	icon_state = "bullet_i"
	damage = 25
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/*
*	14 GAUGE
*/

/obj/projectile/bullet/s14gauge_slug
	name = "12g shotgun slug"
	damage = 27
	sharpness = SHARP_POINTY
	wound_bonus = 0

/obj/projectile/bullet/s14gauge_beanbag
	name = "beanbag slug"
	damage = 5
	stamina = 30
	wound_bonus = 0
	sharpness = NONE
	embedding = null

/obj/projectile/bullet/pellet/s14gauge_buckshot
	name = "buckshot pellet"
	damage = 5
	wound_bonus = 3
	bare_wound_bonus = 3
	wound_falloff_tile = -2.5 // low damage + additional dropoff will already curb wounding potential anything past point blank

/obj/projectile/bullet/pellet/s14gauge_rubbershot
	name = "rubbershot pellet"
	damage = 2
	stamina = 7
	sharpness = NONE
	embedding = null

/obj/projectile/bullet/s14gauge_stunslug
	name = "stunslug"
	damage = 5
	knockdown = 100
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"
	embedding = null
