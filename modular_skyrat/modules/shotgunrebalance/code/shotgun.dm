/* /obj/projectile/bullet/pellet
	var/tile_dropoff = 0.45
	var/tile_dropoff_s = 0.25 */

/obj/item/ammo_casing/shotgun
	custom_materials = list(/datum/material/iron=1000) //We will be using this to prevent refund scamming mats

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
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	pellets = 6 //6 x 10 = 60 Damage Potential
	variance = 30

/obj/projectile/bullet/pellet/shotgun_buckshot/magnum
	damage = 10
	wound_bonus = 8

/obj/item/ammo_casing/shotgun/express
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/express
	pellets = 9 //6 x 10 = 60 Damage Potential
	variance = 20 //tighter spread

/obj/projectile/bullet/pellet/shotgun_buckshot/express
	damage = 5

/obj/item/ammo_casing/shotgun/flechette
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/flechette
	pellets = 7 //7 x 7 = 49 Damage Potential
	variance = 25

/obj/projectile/bullet/pellet/shotgun_buckshot/flechette
	damage = 7
	weak_against_armour = FALSE //Were here to rip armor

/obj/projectile/bullet/pellet/shotgun_improvised
	weak_against_armour = TRUE // We will not have Improvised are Better 2.0
