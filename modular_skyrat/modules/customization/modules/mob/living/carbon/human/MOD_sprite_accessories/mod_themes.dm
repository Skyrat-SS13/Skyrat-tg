// All available options
#define STANDARD_BLUE "standard_blue"
#define SECURITY_AMBER "security_amber"
#define CONTRACTOR_RED "contractor_red"
#define WIZARD_VIOLET "wizard_violet"
#define EVIL_GREEN "evil_green"
#define RESEARCH_PURPLE "research_purple"
#define ENGINEERING_ORANGE "engineering_orange"

/datum/mod_theme
	/// Wether or not the MOD projects hardlight at all
	var/hardlight = TRUE
	/// The icon_state which is chosen to render as hardlight
	var/hardlight_theme = STANDARD_BLUE

//	Command
/datum/mod_theme/magnate
	hardlight_theme = RESEARCH_PURPLE

/datum/mod_theme/research
	hardlight_theme = RESEARCH_PURPLE

/datum/mod_theme/advanced
	hardlight_theme = ENGINEERING_ORANGE

/datum/mod_theme/safeguard
	hardlight_theme = SECURITY_AMBER

/datum/mod_theme/rescue
	hardlight_theme = STANDARD_BLUE


//	Crew
/datum/mod_theme/engineering
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/atmospheric
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/loader
	hardlight = FALSE

/datum/mod_theme/mining
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/medical
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/security
	hardlight_theme = SECURITY_AMBER


//	Traitor
/datum/mod_theme/contractor
	hardlight_theme = CONTRACTOR_RED

/datum/mod_theme/syndicate
	hardlight_theme = EVIL_GREEN

/datum/mod_theme/enchanted
	hardlight_theme = WIZARD_VIOLET

/datum/mod_theme/ninja
	hardlight_theme = EVIL_GREEN

/datum/mod_theme/elite
	hardlight_theme = EVIL_GREEN


//	Misc.
/datum/mod_theme/apocryphal
	hardlight_theme = SECURITY_AMBER

/datum/mod_theme/corporate
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/cosmohonk
	hardlight_theme = CONTRACTOR_RED


// ERT
/datum/mod_theme/responsory
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/frontline
	hardlight_theme = STANDARD_BLUE


// Debug
/datum/mod_theme/debug
	hardlight_theme = STANDARD_BLUE

/datum/mod_theme/administrative
	hardlight_theme = STANDARD_BLUE


#undef STANDARD_BLUE
#undef SECURITY_AMBER
#undef CONTRACTOR_RED
#undef WIZARD_VIOLET
#undef EVIL_GREEN
#undef RESEARCH_PURPLE
#undef ENGINEERING_ORANGE
