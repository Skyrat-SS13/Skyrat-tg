#define PREVIEW_PREF_JOB "Job"
#define PREVIEW_PREF_LOADOUT "Loadout"
#define PREVIEW_PREF_UNDERWEAR "Underwear"
#define PREVIEW_PREF_NAKED "Naked"
#define PREVIEW_PREF_NAKED_AROUSED "Naked - Aroused"

/// for tri color prefs: doesn't check type_to_check pref
#define TRICOLOR_NO_CHECK 0
/// checks that the value of type_to_check is not FALSE
#define TRICOLOR_CHECK_BOOLEAN 1
/// checks that the value of type_to_check is associated with a factual sprite accessory (tldr not "None")
#define TRICOLOR_CHECK_ACCESSORY 2

#define ORGAN_PREF_POSI_BRAIN "Positronic Brain"
#define ORGAN_PREF_MMI_BRAIN "Man-Machine Interface"
#define ORGAN_PREF_CIRCUIT_BRAIN "Circuitboard"

// Playtime is tracked in minutes
/// Have any less hours than listed below and you get access to a pin indicating you're new
#define PLAYTIME_GREEN 6000 // 100 hours
