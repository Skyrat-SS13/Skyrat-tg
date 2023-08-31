// Base yellow carwo case

/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case
	desc = "A thick yellow gun case with foam inserts laid out to fit a weapon, magazines, and gear securely."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "case_carwo"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_righthand.dmi'
	inhand_icon_state = "yellowcase"

	material_flags = NONE

// Sindano in a box, how innovative!

/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano
	name = "\improper Carwo 'Sindano' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_smg/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty

/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano/PopulateContents()
	. = ..()

	generate_items_inside(list(
		/obj/item/ammo_box/c35sol/incapacitator = 1,
		/obj/item/ammo_box/c35sol = 1,
	),src)

// Boxed grenade launcher, grenades sold seperately on this one

/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/kiboko_magless
	name = "\improper Carwo 'Kiboko' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c980_grenade/starts_empty

/obj/structure/closet/crate/large/import/armory_grenade_launcher
	name = "\improper Security Heavy Weapons Crate"
	desc = "Its covered in shipping labels and instructions regarding the use of a <b>crowbar</b> to open it. It looks like it was dropped several times during shipping."

/obj/structure/closet/crate/large/import/armory_grenade_launcher/PopulateContents()
	. = ..()

	new /obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/kiboko_magless(src)
	new /obj/item/ammo_box/c980grenade(src)
	new /obj/item/ammo_box/c980grenade(src)
	new /obj/item/ammo_box/c980grenade/smoke(src)
	new /obj/item/ammo_box/c980grenade/riot(src)
