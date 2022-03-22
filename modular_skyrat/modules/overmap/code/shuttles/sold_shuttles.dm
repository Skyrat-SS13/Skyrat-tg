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
/datum/sold_shuttle/common_mining
	name = "Small Travel Shuttle"
	desc = "Small shuttle fitted for up to 4 people. Perfect for travel, but not much else"
	detailed_desc = "It's small sized and it's equipped with 1 burst engine"
	cost = 5000
	shuttle_id = "mining_common_meta"
	allowed_docks = list(DOCKS_SMALL_UPWARDS)

/datum/sold_shuttle/common_vulture
	name = "MS Vulture"
	desc = "A medium sized mining shuttle, equipped with living quarters."
	detailed_desc = "Mounted with four 'Hightail' shuttle drives, this ship is fit for a variety of missions, with both equipment for mining, long-term journeys, and seating for extra crew."
	shuttle_id = "common_vulture"
	cost = 7500
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_MINING

/datum/sold_shuttle/common_baserunner
	name = "MS Baserunner"
	desc = "A small cargo and personnel shuttle, lacks a full airlock."
	detailed_desc = "Originally designed to fit in the main hangar of the rare vixen carrier class, also serves purpose as an inexpensive and reliable ship for light work."
	shuttle_id = "common_baserunner"
	cost = 5000
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)

/datum/sold_shuttle/common_workman
	name = "MS Workman"
	desc = "An extremely small resource collection ship, seats a single person."
	detailed_desc = "Made to usually operate from larger motherships, this single seat mining shuttle is still capable of limited independent operation."
	cost = 3000
	allowed_docks = list(DOCKS_SMALL_UPWARDS)

////////////////////////
//Exploration shuttles//
////////////////////////
/datum/sold_shuttle/crow
	name = "NXV Crow"
	desc = "A medium sized cargo shuttle, equipped with living quarters."
	detailed_desc = "Filling the niche role of a speedy cargo hauler, the Crow's six 'Hightail' shuttle drives and the spacious cargo bay lets you move just about anything to anywhere with short delay."
	shuttle_id = "exploration_crow"
	cost = 7500
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/deckard
	name = "NXV Deckard"
	desc = "A reliable and cheap multi-purpose shuttle of medium size."
	detailed_desc = "While it does nothing in particular amazingly well, the Deckard's four 'Hightail' shuttle drives, combined with the full suite of shuttle equipment provides at least decent performance in all fields."
	shuttle_id = "exploration_deckard"
	cost = 6000
	allowed_docks = list(DOCKS_MEDIUM_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/nexus
	name = "NXV Nexus"
	desc = "A large, decently well equipped exploration shuttle."
	detailed_desc = "Featuring six high-capacity 'Harrier' drives, this ship is equipped with everything a modern spacer would need for mostly station-independent space exploration, with medical and even resourcing facilies."
	shuttle_id = "exploration_nexus"
	cost = 15500
	allowed_docks = list(DOCKS_HUGE_UPWARDS)
	shuttle_type = SHUTTLE_EXPLORATION

/datum/sold_shuttle/nexus_retrofit
	name = "NXV Nexus Retrofit"
	desc = "A large sized exploration shuttle, well equipped, it is a retrofit of the NXV Nexus."
	detailed_desc = "Holding the same six high-capacity 'Harrier' drives as the standard nexus, this model flaunts a much larger size, and as a result, much larger and enhanced facilities, at the cost of the vessel's top speed."
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

