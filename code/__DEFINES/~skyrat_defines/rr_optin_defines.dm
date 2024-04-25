
/// Assoc list of stringified opt_in_## define to the front-end string to show users as a representation of the setting.
GLOBAL_LIST_INIT(rr_opt_in_strings, list(
	"0" = "No",
	"1" = "Yes",
))

//defines for antag opt in objective checking
//objectives check for all players with a value equal or greater than the 'threat' level of an objective then pick from that list
//command + sec roles are always opted in regardless of opt in status

/// Round removal opt-in define
#define OPT_IN_RR 1

/// Prefers not to round removed. Will still be a potential target if playing sec or command.
#define OPT_OUT_RR 0

/// The minimum opt-in level for people playing sec.
#define SECURITY_OPT_IN_LEVEL OPT_IN_RR
/// The minimum opt-in level for people playing command.
#define COMMAND_OPT_IN_LEVEL OPT_IN_RR

/// The default opt in level for preferences and mindless mobs.
#define OPT_IN_DEFAULT_LEVEL OPT_OUT_RR

/// If the player has any non-ghost role antags enabled, they are forced to use a minimum of this.
#define OPT_IN_ANTAG_ENABLED_LEVEL OPT_IN_RR
