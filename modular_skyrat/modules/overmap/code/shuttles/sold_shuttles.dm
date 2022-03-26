/datum/sold_shuttle
	/// Name of the shuttle
	var/name = "Shuttle Name"
	/// Description of the shuttle
	var/desc = "Description."
	/// Detailed description of the ship
	var/detailed_desc = "Detailed specifications."
	/// ID of the shuttle
	var/shuttle_id
	/// How much does it cost
	var/cost = 5000
	/// How much left in stock
	var/stock = 1
	/// What type of the shuttle it is. Consoles may have limited purchase range
	var/shuttle_type = SHUTTLE_CIV
	/// Associative to TRUE list of dock id's that this template can fit into
	var/allowed_docks = list()

///////////////////
//Common shuttles//
///////////////////

/datum/sold_shuttle/common_vulture
	name = "MS Vulture"
	desc = "A medium sized mining shuttle, equipped with living space for one."
	detailed_desc = "Sporting seating for four, and living space for one, the Vulture series of ships is an excellent choice for the average crew member to take a space vacation. Including the mining laser on board, the enterprising pilot could even go for some ore asteroid mining."
	shuttle_id = "common_vulture"
	cost = 7500
	stock = 2
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_MINING

/datum/sold_shuttle/common_baserunner
	name = "MS Baserunner"
	desc = "A small cargo and personnel shuttle, lacks a full airlock."
	detailed_desc = "With seating for three, and a small cargo capacity, the Baserunner series certainly sets no records, but remains a very affordable option for anyone in need of a service shuttle for a variety of missions."
	shuttle_id = "common_baserunner"
	cost = 5000
	stock = 3
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_MINING

/datum/sold_shuttle/common_workman
	name = "MS Workman"
	desc = "An extremely small resource collection ship, seats a single person."
	detailed_desc = "While diminutive in size, the Workman series of mining shuttles makes up for that in price and utility, perfect for when you need a ship to mine some asteroids, and you need it now."
	cost = 3000
	stock = 5
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_MINING

////////////////////////
//Exploration shuttles//
////////////////////////

/datum/sold_shuttle/crow
	name = "NXV Crow"
	desc = "A medium sized cargo shuttle, equipped with living quarters."
	detailed_desc = "With full trading suite, and decently sized cargo bay to boot, the Crow series of ships may not get any awards for looks, but it gets the job done, a mobile cargo department at your fingertips for the right price."
	shuttle_id = "exploration_crow"
	cost = 7500
	stock = 2
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/deckard
	name = "NXV Deckard"
	desc = "A reliable and cheap multi-purpose shuttle of medium size."
	detailed_desc = "Sporting just about everything an up and coming pilot could want on a shuttle, the Deckard series is a jack of all trades, and master of none, paired with the reasonable price range it makes a good ship for pilots of all experience levels."
	shuttle_id = "exploration_deckard"
	cost = 6000
	stock = 3
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/nexus
	name = "NXV Nexus"
	desc = "A large, well equipped exploration shuttle."
	detailed_desc = "Rocking just about any crew facility a captain could want on a ship, the Nexus series is a perfect shuttle for long flights across the stars, should you have deep enough pockets to afford buying one."
	shuttle_id = "exploration_nexus"
	cost = 15500
	stock = 2
	allowed_docks = list(DOCKS_HUGE_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/nexus_retrofit
	name = "NXV Nexus Retrofit"
	desc = "A massive exploration shuttle, well equipped, it is a retrofit of the NXV Nexus."
	detailed_desc = "Dominating the exploration ship game, the Nexus Retrofit series is any up and coming captain's dream, with crew facilities far enhanced over the baseline Nexus series, the only downfall being the extreme price associated."
	shuttle_id = "exploration_nexus_2"
	cost = 22000
	allowed_docks = list(DOCKS_HUGE_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

///////////////////////////
//BUILD YOUR OWN SHUTTLES//
///////////////////////////

/datum/sold_shuttle/platform_small
	name = "Small Shuttle Platform"
	desc = "Empty 'build your own shuttle' platform. It's small sized (13x9) and of rectangular shape. It comes with some construction supplies."
	detailed_desc = "The construction supplies contain:\
		<BR> - 1 Shuttle Computer (Circuit board)\
		<BR> - 2 Propulsion Engines (Circuit board)\
		<BR> - 1 Rapid Pipe Dispenser\
		<BR> - 1 Rapid Construction Device\
		<BR> - 1 mechanical toolbox\
		<BR> - 1 electrical toolbox\
		<BR> - 1 APC electronics\
		<BR> - 1 air alarm electronics\
		<BR> - 1 air canister\
		<BR> - 50 iron sheets\
		<BR> - 50 glass sheets\
		<BR> - 50 titanium sheets\
		"
	cost = 3000
	stock = 3
	shuttle_id = "common_platform_small"
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)

/datum/sold_shuttle/platform_medium
	name = "Medium Shuttle Platform"
	desc = "Empty 'build your own shuttle' platform. It's medium sized (17x13) and of a bullet shape. It comes with some construction supplies."
	detailed_desc = "The construction supplies contain:\
		<BR> - 1 Shuttle Computer (Circuit board)\
		<BR> - 3 Propulsion Engines (Circuit board)\
		<BR> - 1 Rapid Pipe Dispenser\
		<BR> - 1 Rapid Construction Device\
		<BR> - 1 mechanical toolbox\
		<BR> - 1 electrical toolbox\
		<BR> - 1 APC electronics\
		<BR> - 1 air alarm electronics\
		<BR> - 2 air canisters\
		<BR> - 100 iron sheets\
		<BR> - 100 glass sheets\
		<BR> - 100 titanium sheets\
		"
	cost = 5000
	stock = 2
	shuttle_id = "common_platform_medium"
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)

/datum/sold_shuttle/platform_large
	name = "Large Shuttle Platform"
	desc = "Empty 'build your own shuttle' platform. It's large sized (23x15) and of a bullet shape. It comes with some construction supplies."
	detailed_desc = "The construction supplies contain:\
		<BR> - 1 Shuttle Computer (Circuit board)\
		<BR> - 5 Propulsion Engines (Circuit board)\
		<BR> - 1 Rapid Pipe Dispenser\
		<BR> - 1 Rapid Construction Device\
		<BR> - 1 mechanical toolbox\
		<BR> - 1 electrical toolbox\
		<BR> - 1 APC electronics\
		<BR> - 1 air alarm electronics\
		<BR> - 4 air canister\
		<BR> - 200 iron sheets\
		<BR> - 200 glass sheets\
		<BR> - 200 titanium sheets\
		"
	cost = 10000
	shuttle_id = "common_platform_large"
	allowed_docks = list(DOCKS_LARGE_UPWARDS)

////////
//MISC//
////////
