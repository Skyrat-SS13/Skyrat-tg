#define SEE_EXAMINES 			(1 << 0)
#define SEE_STRUGGLES 			(1 << 1)
#define SEE_OTHER_MESSAGES 		(1 << 2)
#define DEVOURABLE				(1 << 3)
#define DIGESTABLE				(1 << 4)
#define ABSORBABLE				(1 << 5)
//#define CAN_HEAR_NOISES		(1 << 6)
//#define SIMPLEMOB_VORE		(1 << 7)
#define VORE_TOGGLES_DEFAULT	(SEE_EXAMINES|SEE_STRUGGLES|SEE_OTHER_MESSAGES|DEVOURABLE)

#define VORE_MODE_HOLD			0
#define VORE_MODE_DIGEST		1
#define VORE_MODE_ABSORB		2

#define LIST_DIGEST_PREY		"digest_messages_prey"
#define LIST_DIGEST_PRED		"digest_messages_owner"
#define LIST_STRUGGLE_INSIDE	"struggle_messages_inside"
#define LIST_STRUGGLE_OUTSIDE	"struggle_messages_outside"
#define LIST_EXAMINE			"examine_messages"

#define MAX_BELLIES 			8
#define MAX_BELLY_NAME_LENGTH	30 //yeah I dunno, adjust this if you want to
