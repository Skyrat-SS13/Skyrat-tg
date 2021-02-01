#define WATER_HEIGH_DIFFERENCE_SOUND_CHANCE 50
#define WATER_HEIGH_DIFFERENCE_DELTA_SPLASH 7 //Delta needed for the splash effect to be made in 1 go


#define PARTIAL_TRANSFER_AMOUNT 0.3

#define LIQUID_MUTUAL_SHARE 1
#define LIQUID_NOT_MUTUAL_SHARE 2

#define LIQUID_GIVER 1
#define LIQUID_TAKER 2

#define TURF_HEIGHT_BLOCK_THRESHOLD 20

#define LIQUID_HEIGHT_DIVISOR 10

#define LIQUID_ATTRITION_TO_STOP_ACTIVITY 2

#define LIQUID_STATE_PUDDLE			1
#define LIQUID_STATE_ANKLES			2
#define LIQUID_STATE_WAIST			3
#define LIQUID_STATE_SHOULDERS		4
#define LIQUID_STATE_FULLTILE		5
#define TOTAL_LIQUID_STATES			5
#define LYING_DOWN_SUBMERGEMENT_STATE_BONUS			2

#define LIQUID_ANKLES_LEVEL_HEIGHT 8
#define LIQUID_WAIST_LEVEL_HEIGHT 19
#define LIQUID_SHOULDERS_LEVEL_HEIGHT 29
#define LIQUID_FULLTILE_LEVEL_HEIGHT 39

//Threshold at which we "choke" on the water, instead of holding our breath
#define OXYGEN_DAMAGE_CHOKING_THRESHOLD 15

//Less overhead than using the helper
#define PICK_WATER_WADE_NOISES pick('hrzn/sound/effects/water_wade1.ogg', 'hrzn/sound/effects/water_wade2.ogg', 'hrzn/sound/effects/water_wade3.ogg', 'hrzn/sound/effects/water_wade4.ogg')

#define IMMUTABLE_LIQUID_SHARE 1

#define LIQUID_RECURSIVE_LOOP_SAFETY 100 //Hundred loops at maximum for adjacency checking

//Height at which we consider the tile "full" and dont drop liquids on it from the upper Z level
#define LIQUID_HEIGHT_CONSIDER_FULL_TILE 50 

#define SSLIQUIDS_RUN_TYPE_TURFS 1
#define SSLIQUIDS_RUN_TYPE_GROUPS 2
#define SSLIQUIDS_RUN_TYPE_IMMUTABLES 3

#define LIQUID_GROUP_DECAY_TIME 3
