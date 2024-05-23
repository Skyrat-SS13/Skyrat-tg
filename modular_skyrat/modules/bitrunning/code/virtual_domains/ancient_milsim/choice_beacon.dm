/obj/item/choice_beacon/ancient_milsim
	name = "early access equipment beacon"
	desc = "Summon a gear closet for your contributions in the early access testing. Synchronises with the current game version to give you the most up-to-date class equipment."
	company_source = "'Time Of Valor 2' development team"
	company_message = span_bold("Thanks, and have fun!")

/obj/item/choice_beacon/ancient_milsim/generate_display_names()
	var/static/list/gear_options
	if(!gear_options)
		gear_options = list()
		for(var/obj/structure/closet/crate/secure/weapon/milsim/crate as anything in subtypesof(/obj/structure/closet/crate/secure/weapon/milsim))
			gear_options[initial(crate.name)] = crate
	return gear_options

/obj/structure/closet/crate/secure/weapon/milsim/after_open()
	qdel(src)

/obj/structure/closet/crate/secure/weapon/milsim/mechanic
	name = "mechanic loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/mechanic/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/sol/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/responsory/milsim_mechanic(src)

/obj/structure/closet/crate/secure/weapon/milsim/marksman
	name = "marksman loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/marksman/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/sol/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/responsory/milsim_marksman(src)

/obj/structure/closet/crate/secure/weapon/milsim/medic
	name = "medic loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/medic/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/sol/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/responsory/milsim_medic(src)

/obj/structure/closet/crate/secure/weapon/milsim/trapper
	name = "trapper loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/trapper/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/sol/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/responsory/milsim_trapper(src)
