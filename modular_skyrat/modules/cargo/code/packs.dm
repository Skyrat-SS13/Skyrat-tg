/// Cost of the crate. DO NOT GO ANY LOWER THAN X1.4 the "CARGO_CRATE_VALUE" value if using regular crates, or infinite profit will be possible!

/*
*	LIVESTOCK
*/

/datum/supply_pack/critter/doublecrab
	name = "Crab Crate"
	desc = "Contains two crabs. Get your crab on!"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/mob/living/basic/crab,
		/mob/living/basic/crab,
	)
	crate_name = "look sir free crabs"

/datum/supply_pack/critter/mouse
	name = "Mouse Crate"
	desc = "Good for snakes and lizards of all ages. Contains six feeder mice."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/mob/living/basic/mouse,
	)
	crate_name = "mouse crate"

/datum/supply_pack/critter/mouse/generate()
	. = ..()
	for(var/i in 1 to 5)
		new /mob/living/basic/mouse(.)

/datum/supply_pack/critter/chinchilla
	name = "Chinchilla Crate"
	desc = "Contains four chinchillas. Dust not included."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(
		/mob/living/basic/pet/chinchilla,
	)
	crate_name = "chinchilla crate"

/datum/supply_pack/critter/chinchilla/generate()
	. = ..()
	for(var/i in 1 to 3)
		new /mob/living/basic/pet/chinchilla(.)

/*
*	MEDICAL
*/

/datum/supply_pack/medical/anesthetics
	name = "Anesthetics Crate"
	desc = "Contains two of the following: Morphine bottles, syringes, breath masks, and anesthetic tanks. Requires Medical Access to open."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/syringe,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath,
		/obj/item/tank/internals/anesthetic,
		/obj/item/tank/internals/anesthetic,
	)
	crate_name = "anesthetics crate"

/datum/supply_pack/medical/bodybags
	name = "Bodybags"
	desc = "For when the bodies hit the floor. Contains 4 boxes of bodybags."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/box/bodybags,
	)
	crate_name = "bodybag crate"

/datum/supply_pack/medical/firstaidmixed
	name = "Mixed Medical Kits"
	desc = "Contains one of each medical kits for dealing with a variety of injured crewmembers."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/storage/medkit/toxin,
		/obj/item/storage/medkit/o2,
		/obj/item/storage/medkit/brute,
		/obj/item/storage/medkit/fire,
		/obj/item/storage/medkit/regular,
	)
	crate_name = "medical kit crate"

/datum/supply_pack/medical/medipens
	name = "Epinephrine Medipens"
	desc = "Contains two boxes of epinephrine medipens. Each box contains seven pens."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(
		/obj/item/storage/box/medipens,
		/obj/item/storage/box/medipens,
	)
	crate_name = "medipen crate"

/datum/supply_pack/medical/modsuit_medical
	name = "Medical MODsuit Crate"
	desc = "Contains a single MODsuit, built to standard medical specifications."
	cost = CARGO_CRATE_VALUE * 13
	access = ACCESS_MEDICAL
	contains = list(/obj/item/mod/control/pre_equipped/medical)
	crate_name = "medical MODsuit crate"
	crate_type = /obj/structure/closet/crate/secure //No medical varient with security locks.

/datum/supply_pack/medical/compact_defib
	name = "Compact Defibrillator Crate"
	desc = "Contains a single compact defibrillator. Capable of being worn as a belt."
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_MEDICAL
	contains = list(/obj/item/defibrillator/compact)
	crate_name = "compact defibrillator crate"

/datum/supply_pack/medical/medigun
	name = "CWM-479 Medigun"
	desc = "Contains a single VeyMedical CWM-479 model medical gun; cells not included."
	cost = CARGO_CRATE_VALUE * 30
	access = ACCESS_MEDICAL
	contains = list(/obj/item/storage/briefcase/medicalgunset/standard)
	crate_name = "CWM-479 medigun crate"

/datum/supply_pack/medical/medicells
	name = "Medicell Replacement Crate"
	desc = "Contains the tier I Medigun cells."
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_MEDICAL
	contains = list(
		/obj/item/weaponcell/medical/brute,
		/obj/item/weaponcell/medical/burn,
		/obj/item/weaponcell/medical/toxin,
	)
	crate_name = "medicell replacement crate"

/*
*	SECURITY
*/

/datum/supply_pack/security/MODsuit_security
	name = "Security MODsuit Crate"
	desc = "Contains a single armored up MODsuit, built to standard security specifications."
	cost = CARGO_CRATE_VALUE * 16
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/mod/control/pre_equipped/security)
	crate_name = "security MODsuit crate"

/datum/supply_pack/security/armor_skyrat
	name = "Armor Crate"
	desc = "Three vests of well-rounded, decently-protective armor."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	contains = list(
		/obj/item/clothing/suit/armor/vest/alt,
		/obj/item/clothing/suit/armor/vest/alt,
		/obj/item/clothing/suit/armor/vest/alt,
	)
	crate_name = "armor crate"

/datum/supply_pack/security/helmets_skyrat
	name = "Helmets Crate"
	desc = "Contains three standard-issue brain buckets."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/head/helmet/sec/sol = 3)
	crate_name = "helmet crate"

/datum/supply_pack/security/deployablebarricades
	name = "C.U.C.K.S Deployable Barricades"
	desc = "Two cases of deployable barricades, for all your fortification needs."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/storage/barricade,
		/obj/item/storage/barricade,
	)
	crate_name = "C.U.C.K.S Crate"

/*
*	ENGINEERING
*/

/datum/supply_pack/engineering/material_pouches
	name = "Material Pouches Crate"
	desc = "Contains three material pouches."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(
		/obj/item/storage/pouch/material,
		/obj/item/storage/pouch/material,
		/obj/item/storage/pouch/material,
	)
	cost = CARGO_CRATE_VALUE * 15
	crate_name = "material pouches crate"

/datum/supply_pack/engineering/doublecap_tanks
	name = "Double Extended Emergency Tank Crate"
	desc = "Contains four double extended-capacity emergency tanks."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/tank/internals/emergency_oxygen/double,
		/obj/item/tank/internals/emergency_oxygen/double,
	)
	cost = CARGO_CRATE_VALUE * 15
	crate_name = "double extended emergency tank crate"

/datum/supply_pack/engineering/advanced_extinguisher
	name = "Advanced Foam Extinguisher Crate"
	desc = "Contains advanced fire extinguishers which use foam as extinguishing agent."
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(
		/obj/item/extinguisher/advanced,
		/obj/item/extinguisher/advanced,
		/obj/item/extinguisher/advanced,
	)
	cost = CARGO_CRATE_VALUE * 18
	crate_name = "advanced extinguisher crate"

/datum/supply_pack/engineering/modsuit_engineering
	name = "Engineering MODsuit Crate"
	desc = "Contains a single MODsuit, built to standard engineering specifications."
	access = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/mod/control/pre_equipped/engineering)
	cost = CARGO_CRATE_VALUE * 13
	crate_name = "engineering MODsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/modsuit_atmospherics
	name = "Atmospherics MODsuit Crate"
	desc = "Contains a single MODsuit, built to standard atmospherics specifications."
	access = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/mod/control/pre_equipped/atmospheric)
	cost = CARGO_CRATE_VALUE * 16
	crate_name = "atmospherics MODsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/engi_inducers
	name = "NT-150 Industrial Power Inducers Crate"
	desc = "An improved model over the NT-75 EPI, the NT-150 charges at double the rate and contains an improved powercell. Contains two engineering-spec Inducers."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/inducer,
		/obj/item/inducer,
	)
	crate_name = "engineering inducer crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/gas_miner
	name = "Gas Miner Delivery Beacon Crate"
	desc = "Contains a single gas miner delivery beacon, for the ordering of one gas miner."
	access = ACCESS_ATMOSPHERICS
	contains = list(/obj/item/summon_beacon/gas_miner)
	cost = CARGO_CRATE_VALUE * 50
	crate_name = "gas miner delivery beacon crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/engineering/improved_rcd
	name = "Improved RCD Crate"
	desc = "Contains 3 upgraded RCDs featuring superior material storage. Each comes with complimentary frames and circuitry upgrades to boot!"
	access = ACCESS_ENGINE_EQUIP
	cost = CARGO_CRATE_VALUE * 18
	contains = list(
		/obj/item/construction/rcd/improved,
		/obj/item/construction/rcd/improved,
		/obj/item/construction/rcd/improved,
	)
	crate_name = "improved RCD crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/*
*	MISC
*/

/datum/supply_pack/misc/speedbike //If you see this bought in game, its time to nerf a cargo exploit.
	name = "Speedbike"
	desc = "Put your shades on, saddle up, and ride off directly into the sun on this turbo deluxe space-cruising speedbike."
	cost = 1000000 //Special case, we don't want to make this in terms of crates because having bikes be a million credits is the whole meme.
	contains = list(/obj/vehicle/ridden/speedbike)
	crate_name = "speedbike crate"

/datum/supply_pack/misc/painting
	name = "Advanced Art Supplies"
	desc = "Bring out your artistic spirit with these advanced art supplies. Contains coloring supplies, cloth for canvas, and two easels to work with!"
	cost = CARGO_CRATE_VALUE * 2.2
	contains = list(
		/obj/structure/easel,
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
		/obj/item/stack/sheet/cloth/ten,
	)
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
	contains = list(
		/obj/item/bedsheet/blue,
		/obj/item/bedsheet/green,
		/obj/item/bedsheet/orange,
		/obj/item/bedsheet/purple,
		/obj/item/bedsheet/red,
		/obj/item/bedsheet/yellow,
		/obj/item/bedsheet/brown,
		/obj/item/bedsheet/black,
		/obj/item/bedsheet/rainbow,
	)
	crate_name = "colored bedsheet crate"

/datum/supply_pack/misc/candles
	name = "Candle Crate"
	desc = "Set up a romantic dinner or host a séance with these extra candles and crayons."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/storage/fancy/candle_box,
		/obj/item/storage/fancy/candle_box,
		/obj/item/storage/box/matches,
	)
	crate_name = "candle crate"

/datum/supply_pack/misc/vanguard_surplus
	name = "Expeditionary Corps Surplus"
	desc = "Contains an assortment of surplus equipment from the now-defunct Vanguard Expeditionary Corps."
	cost = CARGO_CRATE_VALUE * 19
	contains = list(
		/obj/item/storage/box/expeditionary_survival,
		/obj/item/melee/tomahawk,
		/obj/item/storage/backpack/duffelbag/expeditionary_corps,
		/obj/item/clothing/gloves/color/black/expeditionary_corps,
		/obj/item/clothing/head/helmet/expeditionary_corps,
		/obj/item/clothing/suit/armor/vest/expeditionary_corps,
		/obj/item/storage/belt/military/expeditionary_corps,
		/obj/item/clothing/under/rank/expeditionary_corps,
		/obj/item/clothing/shoes/combat/expeditionary_corps,
		/obj/item/modular_computer/pda/expeditionary_corps,
		/obj/item/knife/combat/marksman,
	)
	/// How many of the contains to put in the crate
	var/num_contained = 3

/datum/supply_pack/misc/vanguard_surplus/fill(obj/structure/closet/crate/filled_crate)
	var/list/contain_copy = contains.Copy()
	for(var/i in 1 to num_contained)
		var/item = pick_n_take(contain_copy)
		new item(filled_crate)

/datum/supply_pack/misc/gravity_harness
	name = "Gravity Suspension Harness"
	desc = "A back-mounted suspensor harness powered by cells, designed by Deep Spacer tribes to either nullify or amplify gravity. \
		While it's a pretty cheap bootleg of the personal gravitic engines used by the Skrell, this one's been fitted with straps and a basic storage module."
	cost = CARGO_CRATE_VALUE * 6 // 1200 credits
	contains = list(/obj/item/gravity_harness)

/*
*	FOOD
*/

/datum/supply_pack/organic/combomeal
	name = "Burger Combo Crate"
	desc = "We value our customers at the Greasy Griddle, so much so that we're willing to deliver -just for you.- Contains two combo meals, consisting of a Burger, Fries, and pack of chicken nuggets!"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/cheese,
		/obj/item/food/fries,
		/obj/item/food/fries,
		/obj/item/storage/fancy/nugget_box,
		/obj/item/storage/fancy/nugget_box,
	)
	crate_name = "burger-n-nuggs combo meal"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/fiestatortilla
	name = "Fiesta Crate"
	desc = "Spice up the kitchen with this fiesta themed food order! Contains 8 tortilla based food items and some hot-sauce."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(
		/obj/item/food/taco,
		/obj/item/food/taco,
		/obj/item/food/taco/plain,
		/obj/item/food/taco/plain,
		/obj/item/food/enchiladas,
		/obj/item/food/enchiladas,
		/obj/item/food/carneburrito,
		/obj/item/food/cheesyburrito,
		/obj/item/reagent_containers/cup/bottle/capsaicin,
	)
	crate_name = "fiesta crate"

/datum/supply_pack/organic/fakemeat
	name = "Meat Crate 'Synthetic'"
	desc = "Run outta meat already? Keep the lizards content with this freezer filled with cruelty-free and chemically compounded meat! Contains 12 slabs of meat product, and 4 slabs of *carp*."
	cost = CARGO_CRATE_VALUE * 2.25
	contains = list(
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
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
	)
	crate_name = "meaty crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/mixedboxes
	name = "Mixed Ingredient Boxes"
	desc = "Get overwhelmed with inspiration by ordering these boxes of surprise ingredients! Get four boxes filled with an assortment of products!"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
	)
	crate_name = "wildcard food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/fcsurplus
	name = "Fine Cuisine Assortment Value Pack"
	desc = "Chef slop boring? Have high-maintenance crewmembers that with wings? Maybe you just want to revel in the sinful delight that are Cheese Curds? The Finest of our trade union has made the pack for you, containing a mix of fine oils, vinegar, and exceptionally rare ingredients."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/canned/larvae,
		/obj/item/food/moonfish_eggs,
	)
	crate_name = "fine cuisine assortment pack"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/qualityoilbulk
	name = "Quality Oil Bulk Pack"
	desc = "Normal cooking oil not cutting it? Chef throw all the quality stuff in the frier because they thought it was funny? Well, We got you covered, Introducing a bulk pack of Ten (10) bottles of our finest oils, blended for the perfect taste in cold recipes, and a resistance for going acrid when cooking."
	cost = CARGO_CRATE_VALUE * 9
	contains = list(
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
		/obj/item/reagent_containers/condiment/olive_oil,
	)
	crate_name = "bulk quality oil pack"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/vinegarbulk
	name = "Vinegar Bulk Pack"
	desc = "Mothic Cuisine night? The winged fellows in port? Well, We'll have you cooking in no time. Refined from several rich wines and cultivated for just the right bite, This pack Ten (10) Bottles of vinegar for the perfect dressings and sauces."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
	)
	crate_name = "bulk vinegar pack"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/bulkcanmoff
	name = "Bulk Mothic Canned Goods"
	desc = "Trying your hand at pestos and sauces? Cant just grow the stuff and can it yourself? Well, No matters, No worries, We here have you covered with Five (5) cans of tomatoes and pine nuts to help care for your winged friends."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/tomatoes,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
		/obj/item/food/canned/pine_nuts,
	)
	crate_name = "bulk moffic pack"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/bulkcanliz
	name = "Bulk Lizard Goods"
	desc = "Having some devious tastes? One of your scalie friends wanting something that isn't fried mystery meat? Well you're just one order away from from the perfect pleaser. Containing Three (3) Cans of our finest-sourced canned jellyfish, snails and bee larvae, An addition of Three (3) packs of cruelty free Moonfish eggs might get their hearts."
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/jellyfish,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/canned/desert_snails,
		/obj/item/food/moonfish_eggs,
		/obj/item/food/moonfish_eggs,
		/obj/item/food/moonfish_eggs,
		/obj/item/food/canned/larvae,
		/obj/item/food/canned/larvae,
		/obj/item/food/canned/larvae,
	)
	crate_name = "bulk lizard pack"
	crate_type = /obj/structure/closet/crate/freezer

/*
*	Service
*/

/datum/supply_pack/service/buildabar
	name = "Build a Bar Crate"
	desc = "Looking to set up your own little safe haven? Get a jump-start on it with this handy kit. Contains circuitboards for bar equipment, some parts, and some basic bartending supplies. (Glass not included)"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/storage/box/drinkingglasses,
		/obj/item/storage/box/drinkingglasses,
		/obj/item/storage/part_replacer/cargo,
		/obj/item/stack/sheet/iron/ten,
		/obj/item/stack/sheet/iron/five,
		/obj/item/stock_parts/cell/high,
		/obj/item/stock_parts/cell/high,
		/obj/item/stack/cable_coil,
		/obj/item/book/manual/wiki/barman_recipes,
		/obj/item/reagent_containers/cup/glass/shaker,
		/obj/item/circuitboard/machine/chem_dispenser/drinks/beer,
		/obj/item/circuitboard/machine/chem_dispenser/drinks,
		/obj/item/circuitboard/machine/dish_drive,
	)
	crate_name = "build a bar crate"

/datum/supply_pack/service/hydrohelper
	name = "Hydro-Helper Circuit Pack"
	desc = "Botany being lazy with something? Being refused circuit boards? grow your only little garden with these three boards. (seeds and parts not included)"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/circuitboard/machine/hydroponics,
		/obj/item/circuitboard/machine/hydroponics,
		/obj/item/circuitboard/machine/hydroponics,
	)
	crate_name = "garden crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/service/janitor/janpimp
	name = "Custodial Cruiser"
	desc = "Clown steal your ride? Assistant lock it in the dorms? Order a new one and get back to cleaning in style!"
	cost = CARGO_CRATE_VALUE * 4
	access = ACCESS_JANITOR
	contains = list(
		/obj/vehicle/ridden/janicart,
		/obj/item/key/janitor,
	)
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
	contains = list(
		/obj/item/soap/nanotrasen,
		/obj/item/soap/nanotrasen,
		/obj/item/grenade/clusterbuster/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/reagent_containers/cup/bottle/ammonia,
		/obj/item/reagent_containers/cup/bottle/ammonia,
		/obj/item/reagent_containers/cup/bottle/ammonia,
	)
	crate_name = "premium janitorial crate"

/datum/supply_pack/service/lamplight
	name = "Lamp Light Crate"
	desc = "Dealing with brownouts? Lights out across the station? Brighten things up with a pack of four lamps and flashlights."
	cost = CARGO_CRATE_VALUE * 1.75
	contains = list(
		/obj/item/flashlight/lamp,
		/obj/item/flashlight/lamp,
		/obj/item/flashlight/lamp/green,
		/obj/item/flashlight/lamp/green,
		/obj/item/flashlight,
		/obj/item/flashlight,
		/obj/item/flashlight,
		/obj/item/flashlight,
	)
	crate_name = "lamp light crate"

/datum/supply_pack/service/medieval
	name = "Authentic Renaissance Faire Crate"
	desc = "Contains two authentic suits of armor, swords, and two bows and cuirass' for the cowards hiding in the back."
	cost = CARGO_CRATE_VALUE * 30
	contraband = TRUE
	contains = list(
		/obj/item/clothing/suit/armor/riot/knight/larp/red,
		/obj/item/clothing/gloves/plate/larp/red,
		/obj/item/clothing/head/helmet/knight/red,
		/obj/item/clothing/shoes/plate/larp/red,
		/obj/item/claymore/weak/weaker,
		/obj/item/clothing/shoes/plate/larp/blue,
		/obj/item/clothing/suit/armor/riot/knight/larp/blue,
		/obj/item/clothing/gloves/plate/larp/blue,
		/obj/item/clothing/head/helmet/knight/blue,
		/obj/item/claymore/weak/weaker,
		/obj/item/clothing/suit/armor/vest/cuirass/larp,
		/obj/item/clothing/suit/armor/vest/cuirass/larp,
		/obj/item/gun/ballistic/bow/longbow,
		/obj/item/gun/ballistic/bow/longbow,
		/obj/item/storage/bag/quiver,
		/obj/item/storage/bag/quiver,
		/obj/item/clothing/head/helmet/knight/red,
		/obj/item/clothing/head/helmet/knight/blue,
		/obj/item/food/bread/plain,
	)
	crate_name = "vintage crate"

/datum/supply_pack/organic/lavalandsamples
	name = "Planetary Flora Samples"
	desc = "A box of samples taken from the surface of Lavaland. Requires Hydroponics access to open."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_HYDROPONICS
	contains = list(
		/obj/item/seeds/lavaland/polypore,
		/obj/item/seeds/lavaland/porcini,
		/obj/item/seeds/lavaland/inocybe,
		/obj/item/seeds/lavaland/ember,
		/obj/item/seeds/lavaland/seraka,
		/obj/item/seeds/lavaland/fireblossom,
		/obj/item/seeds/lavaland/cactus,
	)
	crate_name = "planetary seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/service/MODsuit_cargo
	name = "Cargo Loader MODsuit Crate"
	desc = "Contains a single quad-armed MODsuit, built to standard cargo specifications."
	cost = CARGO_CRATE_VALUE * 13
	access_view = ACCESS_CARGO
	contains = list(/obj/item/mod/control/pre_equipped/loader)
	crate_name = "cargo MODsuit crate"

/datum/supply_pack/service/snowmobile
	name = "Snowmobile kit"
	desc = "Trapped on a frigid wasteland? Need to get around fast? Purchase a refurbished snowmobile with a FREE 10 microsecond warranty!"
	cost = CARGO_CRATE_VALUE * 7.5
	contains = list(
		/obj/vehicle/ridden/atv/snowmobile = 1,
		/obj/item/key/atv = 1,
		/obj/item/clothing/mask/gas/explorer = 1,
	)
	crate_name = "snowmobile kit"
	crate_type = /obj/structure/closet/crate/large

/*
*	MATERIALS AND SHEETS
*/

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

/datum/supply_pack/imports/cin_surplus
	name = "CIN Military Surplus Crate"
	desc = "A collection of surplus equipment sourced from the Coalition of Independent Nations' military stockpiles. Likely to contain old and outdated equipment, as is the nature of surplus."
	contraband = TRUE
	cost = CARGO_CRATE_VALUE * 9
	contains = list(
		/obj/item/storage/box/colonial_rations = 1,
		/obj/item/storage/toolbox/ammobox/strilka310 = 1,
		/obj/item/storage/toolbox/ammobox/strilka310/surplus = 1,
		/obj/item/storage/toolbox/maint_kit = 1,
		/obj/item/storage/toolbox/guncase/soviet/sakhno = 2,
		/obj/item/ammo_box/strilka310 = 1,
		/obj/item/clothing/suit/armor/vest/cin_surplus_vest = 1,
		/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color = 1,
		/obj/item/storage/backpack/industrial/cin_surplus/random_color = 1,
		/obj/item/storage/belt/military/cin_surplus/random_color = 1,
		/obj/item/clothing/gloves/tackler/combat = 1,
		/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color = 1,
		/obj/item/clothing/shoes/jackboots = 1,
		/obj/item/clothing/mask/gas/hecu2 = 1,
		/obj/item/clothing/mask/balaclavaadjust = 1,
	)

/datum/supply_pack/imports/cin_surplus/fill(obj/structure/closet/crate/we_are_filling_this_crate)
	for(var/i in 1 to 10)
		var/item = pick_weight(contains)
		new item(we_are_filling_this_crate)

/*
* VENDING RESTOCKS
*/

/datum/supply_pack/vending/dorms
	name = "LustWish Supply Crate"
	desc = "This crate contains a single refill for the LustWish vendor."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/vending_refill/lustwish)

/datum/supply_pack/vending/barber
	name = "Fab-O-Vend Supply Crate"
	desc = "Contains a single restock for the Fab-O-Vend, great for those who are indecisive about their looks."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/vending_refill/barbervend)
