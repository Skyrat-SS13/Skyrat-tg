#define SEE_EXAMINES 			(1 << 0)
#define SEE_STRUGGLES 			(1 << 1)
#define SEE_OTHER_MESSAGES 		(1 << 2)
#define DEVOURABLE				(1 << 3)
#define DIGESTABLE				(1 << 4)
#define ABSORBABLE				(1 << 5)
//#define CAN_HEAR_NOISES		(1 << 6)
//#define SIMPLEMOB_VORE		(1 << 7)
#define VORE_TOGGLES_DEFAULT	(SEE_EXAMINES|SEE_STRUGGLES|SEE_OTHER_MESSAGES)

#define VORE_MODE_HOLD		0
#define VORE_MODE_DIGEST	1
#define VORE_MODE_ABSORB	2

#define LIST_DIGEST_PREY			"digest_messages_prey"
#define LIST_DIGEST_PRED			"digest_messages_owner"
#define LIST_STRUGGLE_INSIDE		"struggle_messages_inside"
#define LIST_STRUGGLE_OUTSIDE		"struggle_messages_outside"
#define LIST_EXAMINE				"examine_messages"


/datum/vore_prefs
	var/path
	var/client
	var/vore_enabled = FALSE //master toggle
	var/vore_toggles = VORE_TOGGLES_DEFAULT
	var/tastes_of = ""
	var/list/bellies = list()

	/* someone else can do this
	can hear noises toggle + vore noises
	simplemob vore
	*/

/datum/vore_prefs/New(client/holder = null)
	if (!holder)
		return
	client = holder
	var/current_slot = client?.prefs?.default_slot
	path = "data/player_saves/[ckey[1]]/[ckey]/vore.sav"
	if (fexists(path))
		load_prefs(default_slot)
	else
		save_prefs(default_slot)

/datum/vore_prefs/proc/load_prefs(slot = 1)
	if (!path || !fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	READ_FILE(S["vore_enabled"], vore_enabled)
	if (!vore_enabled)
		return
	S.cd = "/char[slot]"
	READ_FILE(S["vore_toggles"], vore_toggles)
	READ_FILE(S["vore_taste"], tastes_of)
	READ_FILE(S["bellies"], bellies)
	if (!length(bellies))
		bellies.Add(default_belly_info())

/datum/vore_prefs/save_prefs(slot = 1)
	if (!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	WRITE_FILE(S["vore_enabled"], vore_enabled)
	if (!vore_enabled)
		return
	S.cd = "/char[slot]"
	WRITE_FILE(S["vore_toggles"], vore_toggles)
	WRITE_FILE(S["vore_taste"], tastes_of)
	WRITE_FILE(S["bellies"], bellies)

/datum/vore_prefs/proc/get_belly_info(slot = 1)
	if (slot > length(bellies) || slot < 1)
		return default_belly_info()
	return bellies[slot]
