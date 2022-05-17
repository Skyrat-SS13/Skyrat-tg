/* /obj/projectile/bullet/pellet
	var/tile_dropoff = 0.45
	var/tile_dropoff_s = 0.25 */

////////////////////////////
///////////14 GAUGE/////////
////////////////////////////

/obj/item/gun/ballistic/rifle/ishotgun/gauge14
	name = "improvised double-barrel shotgun"
	desc = "A break-action 14 gauge double-barrel shotgun. You need both hands to fire this."
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised/gauge14
	sawn_desc = "A break-action 14 gauge double-barrel shotgun, but with most of the stock and some of the barrel removed. You still need both hands to fire this."
	bolt_type = BOLT_TYPE_NO_BOLT

/obj/item/ammo_box/magazine/internal/shot/improvised/gauge14
	name = "improvised shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/improvised
	max_ammo = 2
	caliber = CALIBER_14GAUGE

/datum/crafting_recipe/ishotgun14g
	name = "Improvised Double-Barrel Shotgun"
	result = /obj/item/gun/ballistic/rifle/ishotgun/gauge14
	reqs = list(/obj/item/weaponcrafting/receiver = 1,
				/obj/item/pipe = 2,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/stack/package_wrap = 5,
				/obj/item/stack/sheet/iron = 5,
				/obj/item/stack/sheet/plasteel = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//Bullets
/obj/projectile/bullet/s14gauge_slug
	name = "12g shotgun slug"
	damage = 35
	sharpness = SHARP_POINTY
	wound_bonus = 0

/obj/projectile/bullet/s14gauge_beanbag
	name = "beanbag slug"
	damage = 5
	stamina = 30
	wound_bonus = 0
	sharpness = NONE
	embedding = null


/obj/projectile/bullet/pellet/s14gauge
	tile_dropoff = 0.3
	tile_dropoff_s = 0.15

/obj/projectile/bullet/pellet/s14gauge/buckshot
	name = "buckshot pellet"
	damage = 6
	wound_bonus = 3
	bare_wound_bonus = 3
	wound_falloff_tile = -2.5 // low damage + additional dropoff will already curb wounding potential anything past point blank
	weak_against_armour = TRUE

/obj/projectile/bullet/pellet/s14gauge/rubbershot
	name = "rubbershot pellet"
	damage = 3
	stamina = 8
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

/obj/projectile/bullet/pellet/s14gauge/improvised
	tile_dropoff = 0.35
	damage = 4
	wound_bonus = 0
	bare_wound_bonus = 7.5
	weak_against_armour = TRUE

/obj/projectile/bullet/pellet/s14gauge/improvised/Initialize(mapload)
	. = ..()
	range = rand(1, 8)

/obj/projectile/bullet/pellet/s14gauge/improvised/on_range()
	do_sparks(1, TRUE, src)
	..()

//Casings

/obj/item/ammo_casing/s14gauge
	name = "14 gauge shotgun slug"
	desc = "A 14 gauge lead slug."
	icon_state = "blshell"
	worn_icon_state = "shell"
	caliber = CALIBER_14GAUGE
	custom_materials = list(/datum/material/iron=500)
	projectile_type = /obj/projectile/bullet/s14gauge_slug

/obj/item/ammo_casing/s14gauge/beanbag
	name = "14 gauge beanbag slug"
	desc = "A weak beanbag slug for riot control."
	icon_state = "bshell"
	custom_materials = list(/datum/material/iron=250)
	projectile_type = /obj/projectile/bullet/s14gauge_beanbag
	harmful = FALSE

/obj/item/ammo_casing/s14gauge/buckshot
	name = "14 gauge buckshot shell"
	desc = "A 14 gauge  buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/buckshot
	pellets = 7 //
	variance = 15

/obj/item/ammo_casing/s14gauge/rubbershot
	name = "14 gauge rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "bshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/rubbershot
	pellets = 7
	variance = 15

/obj/item/ammo_casing/s14gauge/stunslug
	name = "14 gauge taser slug"
	desc = "A stunning taser slug."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/s14gauge_stunslug
	custom_materials = list(/datum/material/iron=500,/datum/material/gold=100)
	harmful = FALSE

/obj/item/ammo_casing/s14gauge/improvised
	name = "improvised 14 gauge shell"
	desc = "An extremely weak shotgun shell with multiple small pellets made out of metal shards."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/improvised
	pellets = 14 // 14 x 4 = 56 Damage Potential but this is drops off extremely fast
	variance = 25
	custom_materials = list(/datum/material/iron=250)

/datum/crafting_recipe/improvised14gslug
	name = "Improvised 14 Gauge Shotgun Shell"
	result = /obj/item/ammo_casing/s14gauge/improvised
	reqs = list(/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 1,
				/datum/reagent/fuel = 10)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 12
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

//Storage Boxes

/obj/item/storage/box/rubbershot_14gauge
	name = "box of 14 gauge rubber shots"
	desc = "A box full of rubber shots, designed for riot shotguns."
	icon_state = "secbox_xl"
	illustration = "rubbershot"

/obj/item/storage/box/rubbershot_14gauge/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/s14gauge/rubbershot(src)

/obj/item/storage/box/lethalshot_14gauge
	name = "box of lethal 14 gauge shotgun shots"
	desc = "A box full of lethal shots, designed for riot shotguns."
	icon_state = "secbox_xl"
	illustration = "buckshot"

/obj/item/storage/box/lethalshot_14gauge/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/s14gauge/buckshot(src)

/obj/item/storage/box/beanbag_14gauge
	name = "box of 14 gauge beanbags"
	desc = "A box full of beanbag shells."
	icon_state = "secbox_xl"
	illustration = "beanbag"

/obj/item/storage/box/beanbag_14gauge/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_casing/s14gauge/beanbag(src)
