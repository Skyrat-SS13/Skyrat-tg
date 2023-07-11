// Military pistol

/obj/item/gun/ballistic/automatic/pistol/luna
	name = "\improper Luno 'Anglofiŝo' Service Pistol"
	desc = "The standard issue service pistol of SolFed's various military branches. Comes with attached light."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_32.dmi'
	icon_state = "anglofiso"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/pistol_large.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	mag_type = /obj/item/ammo_box/magazine/c35sol_pistol
	special_mags = TRUE

	fire_delay = 2

/obj/item/gun/ballistic/automatic/pistol/luna/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

// Police pistol

/obj/item/gun/ballistic/automatic/pistol/luna/police
	name = "\improper Luno 'Anglofiŝo-P' Peacekeeper Pistol"
	desc = "The standard issue service pistol of SolFed's various peacekeeping forces. Comes with attached light."

	icon_state = "anglofiso_police"

// Police glockinator

/obj/item/gun/ballistic/automatic/pistol/luna/police
	name = "\improper Luno 'Kirasfiŝo' Peacekeeper Pistol"
	desc = "A modificaiton of the standard Luno peacekeeper pistol. It has a higher firerate and a burst selector. Due to the fact it expends some of the fired round's gas to accelerate fire, some lethality is lost."

	icon_state = "kirasfiso"

	projectile_damage_multiplier = 0.72 // Makes it exactly 18 damage per normal round, rather than 25

	burst_size = 3
	fire_delay = 1.75
	spread = 5

	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/gun/ballistic/automatic/pistol/luna/pocket
	name = "\improper Luno 'Puffiŝo' Pocket Pistol"
	desc = "A significantly smaller version of the modern Luno pistol line. For the price of lower power, you too can have a pistol in your pocket."

	icon_state = "puffiso"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/pistol_small.ogg'

	projectile_damage_multiplier = 0.8 // Makes it exactly 20 damage per normal round

/obj/item/gun/ballistic/automatic/pistol/luna/pocket/add_seclight_point()
	return

// Magazines

/obj/item/ammo_box/magazine/c35sol_pistol
	name = "\improper Luno pistol magazine"
	desc = "A standard size magazine for the Luno 'Anglofiŝo', holds nine rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "pistolstandard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 9

/obj/item/ammo_box/magazine/c35sol_pistol
	name = "\improper Luno extended pistol magazine"
	desc = "An extended magazine for the Luno 'Anglofiŝo', holds eighteen rounds."

	icon_state = "pistolstendo"

	max_ammo = 18
