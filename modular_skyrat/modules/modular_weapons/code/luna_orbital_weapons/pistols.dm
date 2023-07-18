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

	suppressor_x_offset = 9
	suppressor_y_offset = 0

	fire_delay = 2

/obj/item/gun/ballistic/automatic/pistol/luna/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_LUNA)

/obj/item/gun/ballistic/automatic/pistol/luna/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

/obj/item/gun/ballistic/automatic/pistol/luna/examine_more(mob/user)
	. = ..()

	. += "The Luna Orbital servopistolo line, built to meet the requirements set out \
		by the SolFed department of defense for a new military service pistol. The requirements \
		of an interstellar military force are complex and strict, though there are two more important than the rest. \
		The new weapon was to use the newly developed .35 Sol Short caseless ammunition, \
		and had to have the reliability to function without failure in just about any environment \
		SolFed forces may find themselves in. The resulting weapon is what you look at now, \
		in consistent use by SolFed militaries and police forces since 2557."

	return .

/obj/item/gun/ballistic/automatic/pistol/luna/no_mag
	spawnwithmagazine = FALSE

// Police pistol

/obj/item/gun/ballistic/automatic/pistol/luna/police
	name = "\improper Luno 'Anglofiŝo-P' Peacekeeper Pistol"
	desc = "The standard issue service pistol of SolFed's various peacekeeping forces. Comes with attached light."

	icon_state = "anglofiso_police"

/obj/item/gun/ballistic/automatic/pistol/luna/police/no_mag
	spawnwithmagazine = FALSE

// Police glockinator

/obj/item/gun/ballistic/automatic/pistol/luna/police/glockinator
	name = "\improper Luno 'Kirasfiŝo' Peacekeeper Pistol"
	desc = "A modificaiton of the standard Luno peacekeeper pistol. It has a higher firerate and automatic fire capability. Due to the fact it expends some of the fired round's gas to accelerate fire, some lethality is lost."

	icon_state = "kirasfiso"

	projectile_damage_multiplier = 0.8 // Makes it exactly 20 damage per normal round

	fire_delay = 1.8
	spread = 10

	suppressor_x_offset = 11

	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/gun/ballistic/automatic/pistol/luna/police/glockinator/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/pistol/luna/police/glockinator/examine_more(mob/user)
	. = ..()

	. += "This particular variant is modified significantly from standard pistol models, \
		Of note, featuring automatic fire capability and heavier construction. It is used mostly \
		by police forces, with most variants made to arm companies like Lopland Securities."

	return .

/obj/item/gun/ballistic/automatic/pistol/luna/police/glockinator/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/luna/pocket
	name = "\improper Luno 'Puffiŝo' Pocket Pistol"
	desc = "A significantly smaller version of the modern Luno pistol line. For the price of lower power, you too can have a pistol in your pocket."

	icon_state = "puffiso"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/pistol_small.ogg'

	w_class = WEIGHT_CLASS_SMALL

	projectile_damage_multiplier = 0.8 // Makes it exactly 20 damage per normal round

	suppressor_x_offset = 6

	spread = 7

/obj/item/gun/ballistic/automatic/pistol/luna/pocket/add_seclight_point()
	return

/obj/item/gun/ballistic/automatic/pistol/luna/pocket/examine_more(mob/user)
	. = ..()

	. += "This particular variant is modified significantly from standard pistol models, \
		Of note, it is significantly smaller than its counterparts. This decreased size \
		allows it to be easily concealed, making it a popular self defense option in Sol \
		space."

	return .

/obj/item/gun/ballistic/automatic/pistol/luna/pocket/no_mag
	spawnwithmagazine = FALSE

// Magazines

/obj/item/ammo_box/magazine/c35sol_pistol
	name = "\improper Luno pistol magazine"
	desc = "A standard size magazine for Luno pistols, holds nine rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "pistolstandard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 9

/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c35sol_pistol/stendo
	name = "\improper Luno extended pistol magazine"
	desc = "An extended magazine for Luno pistols, holds eighteen rounds."

	icon_state = "pistolstendo"

	max_ammo = 18

/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty
	start_empty = TRUE
