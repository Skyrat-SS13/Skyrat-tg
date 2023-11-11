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

/obj/structure/closet/crate/secure/weapon/milsim/mecha
	name = "mechanic loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/mecha/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/trappiste(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/contractor/ancient_milsim(src)
	new /obj/item/storage/belt/utility/full/powertools(src)
	new /obj/item/book/granter/action/spell/charge(src)
	new /obj/vehicle/sealed/mecha/gygax/ancient_milsim/loaded(src)

/obj/structure/closet/crate/secure/weapon/milsim/marksman
	name = "marksman loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/marksman/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/sol_rifle/marksman(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)
	new /obj/item/gun/ballistic/automatic/pistol/sol/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/stealth_operative/ancient_milsim(src)

/obj/structure/closet/crate/secure/weapon/milsim/medic
	name = "medic loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/medic/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/sol_smg/evil(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol/stendo(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/gun/energy/cell_loaded/medigun/cmo(src)
	new /obj/item/weaponcell/medical/brute/tier_3(src)
	new /obj/item/weaponcell/medical/burn/tier_3(src)
	new /obj/item/weaponcell/medical/oxygen/tier_3(src)
	new /obj/item/weaponcell/medical/utility/salve(src)
	new /obj/item/weaponcell/medical/utility/clotting(src)
	new /obj/item/weaponcell/medical/utility/temperature(src)
	new /obj/item/storage/medkit/tactical(src)
	new /obj/item/mod/control/pre_equipped/responsory/ancient_milsim(src)

/obj/structure/closet/crate/secure/weapon/milsim/trapper
	name = "trapper loadout crate"

/obj/structure/closet/crate/secure/weapon/milsim/trapper/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/shotgun/automatic/combat(src)
	new /obj/item/storage/box/ammo_box/shotgun_12g(src)
	new /obj/item/storage/box/ammo_box/shotgun_12g(src)
	new /obj/item/gun/ballistic/automatic/pistol(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/mod/control/pre_equipped/policing/ancient_milsim(src)
