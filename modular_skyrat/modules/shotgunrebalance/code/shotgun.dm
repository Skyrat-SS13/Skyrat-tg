/* /obj/projectile/bullet/pellet
	var/tile_dropoff = 0.45
	var/tile_dropoff_s = 0.25 */

/obj/item/ammo_casing/shotgun
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
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/pt20
	custom_materials = list(/datum/material/iron=500,/datum/material/plasma=500,/datum/material/titanium=500)

/obj/projectile/bullet/shotgun_slug/pt20
	name = "armor piercing shotgun slug"
	damage = 40
	armour_penetration = 50

/obj/item/ammo_casing/shotgun/rip
	name = "RIP shotgun slug"
	desc = "Radically Invasive Projectile Slug that is designed to cause massive damage against unarmored targets."
	icon_state = "stunshell"
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

/obj/item/ammo_casing/shotgun/magnum
	name = "magnum buckshot shell"
	desc = "A 12 gauge buckshot shell that fires bigger pellets but has more spread. It is able to contend against armored targets."
	icon_state = "gshell"
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
	icon_state = "gshell"
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
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/flechette
	pellets = 8 //8 x 6 = 48 Damage Potential
	variance = 25

/obj/projectile/bullet/pellet/shotgun_buckshot/flechette
	name = "flechette"
	damage = 6
	weak_against_armour = FALSE //Were here to rip armor
	armour_penetration = 40
	wound_bonus = 9
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED //Did you knew flechettes fly sideways into people

/obj/projectile/bullet/pellet/shotgun_improvised
	weak_against_armour = TRUE // We will not have Improvised are Better 2.0
