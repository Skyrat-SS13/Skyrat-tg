//defines for antag opt in objective checking
//objectives check for all players with a value equal or greater than the 'threat' level of an objective then pick from that list
//command + sec roles are always opted in regardless of opt in status

#define YES_TEMP 1 //for temporary or otherwise 'inconvenient' objectives like kidnapping or theft
#define YES_KILL 2 //cool with being killed but not removed from the round
#define YES_ROUND_REMOVE 3 //fine with being round removed. This doesn't activate any particular objectives, but will display in OOC info
#define NOT_TARGET 0 //Prefers not to be a target. Will still be a potential target if playing sec or command.
