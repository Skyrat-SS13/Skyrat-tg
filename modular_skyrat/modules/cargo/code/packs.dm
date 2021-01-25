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

/datum/supply_pack/medical/advanced_defib
	name = "Advanced Defibrillator Crate"
	desc = "Contains a single high-tech NT defibrillator, capable of self-charging and applying reviving shocks through thick clothing materials."
	cost = CARGO_CRATE_VALUE * 25
	access = ACCESS_CMO
	contains = list(/obj/item/defibrillator/compact/combat/loaded/nanotrasen)
	crate_name = "advanced defibrillator crate"

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

//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Engineering ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/engineering/industrial_rcd
	name = "Industrial RCD Crate"
	desc = "Manufactured at a high-tech NT production facility, this pack contains 2 industrial RCDs with expanded matter reserves and upgraded deconstructors."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/construction/rcd/combat,
					/obj/item/construction/rcd/combat)
	cost = CARGO_CRATE_VALUE * 40
	crate_name = "industrial RCD crate"

/datum/supply_pack/engineering/experimental_rcd
	name = "Experimental RCD Crate"
	desc = "Contains a single highly advanced RCD, capable of projecting its improved construction nanites at an increased range."
	access = ACCESS_CE
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/construction/rcd/arcd)
	cost = CARGO_CRATE_VALUE * 50
	crate_name = "experimental RCD crate"

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
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine)
	cost = CARGO_CRATE_VALUE * 13
	crate_name = "engineering hardsuit crate"

/datum/supply_pack/engineering/hardsuit_atmospherics
	name = "Atmospherics Hardsuit Crate"
	desc = "Contains a single hardsuit, built to standard atmospherics suit specifications."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine/atmos)
	cost = CARGO_CRATE_VALUE * 16
	crate_name = "atmospherics hardsuit crate"

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
	crate_name = "combo meal w/toy"
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
					/obj/item/food/carpmeat/imitation,
                    /obj/item/food/carpmeat/imitation,
                    /obj/item/food/carpmeat/imitation,
                    /obj/item/food/carpmeat/imitation)
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
					/obj/item/stack/sheet/metal/ten,
					/obj/item/stack/sheet/metal/five,
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

/datum/supply_pack/service/lamplight
	name = "Emergency Lighting Crate"
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
	crate_name = "emergency lighting crate"

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
//////////////////////////// Temporarily Disabled ////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/*
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

/datum/supply_pack/service/janitor/janpremium
	name = "Janitor Supplies (Premium)"
	desc = "The custodial union is in a tizzy, so we've gathered up some better supplies for you. In this crate you can get a brand new chem, Drying Agent. This stuff is the work of slimes or magic! This crate also contains a rag to test out the Drying Agent magic, several cleaning grenades, some spare bottles of ammonia, and an MCE (or Massive Cleaning Explosive)." //Skyrat change, fixed typo
	cost = 2700
	contains = list(/obj/item/grenade/clusterbuster/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/reagent_containers/rag,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/spray/drying_agent)
	crate_name = "premium janitorial crate"

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
