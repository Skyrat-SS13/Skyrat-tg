/obj/item/ammo_casing/shotgun
	icon = 'modular_skyrat/modules/shotgunrebalance/icons/shotshells.dmi'
	custom_materials = list(/datum/material/iron=1000) //We will be using this to prevent refund scamming mats

/obj/item/ammo_casing/shotgun/hp
	name = "hollow point slug"
	desc = "A 12 gauge hollow point slug purpose built for unarmored targets."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/hp

/obj/projectile/bullet/shotgun_slug/hp
	name = "12g hollow point shotgun slug"
	damage = 60
	sharpness = SHARP_POINTY
	wound_bonus = 0
	bare_wound_bonus = 40
	weak_against_armour = TRUE

/obj/item/ammo_casing/shotgun/pt20
	name = "PT-20 armor piercing slug"
	desc = "A 12 gauge plastitanium slug purpose built to penetrate armored targets."
	icon_state = "apshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/pt20
	custom_materials = list(/datum/material/iron=500,/datum/material/plasma=500,/datum/material/titanium=500)

/obj/projectile/bullet/shotgun_slug/pt20
	name = "armor piercing shotgun slug"
	damage = 40
	armour_penetration = 50

/obj/item/ammo_casing/shotgun/rip
	name = "RIP shotgun slug"
	desc = "Radically Invasive Projectile Slug that is designed to cause massive damage against unarmored targets by embedding inside them."
	icon_state = "ripshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/rip
	custom_materials = list(/datum/material/iron=500,/datum/material/plasma=500,/datum/material/diamond=500)

/obj/projectile/bullet/shotgun_slug/rip
	name = "RIP shotgun slug"
	damage = 50
	weak_against_armour = TRUE
	embedding = list(embed_chance=80, pain_chance=40, fall_chance=5, jostle_chance=5, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.5, pain_mult=5, rip_time=30)

/obj/item/ammo_casing/shotgun/buckshot
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot
	pellets = 8 //Original: 6 || 8 x 8 = 64 Damage Potential, 34 Damage at 4 tile range
	variance = 25

/obj/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = 8//7.5
	wound_bonus = 5
	bare_wound_bonus = 5
	wound_falloff_tile = -2.5 // low damage + additional dropoff will already curb wounding potential anything past point blank
	weak_against_armour = TRUE // Did you knew shotguns are actually shit against armor?

/obj/item/ammo_casing/shotgun/rubbershot
	name = "rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "rshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_rubbershot
	pellets = 7
	variance = 20
	custom_materials = list(/datum/material/iron=1000)
	harmful = FALSE

/obj/item/ammo_casing/shotgun/magnum
	name = "magnum buckshot shell"
	desc = "A 12 gauge buckshot shell that fires bigger pellets but has more spread. It is able to contend against armored targets."
	icon_state = "magshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	pellets = 6 //6 x 10 = 60 Damage Potential, 27 Damage at 4 tile range
	variance = 30

/obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	name = "magnum buckshot pellet"
	damage = 10
	wound_bonus = 8
	weak_against_armour = FALSE

/obj/item/ammo_casing/shotgun/express
	name = "express buckshot shell"
	desc = "A 12 gauge buckshot shell that has tighter spread and smaller projectiles."
	icon_state = "expshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/express
	pellets = 9 //6 x 9 = 51 Damage Potential, 33 Damage at 4 tile range
	variance = 20 //tighter spread

/obj/projectile/bullet/pellet/shotgun_buckshot/express
	name = "express buckshot pellet"
	damage = 6
	speed = 0.6

/obj/item/ammo_casing/shotgun/flechette
	name = "flechette shell"
	desc = "A 12 gauge flechette shell that specializes in ripping through armor."
	icon_state = "fshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/flechette
	pellets = 8 //8 x 6 = 48 Damage Potential
	variance = 25
	custom_materials = list(/datum/material/iron=500,/datum/material/titanium=500)

/obj/projectile/bullet/pellet/shotgun_buckshot/flechette
	name = "flechette"
	damage = 6
	weak_against_armour = FALSE //Were here to rip armor
	armour_penetration = 40
	wound_bonus = 9
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED //Did you knew flechettes fly sideways into people

/obj/item/ammo_casing/shotgun/beehive
	name = "B3-HVE 'Beehive' shell"
	desc = "A highly experimental non-lethal shell filled with smart nanite pellets that re-aim themselves when bouncing off from surfaces. However they are not able to make out friend from foe."
	icon_state = "cnrshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/beehive
	custom_materials = list(/datum/material/iron=500,/datum/material/silver=500,/datum/material/plasma=500)
	pellets = 6
	variance = 20
	fire_sound = 'sound/weapons/taser.ogg'
	harmful = FALSE

/obj/projectile/bullet/pellet/shotgun_buckshot/beehive
	name = "beehive pellet"
	damage = 4
	stamina = 10
	tile_dropoff = 0.1
	tile_dropoff_s = 0.1
	wound_bonus = -5
	bare_wound_bonus = 5
	wound_falloff_tile = 0
	weak_against_armour = TRUE
	sharpness = NONE
	ricochets_max = 5
	ricochet_chance = 200
	ricochet_auto_aim_angle = 60
	ricochet_auto_aim_range = 8
	ricochet_decay_damage = 1
	ricochet_decay_chance = 1
	ricochet_incidence_leeway = 0 //nanomachines son

/obj/item/ammo_casing/shotgun/antitide
	name = "4NT1-TD3 'Suppressor' shell"
	desc = "A highly experimental shell filled with nanite electrodes that will embed themselves in soft targets. The electrodes are charged from kinetic movement which means moving targets will get punished more."
	icon_state = "lasershell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/antitide
	custom_materials = list(/datum/material/iron=500,/datum/material/gold=500,/datum/material/uranium=500)
	pellets = 5
	variance = 30
	harmful = FALSE
	fire_sound = 'sound/weapons/taser.ogg'

/obj/projectile/bullet/pellet/shotgun_buckshot/antitide
	name = "electrode"
	damage = 4
	stamina = 6
	tile_dropoff = 0.2
	tile_dropoff_s = 0.3
	wound_bonus = 0
	bare_wound_bonus = 0
	stutter = 3 SECONDS
	jitter = 5 SECONDS
	eyeblur = 1 SECONDS
	weak_against_armour = TRUE
	sharpness = NONE
	range = 8
	icon_state = "spark"
	embedding = list(embed_chance=70, pain_chance=25, fall_chance=15, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=2, rip_time=10)

/obj/projectile/bullet/pellet/shotgun_buckshot/antitide/Initialize(mapload)
	. = ..()
	SpinAnimation()
	transform *= 0.25

/obj/projectile/bullet/pellet/shotgun_buckshot/antitide/on_range()
	do_sparks(1, TRUE, src)
	..()

/obj/item/ammo_casing/shotgun/iceblox
	name = "Iceshot shell"
	desc = "A highly experimental shell filled with nanites that will lower the body temperature of hit targets."
	icon_state = "tshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/iceblox
	custom_materials = list(/datum/material/iron=500,/datum/material/plasma=500)
	pellets = 5
	variance = 20

/obj/projectile/bullet/pellet/shotgun_buckshot/iceblox //see /obj/projectile/temp for the original code
	name = "iceblox pellet"
	tile_dropoff = 0.35
	damage = 5
	weak_against_armour = TRUE
	var/temperature = 30

/obj/projectile/bullet/pellet/shotgun_buckshot/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/UnluckyBastard = target
		UnluckyBastard.adjust_bodytemperature(((100-blocked)/100)*(temperature - UnluckyBastard.bodytemperature))

/obj/item/ammo_casing/shotgun/hunter
	name = "hunter buckshot shell"
	desc = "A 12 gauge buckshot shell that fires specially charged pellets that deal extra damage to simpler beings."
	icon_state = "huntershell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/hunter
	pellets = 6 // 6 x 30 = 180 damage vs simples
	variance = 30

/obj/projectile/bullet/pellet/shotgun_buckshot/hunter
	name = "hunter buckshot pellet"
	damage = 5
	wound_bonus = 0
	weak_against_armour = FALSE
		/// Bonus force dealt against certain factions
	var/faction_bonus_force = 25
		/// Any mob with a faction that exists in this list will take bonus damage/effects
	var/list/nemesis_path = /mob/living/simple_animal

/obj/projectile/bullet/pellet/shotgun_buckshot/hunter/prehit_pierce(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, nemesis_path))
		damage += faction_bonus_force
	.=..()

/obj/projectile/bullet/pellet/shotgun_improvised
	weak_against_armour = TRUE // We will not have Improvised are Better 2.0

/obj/item/ammo_casing/shotgun/honk
	name = "confetti shell"
	desc = "A 12 gauge buckshot shell thats been filled to the brim with confetti. Who is making all these?"
	icon_state = "honkshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/honk
	pellets = 12
	variance = 35
	fire_sound = 'sound/items/bikehorn.ogg'
	harmful = FALSE

/obj/projectile/bullet/pellet/shotgun_buckshot/honk
	name = "confetti"
	damage = 0
	stamina = 1
	tile_dropoff_s = 0
	wound_bonus = 0
	bare_wound_bonus = 0
	jitter = 1 SECONDS
	eyeblur = 1 SECONDS
	sharpness = NONE
	hitsound = SFX_CLOWN_STEP
	range = 12
	icon_state = "guardian"
	embedding = null

/obj/projectile/bullet/pellet/shotgun_buckshot/honk/Initialize(mapload)
	. = ..()
	SpinAnimation()
	range = rand(6, 12)
	color = pick(
		COLOR_PRIDE_RED,
		COLOR_PRIDE_ORANGE,
		COLOR_PRIDE_YELLOW,
		COLOR_PRIDE_GREEN,
		COLOR_PRIDE_BLUE,
		COLOR_PRIDE_PURPLE,
	)

/obj/projectile/bullet/pellet/shotgun_buckshot/honk/on_range()
	do_sparks(1, TRUE, src)
	..()
