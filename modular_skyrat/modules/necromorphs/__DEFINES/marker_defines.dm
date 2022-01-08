// SKYRAT EDIT CHANGE -- MARKER buff to balance it more around our pop.
// Can't be moved to modular_skyrat since it's defines, and not having it here makes /everything/ throw errors.
// Overmind defines



// Generic marker defines

#define MARKER_BASE_POINT_RATE                        2           // Base amount of points per process()
#define MARKER_EXPAND_COST                            3           // Price to expand onto a new tile
#define MARKER_ATTACK_REFUND                          2           // Points 'refunded' when the expand attempt actually attacks something instead
#define MARKER_BRUTE_RESIST                           0.5         // Brute damage taken gets multiplied by this value
#define MARKER_FIRE_RESIST                            1           // Burn damage taken gets multiplied by this value
#define MARKER_EXPAND_CHANCE_MULTIPLIER               1           // Increase this value to make markers naturally expand faster
#define MARKER_REINFORCE_CHANCE                       2.5         // The delta_time chance for cores/nodes to reinforce their surroundings
#define MARKER_REAGENTATK_VOL                         25          // Amount of strain-reagents that get injected when the marker attacks: main source of marker damage


// Structure properties

#define MARKER_CORE_MAX_HP                            400
#define MARKER_CORE_HP_REGEN                          2           // Bases health regeneration rate every process(), can be added on by strains
#define MARKER_CORE_CLAIM_RANGE                       12          // Range in which marker tiles are 'claimed' (converted from dead to alive, rarely useful)
#define MARKER_CORE_PULSE_RANGE                       4           // The radius up to which the core activates structures, and up to which structures can be built
#define MARKER_CORE_EXPAND_RANGE                      3           // Radius of automatic expansion
#define MARKER_CORE_STRONG_REINFORCE_RANGE            1           // The radius of tiles surrounding the core that get upgraded
#define MARKER_CORE_REFLECTOR_REINFORCE_RANGE         1
#define MARKER_CORE_MAX_SLASHERS                        2           // Slashers that the core can produce for free

#define MARKER_NODE_MAX_HP                            200
#define MARKER_NODE_HP_REGEN                          3
#define MARKER_NODE_MIN_DISTANCE                      5           // Minimum distance between nodes
#define MARKER_NODE_CLAIM_RANGE                       10
#define MARKER_NODE_PULSE_RANGE                       3           // The radius up to which the core activates structures, and up to which structures can be built
#define MARKER_NODE_EXPAND_RANGE                      2           // Radius of automatic expansion
#define MARKER_NODE_STRONG_REINFORCE_RANGE            0           // The radius of tiles surrounding the node that get upgraded
#define MARKER_NODE_REFLECTOR_REINFORCE_RANGE         0
#define MARKER_NODE_MAX_SLASHERS                        1           // Slashers that nodes can maintain

#define MARKER_FACTORY_MAX_HP                         200
#define MARKER_FACTORY_HP_REGEN                       1
#define MARKER_FACTORY_MIN_DISTANCE                   7           // Minimum distance between factories
#define MARKER_FACTORY_MAX_SLASHERS                     4

#define MARKER_RESOURCE_MAX_HP                        60
#define MARKER_RESOURCE_HP_REGEN                      15
#define MARKER_RESOURCE_MIN_DISTANCE                  3           // Minimum distance between resource markers
#define MARKER_RESOURCE_GATHER_DELAY                  4 SECONDS   // Gather points when pulsed outside this interval
#define MARKER_RESOURCE_GATHER_ADDED_DELAY            0.4 SECONDS// Every additional resource marker adds this amount to the gather delay
#define MARKER_RESOURCE_GATHER_AMOUNT                 1           // The amount of points added to the overmind

#define MARKER_REGULAR_MAX_HP                         30
#define MARKER_REGULAR_HP_REGEN                       1           // Health regenerated when pulsed by a node/core

#define MARKER_STRONG_MAX_HP                          150
#define MARKER_STRONG_HP_REGEN                        2

#define MARKER_REFLECTOR_MAX_HP                       150
#define MARKER_REFLECTOR_HP_REGEN                     2


// Structure purchasing

#define MARKER_UPGRADE_STRONG_COST                    10          // Upgrade and build costs here
#define MARKER_UPGRADE_REFLECTOR_COST                 5
#define MARKER_STRUCTURE_RESOURCE_COST                40
#define MARKER_STRUCTURE_FACTORY_COST                 50
#define MARKER_STRUCTURE_NODE_COST                    50

#define MARKER_REFUND_STRONG_COST                     8           // Points refunded when destroying the structure
#define MARKER_REFUND_REFLECTOR_COST                  4
#define MARKER_REFUND_FACTORY_COST                    25
#define MARKER_REFUND_NODE_COST                       25

// MARKER power properties

#define MARKER_POWER_RELOCATE_COST                    25          // Resource cost to move your core to a different node
#define MARKER_POWER_REROLL_COST                      40          // Strain reroll
#define MARKER_POWER_REROLL_FREE_TIME                 4 MINUTES   // Gain a free strain reroll every x minutes
#define MARKER_POWER_REROLL_CHOICES                   6           // Possibilities to choose from; keep in mind increasing this might fuck with the radial menu


// Mob defines

#define MARKERMOB_HEALING_MULTIPLIER                  0.0125      // Multiplies by -maxHealth and heals the marker by this amount every marker_act
#define MARKERMOB_SLASHER_HEALTH                        30          // Base slasher health
#define MARKERMOB_SLASHER_SPAWN_COOLDOWN                8 SECONDS
#define MARKERMOB_SLASHER_DMG_LOWER                     8
#define MARKERMOB_SLASHER_DMG_UPPER                     16
#define MARKERMOB_BRUTE_RESOURCE_COST           40          // Purchase price for making a brute
#define MARKERMOB_BRUTE_HEALTH                  150         // Base brute health
#define MARKERMOB_BRUTE_DMG_SOLO_LOWER          20          // Damage without active overmind (core dead or xenobio mob)
#define MARKERMOB_BRUTE_DMG_SOLO_UPPER          20
#define MARKERMOB_BRUTE_DMG_LOWER               4           // Damage dealt with active overmind (most damage comes from strain chems)
#define MARKERMOB_BRUTE_DMG_UPPER               4
#define MARKERMOB_BRUTE_REAGENTATK_VOL          20          // Amounts of strain reagents applied on attack -- basically the main damage stat
#define MARKERMOB_BRUTE_DMG_OBJ                 60          // Damage dealth to objects/machines
#define MARKERMOB_BRUTE_HEALING_CORE            0.05        // Percentage multiplier HP restored on Life() when within 2 tiles of the marker core
#define MARKERMOB_BRUTE_HEALING_NODE            0.025       // Same, but for a nearby node
#define MARKERMOB_BRUTE_HEALTH_DECAY            0.0125      // Percentage multiplier HP lost when not near marker tiles or without factory
