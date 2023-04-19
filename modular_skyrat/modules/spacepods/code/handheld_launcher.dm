/obj/item/gun/ballistic/rocket_launcher
	name = "S-MRL (shoulder-mounted rocket launcher)"
	icon = 'modular_skyrat/modules/spacepods/icons/launcher40x32.dmi'
	icon_state = "launcher"
	inhand_icon_state = "launcher"
	lefthand_file = 'modular_skyrat/modules/spacepods/icons/launcher_righthand.dmi'
	righthand_file = 'modular_skyrat/modules/spacepods/icons/launcher_lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/spacepods/icons/launcher_worn.dmi'
	worn_icon_state = "launcher"
	mag_type = /obj/item/ammo_box/magazine/internal/physics_rocket
	fire_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
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
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/gun/ballistic/rocket_launcher/update_overlays()
	. = ..()
	if(chambered?.loaded_projectile)
		var/mutable_appearance/rocket_overlay = mutable_appearance(icon, "rocket")
		rocket_overlay.pixel_x = 20
		. += rocket_overlay

/obj/item/gun/ballistic/rocket_launcher/update_icon_state()
	. = ..()
	if(chambered?.loaded_projectile)
		worn_icon = "launcher"
		inhand_icon_state = "launcher"
	else
		worn_icon = "launcher_empty"
		inhand_icon_state = "launcher_empty"

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
	new rocket_type(get_turf(src), get_angle(get_turf(fired_from), target), 0, 0, 0, 0, target, ignition_time)
	QDEL_NULL(loaded_projectile)
	return TRUE

/obj/item/gun/ballistic/rocket_launcher/missile
	name = "\improper S-MML 84 'Fire and Forget' Missile Launcher"
	mag_type = /obj/item/ammo_box/magazine/internal/physics_rocket/missile

/obj/item/ammo_box/magazine/internal/physics_rocket/missile
	ammo_type = /obj/item/ammo_casing/caseless/physics_rocket/missile


/obj/item/ammo_casing/caseless/physics_rocket/missile
	name = "\improper S-MML 'Fire and Forget' Autotargeting Missile"
	desc = "An 84mm High Explosive rocket. Fire at people and pray."
	rocket_type = /obj/physics_missile/auto_target
	ignition_time = 0.5 SECONDS

/obj/item/ammo_casing/caseless/physics_rocket/missile/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	new rocket_type(get_turf(src), get_angle(get_turf(fired_from), target), 0, 0, 0, 0, target, ignition_time, user)
	QDEL_NULL(loaded_projectile)
	return TRUE
