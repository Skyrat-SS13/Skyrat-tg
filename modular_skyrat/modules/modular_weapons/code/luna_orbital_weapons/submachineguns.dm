// Military SMG

/obj/item/gun/ballistic/automatic/luna_pcc
	name = "\improper Luno 'Leonfiŝo' Submachinegun"
	desc = "A pistol caliber carbine modification of the Luno 'Spadfiŝo' rifle. Made for and used by SolFed's various military branches."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_48.dmi'
	icon_state = "leonfiso"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/worn.dmi'
	worn_icon_state = "military_smg"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/righthand.dmi'
	inhand_icon_state = "military_smg"

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

	mag_type = /obj/item/ammo_box/magazine/c35sol_smg

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/smg_heavy.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 7

	burst_size = 1
	fire_delay = 1
	actions_types = list()

/obj/item/gun/ballistic/automatic/luna_pcc/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/luna_pcc/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_LUNA)

/obj/item/gun/ballistic/automatic/luna_pcc/examine_more(mob/user)
	. = ..()

	. += "The Luno kompakta karabeno line is a series of submachineguns built off of \
		the SolFed standard military rifle. Being a pistol caliber conversion of the base \
		weapon, it is mechanically identical to its larger counterpart. The benefits of a \
		significantly smaller round is that the weapon can be made significantly smaller as well. \
		At nearly three quarters the length of even the short rifle, it finds popular use among \
		army medics and rear line personnel, as well as police forces. Has been in consistent use \
		by SolFed militaries and police forces since 2556"

	return .

// Police SMG

/obj/item/gun/ballistic/automatic/luna_pcc/police
	name = "\improper Luno 'Leonfiŝo-P' Peacekeeper Submachinegun"
	desc = "A pistol caliber carbine modification of the Luno 'Spadfiŝo' rifle. This variant is modified for use in SolFed's various peacekeeping forces."

	icon_state = "leonfiso_police"

	worn_icon_state = "police_smg"

	inhand_icon_state = "police_smg"

// Civilian (?) SMG

/obj/item/gun/ballistic/automatic/luna_pdw
	name = "\improper Luno 'Piranjo' Personal Defense Weapon"
	desc = "A small personal defense weapon capable of rapid two round bursts."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_32.dmi'
	icon_state = "piranjo"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/righthand.dmi'
	inhand_icon_state = "civilian_smg"

	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING

	mag_type = /obj/item/ammo_box/magazine/c35sol_smg

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/smg_light.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 13

	burst_size = 2
	fire_delay = 1

	recoil = 1

	spread = 10

/obj/item/gun/ballistic/automatic/luna_pdw/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_LUNA)

/obj/item/gun/ballistic/automatic/luna_pdw/examine_more(mob/user)
	. = ..()

	. += "The Luno 'Piranjo' is a civilian market personal defense weapon made for \
		anyone who'd need a compact defense weapon, and a pistol just wouldn't cut it \
		It is mechanically similar to SolFed military compact weapons, and even shares \
		caliber and magazines with them. Due to its extremely small size and collapsing \
		stock, it finds popular use by private security companies, ship crew, frontiersmen, \
		and other unsavory individuals."

	return .

/obj/item/gun/ballistic/automatic/luna_pdw/no_mag
	spawnwithmagazine = FALSE

// Magazine (singular)

/obj/item/ammo_box/magazine/c35sol_smg
	name = "\improper Luno submachinegun magazine"
	desc = "A standard size magazine for Luno submachineguns, holds twenty five rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "smgstandard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 27
