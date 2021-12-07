#define DEFAULT_AUTOKICK_SS_WAIT 15 MINUTES

/// Anything above this will result in all afk players being kicked, also used by the lagswitch SS to determine what lagswitches to turn on/off
#define PERFORMANCE_THRESHOLD_CRITICAL 120
/// Anything above this and below critical will result in all ghosts/lobby players being kicked
#define PERFORMANCE_THRESHOLD_MODERATE 100

#define AUTOKICK_SEVERITY_CRITICAL "CRITICAL - All AFK clients"
#define AUTOKICK_SEVERITY_MODERATE "MODERATE - All AFK clients that are in the lobby or observing"
#define AUTOKICK_SEVERITY_NORMAL "NORMAL - All AFK clients that are in the lobby"

// Stops the AFK SS from running.
/datum/config_entry/flag/disable_afk_autokick
