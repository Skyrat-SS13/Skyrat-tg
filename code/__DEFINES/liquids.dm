#define WATER_HEIGH_DIFFERENCE_DELTA_SPLASH 7 //Delta needed for the splash effect to be made in 1 go

#define PARTIAL_TRANSFER_AMOUNT 0.3

#define LIQUID_MUTUAL_SHARE 1
#define LIQUID_NOT_MUTUAL_SHARE 2

#define LIQUID_GIVER 1
#define LIQUID_TAKER 2

#define TURF_HEIGHT_BLOCK_THRESHOLD 20

#define LIQUID_HEIGHT_DIVISOR 10

#define LIQUID_ATTRITION_TO_STOP_ACTIVITY 2

#define LIQUID_STATE_PUDDLE 1
#define LIQUID_STATE_KNEES 2
#define LIQUID_STATE_SHOULDERS 3
#define LIQUID_STATE_FULLTILE 4

#define IMMUTABLE_LIQUID_SHARE 1

#define LIQUID_RECURSIVE_LOOP_SAFETY 100 //Hundred loops at maximum for adjacency checking

//Height at which we consider the tile "full" and dont drop liquids on it from the upper Z level
#define LIQUID_HEIGHT_CONSIDER_FULL_TILE 50 

#define SSLIQUIDS_RUN_TYPE_TURFS 1
#define SSLIQUIDS_RUN_TYPE_GROUPS 2
#define SSLIQUIDS_RUN_TYPE_IMMUTABLES 3

#define LIQUID_GROUP_DECAY_TIME 3
