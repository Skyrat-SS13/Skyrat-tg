/// Cost of the crate. DO NOT GO ANY LOWER THAN X1.4 the "CARGO_CRATE_VALUE" value if using regular crates, or infinite profit will be possible!

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////// Livestock ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/critter/doublecrab
	name = "Crab Crate"
	desc = "Contains two crabs. Get your crab on!"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/simple_animal/crab,
                    /mob/living/simple_animal/crab)
	crate_name = "look sir free crabs"

/datum/supply_pack/critter/mouse
	name = "Mouse Crate"
	desc = "Good for snakes and lizards of all ages. Contains six feeder mice."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/mob/living/simple_animal/mouse,)
	crate_name = "mouse crate"

/datum/supply_pack/critter/mouse/generate()
	. = ..()
	for(var/i in 1 to 5)
		new /mob/living/simple_animal/mouse(.)

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////// Medical /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/medical/anesthetics
	name = "Anesthetics Crate"
	desc = "Contains two of the following: Morphine bottles, syringes, breath masks, and anesthetic tanks. Requires Medical Access to open."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/reagent_containers/glass/bottle/morphine,
                    /obj/item/reagent_containers/glass/bottle/morphine,
                    /obj/item/reagent_containers/syringe,
                    /obj/item/reagent_containers/syringe,
                    /obj/item/clothing/mask/breath,
                    /obj/item/clothing/mask/breath,
                    /obj/item/tank/internals/anesthetic,
                    /obj/item/tank/internals/anesthetic,)
	crate_name = "anesthetics crate"

/datum/supply_pack/medical/bodybags
	name = "Bodybags"
	desc = "For when the bodies hit the floor. Contains 4 boxes of bodybags."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,)
	crate_name = "bodybag crate"

/datum/supply_pack/medical/firstaidmixed
	name = "Mixed Medical Kits"
	desc = "Contains one of each medical kits for dealing with a variety of injured crewmembers."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/storage/firstaid/toxin,
					/obj/item/storage/firstaid/o2,
					/obj/item/storage/firstaid/brute,
					/obj/item/storage/firstaid/fire,
					/obj/item/storage/firstaid/regular)
	crate_name = "medical kit crate"

/datum/supply_pack/medical/medipens
	name = "Epinephrine Medipens"
	desc = "Contains two boxes of epinephrine medipens. Each box contains seven pens."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/storage/box/medipens,
                    /obj/item/storage/box/medipens)
	crate_name = "medipen crate"

/datum/supply_pack/medical/hardsuit_medical
	name = "Medical Hardsuit Crate"
	desc = "Contains a single hardsuit, built to standard medical specifications."
	cost = CARGO_CRATE_VALUE * 13
	access = ACCESS_MEDICAL
	contains = list(/obj/item/clothing/suit/space/hardsuit/medical)
	crate_name = "medical hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure //No medical varient with security locks.

/datum/supply_pack/medical/compact_defib
	name = "Compact Defibrillator Crate"
	desc = "Contains a single compact defibrillator. Capable of being worn as a belt."
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_MEDICAL
	contains = list(/obj/item/defibrillator/compact)
	crate_name = "compact defibrillator crate"

/datum/supply_pack/medical/medigun
	name = "Experimental Medical Beam Crate"
	desc = "Contains a single experimental NT-tech Medical Beam Gun, a highly experimental device capable of sending temporary healing nanites across a short distance."
	cost = CARGO_CRATE_VALUE * 75
	access = ACCESS_CMO
	contains = list(/obj/item/gun/medbeam)
	crate_name = "medical beam gun crate"

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Security ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/security/hardsuit_security
	name = "Security Hardsuit Crate"
	desc = "Contains a single armored up hardsuit, built to standard security specifications."
	cost = CARGO_CRATE_VALUE * 16
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/clothing/suit/space/hardsuit/security)
	crate_name = "security hardsuit crate"

/datum/supply_pack/security/baton_peacekeeper
	name = "Batons Crate"
	desc = "Arm the Civil Protection Forces with three batons. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/melee/classic_baton/peacekeeper,
					/obj/item/melee/classic_baton/peacekeeper,
					/obj/item/melee/classic_baton/peacekeeper)
	crate_name = "baton crate"

/datum/supply_pack/security/croonsurplus
	name = "Croon Weapons Crate"
	desc = "Help out in a local revolt, or fund a civil war, it's not like you have a choice in supplier. (Comes with four magazines of ammo.)"
	cost = CARGO_CRATE_VALUE * 40
	contraband = TRUE
	contains = list(/obj/item/gun/ballistic/automatic/croon/nomag,
					/obj/item/gun/ballistic/automatic/croon/nomag,
					/obj/item/ammo_box/magazine/multi_sprite/croon,
					/obj/item/ammo_box/magazine/multi_sprite/croon,
					/obj/item/ammo_box/magazine/multi_sprite/croon,
					/obj/item/ammo_box/magazine/multi_sprite/croon)
	crate_name = "unmarked weapons crate"
	dangerous = TRUE
	
//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Engineering ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/engineering/industrial_rcd
	name = "Industrial RCD Crate"
	desc = "Manufactured at a high-tech NT production facility, this pack contains 2 industrial RCDs with expanded matter reserves and upgraded deconstructors. Requires CE Access to open."
	access = ACCESS_CE //These contain all upgrades and ~2.5x as much matter. The least we can do is lock it behind CE.
	contains = list(/obj/item/construction/rcd/combat,
					/obj/item/construction/rcd/combat)
	cost = CARGO_CRATE_VALUE * 40
	crate_name = "industrial RCD crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/* Removed pending rebalance
/datum/supply_pack/engineering/experimental_rcd
	name = "Experimental RCD Crate"
	desc = "Contains a single highly advanced RCD, capable of projecting its improved construction nanites at an increased range."
	access = ACCESS_CE
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/construction/rcd/arcd)
	cost = CARGO_CRATE_VALUE * 50
	crate_name = "experimental RCD crate"
*/

/datum/supply_pack/engineering/material_pouches
	name = "Material Pouches Crate"
	desc = "Contains three material pouches."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/storage/bag/material,
					/obj/item/storage/bag/material,
					/obj/item/storage/bag/material)
	cost = CARGO_CRATE_VALUE * 15
	crate_name = "material pouches crate"

/datum/supply_pack/engineering/doublecap_tanks
	name = "Double extended emergency tank Crate"
	desc = "Contains four double extended-capacity emergency tanks."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/tank/internals/emergency_oxygen/double,
					/obj/item/tank/internals/emergency_oxygen/double,
					/obj/item/tank/internals/emergency_oxygen/double,
					/obj/item/tank/internals/emergency_oxygen/double)
	cost = CARGO_CRATE_VALUE * 15
	crate_name = "double extended emergency tank crate"

/datum/supply_pack/engineering/advanced_extinguisher
	name = "Advanced Foam Extinguisher Crate"
	desc = "Contains advanced fire extinguishers which use foam as extinguishing agent."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/extinguisher/advanced,
					/obj/item/extinguisher/advanced,
					/obj/item/extinguisher/advanced)
	cost = CARGO_CRATE_VALUE * 18
	crate_name = "advanced extinguisher crate"

/datum/supply_pack/engineering/hardsuit_engineering
	name = "Engineering Hardsuit Crate"
	desc = "Contains a single hardsuit, built to standard engineering specifications."
	access = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine)
	cost = CARGO_CRATE_VALUE * 13
	crate_name = "engineering hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/hardsuit_atmospherics
	name = "Atmospherics Hardsuit Crate"
	desc = "Contains a single hardsuit, built to standard atmospherics suit specifications."
	access = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine/atmos)
	cost = CARGO_CRATE_VALUE * 16
	crate_name = "atmospherics hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/engi_inducers
	name = "NT-150 Industrial Power Inducers Crate"
	desc = "An improved model over the NT-75 EPI, the NT-150 charges at double the rate and contains an improved powercell. Contains two engineering-spec Inducers."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/inducer,
					/obj/item/inducer)
	crate_name = "engineering inducer crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Misc Crates /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/misc/painting
	name = "Advanced Art Supplies"
	desc = "Bring out your artistic spirit with these advanced art supplies. Contains coloring supplies, cloth for canvas, and two easels to work with!"
	cost = CARGO_CRATE_VALUE * 2.2
	contains = list(/obj/structure/easel,
					/obj/structure/easel,
					/obj/item/toy/crayon/spraycan,
					/obj/item/toy/crayon/spraycan,
					/obj/item/storage/crayons,
					/obj/item/storage/crayons,
					/obj/item/toy/crayon/white,
					/obj/item/toy/crayon/white,
					/obj/item/toy/crayon/rainbow,
					/obj/item/toy/crayon/rainbow,
					/obj/item/stack/sheet/cloth/ten,
					/obj/item/stack/sheet/cloth/ten)
	crate_name = "advanced art supplies"

/datum/supply_pack/service/paintcan
	name = "Adaptive Paintcan"
	desc = "Give things a splash of color with this experimental color-changing can of paint! Sellers note: We are not responsible for lynchings carried out by angry janitors, security officers, or any other crewmembers as a result of you using this."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/paint/anycolor)

/datum/supply_pack/misc/coloredsheets
	name = "Bedsheet Crate"
	desc = "Give your night life a splash of color with this crate filled with bedsheets! Contains a total of nine different-colored sheets."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/bedsheet/blue,
					/obj/item/bedsheet/green,
					/obj/item/bedsheet/orange,
					/obj/item/bedsheet/purple,
					/obj/item/bedsheet/red,
					/obj/item/bedsheet/yellow,
					/obj/item/bedsheet/brown,
					/obj/item/bedsheet/black,
					/obj/item/bedsheet/rainbow)
	crate_name = "colored bedsheet crate"

/datum/supply_pack/misc/candles
	name = "Candle Crate"
	desc = "Set up a romantic dinner or host a séance with these extra candles and crayons."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/storage/fancy/candle_box,
					/obj/item/storage/fancy/candle_box,
					/obj/item/storage/box/matches)
	crate_name = "candle crate"

/*
/datum/supply_pack/misc/jukebox
	name = "Jukebox Crate"
	desc = "Contains a regular old jukebox. It can play music!"
	cost = CARGO_CRATE_VALUE * 20
	contains = list(/obj/machinery/jukebox)
	crate_name = "jukebox crate"

/datum/supply_pack/misc/jukebox_disco
	name = "Radiant Dance Machine Crate"
	desc = "Contains the new and improved Radiant Dance Machine Mark IV! Capable of playing a large selections of music, while projecting a fabulous lightshow."
	cost = CARGO_CRATE_VALUE * 50
	contains = list(/obj/machinery/jukebox/disco)
	crate_name = "dance machine crate"
*/

/datum/supply_pack/misc/fuel_pellets
	name = "Exploration Drone Fuel Crate"
	desc = "Atmos on fire, and you still really wanna explore the stars? We've got you covered, for the fuel atleast."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/fuel_pellet,
					/obj/item/fuel_pellet,
					/obj/item/fuel_pellet)
	crate_name = "drone fuel crate"

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Food Stuff //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/organic/combomeal
	name = "Burger Combo Crate"
	desc = "We value our customers at the Greasy Griddle, so much so that we're willing to deliver -just for you.- Contains two combo meals, consisting of a Burger, Fries, and pack of chicken nuggets!"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/food/burger/cheese,
                    /obj/item/food/burger/cheese,
					/obj/item/food/fries,
                    /obj/item/food/fries,
                    /obj/item/storage/fancy/nugget_box,
                    /obj/item/storage/fancy/nugget_box)
	crate_name = "burger n nuggs combo meal"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/fiestatortilla
	name = "Fiesta Crate"
	desc = "Spice up the kitchen with this fiesta themed food order! Contains 8 tortilla based food items and some hot-sauce."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/food/taco,
					/obj/item/food/taco,
					/obj/item/food/taco/plain,
					/obj/item/food/taco/plain,
					/obj/item/food/enchiladas,
					/obj/item/food/enchiladas,
					/obj/item/food/carneburrito,
					/obj/item/food/cheesyburrito,
					/obj/item/reagent_containers/glass/bottle/capsaicin)
	crate_name = "fiesta crate"

/datum/supply_pack/organic/fakemeat
	name = "Meat Crate 'Synthetic'"
	desc = "Run outta meat already? Keep the lizards content with this freezer filled with cruelty-free and chemically compounded meat! Contains 12 slabs of meat product, and 4 slabs of *carp*."
	cost = CARGO_CRATE_VALUE * 2.25
	contains = list(/obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
                    /obj/item/food/meat/slab/meatproduct,
					/obj/item/food/fishmeat/carp/imitation,
                    /obj/item/food/fishmeat/carp/imitation,
                    /obj/item/food/fishmeat/carp/imitation,
                    /obj/item/food/fishmeat/carp/imitation)
	crate_name = "meaty crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/mixedboxes
	name = "Mixed Ingredient Boxes"
	desc = "Get overwhelmed with inspiration by ordering these boxes of surprise ingredients! Get four boxes filled with an assortment of products!"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/box/ingredients/wildcard,
					/obj/item/storage/box/ingredients/wildcard,
					/obj/item/storage/box/ingredients/wildcard,
					/obj/item/storage/box/ingredients/wildcard)
	crate_name = "wildcard food crate"
	crate_type = /obj/structure/closet/crate/freezer

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Pack Type ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/service/buildabar
	name = "Build a Bar Crate"
	desc = "Looking to set up your own little safe haven? Get a jump-start on it with this handy kit. Contains circuitboards for bar equipment, some parts, and some basic bartending supplies. (Glass not included)"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/storage/box/drinkingglasses,
					/obj/item/storage/box/drinkingglasses,
                    /obj/item/storage/part_replacer/cargo,
					/obj/item/stack/sheet/iron/ten,
					/obj/item/stack/sheet/iron/five,
                    /obj/item/stock_parts/cell/high,
                    /obj/item/stock_parts/cell/high,
					/obj/item/stack/cable_coil,
					/obj/item/book/manual/wiki/barman_recipes,
					/obj/item/reagent_containers/food/drinks/shaker,
					/obj/item/circuitboard/machine/chem_dispenser/drinks/beer,
					/obj/item/circuitboard/machine/chem_dispenser/drinks,
					/obj/item/circuitboard/machine/dish_drive)
	crate_name = "build a bar crate"

/datum/supply_pack/service/janitor/janpimp
	name = "Custodial Cruiser"
	desc = "Clown steal your ride? Assistant lock it in the dorms? Order a new one and get back to cleaning in style!"
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_JANITOR
	contains = list(/obj/vehicle/ridden/janicart,
					/obj/item/key/janitor)
	crate_name = "janitor ride crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/service/janitor/janpimpkey
	name = "Cruiser Keys"
	desc = "Replacement Keys for the Custodial Cruiser."
	cost = CARGO_CRATE_VALUE * 1.5
	access = ACCESS_JANITOR
	contains = list(/obj/item/key/janitor)
	crate_name = "key crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/service/janitor/janpremium
	name = "Janitor Supplies (Premium)"
	desc = "For when the mess is too big for a mop to handle. Contains, several cleaning grenades, some spare bottles of ammonia, two bars of soap, and an MCE (or Massive Cleaning Explosive)."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/soap/nanotrasen,
					/obj/item/soap/nanotrasen,
					/obj/item/grenade/clusterbuster/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia)
	crate_name = "premium janitorial crate"

/datum/supply_pack/service/lamplight
	name = "Lamp Light Crate"
	desc = "Dealing with brownouts? Lights out across the station? Brighten things up with a pack of four lamps and flashlights."
	cost = CARGO_CRATE_VALUE * 1.75
	contains = list(/obj/item/flashlight/lamp,
					/obj/item/flashlight/lamp,
					/obj/item/flashlight/lamp/green,
                    /obj/item/flashlight/lamp/green,
                    /obj/item/flashlight,
                    /obj/item/flashlight,
                    /obj/item/flashlight,
                    /obj/item/flashlight,)
	crate_name = "lamp light crate"

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Materials & Sheets //////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/materials/rawlumber
	name = "20 Towercap Logs"
	desc = "Set up a cookout or a classy beachside bonfire with these terrific towercaps!"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/grown/log)
	crate_name = "lumber crate"

/datum/supply_pack/materials/rawlumber/generate()
	. = ..()
	for(var/i in 1 to 19)
		new /obj/item/grown/log(.)


//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Vending Restocks ///////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Temporarily Disabled ////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/*
/datum/supply_pack/vending/wardrobes/dormtime //Disabled because the dorm vendor/kinkmate is only half finished and I don't have time to fix it atm.
	name = "Dorms-Time Restock"
	desc = "This crate contains a refill for the Droms-Time Vendor."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/vending_refill/kink)
	crate_name = "dorms-time restock"

/datum/supply_pack/service/wrapping_paper
	name = "Cargo Packaging Crate"
	desc = "Want to mail your loved ones gift-wrapped chocolates, stuffed animals, or the Clown's severed head? You can do all that, with this crate full of festive (and normal) wrapping paper. Also contains a hand labeler and a destination tagger for easy shipping!"
	cost = 1000
	contains = list(/obj/item/stack/wrapping_paper,
					/obj/item/stack/wrapping_paper,
					/obj/item/stack/wrapping_paper,
					/obj/item/stack/packageWrap,
					/obj/item/stack/packageWrap,
					/obj/item/stack/packageWrap,
					/obj/item/destTagger,
					/obj/item/hand_labeler)
	crate_type = /obj/structure/closet/crate/wooden
	crate_name = "wrapping paper crate"

/datum/supply_pack/service/cargo_supples
	name = "Cargo Supplies Crate"
	desc = "Sold everything that wasn't bolted down? You can get right back to work with this crate containing stamps, an export scanner, destination tagger, hand labeler and some package wrapping. Now with extra toner cartidges!"
	cost = 1000
	contains = list(/obj/item/stamp,
					/obj/item/stamp/denied,
					/obj/item/export_scanner,
					/obj/item/destTagger,
					/obj/item/hand_labeler,
					/obj/item/toner,
					/obj/item/toner,
					/obj/item/stack/packageWrap,
					/obj/item/stack/packageWrap)
	crate_name = "cargo supplies crate"

/datum/supply_pack/service/janitor/advanced
	name = "Advanced Sanitation Crate"
	desc = "Contains all the essentials for an advanced spacefaring cleanup crew. This kit includes a trashbag, an advanced mop, a bottle of space cleaner, a floor buffer, and a holosign projector. Requires Janitorial Access to Open"
	cost = 5700
	access = ACCESS_JANITOR
	contains = list(/obj/item/storage/bag/trash/bluespace,
					/obj/item/reagent_containers/spray/cleaner,
					/obj/item/mop/advanced,
					/obj/item/lightreplacer,
					/obj/item/janiupgrade,
					/obj/item/holosign_creator)
	crate_name = "advanced santation crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/shower
	name = "Shower Supplies"
	desc = "Everyone needs a bit of R&R. Make sure you get can get yours by ordering this crate filled four towels, a rubber ducky, and soap!"
	cost = 1000
	contains = list(/obj/item/reagent_containers/rag/towel,
					/obj/item/reagent_containers/rag/towel,
					/obj/item/reagent_containers/rag/towel,
					/obj/item/reagent_containers/rag/towel,
					/obj/item/bikehorn/rubberducky,
					/obj/item/soap/nanotrasen)
	crate_name = "shower crate"
*/
