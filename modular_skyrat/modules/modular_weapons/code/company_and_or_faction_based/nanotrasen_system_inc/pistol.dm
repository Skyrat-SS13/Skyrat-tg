//Handgun


/obj/item/storage/toolbox/guncase/skyrat/nt_glock
	name = "9x25mm Mk2 Standard Pistol"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/nt_glock/empty
	extra_to_spawn = /obj/item/ammo_box/magazine/m9mm/rubber

/obj/item/storage/toolbox/guncase/skyrat/nt_glock/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm/ihdf = 2,
	), src)

/obj/item/gun/ballistic/automatic/pistol/nt_glock
	name = "\improper GP-9"
	desc = "General Purpose Pistol Number 9. A classic .9mm handgun with a small magazine capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "black"
	w_class = WEIGHT_CLASS_NORMAL
	spread = 12
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	pin = /obj/item/firing_pin
	projectile_damage_multiplier = 0.8
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/rubber

/obj/item/gun/ballistic/automatic/pistol/nt_glock/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/pistol/nt_glock/empty
	spawnwithmagazine = FALSE


/obj/item/storage/toolbox/guncase/skyrat/nt_glock_spec
	name = "9x25mm Mk2 Standard Pistol"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/nt_glock/empty
	extra_to_spawn = null

/obj/item/storage/toolbox/guncase/skyrat/nt_glock_spec/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm/hp = 2,
		/obj/item/ammo_box/magazine/m9mm/ap = 2,
	), src)

/obj/item/gun/ballistic/automatic/pistol/nt_glock/spec
	name = "\improper GP-93R"
	desc = "General Purpose Pistol Number 9, 3-Round Burst. A classic .9mm handgun with a small magazine capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "silver"
	spread = 18
	pin = /obj/item/firing_pin
	projectile_damage_multiplier = 0.9
	fire_delay = 2
	burst_size = 3

/obj/item/gun/ballistic/automatic/pistol/nt_glock/empty
	spawnwithmagazine = FALSE

// Revolver

/obj/item/gun/ballistic/revolver/nt_revolver
	name = "\improper R10"
	desc = "The Revolver Number 10. A rugged and reliable pistol chambered in 10mm Auto, holds 6 shot. Remember our promise"

/obj/item/gun/ballistic/revolver/nt_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)


/obj/item/storage/toolbox/guncase/skyrat/nt_revolver
	name = "10mm Auto Standard Revolver"

	weapon_to_spawn = /obj/item/gun/ballistic/revolver/nt_revolver
	extra_to_spawn = /obj/item/ammo_box/c10mm/speedloader/rubber

/obj/item/storage/toolbox/guncase/skyrat/nt_glock/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/c10mm/speedloader = 2,
	), src)

