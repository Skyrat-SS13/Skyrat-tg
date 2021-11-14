#define VORE_SAVEFILE_VERSION 1 //UPDATE THIS AND CREATE SANITY CHECKS IF YOU MAKE MAJOR CHANGES

//TOGGLES - EVERYTHING YOU NEED TO UPDATE FOR NEW THINGS IS IN THIS SECTION OR IN THE switch_toggles() PROC IN vore_prefs.dm (although if creating a new section, update sanitize_vars() in vore_prefs.dm)

#define VORE_MECHANICS_TOGGLES "mechanics"
#define VORE_MECHANICS_TOGGLES_DEFAULT (DEVOURABLE)
#define DEVOURABLE (1 << 1)
#define DIGESTABLE (1 << 2)
#define ABSORBABLE (1 << 3)
//#define SIMPLEMOB (1 << 4)

#define VORE_CHAT_TOGGLES "chat"
#define VORE_CHAT_TOGGLES_DEFAULT (SEE_EXAMINES|SEE_STRUGGLES|SEE_OTHER_MESSAGES)
#define SEE_EXAMINES  (1 << 1)
#define SEE_STRUGGLES  (1 << 2)
#define SEE_OTHER_MESSAGES  (1 << 3) //may wanna split this up a bit, I dunno

/*
#define VORE_SOUND_TOGGLES "sound"
#define VORE_SOUND_TOGGLES_DEFAULT (0) //keep this defaulting to all of them off because vore sounds are more of a pref break than the rest
#define HEAR_GULP_NOISES (1 << 1)
#define HEAR_BELLY_NOISES (1 << 2)
#define HEAR_DIGEST_NOISES (1 << 3)
#define HEAR_STRUGGLE_NOISES (1 << 4)
#define HEAR_DEATH_NOISES (1 << 5)
*/

#define VORE_TOGGLE_SECTION_AMOUNT 2 //VORE_MECHANICS_TOGGLES into one section, VORE_CHAT_TOGGLES into another, etc if you add more update this and the switch_toggles() in vore_prefs


#define MAX_BELLIES 8
#define MAX_BELLY_NAME_LENGTH 30 //yeah I dunno, adjust this if you want to
#define VORE_EATING_TIME (5 SECONDS)

#define UPDATE_INSIDE (1 << 0)
#define UPDATE_BELLY_VARS (1 << 1)
#define UPDATE_BELLY_LIST (1 << 2)
#define UPDATE_CONTENTS (1 << 3)
#define UPDATE_TOGGLES (1 << 4)
#define UPDATE_CHAR_VARS (1 << 5)
#define UPDATE_STATIC_DATA (1 << 6)
#define UPDATE_ALL (UPDATE_INSIDE|UPDATE_BELLY_VARS|UPDATE_BELLY_LIST|UPDATE_CONTENTS|UPDATE_TOGGLES|UPDATE_CHAR_VARS)


/* PLACES YOU NEED TO ADD THE FOLLOWING DEFINES TO IF YOU WANT TO ADD NEW MODES/EMOTE LISTS:
static_belly_vars()		vore_helpers.dm
default_belly_info()	vore_helpers.dm
get_input()				vore_prefs.dm
get_desc_for_input()	vore_prefs.dm
ui_static_data()		vore_prefs.dm
corresponding things in VorePanel.js (tgui interfaces folder)
*/

#define VORE_MODE_HOLD 0
#define VORE_MODE_DIGEST 1
#define VORE_MODE_ABSORB 2
#define VORE_MODE_UNABSORB 3
//#define VORE_MODE_NOISY 4

#define BELLY_NAME "name"
#define BELLY_DESC "desc"
#define BELLY_MODE "mode"
#define BELLY_SWALLOW_VERB "swallow_verb"
#define BELLY_CAN_TASTE "can_taste"
#define LIST_DIGEST_PREY "dmp" //digest_messages_prey
#define LIST_DIGEST_PRED "dmo" //digest_messages_owner
#define LIST_ABSORB_PREY "amp" //absorb_messages_prey
#define LIST_ABSORB_PRED "amo" //absorb_messages_owner
#define LIST_UNABSORB_PREY "ump" //unabsorb_messages_prey
#define LIST_UNABSORB_PRED "umo" //unabsorb_messages_owner
#define LIST_STRUGGLE_INSIDE "smi" //struggle_messages_inside
#define LIST_STRUGGLE_OUTSIDE "smo" //struggle_messages_outside
#define LIST_EXAMINE "em"  //examine_messages
