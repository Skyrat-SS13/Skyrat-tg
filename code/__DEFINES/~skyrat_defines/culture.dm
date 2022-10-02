//Amount of linguistic points people have by default. 1 point to understand, 2 points to get it spoken
#define LINGUISTIC_POINTS_DEFAULT 5
// How many points you have upon having QUIRK_LINGUIST.
#define LINGUISTIC_POINTS_LINGUIST 6

#define LANGUAGE_UNDERSTOOD	1
#define LANGUAGE_SPOKEN	2

GLOBAL_LIST_EMPTY(employment)
GLOBAL_LIST_EMPTY(social_backgrounds)
GLOBAL_LIST_EMPTY(origins)
GLOBAL_LIST_EMPTY(culture_features)

// Bitflags for groups of culture entries that should not be allowed to mix.
// All cultures that have large amounts of synths allow synth backgrounds too.
#define CULTURE_ALL 0
#define CULTURE_SYNTH (1<<1)
#define CULTURE_AKULAN (1<<2)
#define CULTURE_TAJARAN (1<<3)
#define CULTURE_NT ((1<<4) | CULTURE_SYNTH)
#define CULTURE_SYNDICATE ((1<<5) | CULTURE_SYNTH)
#define CULTURE_SOL ((1<<6) | CULTURE_SYNTH)
#define CULTURE_LAVALAND (1<<7)
#define CULTURE_NRI (1<<8 | CULTURE_SYNTH)

// Group defines
#define CULTURE_GROUP_HUMAN (CULTURE_SOL | CULTURE_SYNDICATE | CULTURE_NT | CULTURE_SYNTH | CULTURE_NRI)
#define CULTURE_GROUP_SPACE_FARING (CULTURE_GROUP_HUMAN | CULTURE_TAJARAN | CULTURE_AKULAN)
