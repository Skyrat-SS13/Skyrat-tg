// Alphabetized by trader. Any trader can use these datums, but this keeps things a bit more organized.

/////////Artifact Shop Employee/////////

/datum/sold_goods/excavation_pick_set
	path = /obj/item/storage/excavation_pick_set/full

/datum/sold_goods/excavation_measuring_tape
	path = /obj/item/excavation_measuring_tape

/datum/sold_goods/excavation_depth_scanner
	path = /obj/item/excavation_depth_scanner

/datum/sold_goods/excavation_locator
	path = /obj/item/excavation_locator

/datum/sold_goods/anomalous_crystal
	cost = 1000
	path = /obj/item/anomalous_sliver/crystal

/////////Atmospheric Shop Employee/////////

/datum/sold_goods/belt/nitrogen
	cost = 100
	path = /obj/item/tank/internals/nitrogen/belt
	stock_high = 5
	stock_low = 3

/datum/sold_goods/belt/plasma
	cost = 180
	path = /obj/item/tank/internals/plasmaman/belt
	stock_high = 5
	stock_low = 3

/datum/sold_goods/emergency_oxygen
	cost = 60
	path = /obj/item/tank/internals/emergency_oxygen
	stock_high = 5
	stock_low = 3

/datum/sold_goods/voidsuit
	name = "vintage space suit"
	cost = 1250
	path = /obj/item/storage/box/hero/astronaut
	stock_high = 1
	stock_low = 1

/////////Clothing Store Employee/////////

/datum/sold_goods/clothing_under
	trading_types = list(/obj/item/clothing/under = TRADER_SUBTYPES,
						/obj/item/clothing/under/syndicate = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/under/chameleon = TRADER_BLACKLIST_TYPES)
/datum/sold_goods/clothing_under/two
/datum/sold_goods/clothing_under/three
/datum/sold_goods/clothing_under/four
/datum/sold_goods/clothing_under/five
/datum/sold_goods/clothing_under/six

/datum/sold_goods/clothing_suit
	cost = 150
	trading_types = list(/obj/item/clothing/suit = TRADER_SUBTYPES,
						/obj/item/clothing/suit/armor = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/under/chameleon = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/suit/space = TRADER_BLACKLIST_TYPES)

/datum/sold_goods/clothing_suit/two

/datum/sold_goods/clothing_boots
	trading_types = list(/obj/item/clothing/shoes = TRADER_SUBTYPES,
						/obj/item/clothing/shoes/combat = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/shoes/chameleon = TRADER_BLACKLIST_TYPES)

/datum/sold_goods/clothing_boots/two
/datum/sold_goods/clothing_boots/three
/datum/sold_goods/clothing_boots/four

/datum/sold_goods/clothing_head
	trading_types = list(/obj/item/clothing/head = TRADER_SUBTYPES,
						/obj/item/clothing/head/helmet = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/head/chameleon = TRADER_BLACKLIST_TYPES)

/datum/sold_goods/clothing_head/two
/datum/sold_goods/clothing_head/three
/datum/sold_goods/clothing_head/four

/datum/sold_goods/clothing_gloves
	trading_types = list(/obj/item/clothing/gloves = TRADER_SUBTYPES,
						/obj/item/clothing/gloves/tackler = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/gloves/combat = TRADER_BLACKLIST_TYPES,
						/obj/item/clothing/gloves/rapid = TRADER_BLACKLIST_TYPES)

/datum/sold_goods/clothing_gloves/two
/datum/sold_goods/clothing_gloves/three

/datum/sold_goods/budget_insuls
	cost = 355
	path = /obj/item/clothing/gloves/color/fyellow

/////////Drugstore Employee/////////

/datum/sold_goods/flashlight
	cost = 50
	path = /obj/item/flashlight

/datum/sold_goods/flash
	cost = 150
	path = /obj/item/assembly/flash

/datum/sold_goods/paint
	trading_types = list(/obj/item/paint = TRADER_SUBTYPES)

/datum/sold_goods/aicard
	stock_high = 1
	stock_low = 1
	cost = 200
	path = /obj/item/aicard

/datum/sold_goods/binoculars
	path = /obj/item/binoculars

/datum/sold_goods/airlock_painter
	path = /obj/item/airlock_painter

/datum/sold_goods/multitool
	path = /obj/item/multitool

/datum/sold_goods/lightreplacer
	cost = 350
	path = /obj/item/lightreplacer

/datum/sold_goods/megaphone
	cost = 350
	path = /obj/item/megaphone

/datum/sold_goods/paicard
	stock_high = 1
	stock_low = 1
	cost = 200
	path = /obj/item/paicard

/datum/sold_goods/t_scanner
	path = /obj/item/t_scanner

/datum/sold_goods/analyzer
	path = /obj/item/analyzer

/datum/sold_goods/healthanalyzer
	cost = 200
	path = /obj/item/healthanalyzer

/datum/sold_goods/taperecorder
	path = /obj/item/taperecorder

/datum/sold_goods/mmi
	path = /obj/item/mmi

/datum/sold_goods/toner
	path = /obj/item/toner

/datum/sold_goods/camera
	path = /obj/item/camera

/datum/sold_goods/camera_film
	cost = 40
	path = /obj/item/camera_film

/datum/sold_goods/gps
	path = /obj/item/gps

/datum/sold_goods/dest_tagger
	path = /obj/item/dest_tagger

/datum/sold_goods/wrapping_paper
	cost = 50
	path = /obj/item/stack/wrapping_paper

/datum/sold_goods/anomaly_neutralizer
	cost = 250
	path = /obj/item/anomaly_neutralizer

/datum/sold_goods/random_medical_stack
	cost = 200
	trading_types = list(/obj/item/stack/medical = TRADER_SUBTYPES)

/datum/sold_goods/random_medical_stack/two

/datum/sold_goods/grey_bull
	cost = 50
	path = /obj/item/reagent_containers/food/drinks/soda_cans/grey_bull

/////////Electronic Shop Employee/////////

/datum/sold_goods/electronics
	trading_types = list(/obj/item/electronics = TRADER_SUBTYPES)

/datum/sold_goods/electronics/two

/datum/sold_goods/cable_coil
	path = /obj/item/stack/cable_coil

/datum/sold_goods/computer_battery
	path = /obj/item/computer_hardware/battery

/datum/sold_goods/computer_hardware
	trading_types = list(/obj/item/computer_hardware = TRADER_SUBTYPES)

/datum/sold_goods/computer_hardware/two
/datum/sold_goods/computer_hardware/three

/datum/sold_goods/laptop
	cost = 500
	path = /obj/item/modular_computer/laptop/preset/civilian

/datum/sold_goods/cell
	path = /obj/item/stock_parts/cell

/datum/sold_goods/decent_cell
	cost = 200
	trading_types = list(/obj/item/stock_parts/cell/upgraded = TRADER_THIS_TYPE,
							/obj/item/stock_parts/cell/upgraded/plus = TRADER_THIS_TYPE,
							/obj/item/stock_parts/cell/high = TRADER_THIS_TYPE)

/////////Medical Supplier/////////

/datum/sold_goods/firstaid
	cost = 300
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/firstaid

/datum/sold_goods/firstaid_fire
	cost = 500
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/firstaid/fire

/datum/sold_goods/firstaid_brute
	cost = 500
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/firstaid/brute

/datum/sold_goods/firstaid_toxin
	cost = 500
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/firstaid/toxin

/datum/sold_goods/pill_bottle_multiver
	cost = 300
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/pill_bottle/multiver

/datum/sold_goods/pill_bottle_iron
	cost = 200
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/pill_bottle/iron

/datum/sold_goods/bottle_morphine
	cost = 200
	stock_high = 1
	stock_low = 1
	path = /obj/item/reagent_containers/glass/bottle/morphine

/datum/sold_goods/bottle_chloral
	cost = 200
	stock_high = 1
	stock_low = 1
	path = /obj/item/reagent_containers/glass/bottle/chloralhydrate

/datum/sold_goods/bottle_epinephrine
	cost = 200
	stock_high = 1
	stock_low = 1
	path = /obj/item/reagent_containers/glass/bottle/epinephrine

/datum/sold_goods/pill_bottle_iron
	cost = 200
	stock_high = 1
	stock_low = 1
	path = /obj/item/storage/pill_bottle/iron

/datum/sold_goods/scalpel
	path = /obj/item/scalpel

/datum/sold_goods/circular_saw
	cost = 200
	path = /obj/item/circular_saw

/datum/sold_goods/bonesetter
	path = /obj/item/bonesetter

/datum/sold_goods/hemostat
	path = /obj/item/hemostat

/datum/sold_goods/retractor
	path = /obj/item/retractor

/datum/sold_goods/cautery
	path = /obj/item/cautery

/datum/sold_goods/universal_blood_pack
	name = "universal blood pack"
	cost = 400
	path = /obj/item/reagent_containers/blood/universal

/////////Pet Shop Employee/////////

/datum/sold_goods/corgi
	stock_high = 1
	stock_low = 1
	cost = 300
	path = /mob/living/simple_animal/pet/dog/corgi

/datum/sold_goods/fox
	stock_high = 1
	stock_low = 1
	cost = 400
	path = /mob/living/simple_animal/pet/fox

/datum/sold_goods/cat
	stock_high = 1
	stock_low = 1
	cost = 200
	path = /mob/living/simple_animal/pet/cat

/datum/sold_goods/penguin
	stock_high = 1
	stock_low = 1
	cost = 400
	path = /mob/living/simple_animal/pet/penguin/emperor

/datum/sold_goods/sloth
	stock_high = 1
	stock_low = 1
	cost = 300
	path = /mob/living/simple_animal/sloth

/datum/sold_goods/lizard
	stock_high = 1
	stock_low = 1
	cost = 200
	path = /mob/living/simple_animal/hostile/lizard

/////////Robot Seller/////////

/datum/sold_goods/posibrain
	cost = 400
	stock_high = 1
	stock_low = 1
	path = /obj/item/mmi/posibrain

/datum/sold_goods/random_bot
	stock_high = 1
	stock_low = 1
	cost = 400
	trading_types = list(/mob/living/simple_animal/bot = TRADER_SUBTYPES,
						/mob/living/simple_animal/bot/secbot = TRADER_BLACKLIST_SUBTYPES,
						/mob/living/simple_animal/bot/honkbot = TRADER_BLACKLIST_TYPES)

/datum/sold_goods/random_bot/two

/datum/sold_goods/incomplete_bot
	cost = 200
	trading_types = list(/obj/item/bot_assembly = TRADER_SUBTYPES)

/////////Rock'n'Drill Mining Inc/////////

/datum/sold_goods/mining_kit
	cost = 350
	path = /obj/item/storage/backpack/duffelbag/mining_conscript/basic
	stock_high = 4
	stock_low = 2

/datum/sold_goods/stack/iron_ten
	stock_high = 3
	stock_low = 10
	amount = 10
	cost = 100
	path = /obj/item/stack/sheet/iron

/datum/sold_goods/stack/glass_ten
	stock_high = 3
	stock_low = 10
	amount = 10
	cost = 100
	path = /obj/item/stack/sheet/glass

/datum/sold_goods/stack/silver_ten
	amount = 10
	cost = 300
	path = /obj/item/stack/sheet/mineral/silver

/datum/sold_goods/stack/gold_ten
	amount = 10
	cost = 600
	path = /obj/item/stack/sheet/mineral/gold

/datum/sold_goods/stack/uranium_ten
	amount = 10
	cost = 1000
	path = /obj/item/stack/sheet/mineral/uranium

/datum/sold_goods/stack/plasma_ten
	amount = 10
	cost = 1000
	path = /obj/item/stack/sheet/mineral/plasma

/datum/sold_goods/stack/diamond_five
	amount = 5
	cost = 1000
	path = /obj/item/stack/sheet/mineral/diamond

/////////Toy Shop Employee/////////

/datum/sold_goods/toy
	cost = 100
	trading_types = list(/obj/item/toy = TRADER_SUBTYPES,
						/obj/item/toy/figure = TRADER_BLACKLIST_TYPES)

/datum/sold_goods/toy/two
/datum/sold_goods/toy/three
/datum/sold_goods/toy/four

/datum/sold_goods/toy_plushie
	cost = 100
	trading_types = list(/obj/item/toy/plush = TRADER_SUBTYPES)

/datum/sold_goods/toy_figure
	cost = 150
	trading_types = list(/obj/item/toy/figure = TRADER_SUBTYPES)

/datum/sold_goods/toy_figure/two

/datum/sold_goods/toy_guns
	cost = 200
	trading_types = list(/obj/item/gun/ballistic/automatic/toy = TRADER_THIS_TYPE,
							/obj/item/gun/ballistic/automatic/pistol/toy = TRADER_THIS_TYPE,
							/obj/item/gun/ballistic/shotgun/toy = TRADER_THIS_TYPE,
							/obj/item/gun/ballistic/automatic/l6_saw/toy = TRADER_THIS_TYPE)

/////////Xenolife Collector/////////

/datum/sold_goods/space_carp
	cost = 400
	path = /mob/living/simple_animal/hostile/carp

/datum/sold_goods/goliath
	cost = 500
	path = /mob/living/simple_animal/hostile/asteroid/goliath
