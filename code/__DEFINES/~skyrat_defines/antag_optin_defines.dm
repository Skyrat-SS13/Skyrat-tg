/// Assoc list of stringified opt_in_## define to the front-end string to show users as a representation of the setting.
GLOBAL_LIST_INIT(antag_opt_in_strings, list(
	"0" = "No",
	"1" = "Yes - Temporary/Inconvienence",
	"2" = "Yes - Kill",
	"3" = "Yes - Round Remove",
))

//defines for antag opt in objective checking
//objectives check for all players with a value equal or greater than the 'threat' level of an objective then pick from that list
//command + sec roles are always opted in regardless of opt in status

/// For temporary or otherwise 'inconvenient' objectives like kidnapping or theft
#define OPT_IN_YES_TEMP 1
/// Cool with being killed or otherwise occupied but not removed from the round
#define OPT_IN_YES_KILL 2
/// Fine with being round removed.
#define OPT_IN_YES_ROUND_REMOVE 3

/// Prefers not to be a target. Will still be a potential target if playing sec or command.
#define OPT_IN_NOT_TARGET 0

/// The minimum opt-in level for people playing sec.
#define SECURITY_OPT_IN_LEVEL OPT_IN_YES_KILL
/// The minimum opt-in level for people playing command.
#define COMMAND_OPT_IN_LEVEL OPT_IN_YES_KILL
