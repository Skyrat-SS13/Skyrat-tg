/datum/trader_bounty/gun_celebration_day
	bounty_name = "Gun Celebration Day"
	amount = 5
	reward_cash = 2000
	possible_paths = list(
		/obj/item/food/burger/baconburger,
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/plain,
		/obj/item/food/burger/rib
		)
	bounty_text = "We're celebrating the galaxy wide gun day today, and we require burgers for the party! It'd be real nice if you could procure some for us."
	bounty_complete_text = "HELL YEAH! Now we can party for real."

/datum/trader_bounty/reagent/ammo_requisition
	bounty_name = "Ammunition Requisition"
	amount = 90 //3 bottles
	reagent_type = /datum/reagent/gunpowder
	reward_cash = 2000
	bounty_text = "We're running out of ammunition stock and require more gunpowder to produce more! Please fetch us some."
	bounty_complete_text = "With this, we're sure to make a bang."

/datum/trader_bounty/reagent/explosive_ammo
	bounty_name = "Explosive Bullets"
	amount = 90 //3 bottles
	reagent_type = /datum/reagent/rdx
	reward_cash = 2000
	bounty_text = "We are experimenting with making our bullets explode and require some chemicals that can give us the right type of bang."
	bounty_complete_text = "With this, we're sure to make a bang."

/datum/trader_bounty/anomalous_energy_sources
	bounty_name = "Anomalous Energy Sources"
	amount = 3
	path = /obj/item/anomalous_sliver/crystal
	reward_cash = 3000
	bounty_text = "We are looking into acquiring new and more effective energy sources for our weapons and found interest in those new crystals the rumors been spreading around."
	bounty_complete_text = "This will surely be useful for our research."

/datum/trader_bounty/unlimited_power
	bounty_name = "Unlimited Power?"
	amount = 1
	path = /obj/item/stock_parts/cell/high/slime_hypercharged
	reward_cash = 3000
	bounty_text = "Our electricity bill is getting way too steep, we need to switch to renewable energy, and by that I mean a supercharged slime core."
	bounty_complete_text = "You won't catch us with our lights off now."

/datum/trader_bounty/heavy_lifting
	bounty_name = "Heavy Lifting"
	amount = 1
	path = /obj/vehicle/sealed/mecha/working/ripley
	reward_cash = 5000
	bounty_text = "Filled with brim of ores and bars, we're expanding our warehouses and require an immediate help of a very strong machine. If you could supply us with a Ripley, we'd pay you handsomely."
	bounty_complete_text = "Expect twice the stock next time you visit us!"

/datum/trader_bounty/gas/hard_to_breathe
	bounty_name = "Hard to Breathe"
	amount = 20
	gas_type = /datum/gas/pluoxium
	reward_cash = 3000
	bounty_text = "During strip mining our miners often complain about the quality of air, or sometimes drop dead from lung complications, which is really inefficient. So we're deciding to invest into premium air!"

/datum/trader_bounty/reagent/medicine_easy
	bounty_name = "Medicine Restock"
	amount = 60 //2 bottles
	reward_cash = 2000
	possible_reagent_types = list(
		/datum/reagent/medicine/mannitol,
		/datum/reagent/medicine/potass_iodide,
		/datum/reagent/medicine/salglu_solution,
		/datum/reagent/medicine/c2/seiver,
		/datum/reagent/medicine/mine_salve,
		/datum/reagent/medicine/morphine,
		/datum/reagent/toxin/formaldehyde
		)
	bounty_text = "We're running short of some of the lower-grade medicine. Mind giving us some bottles?"

/datum/trader_bounty/reagent/medicine_hard
	bounty_name = "Medicine Restock"
	amount = 60 //2 bottles
	reward_cash = 3500
	possible_reagent_types = list(
		/datum/reagent/medicine/psicodine,
		/datum/reagent/medicine/neurine,
		/datum/reagent/medicine/sal_acid,
		/datum/reagent/medicine/oxandrolone,
		/datum/reagent/medicine/cryoxadone,
		/datum/reagent/medicine/mutadone,
		/datum/reagent/medicine/oculine,
		/datum/reagent/medicine/inacusiate,
		/datum/reagent/medicine/c2/synthflesh
		)
	bounty_text = "We're running short of some of the higher-grade medicine. Mind giving us some bottles?"

/datum/trader_bounty/reagent/fertilizer_shortage
	bounty_name = "Fertilizer Shortage"
	amount = 60 //2 bottles
	reward_cash = 2000
	possible_reagent_types = list(
		/datum/reagent/saltpetre,
		/datum/reagent/diethylamine
		)
	bounty_text = "Despite the plants being in an environmentally controlled biospheres, they still need some good fertilizer to grow, and we've just run out of it!"

/datum/trader_bounty/stack/golden_circuits
	bounty_name = "Golden Circuits"
	amount = 10
	path = /obj/item/stack/sheet/mineral/gold
	reward_cash = 2000
	bounty_text = "With my ever so advancing robots I require a swath of gold to make the neccesary circuitry for them. I'm sure you've got some lying around?"

/datum/trader_bounty/stack/seeing_diamonds
	bounty_name = "Seeing Diamonds"
	amount = 5
	path = /obj/item/stack/sheet/mineral/diamond
	reward_cash = 3000
	bounty_text = "Did you knew that diamonds make perfect optical component for lasers? And did you also knew that robots with lasers for their eyes are amazing? Yeah I'm sure you can do the math."

/datum/trader_bounty/stack/biological_compounds
	bounty_name = "Biological Compounds"
	amount = 20
	possible_paths = list(
		/obj/item/stack/sheet/mineral/uranium,
		/obj/item/stack/sheet/mineral/plasma
		)
	reward_cash = 3000
	bounty_text = "Did you knew that some materials have a really extraordinary and fascinating effect on biological lifeforms? Especially deadly viruses and... other fun things. Fetch me some of this please."
	bounty_complete_text = "This will prove invaluable to my research."

/datum/trader_bounty/kitchen_restock_botany
	bounty_name = "Kitchen Restock"
	amount = 10
	reward_cash = 2000
	possible_paths = list(
		/obj/item/food/grown/carrot,
		/obj/item/food/grown/potato,
		/obj/item/food/grown/corn,
		/obj/item/food/grown/eggplant,
		/obj/item/food/grown/chili,
		/obj/item/food/grown/tomato,
		/obj/item/food/grown/onion,
		/obj/item/food/grown/banana,
		/obj/item/food/grown/apple,
		/obj/item/food/grown/mushroom/chanterelle,
		/obj/item/food/grown/redbeet,
		/obj/item/food/grown/cabbage,
		/obj/item/food/grown/citrus/lemon
		)
	bounty_text = "We're in need of a couple greens to supply our kitchen. Hope you can help us!"

/datum/trader_bounty/kitchen_restock_meat
	bounty_name = "Kitchen Restock"
	amount = 3
	reward_cash = 2000
	possible_paths = list(
		/obj/item/food/meat/slab/monkey,
		/obj/item/food/fishmeat/carp
		)
	bounty_text = "We're in need of a couple meat products to supply our kitchen. Hope you can help us!"

/datum/trader_bounty/festive_preparations
	bounty_name = "Festive Preperations"
	amount = 10
	reward_cash = 2000
	possible_paths = list(
		/obj/item/food/grown/poppy,
		/obj/item/food/grown/poppy/lily,
		/obj/item/food/grown/poppy/geranium,
		/obj/item/food/grown/poppy/geranium/fraxinella
		)
	bounty_text = "We're making preparations for then new chinese space year, and are in dire need of flowers for decorations."
	bounty_complete_text = "Thank you for saving our festival!."
