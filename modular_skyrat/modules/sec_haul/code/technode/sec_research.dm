//Security Technology
//Sol 35 mag

/datum/design/sol35_mag_pistol
	name = "Sol .35 Short Pistol Magazine"
	desc = "A magazine for compatible Sol .35 Short Weaponry."
	id = "sol35_shortmag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/sol35_mag_ext_pistol
	name = "Sol .35 Short Extended Pistol Magazine"
	desc = "An extended capacity magazine for compatible Sol .35 Short Weaponry."
	id = "sol35_shortextmag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

// Sol 40 Rifle
//These use plastic so they are still material costly, but should be not as bad

/datum/design/sol40_mag_rifle
	name = "Sol .40 Rifle Magazine"
	desc = "A short Sol .40 Rifle magazine for compatible Weaponry."
	id = "sol40_riflemag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/c40sol_rifle/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/sol40_mag_standard_rifle
	name = "Sol .40 Rifle Standard Magazine"
	desc = "A regular sized Sol .40 Rifle magazine for compatible Weaponry."
	id = "sol40_riflstandardemag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/sol40_mag_drum_rifle
	name = "Sol .40 Rifle Drum Magazine"
	desc = "A large drum Sol .40 Rifle magazine for compatible Weaponry."
	id = "sol40_rifldrummag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 40)
	build_path = /obj/item/ammo_box/magazine/c40sol_rifle/drum/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//Grenade Launcher stuff

/datum/design/kiboko_mag
	name = "Kiboko Grenade Magazine"
	desc = "A standard magazine for compatible grenade launcher."
	id = "solgrenade_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c980_grenade/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/kiboko_box_mag
	name = "Kiboko Grenade Box Magazine"
	desc = "An extended capacity box magazine for compatible grenade launcher."
	id = "solgrenade_extmag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//12 Gauge Ammunition Boxes
//This shit is a mistake but we embraced it instead of removing it, They all will require plastic to make alongside the iron cost
//I hate it

/datum/design/advancedgaugeboxes
	name = "12 Gauge Advanced Buckshot Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_buckshot"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/buckshot
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_slug
	name = "12 Gauge Advanced Slug Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_slug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_flech
	name = "12 Gauge Advanced Flechette Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_flechette"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 6, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/flechette
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_antitide
	name = "12 Gauge Advanced Anti Riot Ammunition Box(Non-Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_antitide"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/antitide
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_incinslug
	name = "12 Gauge Advanced Incendiary Slug Ammunition Box(Very Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_incinslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/incendiary
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_hornet
	name = "12 Gauge Advanced Hornet Ammunition Box(Less-Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_hornet"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/beehive
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_magnum
	name = "12 Gauge Advanced Magnum Ammunition Box(Very Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_magnum"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 35, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/magnum
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_express
	name = "12 Gauge Advanced Express Ammunition Box(Very Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_express"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/express
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_beanbagslug
	name = "12 Gauge Advanced Bean Bag Ammunition Box(Non-Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_bslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/bean
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_rubbershot
	name = "12 Gauge Advanced Rubber Shot Ammunition Box(Less-Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_db
	name = "12 Gauge Advanced Dragons Breath Ammunition Box(Very Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_db"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,  /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 15 , /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/dragonsbreath
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_breaching
	name = "12 Gauge Advanced Breaching Slug Ammunition Box(Destructive)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_br"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,  /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 35 , /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/breaching
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

// Misc Gun Stuff

/datum/design/m9mm_mag
	name = "9x25mm Mk2 Pistol Magazine(Lethal)"
	desc = "A standard magazine for pistol using 9x25mm Mk2."
	id = "m9mm_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12)
	build_path = /obj/item/ammo_box/magazine/m9mm
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_mag_rubber
	name = "9x25mm Mk2 Pistol Magazine(Less-Lethal)"
	desc = "A standard magazine for pistol using 9x25mm Mk2."
	id = "m9mm_mag_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/m9mm/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_mag_ihdf
	name = "9x25mm Mk2 Pistol Magazine(Non-Lethal)"
	desc = "A standard magazine for pistol using 9x25mm Mk2."
	id = "m9mm_mag_ihdf"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/m9mm/ihdf
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m45_mag
	name = ".460 Ceres Pistol Magazine(Lethal)"
	desc = "A standard magazine for pistol using .460 Ceres."
	id = "m45_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/casingfor457
	name = ".457 Government Casing (Very lethal)"
	desc = "A bullet casing for .457 Government."
	id = "c457_casing"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_casing/c457govt
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c10mm_r
	name = "10mm Auto Speedloader Rubber (Less lethal)"
	desc = "A speedloader in 10mm Auto."
	id = "c10mm_r"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15)
	build_path = /obj/item/ammo_box/c10mm/speedloader/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c10mm_rl
	name = "10mm Auto Speedloader (lethal)"
	desc = "A speedloader in 10mm Auto."
	id = "c10mm_rl"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15)
	build_path = /obj/item/ammo_box/c10mm/speedloader
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//Conversion Kit

/datum/design/sol_rifle_carbine_kit
	name = "Sol Carbine Conversion Part Kit(Very Lethal)"
	desc = "The kit to brutalise your functional battle rifle into a short carbine, ideal for close quarter."
	id = "sol_rifle_carbine_gun"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/plastic =SHEET_MATERIAL_AMOUNT * 3.5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/sol_rifle_carbine_kit
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/sol_smg_rapidfire_kit
	name = "Romulus SMG Twin-Burst Conversion Kit(Very Lethal)"
	desc = "The kit to brutalise your functional submachine gun into a monstrosity that fires in two round-burst at a faster rate."
	id = "sol_smg_rapidfire_kit"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/plastic =SHEET_MATERIAL_AMOUNT * 3.5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcrafting/gunkit/sol_smg_rapidfire_kit
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_KITS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE
