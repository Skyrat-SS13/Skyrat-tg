/obj/projectile/bullet/advanced
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
	icon_state = "bullet"

///////////////////////////6mm
//RUBBER | LETHAL | IHDF
///////////////////////////////
/obj/item/ammo_casing/b6mm
	name = "6mm bullet casing"
	desc = "A 6mm bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_6MM
	projectile_type = /obj/projectile/bullet/advanced/b6mm

/obj/projectile/bullet/advanced/b6mm
	name = "6mm bullet"
	damage = 15
	speed = 0.5

/obj/item/ammo_casing/b6mm/rubber
	name = "6mm rubber bullet casing"
	desc = "A 6mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_6MM
	projectile_type = /obj/projectile/bullet/advanced/b6mm/rubber

/obj/projectile/bullet/advanced/b6mm/rubber
	name = "6mm rubber bullet"
	icon_state = "bullet_r"
	damage = 5
	stamina = 10
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/b6mm/ihdf
	name = "6mm IHDF bullet casing"
	desc = "A 6mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = CALIBER_6MM
	projectile_type = /obj/projectile/bullet/advanced/b6mm/ihdf

/obj/projectile/bullet/advanced/b6mm/ihdf
	name = "6mm ihdf bullet"
	icon_state = "bullet_i"
	damage = 15
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	damage_type = STAMINA

///////////////////////////9mm
//RUBBER | LETHAL | HP | IHDF
///////////////////////////////
/obj/item/ammo_casing/b9mm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/advanced/b9mm

/obj/projectile/bullet/advanced/b9mm
	name = "9mm bullet"
	damage = 20
	speed = 0.7

/obj/item/ammo_casing/b9mm/hp
	name = "9mm HP bullet casing"
	desc = "A 9mm hollowpoint bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/advanced/b9mm/hp

/obj/projectile/bullet/advanced/b9mm/hp
	name = "9mm hollowpoint bullet"
	icon_state = "bullet_h"
	damage = 20
	wound_bonus = 30
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/obj/item/ammo_casing/b9mm/rubber
	name = "9mm rubber bullet casing"
	desc = "A 9mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/advanced/b9mm/rubber

/obj/projectile/bullet/advanced/b9mm/rubber
	name = "9mm rubber bullet"
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

/obj/item/ammo_casing/b9mm/ihdf
	name = "9mm IHDF bullet casing"
	desc = "A 9mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/advanced/b9mm/ihdf

/obj/projectile/bullet/advanced/b9mm/ihdf
	name = "9mm ihdf bullet"
	icon_state = "bullet_i"
	damage = 25
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)


///////////////////////////10mm
//RUBBER | LETHAL | HP | IHDF
///////////////////////////////
/obj/item/ammo_casing/b10mm
	name = "10mm bullet casing"
	desc = "A 10mm bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/advanced/b10mm

/obj/projectile/bullet/advanced/b10mm
	name = "10mm bullet"
	damage = 30
	speed = 0.9

/obj/item/ammo_casing/b10mm/hp
	name = "10mm HP bullet casing"
	desc = "A 10mm hollowpoint bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/advanced/b10mm/hp

/obj/projectile/bullet/advanced/b10mm/hp
	name = "10mm hollowpoint bullet"
	icon_state = "bullet_h"
	damage = 30
	wound_bonus = 30
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/obj/item/ammo_casing/b10mm/rubber
	name = "10mm rubber bullet casing"
	desc = "A 10mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/advanced/b10mm/rubber

/obj/projectile/bullet/advanced/b10mm/rubber
	name = "10mm rubber bullet"
	icon_state = "bullet_r"
	damage = 7
	stamina = 25
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null

/obj/item/ammo_casing/b10mm/ihdf
	name = "10mm IHDF bullet casing"
	desc = "A 10mm intelligent high-impact dispersal foam bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "si-casing"
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/advanced/b10mm/ihdf

/obj/projectile/bullet/advanced/b10mm/ihdf
	name = "10mm ihdf bullet"
	icon_state = "bullet_i"
	damage = 30
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

//////////////////12mm
//RUBBER | LETHAL | HP
//////////////////////
/obj/item/ammo_casing/b12mm
	name = "12mm bullet casing"
	desc = "A 12mm bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/advanced/b12mm

/obj/projectile/bullet/advanced/b12mm
	name = "12mm bullet"
	damage = 45
	speed = 1.2

/obj/item/ammo_casing/b12mm/hp
	name = "12mm HP bullet casing"
	desc = "A 12mm hollowpoint bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/advanced/b12mm/hp

/obj/projectile/bullet/advanced/b12mm/hp
	name = "12mm hollowpoint bullet"
	icon_state = "bullet_h"
	damage = 45
	wound_bonus = 35
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	weak_against_armour = TRUE

/obj/item/ammo_casing/b12mm/rubber
	name = "12mm rubber bullet casing"
	desc = "A 12mm rubber bullet casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sr-casing"
	caliber = CALIBER_12MM
	projectile_type = /obj/projectile/bullet/advanced/b12mm/rubber

/obj/projectile/bullet/advanced/b12mm/rubber
	name = "12mm rubber bullet"
	icon_state = "bullet_r"
	damage = 13
	stamina = 50
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embedding = null


/obj/item/ammo_casing/b577
	name = ".577 Snider bullet casing"
	desc = "A .577 Sniderbullet casing."
	caliber = ".577 Snider"
	projectile_type = /obj/projectile/bullet/advanced/b577

/obj/projectile/bullet/advanced/b577
	name = "577 bullet"
	damage = 40
	wound_bonus = 15
	bare_wound_bonus = 30
	dismemberment = 15

//SMARTGUN
/obj/item/ammo_casing/smartgun
	name = "smartgun bullet casing"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "smartgun"
	desc = "A smartgun cartridge."
	caliber = "smartgun"
	projectile_type = /obj/projectile/bullet/advanced/smartgun

/obj/projectile/bullet/advanced/smartgun
	name = "smartgun dart"
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

/////////////4.73x33mm CASELESS
//RUBBER | LETHAL | HP | IHDF
///////////////////////////////
/obj/item/ammo_casing/caseless/b473
	name = "4.73x33mm bullet"
	desc = "A 4.73x33mm bullet."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_473MM
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect
	projectile_type = /obj/projectile/bullet/advanced/b473

/obj/projectile/bullet/advanced/b473
	name = "4.73x33mm bullet"
	damage = 20
	speed = 0.7

/obj/item/ammo_casing/caseless/b473/hp
	name = "4.73x33mm HP bullet"
	desc = "A 4.73x33mm hollowpoint bullet."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sh-casing"
	caliber = CALIBER_473MM
	projectile_type = /obj/projectile/bullet/advanced/b473/hp

/obj/projectile/bullet/advanced/b473/hp
	name = "4.73x33mm hollowpoint bullet"
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

/obj/projectile/bullet/advanced/b473/ihdf
	name = "4.73x33mm ihdf bullet"
	icon_state = "bullet_i"
	damage = 25
	damage_type = STAMINA
	embedding = list(embed_chance=0, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
