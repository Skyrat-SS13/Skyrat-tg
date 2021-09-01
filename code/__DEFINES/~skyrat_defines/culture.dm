#define CULTURE_CULTURE "culture"
#define CULTURE_FACTION "faction"
#define CULTURE_LOCATION "location"

//Amount of linguistic points people have by default. 1 point to understand, 2 points to get it spoken
#define LINGUISTIC_POINTS_DEFAULT 5
// How many points you have upon having QUIRK_LINGUIST.
#define LINGUISTIC_POINTS_LINGUIST 6

#define LANGUAGE_UNDERSTOOD	1
#define LANGUAGE_SPOKEN	2

//GROUPED CULTURAL DEFINES FOR SPECIES
#define CULTURES_EXOTIC	/datum/cultural_info/culture/generic, \
						/datum/cultural_info/culture/vatgrown, \
						/datum/cultural_info/culture/spacer_core, \
						/datum/cultural_info/culture/spacer_frontier, \
						/datum/cultural_info/culture/zolmalchi

#define CULTURES_XENO	/datum/cultural_info/culture/xenoknockoff

#define CULTURES_LIZARD /datum/cultural_info/culture/lavaland

#define CULTURES_HUMAN	/datum/cultural_info/culture/generic_human, \
						/datum/cultural_info/culture/martian_surfacer, \
						/datum/cultural_info/culture/martian_tunneller, \
						/datum/cultural_info/culture/earthling, \
						/datum/cultural_info/culture/luna_poor, \
						/datum/cultural_info/culture/luna_rich, \
						/datum/cultural_info/culture/terran, \
						/datum/cultural_info/culture/venusian_upper, \
						/datum/cultural_info/culture/venusian_surfacer, \
						/datum/cultural_info/culture/belter, \
						/datum/cultural_info/culture/plutonian, \
						/datum/cultural_info/culture/ceti

#define LOCATIONS_GENERIC	/datum/cultural_info/location/generic, \
							/datum/cultural_info/location/stateless

#define LOCATIONS_HUMAN /datum/cultural_info/location/earth, \
						/datum/cultural_info/location/mars, \
						/datum/cultural_info/location/luna, \
						/datum/cultural_info/location/mars, \
						/datum/cultural_info/location/venus, \
						/datum/cultural_info/location/ceres, \
						/datum/cultural_info/location/pluto, \
						/datum/cultural_info/location/cetiepsilon, \
						/datum/cultural_info/location/eos, \
						/datum/cultural_info/location/terra, \
						/datum/cultural_info/location/tersten, \
						/datum/cultural_info/location/lorriman, \
						/datum/cultural_info/location/cinu, \
						/datum/cultural_info/location/yuklid, \
						/datum/cultural_info/location/lordania, \
						/datum/cultural_info/location/kingston, \
						/datum/cultural_info/location/gaia, \
						/datum/cultural_info/location/magnitka


#define FACTIONS_GENERIC	/datum/cultural_info/faction/none, \
							/datum/cultural_info/faction/generic, \
							/datum/cultural_info/faction/nanotrasen, \
							/datum/cultural_info/faction/freetrade

#define FACTIONS_HUMAN		/datum/cultural_info/faction/solgov, \
							/datum/cultural_info/faction/fleet, \
							/datum/cultural_info/faction/torchco, \
							/datum/cultural_info/faction/gcc, \
							/datum/cultural_info/faction/remote, \
							/datum/cultural_info/faction/police, \
							/datum/cultural_info/faction/xynergy, \
							/datum/cultural_info/faction/hephaestus, \
							/datum/cultural_info/faction/pcrc, \
							/datum/cultural_info/faction/saare, \
							/datum/cultural_info/faction/dais

GLOBAL_LIST_EMPTY(culture_cultures)
GLOBAL_LIST_EMPTY(culture_factions)
GLOBAL_LIST_EMPTY(culture_locations)
