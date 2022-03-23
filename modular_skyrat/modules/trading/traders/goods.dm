/datum/trader/toyshop
	name = "Toy Shop Employee"
	possible_origins = list("Toys R Ours", "LET'S GO", "Kay-Cee Toys", "Build-a-Cat", "Magic Box", "The Positronic's Dungeon and Baseball Card Shop")
	speech = list("hail"    = "Uhh... hello? Welcome to ORIGIN, I hope you have a, uhh.... good shopping trip.",
				"hail_deny"         = "Nah, you're not allowed here. At all",

				"trade_complete"       = "Thanks for shopping... here... at ORIGIN.",
				"trade_found_unwanted" = "Nah! That's not what I'm looking for. Something rarer.",
				"trade_not_enough"   = "Just 'cause they're made of cardboard doesn't mean they don't cost money...",
				"how_much"          = "Uhh... I'm thinking like... VALUE. Right? Or something rare that complements my interest.",
				"what_want"         = "Ummmm..... I guess I want..",

				"compliment_deny"   = "Ha! Very funny! You should write your own television show.",
				"compliment_accept" = "Why yes, I do work out.",
				"insult_good"       = "Well, well, well. Guess we learned who was the troll here.",
				"insult_bad"        = "I've already written a nasty Spacebook post in my mind about you.")
	sold_goods = list(
		/datum/sold_goods/plushie_crate,
		/datum/sold_goods/actionfigure_box,
		/datum/sold_goods/foamforce_shotguns,
		/datum/sold_goods/foamforce_pistols,
		/datum/sold_goods/toy_crate
		)
	bought_goods = list(
		/datum/bought_goods/toys,
		/datum/bought_goods/toy_figures
		)

/datum/trader/electronics
	name = "Electronic Shop Employee"
	trade_flags = TRADER_MONEY|TRADER_SELLS_GOODS
	possible_origins = list("Best Sale", "Overstore", "Oldegg", "Circuit Citadel", "Silicon Village", "Positronic Solutions LLC", "Sunvolt Inc.")
	speech = list("hail"    = "Hello, sir! Welcome to ORIGIN, I hope you find what you are looking for.",
				"hail_deny"         = "Your call has been disconnected.",

				"trade_complete"    = "Thank you for shopping at ORIGIN, would you like to get the extended warranty as well?",
				"trade_no_goods"    = "As much as I'd love to buy that from you, I can't.",
				"trade_not_enough"  = "Your offer isn't adequate, sir.",
				"how_much"          = "Your total comes out to VALUE credits.",

				"compliment_deny"   = "Hahaha! Yeah... funny...",
				"compliment_accept" = "That's very nice of you!",
				"insult_good"       = "That was uncalled for, sir. Don't make me get my manager.",
				"insult_bad"        = "Sir, I am allowed to hang up the phone if you continue, sir.")

	sold_goods = list(
		/datum/sold_goods/electronics/airlock,
		/datum/sold_goods/electronics/airalarm,
		/datum/sold_goods/electronics/apc,
		/datum/sold_goods/electronics/firelock,
		/datum/sold_goods/electronics/firealarm,
		/datum/sold_goods/cable_coil,
		/datum/sold_goods/computer_battery,
		/datum/sold_goods/laptop,
		/datum/sold_goods/cell,
		/datum/sold_goods/high_cell
		)
	possible_supplies_bounties = list(
		/datum/trader_bounty/engineering_supplies = 100,
		/datum/trader_bounty/material_supplies = 100
		)

/datum/trader/devices
	name = "Convinince Store Employee"
	trade_flags = TRADER_MONEY|TRADER_SELLS_GOODS
	possible_origins = list("Buy 'n Save", "3 Bucks A Tool", "C&B", "Fentles", "Dr. Goods", "Beevees", "McGillicuddy's")
	speech = list("hail"    = "Hello, hello! Bits and bobs and everything in between, I hope you find what you're looking for!",
				"hail_silicon"      = "Ah! Hello, robot. We only sell things that, ah.... people can hold in their hands, unfortunately. You are still allowed to buy, though!",
				"hail_deny"         = "Oh no. I don't want to deal with YOU.",

				"trade_complete"    = "Thank you! Now remember, there isn't any return policy here, so be careful with that!",
				"trade_no_goods"    = "I'm sorry, I only sell goods.",
				"trade_not_enough"  = "Gotta pay more than that to get that!",
				"how_much"          = "Well... I bought it for a lot, but I'll give it to you for VALUE.",

				"compliment_deny"   = "Uh... did you say something?",
				"compliment_accept" = "Mhm! I can agree to that!",
				"insult_good"       = "Wow, where was that coming from?",
				"insult_bad"        = "Don't make me blacklist your connection.")
	sold_goods = list(
		/datum/sold_goods/flashlight,
		/datum/sold_goods/aicard,
		/datum/sold_goods/binoculars,
		/datum/sold_goods/airlock_painter,
		/datum/sold_goods/multitool,
		/datum/sold_goods/lightreplacer,
		/datum/sold_goods/megaphone,
		/datum/sold_goods/paicard,
		/datum/sold_goods/t_scanner,
		/datum/sold_goods/analyzer,
		/datum/sold_goods/healthanalyzer,
		/datum/sold_goods/taperecorder,
		/datum/sold_goods/mmi,
		/datum/sold_goods/toner,
		/datum/sold_goods/camera,
		/datum/sold_goods/camera_film,
		/datum/sold_goods/gps,
		/datum/sold_goods/dest_tagger,
		/datum/sold_goods/wrapping_paper,
		/datum/sold_goods/anomaly_neutralizer,
		/datum/sold_goods/flash,
		/datum/sold_goods/grey_bull,
		/datum/sold_goods/suture,
		/datum/sold_goods/mesh,
		/datum/sold_goods/material_supplies,
		/datum/sold_goods/medical_supplies
		)

/datum/trader/robots
	name = "Robot Seller"
	trade_flags = TRADER_MONEY|TRADER_SELLS_GOODS
	possible_origins = list("AI for the Straight Guy", "Mechanical Buddies", "Bot Chop Shop", "Omni Consumer Projects")
	speech = list("hail" = "Welcome to ORIGIN! Let me walk you through our fine robotic selection!",
				"hail_silicon"   = "Welcome to ORIGIN! Let- oh, you're a cyborg! Well, your money is good anyway. Welcome, welcome!",
				"hail_deny"      = "ORIGIN no longer wants to speak to you.",

				"trade_complete" = "I hope you enjoy your new robot!",
				"trade_no_goods" = "You gotta buy the robots, sir. I don't do trades.",
				"trade_not_enough" = "You're coming up short on cash.",
				"how_much"       = "My fine selection of robots will cost you VALUE!",

				"compliment_deny"= "Well, I almost believed that.",
				"compliment_accept"= "Thank you! My craftsmanship is my life.",
				"insult_good"    = "Uncalled for.... uncalled for.",
				"insult_bad"     = "I've programmed AI better at insulting than you!")
	sold_goods = list(
		/datum/sold_goods/aicard,
		/datum/sold_goods/paicard,
		/datum/sold_goods/posibrain,
		/datum/sold_goods/bot/medbot,
		/datum/sold_goods/bot/firebot,
		/datum/sold_goods/bot/floorbot,
		/datum/sold_goods/bot/cleanbot
		)
	possible_bounties = list(
		/datum/trader_bounty/stack/golden_circuits = 100,
		/datum/trader_bounty/stack/seeing_diamonds = 100
		)
	possible_supplies_bounties = list(
		/datum/trader_bounty/engineering_supplies = 100,
		/datum/trader_bounty/material_supplies = 100
		)

/datum/trader/xeno_shop
	name = "Xenolife Collector"
	possible_origins = list("CSV Not a Poacher", "XenoHugs", "Exotic Specimen Acquisition", "Skinner Catering Reseller", "Corporate Companionship Division", "Lonely Pete's Exotic Companionship","Space Wei's Exotic Cuisine")
	speech = list("hail"    = "Welcome! We are always looking to acquire more exotic life forms.",
				"hail_deny"         = "We no longer wish to speak to you. Please contact our legal representative if you wish to rectify this.",

				"trade_complete"    = "Remember to give them attention and food. They are living beings, and you should treat them like so.",
				"trade_found_unwanted" = "I only want animals. I don't need food or shiny things. I'm looking for specific ones, at that. Ones I already have the cage and food for.",
				"trade_not_enough"   = "I'd give you this for free, but I need the money to feed the specimens. So you must pay in full.",
				"how_much"          = "This is a good choice. I believe it will cost you VALUE credits.",
				"what_want"         = "I have the facilities, currently, to support",

				"compliment_deny"   = "According to customs on 34 planets I traded with, this constitutes sexual harrasment.",
				"compliment_accept" = "Thank you. I needed that.",
				"insult_good"       = "No need to be upset, I believe we can do business.",
				"insult_bad"        = "I have traded dogs with more bark than that.")
	//Not much for now, need more cool alien mobs
	//Not much for now, need more cool alien mobs. MORE IMPORTANTLY we need fauna nets to catch them!
	sold_goods = list(
		/datum/sold_goods/space_carp,
		/datum/sold_goods/goliath
		)
	bought_goods = list(
		/datum/bought_goods/space_carp,
		/datum/bought_goods/goliath
		)
	possible_supplies_bounties = list(
		/datum/trader_bounty/food_supplies = 100,
		/datum/trader_bounty/medical_supplies = 100
		)

/datum/trader/medical
	name = "Medical Supplier"
	sell_margin = 1.3
	possible_origins = list("Infirmary of CSV Iniquity", "Dr.Krieger's Practice", "Legit Medical Supplies (No Refund)", "Mom's & Pop's Addictive Opoids", "Legitimate Pharmaceutical Firm", "Designer Drugs by Lil Xanny")
	speech = list("hail"    = "Huh? How'd you get this number?! Oh well, if you wanna talk biz, I'm listening.",
				"hail_deny"         = "This is an automated message. Feel free to fuck the right off after the buzzer. *buzz*",

				"trade_complete"    = "Good to have business with ya. Remember, no refunds.",
				"trade_found_unwanted" = "What the hell do you expect me to do with this junk?",
				"trade_not_enough"   = "Sorry, pal, full payment upfront, I don't write the rules. Well, I do, but that's beside the point.",
				"how_much"          = "Hmm, this is one damn fine item, but I'll part with it for VALUE credits.",
				"what_want"         = "I could always use some:...",

				"compliment_deny"   = "Haha, how nice of you. Why don't you go fall in an elevator shaft.",
				"compliment_accept" = "Damn right I'm awesome, tell me more.",
				"insult_good"       = "Damn, pal, no need to get snippy.",
				"insult_bad"        = "*muffled laughter* Sorry, was that you trying to talk shit? Adorable.")
	sold_goods = list(
		/datum/sold_goods/firstaid,
		/datum/sold_goods/firstaid_fire,
		/datum/sold_goods/firstaid_brute,
		/datum/sold_goods/firstaid_toxin,
		/datum/sold_goods/pill_bottle_multiver,
		/datum/sold_goods/pill_bottle_iron,
		/datum/sold_goods/scalpel,
		/datum/sold_goods/circular_saw,
		/datum/sold_goods/bonesetter,
		/datum/sold_goods/hemostat,
		/datum/sold_goods/retractor,
		/datum/sold_goods/cautery,
		/datum/sold_goods/universal_blood_pack,
		/datum/sold_goods/bottle_morphine,
		/datum/sold_goods/bottle_chloral,
		/datum/sold_goods/bottle_epinephrine,
		/datum/sold_goods/suture,
		/datum/sold_goods/mesh,
		/datum/sold_goods/medical_supplies
		)
	bought_goods = list(
		/datum/bought_goods/liver,
		/datum/bought_goods/lungs,
		/datum/bought_goods/heart,
		/datum/bought_goods/reagent/meth
		)
	possible_deliveries = list(
		/datum/delivery_run/medical_supplies_delivery = 100,
		/datum/delivery_run/delicate_biological_matter = 50
		)
	possible_bounties = list(
		/datum/trader_bounty/reagent/medicine_easy = 100,
		/datum/trader_bounty/reagent/medicine_hard = 100,
		/datum/trader_bounty/stack/biological_compounds = 100
		)

/datum/trader/mining
	name = "Rock'n'Drill Mining Inc"
	current_credits = RICH_TRADER_CREDIT_AMOUNT
	sell_margin = 1.3
	possible_origins = list("Automated Smelter AH-532", "CMV Locust", "The Galactic Foundry Company", "Crucible LLC")
	speech = list("hail"    = "Welcome to R'n'D Mining. Please place your order.",
				"hail_deny"         = "There is no response on the line.",

				"trade_complete"    = "Transaction complete. Please use our services again",
				"trade_found_unwanted" = "Sorry, we are currently not looking to purchase these items.",
				"trade_not_enough"   = "Sorry, this is an insufficient sum for this purchase.",
				"how_much"          = "For ONE entry of ITEM the price would be VALUE credits.",
				"what_want"         = "We are currently looking to procure",

				"compliment_deny"   = "I am afraid this is beyond my competency.",
				"compliment_accept" = "Thank you.",
				"insult_good"       = "Alright, we will reconsider the terms.",
				"insult_bad"        = "This is not acceptable, please cease.")

	bought_goods = list(
		/datum/bought_goods/stack/iron,
		/datum/bought_goods/stack/silver,
		/datum/bought_goods/stack/gold,
		/datum/bought_goods/stack/uranium,
		/datum/bought_goods/stack/plasma,
		/datum/bought_goods/stack/diamond
		)
	sold_goods = list(
		/datum/sold_goods/stack/iron_ten,
		/datum/sold_goods/stack/glass_ten,
		/datum/sold_goods/stack/silver_ten,
		/datum/sold_goods/stack/gold_ten,
		/datum/sold_goods/stack/uranium_ten,
		/datum/sold_goods/stack/plasma_ten,
		/datum/sold_goods/stack/diamond_five,
		/datum/sold_goods/mining_kit,
		/datum/sold_goods/material_supplies
		)
	possible_deliveries = list(
		/datum/delivery_run/mineral_delivery = 100,
		/datum/delivery_run/industrial_equipment_delivery = 50
		)
	possible_bounties = list(
		/datum/trader_bounty/gas/hard_to_breathe = 100,
		/datum/trader_bounty/heavy_lifting = 100
		)

/datum/trader/petshop
	name = "Pet Shop Employee"
	possible_origins = list("Fuzzy Wuzzy's", "Alley Cats", "Happy Paws", "All 4 Pets", "Fins & Gills", "Pick Me!", "Stylish Whiskers")
	bought_goods = list(/datum/bought_goods/pets)
	sold_goods = list(
		/datum/sold_goods/corgi,
		/datum/sold_goods/fox,
		/datum/sold_goods/cat,
		/datum/sold_goods/penguin,
		/datum/sold_goods/sloth,
		/datum/sold_goods/lizard
		)

/datum/trader/archeology
	name = "Artifact Shop Employee"
	possible_origins = list("Jungle Relics", "Atlantis", "Fossilized Monsters", "Secrets of the Earth")
	bought_goods = list(
		/datum/bought_goods/fossil,
		/datum/bought_goods/excavation_junk,
		/datum/bought_goods/excavation_artifact,
		/datum/bought_goods/anomalous_crystal
		)
	sold_goods = list(
		/datum/sold_goods/excavation_pick_set,
		/datum/sold_goods/excavation_measuring_tape,
		/datum/sold_goods/excavation_depth_scanner,
		/datum/sold_goods/excavation_locator,
		/datum/sold_goods/anomalous_crystal
		)
	possible_deliveries = list(
		/datum/delivery_run/artifact_delivery = 100
		)
	possible_supplies_bounties = list(
		/datum/trader_bounty/medical_supplies = 100
		)

/datum/trader/atmospherics
	name = "Atmospheric Shop Employee"
	trade_flags = TRADER_MONEY|TRADER_SELLS_GOODS
	possible_origins = list("Fill Up Tanker", "Gasser'up", "Tank Topper", "Uncle Joe's Jenkem Emporium")
	sold_goods = list(
		/datum/sold_goods/belt/nitrogen,
		/datum/sold_goods/belt/plasma,
		/datum/sold_goods/emergency_oxygen,
		/datum/sold_goods/voidsuit,
		/datum/sold_goods/insulated_gloves,
		/datum/sold_goods/toolbox_kit,
		/datum/sold_goods/engineering_supplies
	)
	possible_supplies_bounties = list(
		/datum/trader_bounty/material_supplies = 100
		)
