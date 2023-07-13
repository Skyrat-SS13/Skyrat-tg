// Luna Orbital branded guncase

/obj/item/storage/box/gunset/luna
	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/gunsets.dmi'

/obj/item/storage/box/gunset/luna/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/manufacturer_examine, COMPANY_LUNA)

/obj/item/storage/box/gunset/luna/small
	icon_state = "guncase_s"

	w_class = WEIGHT_CLASS_NORMAL

// Normal police pistol

/obj/item/storage/box/gunset/luna/small/luna_police_pistol
	name = "Luno 'Anglofiŝo-P' supply box"

/obj/item/storage/box/gunset/luna/small/luna_police_pistol/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/luna/police/no_mag(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)

// Police glockinator (for the HoS)

/obj/item/storage/box/gunset/luna/small/luna_glockinator
	name = "Luno 'Kirasfiŝo' supply box"

/obj/item/storage/box/gunset/luna/small/luna_glockinator/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/luna/police/glockinator/no_mag(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty(src)
	new /obj/item/ammo_box/c35sol(src)
	new /obj/item/ammo_box/c35sol/incapacitator(src)
