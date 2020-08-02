//We start from 30 to not interfere with TG DNA defines, should they add more

/// We're using the first mutcolor for our skin coloration
#define MUTCOLOR_SKIN	30
/// We're using all three mutcolor features for our skin coloration
#define MATRIXED_SKIN	31

//Some defines for sprite accessories

// Which color source we're using when the accessory is added 
#define DEFAULT_PRIMARY		1
#define DEFAULT_SECONDARY	2
#define DEFAULT_TERTIARY	3
#define DEFAULT_NONE		4 //as if coloured white (nothing)
#define DEFAULT_MATRIXED	5 //uses all three colors for a matrix

// Defines for whether an accessory should have one or three colors to choose for
#define USE_ONE_COLOR		1
#define USE_MATRIXED_COLORS	2

// Defines for extra bits of accessories
#define COLOR_SRC_PRIMARY	1
#define COLOR_SRC_SECONDARY	2
#define COLOR_SRC_TERTIARY	3
#define COLOR_SRC_NONE		4
#define COLOR_SRC_MATRIXED	5
