//defines for antag opt in objective checking
//objectives check for all players with a value equal or greater than the 'threat' level of an objective then pick from that list
//command + sec roles are always opted in regardless of opt in status

///ANTAG OPTIN - for temporary or otherwise 'inconvenient' objectives like kidnapping or theft
#define YES_TEMP 1
///ANTAG OPTIN - cool with being killed but not removed from the round
#define YES_KILL 2
///ANTAG OPTIN - fine with being killed AND round removed.
#define YES_ROUND_REMOVE 3
///ANTAG OPTIN - Prefers not to be a target. Will still be a potential target if playing sec or command.
#define NOT_TARGET 0
