/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME   (you can make as many subdivisions as you want)
	name = "NICE NAME" (not required but makes things really nice)
	icon = 'ICON FILENAME' (defaults to 'icons/turf/areas.dmi')
	icon_state = "NAME OF ICON" (defaults to "unknown" (blank))
	requires_power = FALSE (defaults to true)
	ambience_index = AMBIENCE_GENERIC   (picks the ambience from an assoc list in ambience.dm)
	ambientsounds = list() (defaults to ambience_index's assoc on Initialize(). override it as "ambientsounds = list('sound/ambience/signal.ogg')" or by changing ambience_index)

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


/*-----------------------------------------------------------------------------*/

// EXTRA

//STATION13

//AI

/area/ai_monitored/ai_sat/mommi
	name = "MoMMI Nest"
	icon_state = "ai"

//AI - Turret_protected

//Maintenance

//Maintenance - Departmental

//Maintenance - Generic

//Radiation Storm Shelter

//Hallway

//Command

//Command - Teleporters

//Command - AI Monitored

//Commons

//Commons - Vacant Rooms

//Service

//Engineering

//Engineering - Construction

//Solars

//Solar Maint

//MedBay

//Security

/area/security/lobby
	name = "Security Lobby"
	icon_state = "security"

/area/security/dorms
	name = "Security Dormitories"
	icon_state = "dorms"

/area/security/medical
	name = "Security Medbay"
	icon_state = "security"

/area/security/eva
	name = "Security E.V.A."
	icon_state = "security"

/area/security/interrogation/recording
	name = "Brig Recording Room"
	icon_state = "interrogation"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/security/prison/perma
	name = "Permanent Confinement"
	icon_state = "sec_prison"

//Security - AI Monitored

//Cargo

//Science

//Research Outpost

/area/science/research_outpost
	has_gravity = STANDARD_GRAVITY

/area/science/research_outpost/hallway
	name = "Research Outpost Hallway"
	icon_state = "hallC"

/area/science/research_outpost/entry
	name = "Research Outpost Shuttle Dock"
	icon_state = "entry"

/area/science/research_outpost/maint
	name = "Research Outpost Maintenance"
	icon_state = "maint_sci"

/area/science/research_outpost/storage
	name = "Toxins Storage"
	icon_state = "tox_storage"

/area/science/research_outpost/longtermstorage
	name = "Long-Term Storage"
	icon_state = "tox_storage"

/area/science/research_outpost/maintstorage
	name = "Maintenance Storage"
	icon_state = "aux_storage"

/area/science/research_outpost/tempstorage
	name = "Temporary Storage"
	icon_state = "aux_storage"

/area/science/research_outpost/gearstorage
	name = "Expidition Preparation"
	icon_state = "eva"

/area/science/research_outpost/iso1
	name = "Isolation Cell 1"
	icon_state = "research"

/area/science/research_outpost/iso2
	name = "Isolation Cell 2"
	icon_state = "research"

/area/science/research_outpost/iso3
	name = "Isolation Cell 3"
	icon_state = "research"

/area/science/research_outpost/anomaly
	name = "Anomalous Materials Lab"
	icon_state = "research"

/area/science/research_outpost/harvesting
	name = "Exotic Particles Collection"
	icon_state = "research"

/area/science/research_outpost/toxins
	name = "Research Outpost Toxins Mixing Lab"
	icon_state = "tox_mix"

/area/science/research_outpost/xenobot
	name = "Research Outpost Xenobotany"
	icon_state = "hydro"

/area/science/research_outpost/med
	name = "Research Outpost Medical"
	icon_state = "medbay1"

/area/science/research_outpost/atmos
	name = "Research Outpost Atmospherics"
	icon_state = "atmos"

/area/science/research_outpost/power
	name = "Research Outpost Power"
	icon_state = "engine"

// Telecommunications Satellite

//Telecommunications - On Station

//External Hull Access

//Trade Outpost

/area/trade
	has_gravity = STANDARD_GRAVITY

/area/trade/tradepost
	name = "Trade Post Processing"
	icon_state = "vacant_commissary"

/area/trade/hallway
	name = "Trade Post Hallways"
	icon_state = "hallC"

/area/trade/docks
	name = "Trade Post Docking"
	icon_state = "entry"

/area/trade/dorms
	name = "Trade Post Dormitories"
	icon_state = "dorms"

/area/trade/vault
	name = "Trade Post Vault"
	icon_state = "nuke_storage"

/area/trade/eva
	name = "Trade Post EVA"
	icon_state = "eva"

/area/trade/medbay
	name = "Trade Post Medbay"
	icon_state = "medbay1"

/area/trade/garden
	name = "Trade Post Botanical Gardens"
	icon_state = "garden"

/area/trade/atmos
	name = "Trade Post Atmospherics"
	icon_state = "atmos"
