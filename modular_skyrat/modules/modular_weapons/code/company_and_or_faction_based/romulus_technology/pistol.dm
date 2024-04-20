//Pistol, Handguns and Revolvers


#define AMMO_GIVEN_ON_START 24
//Now improved

/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS"
	desc = "A large unwiedly revolver developed by Romulus Technology  prior to destruction of the planet, if the initial damage did not kill, the bleedout would. Uses the brutal .460 Rowland ammo."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rowland
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/revolver.dmi'
	icon_state = "microtracker"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'

/obj/item/ammo_box/magazine/internal/cylinder/rowland
	name = "\improper rowland revolver cylinder"
	max_ammo = 6

/obj/item/gun/ballistic/revolver/hos_revolver/long
	name = "\improper HR-460LR"
	desc = "A long unwiedly revolver from Romulus Technology. chambered in the rare .460 Rowland. You might be able to kill someone by whacking it over the head"
	icon_state = "tracker"
	force = 15

/obj/item/storage/bag/b460reloadpouch
	name = "reload pouch"
	desc = "A pouch for holding loose casings for .460 Rowland ammo. incompatible with anything else. Fit on your belt too"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/pouches.dmi'
	icon_state = "reloadpouch"
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/b460reloadpouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 30
	atom_storage.max_slots = 30
	atom_storage.numerical_stacking = TRUE

/obj/item/storage/toolbox/guncase/skyrat/pistol/hos_revolver
	name = "heavy revolver .460"

/obj/item/storage/toolbox/guncase/skyrat/pistol/hos_revolver/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/hos_revolver(src)
	new /obj/item/storage/bag/b460reloadpouch(src)

/obj/item/gun/ballistic/automatic/pistol/m1911/gold
	name = "gold trimmed m1911"
	desc = "A classic .45 handgun with a small magazine capacity. Now trimmed in gold"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/pistol.dmi'
	icon_state = "m1911"

#undef AMMO_GIVEN_ON_START
