//While I could also just, make it a subtype, I prefer to keep it seperate incase I need to switch later

/obj/item/gun/ballistic/automatic/rom_smg
	name = "\improper RomTech Submachine gun"
	desc = "A horrible conversion kit of the sindano only seen in usage by PMC and in Romulus Police Force. Accepts any standard Sol pistol magazine."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/gun40x32.dmi'
	icon_state = "gelato"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_righthand.dmi'
	inhand_icon_state = "gelato"

	special_mags = TRUE

	bolt_type = BOLT_TYPE_OPEN

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	spawn_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE

	can_bayonet = FALSE

	suppressor_x_offset = 11

	burst_size = 2
	fire_delay = 0.1 SECONDS

	spread = 4

/obj/item/gun/ballistic/automatic/gelato/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

//Does not have additional examine text.. Yet
