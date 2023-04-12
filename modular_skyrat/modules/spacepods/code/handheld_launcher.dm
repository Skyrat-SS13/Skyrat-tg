/obj/item/gun/ballistic/rocket_launcher
	name = "S-MRL (shoulder-mounted rocket launcher)"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/physics_rocket
	fire_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 0
	casing_ejector = FALSE
	weapon_weight = WEAPON_HEAVY
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	cartridge_wording = "rocket"
	empty_indicator = TRUE
	tac_reloads = FALSE

/obj/item/gun/ballistic/rocket_launcher/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/backblast)


/obj/item/ammo_box/magazine/internal/physics_rocket
	name = "rocket launcher internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/physics_rocket
	caliber = CALIBER_84MM
	max_ammo = 1

/obj/item/ammo_casing/caseless/physics_rocket
	name = "\improper S-MRL Rocket"
	desc = "An 84mm High Explosive rocket. Fire at people and pray."
	caliber = CALIBER_84MM
	icon_state = "srm-8"
	projectile_type = /obj/projectile
	// How long the rocket "floats" before it fires the main engine.
	var/ignition_time
	var/rocket_type = /obj/physics_rocket

/obj/item/ammo_casing/caseless/physics_rocket/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	new rocket_type(get_turf(src), get_angle(get_turf(fired_from), target), target, ignition_time)
	QDEL_NULL(loaded_projectile)
	return TRUE

/obj/item/gun/ballistic/rocket_launcher/missile
	name = "S-MML (shoulder-mounted missile launcher)"
	mag_type = /obj/item/ammo_box/magazine/internal/physics_rocket/missile

/obj/item/ammo_box/magazine/internal/physics_rocket/missile
	ammo_type = /obj/item/ammo_casing/caseless/physics_rocket/missile


/obj/item/ammo_casing/caseless/physics_rocket/missile
	name = "\improper S-MML Autotargeting Missile"
	desc = "An 84mm High Explosive rocket. Fire at people and pray."
	rocket_type = /obj/physics_missile/auto_target
	ignition_time = 0.5 SECONDS

/obj/item/ammo_casing/caseless/physics_rocket/missile/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	new rocket_type(get_turf(src), get_angle(get_turf(fired_from), target), target, ignition_time, user)
	QDEL_NULL(loaded_projectile)
	return TRUE
