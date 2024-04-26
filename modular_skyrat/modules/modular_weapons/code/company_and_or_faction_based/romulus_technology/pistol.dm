//Pistol, Handguns and Revolvers
//Now improved

/obj/item/gun/ballistic/revolver/hos_revolver
	name = "\improper HR-460MS"
	desc = "An experimental revolver design that can only be loaded one shot at a time, if the initial damage did not kill, the bleedout would. Chambered in .457 Government."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rowland
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/revolver.dmi'
	icon_state = "microtracker"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_heavy.ogg'

/obj/item/gun/ballistic/revolver/hos_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

//PLease keep this in
/obj/item/ammo_box/magazine/internal/cylinder/rowland
	name = "\improper rowland revolver cylinder"
	max_ammo = 5
	ammo_type = /obj/item/ammo_casing/c457govt
	caliber = CALIBER_457GOVT

/obj/item/gun/ballistic/revolver/hos_revolver/long
	name = "\improper HR-460LR"
	desc = "A long unwiedly revolver from Romulus Technology. chambered in the rare .457 Government. You might be able to kill someone by whacking it over the head"
	icon_state = "tracker"
	force = 15

/obj/item/storage/bag/b460reloadpouch
	name = "reload pouch"
	desc = "A pouch for holding loose casings for .357 ammo and .457 ammo. incompatible with anything else. Fit on your belt too"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/pouches.dmi'
	icon_state = "reloadpouch"
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/romulus_technology/guns_worn.dmi'
	worn_icon_state = ""

/obj/item/storage/bag/b460reloadpouch/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 35
	atom_storage.max_slots = 35
	atom_storage.numerical_stacking = TRUE
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/c457govt,
		/obj/item/ammo_casing/a357,
	))

/obj/item/storage/bag/b460reloadpouch/PopulateContents()
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)
	new /obj/item/ammo_casing/c457govt(src)

/obj/item/storage/toolbox/guncase/skyrat/hos_revolver
	name = "heavy revolver .457"

/obj/item/storage/toolbox/guncase/skyrat/hos_revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hos_revolver(src)
	new /obj/item/storage/bag/b460reloadpouch(src)

/obj/item/gun/ballistic/automatic/pistol/m1911/gold
	name = "gold trimmed m1911"
	desc = "A classic .460 ceres handgun with a small magazine capacity. Now trimmed in gold"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/pistol.dmi'
	icon_state = "m1911"

/obj/item/gun/ballistic/automatic/pistol/m1911/gold/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/storage/toolbox/guncase/skyrat/m45a5
	name = "heavy pistol .460 magnum"

/obj/item/storage/toolbox/guncase/skyrat/m45a5/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)

/obj/item/gun/ballistic/automatic/pistol/m45a5
	name = "m45a5"
	desc = "A standard issue pistol given to officers in Romulus Federation, chambered in .460 Rowland Magnum, now commonly found in the hands of high ranking NanotTrasen Staff"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/pistol.dmi'
	icon_state = "m45a5"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_heavy.ogg'
	force = 15

	special_mags = TRUE

	accepted_magazine_type = /obj/item/ammo_box/magazine/m45a5
	spawn_magazine_type = /obj/item/ammo_box/magazine/m45a5

/obj/item/gun/ballistic/automatic/pistol/m45a5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ROMTECH)

/obj/item/gun/ballistic/automatic/pistol/m45a5/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/m45a5/examine_more(mob/user)
	. = ..()

	. += "This Design was made by Romulus Technology for \
		usage during the start of the NRI-Sol Border war. \
		Following the embargo and trade restriction \
		making it impossible for Romulus Federation to source weapory, \
		with this design being rapidly pushed out, being made from an advanced sol design \
		this pistol seems rather unassuming but it has been, itself, the new symbol of peace  \
		Leaving NRI weapon in the past, as it now became the symbol of the oppressive era of Romulus\
		To whom it may concerns, These weapon were mostly used by the new Romulus National Army,\
		 it was a symbol of struggle and freedom \
		Weapons cannot bring people back, but it can save your life."

	return .
