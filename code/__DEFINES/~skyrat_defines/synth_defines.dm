#define MUTANT_SYNTH_ANTENNA "ipc_antenna"
#define MUTANT_SYNTH_SCREEN "ipc_screen"
#define MUTANT_SYNTH_CHASSIS "synth_chassis"
#define MUTANT_SYNTH_HEAD "synth_head"
#define MUTANT_SYNTH_HAIR "synth_hair"

#define DEFAULT_SYNTH_PART_COLOR "#746c6a"
#define DEFAULT_SYNTH_SCREEN_COLOR "#b99b3a"

// EMP specific Defines
#define SYNTH_ORGAN_LIGHT_EMP_DAMAGE 10
#define SYNTH_ORGAN_HEAVY_EMP_DAMAGE 20
#define SYNTH_HEAVY_EMP_MULTIPLIER 2
#define SYNTH_LIGHT_EMP_TEMPERATURE_POWER 30
#define SYNTH_HEAVY_EMP_TEMPERATURE_POWER 100
#define SYNTH_STOMACH_LIGHT_EMP_CHARGE_LOSS 50
#define SYNTH_STOMACH_HEAVY_EMP_CHARGE_LOSS 150
#define SYNTH_BRAIN_WAKE_THRESHOLD 50

// EMP Damage thresholds from EMP - some organs being insta-killed doesnt really add much to the game
#define SYNTH_EMP_HEART_DAMAGE_MAXIMUM 100
#define SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM 75

// Universal stat defines
#define SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL 20 SECONDS
#define SYNTH_DEAF_STACKS 30

// Charge level defines
#define SYNTH_CHARGE_MAX (STANDARD_CELL_CHARGE * 10) //Takes one high capacity cells to go from 0 to 100
#define SYNTH_JOULES_PER_NUTRITION (SYNTH_CHARGE_MAX / NUTRITION_LEVEL_FULL)
#define SYNTH_CHARGE_ALMOST_FULL (NUTRITION_LEVEL_ALMOST_FULL * SYNTH_JOULES_PER_NUTRITION)
#define SYNTH_CHARGE_RATE (STANDARD_CELL_RATE * 5)
#define SYNTH_APC_MINIMUM_PERCENT 20

/// Mechfab defines
#define RND_SUBCATEGORY_MECHFAB_ANDROID "/Android"
#define RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS "/Android Chassis"
#define RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS "/Android Organs"
