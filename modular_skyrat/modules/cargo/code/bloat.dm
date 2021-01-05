//These are currently code in as a complete fucking mess. Remind me to organize later. Courtesy of ZenithEevee

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Armory //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/security/armory/riotshotguns
	name = "Peacekeeper Shotgun Crate"
	desc = "For when the peace needs kept, and you're all out of gum. Contains 3 Peacekeeper shotguns and some non-lethal shells."
	cost = CARGO_CRATE_VALUE * 13.25
	contains = list(/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/storage/box/beanbag,
					/obj/item/storage/box/rubbershot)
	crate_name = "peacekeeper shotgun crate"

/datum/supply_pack/security/armory/woodstock
	name = "Woodstock Originals Crate"
	desc = "For when Oldschool is Cool... Or the Bartender looses their gun. again. Contains 3 woodstock shotguns"
	cost = CARGO_CRATE_VALUE * 9.5
	contains = list(/obj/item/gun/ballistic/shotgun,
					/obj/item/gun/ballistic/shotgun,
					/obj/item/gun/ballistic/shotgun)
	crate_name = "woodstock crate"

/datum/supply_pack/security/armory/wt550ammovariety
	name = "WT-550 Auto Rifle Ammo Variety Crate"
	desc = "AI Gone rogue and blow the Security Lathe? Anti-Corporate scum steal it? Doesn't matter, we got you covered. Contains 2 of each magazine type for the WT550 Auto Rifle."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtic,
					/obj/item/ammo_box/magazine/wt550m9/wtic)
	crate_name = "WT550 Ammo Variety Pack"

/datum/supply_pack/security/armory/mafia //I am a bit iffy on this one. The tommy gun has a fairly good shot-rate. Pack is designed to be used as a bundle of 22 5k briefcases, emag + agent ID with 2 TC to spare
	name = "Secretkeeper Supply Crate"
	desc = "Aye... Lend an ear... Send us the money, And we do you a favour... A Tommygun, a set of clothing to dissapear, and a bodybag for a... Shallow grave... Keep it a secret, Capiche?"
	hidden = TRUE
	cost = 100000 //this is going to stay 100000, As it is implied to be used with the traitor cash briefcase
	contains = list(/obj/item/gun/ballistic/automatic/tommygun,
					/obj/item/clothing/head/fedora,
					/obj/item/clothing/under/rank/civilian/bartender,
					/obj/item/clothing/accessory/waistcoat,
					/obj/item/clothing/neck/tie/black,
					/obj/item/clothing/shoes/jackboots,
					/obj/item/clothing/suit/det_suit/grey,
					/obj/item/clothing/mask/bandana/black,
					/obj/item/clothing/glasses/sunglasses,
					/obj/item/bodybag/bluespace)
	crate_name = "unmarked crate"
	crate_type = /obj/structure/closet/crate/secure/weapon

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Science /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/science/techshellpack
	name = "Techshell Value Pack"
	desc = "Are beanbags, rubbershot, lethals and slugs not doing it for you? This pack contains 3 boxes of 7 unloaded techshells, just begging to be loaded with various dangerous materials!"
	cost = CARGO_CRATE_VALUE * 10.5 //this should be rougly 2100 if my calculations are correct
	contains = list(/obj/item/storage/box/techshell,
					/obj/item/storage/box/techshell,
					/obj/item/storage/box/techshell)
	crate_name = "techshell value pack"
	crate_type = /obj/structure/closet/crate/science

//////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Service //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//disabled temporarily, expect to be back later.
/*
/datum/supply_pack/service/hydrohelper
	name = "Hydro-Helper Circuit Pack"
	desc = "Botany being lazy with something? Being refused circuit boards? Wanting to start your own Gaiatic garden? This pack contains 3 Hydroponic tray circuit boards, a biogenerator circuit board, and a seed extractor circuit board! (Parts and matterials not included)"
	cost = 1500
	contains = list(/obj/item/circuitboard/machine/hydroponics,
					/obj/item/circuitboard/machine/hydroponics,
					/obj/item/circuitboard/machine/hydroponics,
					/obj/item/circuitboard/machine/biogenerator,
					/obj/item/circuitboard/machine/seed_extractor)
	crate_name = "hydro-helper circuit pack"
	crate_type = /obj/structure/closet/crate/hydroponics
*/

//////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Goodies //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
/*
/datum/supply_pack/goody/wt550ammoic
	name = "WT-550 Auto Rifle Incendiary Ammo Single Pack"
	desc = "Contains a 20-round magazine of Incendiary bullets for the WT-550 Auto Rifle. Just dont tell anyone you bought this."
	cost = PAYCHECK_HARD * 7
	contraband = TRUE
	contains = list(/obj/item/ammo_box/magazine/wt550m9/wtic)

/datum/supply_pack/goody/wt550ammoap
	name = "WT-550 Auto Rifle Armor-Piercing Ammo Single Pack"
	desc = "Contains a 20-round magazine of Armor-Piercing bullets for the WT-550 Auto Rifle. Just dont tell anyone you bought this."
	cost = PAYCHECK_HARD * 7
	contraband = TRUE
	contains = list(/obj/item/ammo_box/magazine/wt550m9/wtap)

/datum/supply_pack/goody/techbox
	name = "Techshell Single Pack"
	desc = "Are beanbags, rubbershot, lethals and slugs not doing it for you? This contains 1 box of 7 unloaded techshells. Have fun wrecking havoc!"
	cost = PAYCHECK_HARD * 8.5
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/techshell)

*/
