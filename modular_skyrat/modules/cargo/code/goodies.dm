//////////////////////////////////////////////////////////////////////////////
//////////////////////// Emergency Race Stuff ////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/goody/airsuppliesnitrogen
	name = "Emergency Air Supplies (Nitrogen)"
	desc = "A vox breathing mask and nitrogen tank."
	cost = PAYCHECK_MEDIUM
	contains = list(/obj/item/tank/internals/nitrogen/belt,
                    /obj/item/clothing/mask/breath/vox)

/datum/supply_pack/goody/airsuppliesoxygen
	name = "Emergency Air Supplies (Oxygen)"
	desc = "A breathing mask and emergency oxygen tank."
	cost = PAYCHECK_MEDIUM
	contains = list(/obj/item/tank/internals/emergency_oxygen,
                    /obj/item/clothing/mask/breath)

/datum/supply_pack/goody/airsuppliesplasma
	name = "Emergency Air Supplies (Plasma)"
	desc = "A breathing mask and plasmaman plasma tank."
	cost = PAYCHECK_MEDIUM
	contains = list(/obj/item/tank/internals/plasmaman/belt,
                    /obj/item/clothing/mask/breath)

//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Misc Stuff /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/goody/crayons
	name = "Box of Crayons"
	desc = "Colorful!"
	cost = PAYCHECK_MEDIUM * 2
	contains = list(/obj/item/storage/crayons)

/datum/supply_pack/goody/diamondring
	name = "Diamond Ring"
	desc = "Show them your love is like a diamond: unbreakable and everlasting. No refunds."
	cost = PAYCHECK_MEDIUM * 50
	contains = list(/obj/item/storage/fancy/ringbox/diamond)
	crate_name = "diamond ring crate"

/datum/supply_pack/goody/paperbin
	name = "Paper Bin"
	desc = "Pushing paperwork is always easier when you have paper to push!"
	cost = PAYCHECK_MEDIUM * 4
	contains = list(/obj/item/paper_bin)

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Weapons or Ammo /////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/goody/wt550_single
	name = "WT-550 Auto Rifle Single-Pack"
	desc = "Contains one high-powered, semiautomatic rifle chambered in 4.6x30mm." // "high-powered" lol yea right
	cost = PAYCHECK_HARD * 20
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/automatic/wt550)

/datum/supply_pack/goody/wt550ammo_single
	name = "WT-550 Auto Rifle Ammo Single-Pack"
	desc = "Contains a 20-round magazine for the WT-550 Auto Rifle. Each magazine is designed to facilitate rapid tactical reloads."
	cost = PAYCHECK_HARD * 6
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/ammo_box/magazine/wt550m9)

/datum/supply_pack/goody/makarov
	name = "Makarov Self Defense Pistol"
	desc = "A small, slow firing and low capacity pistol, but hey, it's better then a crowbar, right? (Does not include a weapons permit.)"
	cost = PAYCHECK_MEDIUM * 28
	contains = list(/obj/item/storage/box/gunset/makarov)

/datum/supply_pack/goody/makarov_ammo
	name = "Makarov Ammo Resupply"
	desc = "An ammobox and a few spare magazines for a Makarov 10mm self defense pistol, for self defense, of course."
	cost = PAYCHECK_MEDIUM * 8
	contains = list(/obj/item/ammo_box/advanced/b10mm,
					/obj/item/ammo_box/magazine/multi_sprite/makarov,
					/obj/item/ammo_box/magazine/multi_sprite/makarov)

/datum/supply_pack/goody/pepperball
	name = "PepperBall Self Defense Weapon"
	desc = "A 'state of the art' self defense weapon, firing balls of condensed pepperspray, don't aim for the face. Weapons permit not included."
	cost = PAYCHECK_MEDIUM * 17
	contains = list(/obj/item/storage/box/gunset/pepperball)

/datum/supply_pack/goody/pepperball_ammo
	name = "PepperBall Ammo Resupply"
	desc = "An ammobox and a few spare magazines for a PepperBall self defense weapon, in case you run out."
	cost = PAYCHECK_MEDIUM * 6
	contains = list(/obj/item/ammo_box/advanced/pepperballs,
					/obj/item/ammo_box/magazine/pepperball,
					/obj/item/ammo_box/magazine/pepperball)

/datum/supply_pack/goody/gunmaint
	name = "Gun Maintenance Kits"
	desc = "Keep your pa's rifle in best condition, with two sets of cleaning supplies. Or your standard issue pistol if you're an itchy trigger, we're not here to judge."
	cost = PAYCHECK_MEDIUM * 3
	contains = list(/obj/item/gun_maintenance_supplies,
					/obj/item/gun_maintenance_supplies)

/datum/supply_pack/goody/mcr_single
	name = "MCR-01 Microfusion Single-Pack"
	desc = "Contains one advanced Micron Control Systems Incorporated supplied MCR-01 Microfusion weapons platform."
	cost = PAYCHECK_HARD * 22
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/microfusion/mcr01/advanced)

/datum/supply_pack/goody/mcrammo_single
	name = "Microfusion Cell Single-Pack"
	desc = "Contains a box of three Microfusion cells, compatible with all MCR-01 Microfusion weapons."
	cost = PAYCHECK_HARD * 6
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/box/ammo_box/microfusion/advanced)

/datum/supply_pack/goody/wildcat_single
	name = "CFA Wildcat Single-Pack"
	desc = "Contains one Cantalan Federal Arms Wildcat Sub Machine Gun, chambered in .32 caliber."
	cost = PAYCHECK_HARD * 8
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/automatic/cfa_wildcat)

/datum/supply_pack/goody/wildcatammo_single
	name = "CFA Wildcat Ammo Single-Pack"
	desc = "Contains a 30-round magazine for the CFA Wildcat."
	cost = PAYCHECK_HARD * 4
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat)

/datum/supply_pack/goody/temp_single
	name = "Temperature Gun Kit Single-Pack"
	desc = "Contains a gunkit for a temperature gun, usable on an Allstar SC-2 Laser Carbine to convert it into firing temperature-affecting shots instead of lasers."
	cost = PAYCHECK_MEDIUM * 2
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/weaponcrafting/gunkit/temperature)

/datum/supply_pack/goody/croon_single
	name = "Croon Single-Pack"
	desc = "Contains one Croon Sub Machine Gun chambered in 6.3mm, not exactly reliable... but it'll do you okay."
	cost = PAYCHECK_HARD * 10
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/ballistic/automatic/croon)
	contraband = TRUE

/datum/supply_pack/goody/croonammo_single
	name = "Croon Ammo Single-Pack"
	desc = "Contains a 15-round magazine for the Croon SMG."
	cost = PAYCHECK_HARD * 3
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/ammo_box/magazine/multi_sprite/croon)
	contraband = TRUE

/datum/supply_pack/goody/lasergun_single
	name = "Allstar SC-1 Single-Pack"
	desc = "Contains one Allstar Lasers SC-1 laser gun."
	cost = PAYCHECK_HARD * 10
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/gun/energy/laser)

/datum/supply_pack/goody/cmg
	name = "NT CMG-1 Single-kit"
	desc = "Contains a single CMG-1 Weapons kit"
	cost = PAYCHECK_HARD * 10
	access_view = ACCESS_ARMORY
	contains = list(
		/obj/item/storage/box/gunset/cmg,
		)

/datum/supply_pack/goody/cmg_lethal_ammo
	name = "NT CMG-1 Lethal Ammo"
	desc = "Contains 3 24-round lethal CMG-1 magazines."
	cost = PAYCHECK_HARD * 15
	access_view = ACCESS_ARMORY
	contains = list(
		/obj/item/ammo_box/magazine/cmgm45,
		/obj/item/ammo_box/magazine/cmgm45,
		/obj/item/ammo_box/magazine/cmgm45,
	)

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Carpet Packs ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/goody/carpet
	name = "Classic Carpet Single-Pack"
	desc = "Plasteel floor tiles getting on your nerves? This 50 units stack of extra soft carpet will tie any room together."
	cost = PAYCHECK_MEDIUM * 3
	contains = list(/obj/item/stack/tile/carpet/fifty)

/datum/supply_pack/goody/carpet/black
	name = "Black Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/black/fifty)

/datum/supply_pack/goody/carpet/premium
	name = "Royal Black Carpet Single-Pack"
	desc = "Exotic carpets for all your decorating needs. This 50 unit stack of extra soft carpet will tie any room together."
	cost = PAYCHECK_MEDIUM * 3.5
	contains = list(/obj/item/stack/tile/carpet/royalblack/fifty)

/datum/supply_pack/goody/carpet/premium/royalblue
	name = "Royal Blue Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/royalblue/fifty)

/datum/supply_pack/goody/carpet/premium/red
	name = "Red Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/red/fifty)

/datum/supply_pack/goody/carpet/premium/purple
	name = "Purple Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/purple/fifty)

/datum/supply_pack/goody/carpet/premium/orange
	name = "Orange Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/orange/fifty)

/datum/supply_pack/goody/carpet/premium/green
	name = "Green Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/green/fifty)

/datum/supply_pack/goody/carpet/premium/cyan
	name = "Cyan Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/cyan/fifty)

/datum/supply_pack/goody/carpet/premium/blue
	name = "Blue Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/blue/fifty)

