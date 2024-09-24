//Handgun


/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/nt_glock
	name = "9x25mm Mk12 Standard Pistol"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/nt_glock/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/nt_glock/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm/ihdf = 2,
		/obj/item/ammo_box/magazine/m9mm/rubber = 3,
	), src)

/obj/item/gun/ballistic/automatic/pistol/nt_glock
	name = "\improper GP-9"
	desc = "General Purpose Pistol Number 9. A classic 9x25mm handgun with a small magazine capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "black"
	w_class = WEIGHT_CLASS_NORMAL
	spread = 10
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	pin = /obj/item/firing_pin
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/rubber
	suppressor_x_offset = -2
	suppressor_y_offset = -1

/obj/item/gun/ballistic/automatic/pistol/nt_glock/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/pistol/nt_glock/empty
	spawnwithmagazine = FALSE


/obj/item/storage/toolbox/guncase/skyrat/nt_glock_spec
	name = "9x25mm Mk2 Special Operation Pistol"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/nt_glock/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/nt_glock_spec/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm/stendo/hp = 2,
		/obj/item/ammo_box/magazine/m9mm/stendo/ap = 3,
	), src)

/obj/item/gun/ballistic/automatic/pistol/nt_glock/spec
	name = "\improper GP-93R"
	desc = "General Purpose Pistol Number 9, 3-Round Burst. A special operation variant with a high capacity magazine."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "silver"
	spread = 17
	pin = /obj/item/firing_pin
	fire_delay = 2
	burst_size = 3
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/stendo

//Magistrate Pistol

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/firefly
	name = "MX-7C Stun Pistol"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/firefly/empty

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/firefly/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/firefly = 3,
	), src)

/obj/item/gun/ballistic/automatic/pistol/firefly
	name = "\improper MX-7C 'Firefly'"
	desc = "NanoTrasen Experimental Model 7 Compact, A rare pistol chambered in a .117 electrode cartridge. It has has a small magazine capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "firefly"
	w_class = WEIGHT_CLASS_NORMAL
	spread = 10
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	pin = /obj/item/firing_pin
	spawn_magazine_type = /obj/item/ammo_box/magazine/firefly
	accepted_magazine_type = /obj/item/ammo_box/magazine/firefly
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/pistol/firefly/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/pistol/firefly/empty
	spawnwithmagazine = FALSE


// Revolver

/obj/item/gun/ballistic/revolver/nt_revolver
	name = "\improper R10"
	desc = "The Revolver Number 10. A rugged and reliable pistol chambered in 10mm Auto, holds 6 shot. Remember our promise"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "zeta"
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/nt_sec
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/nt_sec

/obj/item/gun/ballistic/revolver/nt_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/nt_revolver
	name = "10mm Auto Standard Revolver"

	weapon_to_spawn = /obj/item/gun/ballistic/revolver/nt_revolver

/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/nt_revolver/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/c10mm/speedloader = 2,
		/obj/item/ammo_box/c10mm/speedloader/rubber = 3,
	), src)

