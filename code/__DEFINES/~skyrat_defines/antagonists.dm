/// Full operative win - goldeneye activated and all ops alive
#define ASSAULT_RESULT_WIN 0
/// Partial operative win - Goldeneye was activated and some ops alive
#define ASSAULT_RESULT_PARTIAL_WIN 1
/// Stalemate - Goldeneye not activated and ops still alive
#define ASSAULT_RESULT_STALEMATE 2
/// Hearty win - Goldeneye activated but no ops alive
#define ASSAULT_RESULT_HEARTY_WIN 3
/// Crew win - Goldeneye not activated and no ops alive
#define ASSAULT_RESULT_LOSS 4

// Conditions for ops to be considered alive
#define ASSAULTOPS_ALL_DEAD 0
#define ASSAULTOPS_PARTLY_DEAD 1
#define ASSAULTOPS_ALL_ALIVE 2

#define GOLDENEYE_REQUIRED_KEYS_MAXIMUM 3

/// Population requirement for bomb objectives (ninja c4, locate weakpoint, etc.) objectives to appear
#define BOMB_POP_REQUIREMENT 80

// Borer evolution defines
// The three primary paths that eventually diverge
#define BORER_EVOLUTION_SYMBIOTE "Symbiote"
#define BORER_EVOLUTION_HIVELORD "Hivelord"
#define BORER_EVOLUTION_DIVEWORM "Diveworm"
// Just general upgrades that don't take you in a specific direction
#define BORER_EVOLUTION_GENERAL "General"
#define BORER_EVOLUTION_START "Start"

// Borer effect flags

/// If the borer is in stealth mode, giving less feedback to hosts at the cost of no health/resource/point gain
#define BORER_STEALTH_MODE (1<<0)
/// If the borer is sugar-immune, taking no ill effects from sugar
#define BORER_SUGAR_IMMUNE (1<<1)
/// If the borer is able to enter hosts in half the time, if not hiding
#define BORER_FAST_BORING (1<<2)
/// If the borer is currently hiding under tables/couches/stairs or appearing on top of them
#define BORER_HIDING (1<<3)
/// If the borer can produce eggs without a host
#define BORER_ALONE_PRODUCTION (1<<4)

// Clock cultist
#define IS_CLOCK(mob) ((FACTION_CLOCK in mob.faction) || mob?.mind?.has_antag_datum(/datum/antagonist/clock_cultist))
