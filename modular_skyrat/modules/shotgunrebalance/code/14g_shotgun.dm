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
//	bolt_type = BOLT_TYPE_NO_BOLT
	semi_auto = TRUE

/obj/item/ammo_box/magazine/internal/shot/improvised/gauge14
	name = "improvised shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/s14gauge/improvised
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
	name = "14g shotgun slug"
	damage = 35
	sharpness = SHARP_POINTY
	wound_bonus = 0

/obj/projectile/bullet/s14gauge_slug_hp
	name = "14g hollow point shotgun slug"
	damage = 50
	sharpness = SHARP_POINTY
	wound_bonus = 0
	bare_wound_bonus = 20
	weak_against_armour = TRUE

/obj/projectile/bullet/s14gauge_beanbag
	name = "14g beanbag slug"
	damage = 5
	stamina = 40
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

/obj/projectile/bullet/pellet/s14gauge/buckshot/magnum
	name = "magnum buckshot pellet"
	damage = 8
	wound_bonus = 4
	bare_wound_bonus = 4
	wound_falloff_tile = -2.5 // low damage + additional dropoff will already curb wounding potential anything past point blank
	weak_against_armour = FALSE

/obj/projectile/bullet/pellet/s14gauge/rubbershot
	name = "rubbershot pellet"
	damage = 3
	stamina = 8
	sharpness = NONE
	embedding = null

/obj/projectile/bullet/pellet/s14gauge/beehive
	name = "beehive pellet"
	damage = 5
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

/obj/projectile/bullet/pellet/s14gauge/antitide
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
	embedding = list(embed_chance=70, pain_chance=25, fall_chance=15, jostle_chance=80, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.9, pain_mult=5, rip_time=10)

/obj/projectile/bullet/pellet/s14gauge/antitide/on_range()
	do_sparks(1, TRUE, src)
	..()

/obj/projectile/bullet/pellet/s14gauge/iceblox //see /obj/projectile/temp for the original code
	name = "iceblox pellet"
	tile_dropoff = 0.35
	damage = 5
	weak_against_armour = TRUE
	var/temperature = 30

/obj/projectile/bullet/pellet/s14gauge/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((30-blocked)/30)*(temperature - M.bodytemperature))

/obj/projectile/bullet/s14gauge_stunslug
	name = "stunslug"
	damage = 5
	paralyze = 100
	stutter = 5 SECONDS
	jitter = 10 SECONDS
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

/obj/item/ammo_casing/s14gauge/hp
	name = "14 gauge hollow point shotgun slug"
	desc = "A 14 gauge hollow point slug purpose built for unarmored targets."
	icon_state = "blshell"
	worn_icon_state = "shell"
	caliber = CALIBER_14GAUGE
	custom_materials = list(/datum/material/iron=500)
	projectile_type = /obj/projectile/bullet/s14gauge_slug_hp

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
	pellets = 7 // 7 x 6 = 42 Damage potential
	variance = 15

/obj/item/ammo_casing/s14gauge/magnum
	name = "14 gauge magnum buckshot shell"
	desc = "A 14 gauge magnum buckshot shell with higher spread and bigger pellets. It is able to contend against armored targets."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/buckshot/magnum
	pellets = 5 // 5 x 8 = 40 Damage potential
	variance = 20

/obj/item/ammo_casing/s14gauge/rubbershot
	name = "14 gauge rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "bshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/rubbershot
	pellets = 7
	variance = 15
	harmful = FALSE

/obj/item/ammo_casing/s14gauge/stunslug
	name = "14 gauge taser slug"
	desc = "A stunning taser slug."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/s14gauge_stunslug
	custom_materials = list(/datum/material/iron=500,/datum/material/gold=100)
	harmful = FALSE

/obj/item/ammo_casing/s14gauge/pyro
	name = "14 gauge pyrosium slug"
	desc = "A 14 gauge slug that is filled with unstable plasma which ignited on contact with a target."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun/no_trail
	custom_materials = list(/datum/material/iron=500,/datum/material/plasma=500)

/obj/item/ammo_casing/s14gauge/beehive
	name = "14 gauge B3-HVE 'Beehive' shell"
	desc = "A highly experimental shell filled with smart nanite pellets that re-aim themselves when bouncing off from surfaces. However they are not able to make out friend from foe."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/beehive
	custom_materials = list(/datum/material/iron=500,/datum/material/silver=500,/datum/material/plasma=500)
	pellets = 5
	variance = 20

/obj/item/ammo_casing/s14gauge/antitide
	name = "14 gauge 4NT1-TD3 'Suppressor' shell"
	desc = "A highly experimental shell filled with nanite electrodes that will embed themselves in soft targets. The electrodes are charged from kinetic movement which means moving targets will get punished more."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/antitide
	custom_materials = list(/datum/material/iron=500,/datum/material/gold=500,/datum/material/uranium=500)
	pellets = 5
	variance = 20
	harmful = FALSE

/obj/item/ammo_casing/s14gauge/iceblox
	name = "14 gauge Iceshot shell"
	desc = "A highly experimental shell filled with nanites that will lower the body temperature of hit targets."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge/iceblox
	custom_materials = list(/datum/material/iron=500,/datum/material/plasma=500)
	pellets = 5
	variance = 20

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
