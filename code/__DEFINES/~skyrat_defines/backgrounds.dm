//Amount of linguistic points people have by default. 1 point to understand, 2 points to get it spoken
#define LINGUISTIC_POINTS_DEFAULT 5
// How many points you have upon having QUIRK_LINGUIST.
#define LINGUISTIC_POINTS_LINGUIST 6

#define LANGUAGE_UNDERSTOOD	1
#define LANGUAGE_SPOKEN	2

// Item slot defines
#define ITEM_SLOT_PASSPORT (1<<20)
#define ui_passport "CENTER-4:12,SOUTH+1:7"
#define OFFSET_PASSPORT "passport"
// This is a constant all the way through layering code. Byond's math precision issues don't matter here.
#define PASSPORT_LAYER 25.9

// Bitflags for groups of culture entries that should not be allowed to mix.
// All cultures that have large amounts of synths allow synth backgrounds too.
#define BACKGROUNDS_ALL 0
#define BACKGROUNDS_SYNTH (1<<1)
#define BACKGROUNDS_AKULAN (1<<2)
#define BACKGROUNDS_TAJARAN (1<<3)
#define BACKGROUNDS_NANOTRASEN ((1<<4) | BACKGROUNDS_SYNTH)
#define BACKGROUNDS_SYNDICATE ((1<<5) | BACKGROUNDS_SYNTH)
#define BACKGROUNDS_SOLFED ((1<<6) | BACKGROUNDS_SYNTH)
#define BACKGROUNDS_LAVALAND (1<<7)
#define BACKGROUNDS_NRI (1<<8 | BACKGROUNDS_SYNTH)
#define BACKGROUNDS_SKRELL_VULPAKIN (1<<9)
#define BACKGROUNDS_MOHGES (1<<10)

// Group defines. Allows anything inside this group.
#define BACKGROUNDS_GROUP_HUMAN (BACKGROUNDS_SOLFED | BACKGROUNDS_SYNDICATE | BACKGROUNDS_NANOTRASEN | BACKGROUNDS_SYNTH | BACKGROUNDS_NRI)
// Alien as in not human, dorks.
#define BACKGROUNDS_GROUP_ALIEN (BACKGROUNDS_AKULAN | BACKGROUNDS_TAJARAN | BACKGROUNDS_LAVALAND | BACKGROUNDS_SKRELL_VULPAKIN | BACKGROUNDS_MOHGES)
#define BACKGROUNDS_GROUP_SPACE_FARING (BACKGROUNDS_GROUP_HUMAN | BACKGROUNDS_TAJARAN | BACKGROUNDS_AKULAN | BACKGROUNDS_SKRELL_VULPAKIN | BACKGROUNDS_MOHGES)
