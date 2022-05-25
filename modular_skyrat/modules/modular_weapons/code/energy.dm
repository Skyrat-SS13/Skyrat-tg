/*
*	BOLT RESPONDER
*	A mini disabler
*	12 shot capacity VS normal disabler's 20.
*/


/obj/item/gun/energy/disabler/bolt_disabler
	name = "Bolt Responder"
	desc = "A pocket-sized non-lethal energy gun with low ammo capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-disabler"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell/mini_egun
	ammo_x_offset = 2
	charge_sections = 3
	can_flashlight = FALSE // Can't attach or detach the flashlight, and override it's icon update
	gunlight_state = "cfa-disabler-light"
	has_gun_safety = FALSE
	company_flag = COMPANY_BOLT

/obj/item/gun/energy/disabler/bolt_disabler/Initialize()
	set_gun_light(new /obj/item/flashlight/seclite(src))
	return ..()

/*
*	CFA PHALANX
*	Similar to the HoS's laser
*	Fires a bouncing non-lethal, lethal and knockdown projectile.
*/

/obj/item/gun/energy/e_gun/cfa_phalanx
	name = "\improper Mk.II Phalanx plasma blaster"
	desc = "Fires a disabling and lethal bouncing projectile, as well as a special muscle-seizing projectile that knocks targets down. It has <b><span style='color:purple'>Cantalan Federal Arms</span></b> etched into the grip."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "phalanx1"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/bounce, /obj/item/ammo_casing/energy/laser/bounce, /obj/item/ammo_casing/energy/electrode/knockdown)
	ammo_x_offset = 1
	charge_sections = 5
	has_gun_safety = FALSE
	cell_type = /obj/item/stock_parts/cell/hos_gun

/*
*	CFA PALADIN
*	Identical to a heavy laser.
*/


/obj/item/gun/energy/laser/cfa_paladin
	name = "\improper Mk.IV Paladin plasma carbine"
	desc = "Essentially a handheld laser cannon. This is solely for killing, and it's dual-laser system reflects that. It has <b><span style='color:purple'>Cantalan Federal Arms</span></b> etched into the grip."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "paladin"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/laser/double)
	charge_sections = 5
	has_gun_safety = FALSE

/*
*	BOUNCE DISABLER
*	A disabler that will always ricochet.
*/


/obj/item/ammo_casing/energy/disabler/bounce
	projectile_type = /obj/projectile/beam/disabler/bounce
	select_name  = "disable"
	e_cost = 60
	fire_sound = 'sound/weapons/taser2.ogg'
	harmful = FALSE

/obj/effect/projectile/tracer/disabler/bounce
	name = "disabler"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "bouncebeam"

/obj/projectile/beam/disabler/bounce
	name = "disabler arc"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "bouncebeam"
	damage = 30
	damage_type = STAMINA
	armor_flag = ENERGY
	eyeblur = 1
	tracer_type = /obj/effect/projectile/tracer/disabler/bounce
	light_range = 5
	light_power = 0.75
	speed = 1.4
	ricochets_max = 6
	ricochet_incidence_leeway = 170
	ricochet_chance = 130
	ricochet_decay_damage = 0.9

// Allows the projectile to reflect on walls like how bullets ricochet.
/obj/projectile/beam/disabler/bounce/check_ricochet_flag(atom/A)
	return TRUE

/*
*	BOUNCE LASER
*	A laser that will always ricochet.
*/

/obj/item/ammo_casing/energy/laser/bounce
	projectile_type = /obj/projectile/beam/laser/bounce
	select_name = "lethal"
	e_cost = 100

/obj/projectile/beam/laser/bounce
	name = "energy arc"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "bouncebeam_red"
	damage = 20
	damage_type = BURN
	armor_flag = LASER
	light_range = 5
	light_power = 0.75
	speed = 1.4
	ricochets_max = 6
	ricochet_incidence_leeway = 170
	ricochet_chance = 130
	ricochet_decay_damage = 0.9

// Allows the projectile to reflect on walls like how bullets ricochet.
/obj/projectile/beam/laser/bounce/check_ricochet_flag(atom/A)
	return TRUE

/*
*	KNOCKDOWN BOLT
*	A taser that had the same stamina impact as a disabler, but a five-second knockdown and taser hitter effects.
*/

/obj/item/ammo_casing/energy/electrode/knockdown
	projectile_type = /obj/projectile/energy/electrode/knockdown
	select_name = "knockdown"
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 200
	harmful = FALSE

/obj/projectile/energy/electrode/knockdown
	name = "electrobolt"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "electro_bolt"
	knockdown = 50
	stamina = 30
	range = 6

/*
*	SINGLE LASER
*	Has an unique sprite
*	Low-powered laser for rapid fire
*	Pea-shooter tier.
*/


/obj/item/ammo_casing/energy/laser/single
	projectile_type = /obj/projectile/beam/laser/single
	e_cost = 50
	select_name = "lethal"

/obj/projectile/beam/laser/single
	name = "laser bolt"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "single_laser"
	damage = 15
	eyeblur = 1
	light_range = 5
	light_power = 0.75
	speed = 0.5
	armour_penetration = 10

/*
*	DOUBLE LASER
*	Visually, this fires two lasers. In code, it's just one.
*	It's fast and great for turrets.
*/

/obj/item/ammo_casing/energy/laser/double
	projectile_type = /obj/projectile/beam/laser/double
	e_cost = 100
	select_name = "lethal"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/projectile/beam/laser/double
	name = "laser bolt"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/projectiles.dmi'
	icon_state = "double_laser"
	damage = 40
	eyeblur = 1
	light_range = 5
	light_power = 0.75
	speed = 0.5
	armour_penetration = 10

/*
*	ENERGY BULLETS
*	Ballistic gunplay but it allows us to target a different part of the armour block.
*	Also allows the benefits of lasers (blobs strains, xenos) over bullets to be used with ballistic gunplay.
*/

/obj/item/ammo_casing/caseless/laser
	name = "type I plasma projectile"
	desc = "A chemical mixture that once triggered, creates a deadly projectile, melting it's own casing in the process."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "plasma_shell"
	worn_icon_state = "shell"
	caliber = "Beam Shell"
	custom_materials = list(/datum/material/iron=4000,/datum/material/plasma=250)
	projectile_type = /obj/projectile/beam/laser/single

/obj/item/ammo_casing/caseless/laser/double
	name = "type II plasma projectile"
	desc = "A chemical mixture that once triggered, creates a deadly projectile, melting it's own casing in the process."
	icon_state = "plasma_shell2"
	worn_icon_state = "shell"
	caliber = "Beam Shell"
	custom_materials = list(/datum/material/iron=4000,/datum/material/plasma=500)
	projectile_type = /obj/projectile/beam/laser/double

/obj/item/ammo_casing/caseless/laser/bounce
	name = "type III reflective projectile (lethal)"
	desc = "A chemical mixture that once triggered, creates a deadly bouncing projectile, melting it's own casing in the process."
	icon_state = "bounce_shell"
	worn_icon_state = "shell"
	caliber = "Beam Shell"
	custom_materials = list(/datum/material/iron=4000,/datum/material/plasma=250)
	projectile_type = /obj/projectile/beam/laser/bounce

/obj/item/ammo_casing/caseless/laser/bounce/disabler
	name = "type III reflective projectile (disabler)"
	desc = "A chemical mixture that once triggered, creates bouncing disabler projectile, melting it's own casing in the process."
	icon_state = "disabler_shell"
	projectile_type = /obj/projectile/beam/disabler/bounce


