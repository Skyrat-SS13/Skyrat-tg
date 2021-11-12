#define SEE_EXAMINES 			(1 << 1)
#define SEE_STRUGGLES 			(1 << 2)
#define SEE_OTHER_MESSAGES 		(1 << 3) //may wanna split this up a bit, I dunno
#define DEVOURABLE				(1 << 4)
#define DIGESTABLE				(1 << 5)
#define ABSORBABLE				(1 << 6)
//#define CAN_HEAR_NOISES		(1 << 7)
//#define SIMPLEMOB_VORE		(1 << 8)
#define VORE_TOGGLES_AMOUNT		6 //update this if you add more toggles above
#define VORE_TOGGLES_DEFAULT	(SEE_EXAMINES|SEE_STRUGGLES|SEE_OTHER_MESSAGES|DEVOURABLE)

#define MAX_BELLIES 			8
#define MAX_BELLY_NAME_LENGTH	30 //yeah I dunno, adjust this if you want to
#define VORE_EATING_TIME		(5 SECONDS)


/* 	PLACES YOU NEED TO ADD THE FOLLOWING DEFINES TO IF YOU WANT TO ADD NEW THINGS:
	static_belly_vars() 	vore_helpers.dm
	default_belly_info()	vore_helpers.dm
	get_input()				vore_prefs.dm
	get_desc_for_input()	vore_prefs.dm
	corresponding things in VorePanel.js (tgui interfaces folder)
*/

#define VORE_MODE_HOLD			0
#define VORE_MODE_DIGEST		1
#define VORE_MODE_ABSORB		2
#define VORE_MODE_UNABSORB		3

#define LIST_DIGEST_PREY		"dmp" //digest_messages_prey
#define LIST_DIGEST_PRED		"dmo" //digest_messages_owner
#define LIST_ABSORB_PREY		"amp" //absorb_messages_prey
#define LIST_ABSORB_PRED		"amo" //absorb_messages_owner
#define LIST_UNABSORB_PREY		"ump" //unabsorb_messages_prey
#define LIST_UNABSORB_PRED		"umo" //unabsorb_messages_owner
#define LIST_STRUGGLE_INSIDE	"smi" //struggle_messages_inside
#define LIST_STRUGGLE_OUTSIDE	"smo" //struggle_messages_outside
#define LIST_EXAMINE			"em"  //examine_messages
