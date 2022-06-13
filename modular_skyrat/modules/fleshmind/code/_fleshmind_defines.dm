// GENERAL DEFINES

/// A list of objects that are considered part of a door, used to determine if a wireweed should attack it.
#define DOOR_OBJECT_LIST list(/obj/machinery/door/airlock, /obj/structure/door_assembly, /obj/machinery/door/firedoor, /obj/machinery/door/window)

#define FACTION_FLESHMIND "fleshmind"

#define MALFUNCTION_RESET_TIME 5 SECONDS

#define MALFUNCTION_CORE_DEATH_RESET_TIME 20 SECONDS

#define STRUCTURE_EMP_LIGHT_DISABLE_TIME 5 SECONDS
#define STRUCTURE_EMP_HEAVY_DISABLE_TIME 10 SECONDS

#define STRUCTURE_EMP_LIGHT_DAMAGE 30
#define STRUCTURE_EMP_HEAVY_DAMAGE 50

#define MOB_EMP_LIGHT_DAMAGE 10
#define MOB_EMP_HEAVY_DAMAGE 20

#define FLESHMIND_NAME_MODIFIER_LIST list ("Warped", "Altered", "Modified", "Upgraded", "Abnormal")

/// The range at which most of our objects, mobs and structures activate at. 7 seems to be the perfect number.
#define DEFAULT_VIEW_RANGE 7

#define MALFUNCTION_CHANCE_LOW 0.5
#define MALFUNCTION_CHANCE_MEDIUM 1
#define MALFUNCTION_CHANCE_HIGH 2

#define SPECIES_MONKEY_MAULER "monkey_mauler"

#define FLESHMIND_LIGHT_BLUE "#50edd9"

/// Core is in danger, engage turboboosters
#define MOB_RALLY_SPEED 0.5

/// The max spread distance a wireweed can spread thru a vent.
#define MAX_VENT_SPREAD_DISTANCE 10

#define CONTROLLED_MOB_POLICY "You are part of the fleshmind, this means any fleshmind entities, structures, mobs are your ally. You must not attack them. \n \
	You must roleplay that you are part of the fleshmind. Your number one goal is converting other hosts and spreading the flesh."

#define FLESHMIND_EVENT_MAKE_CORRUPTION_CHANCE 2

#define FLESHMIND_EVENT_MAKE_CORRUPT_MOB 1

// CONTROLLER RELATED DEFINES

#define AI_FORENAME_LIST list("Von Neumann", "Lazarus", "Abattoir", "Auto-Surgeon", "Tra-Sentience", \
	"NanoNurse", "Vivisector", "Ex Costa", "Apostasy", "Gnosis", "Balaam", "Ophite", \
	"Sarif", "VersaLife", "Slylandro", "SHODAN", "Pandora", "Master Controller")

#define AI_SURNAME_LIST list("Mk I", "Mk II", "Mk III", "Mk IV", "Mk V", "Mk X", \
	"v0.9", "v1.0", "v1.1", "v2.0", "2418-B", "Open Beta", \
	"Pre-Release", "Commercial Release", "Closed Alpha", "Hivebuilt")

/// The controller must reach this before it can level up to the next level.
#define CONTROLLER_LEVEL_UP_THRESHOLD 300

#define CONTROLLER_LEVEL_1 1
#define CONTROLLER_LEVEL_2 2
#define CONTROLLER_LEVEL_3 3
#define CONTROLLER_LEVEL_4 4
#define CONTROLLER_LEVEL_5 5
#define CONTROLLER_LEVEL_MAX 6

#define CONTROLLER_CORE_SPREAD_PROGRESS_BOOST 10
#define CONTROLLER_LEVEL_UP_SPREAD_BOOST 4000

#define SPREAD_PROGRESS_REQUIRED 100

#define CONTROLLER_DEATH_DO_NOTHING 1
#define CONTROLLER_DEATH_SLOW_DECAY 2
#define CONTROLLER_DEATH_DELETE_ALL 3

// WIREWEED RELATED DEFINES

#define CORE_DAMAGE_WIREWEED_ACTIVATION_RANGE 6
#define GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE 2

#define WIREWEED_WIRECUTTER_KILL_TIME 2 SECONDS

#define WIREWEED_HEAL_CHANCE 10

#define WIREWEED_REPLACE_BODYPART_CHANCE 5

#define WIREWEED_HEAL_AMOUNT 3

