#define CULTURE_CULTURE "culture"
#define CULTURE_FACTION "faction"
#define CULTURE_LOCATION "location"

//Amount of linguistic points people have by default. 1 point to understand, 2 points to get it spoken
#define LINGUISTIC_POINTS_DEFAULT 5
// How many points you have upon having QUIRK_LINGUIST.
#define LINGUISTIC_POINTS_LINGUIST 6

#define LANGUAGE_UNDERSTOOD	1
#define LANGUAGE_SPOKEN	2

GLOBAL_LIST_INIT(culture_cultures, subtypesof(/datum/cultural_info/culture))
GLOBAL_LIST_INIT(culture_factions, subtypesof(/datum/cultural_info/faction))
GLOBAL_LIST_INIT(culture_locations, subtypesof(/datum/cultural_info/location))
