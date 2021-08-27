////////////////////////
//CME DEFINES FILE!
///////////////////////

GLOBAL_LIST_INIT(cme_loot_list, list(
	/obj/item/bombcore/emp = 1
))

/obj/item/strange

#define CME_UNKNOWN "unknown"
#define CME_MINIMAL "minimal"
#define CME_MODERATE "moderate"
#define CME_EXTREME "extreme"
#define CME_ARMAGEDDON "armageddon"

//Times are SECONDS, they're devided by 2 because that's how long the controller takes to process. 20 deciseconds = 2 seconds. I know, it's dumb as fuck.
//NOT ANYMORE, NOW WE MULTIPLY BY A HALF

#define CME_MINIMAL_LIGHT_RANGE_LOWER 3 //The lowest range for the emp pulse light range.
#define CME_MINIMAL_LIGHT_RANGE_UPPER 5 //The highest range for the emp pulse light range.
#define CME_MINIMAL_HEAVY_RANGE_LOWER 2 //The lowest range for the emp pulse heavy range.
#define CME_MINIMAL_HEAVY_RANGE_UPPER 3 //The highest range for the emp pulse heavy range.
#define CME_MINIMAL_FREQUENCY_LOWER 50 * 0.5 //The lower time range for cme bubbles to appear.
#define CME_MINIMAL_FREQUENCY_UPPER 60 * 0.5 //The higher time range for cme bubbles to appear.
#define CME_MINIMAL_BUBBLE_BURST_TIME 120 SECONDS //The time taken for a cme bubble to pop.
#define CME_MINIMAL_END 480 * 0.5 //The amount of time starting from THE MINIMAL START TIME for the event to end. - How long it actually lasts.

#define CME_MODERATE_LIGHT_RANGE_LOWER 5
#define CME_MODERATE_LIGHT_RANGE_UPPER 7
#define CME_MODERATE_HEAVY_RANGE_LOWER 3
#define CME_MODERATE_HEAVY_RANGE_UPPER 5
#define CME_MODERATE_FREQUENCY_LOWER 40 * 0.5
#define CME_MODERATE_FREQUENCY_UPPER 50 * 0.5
#define CME_MODERATE_BUBBLE_BURST_TIME 30 SECONDS
#define CME_MODERATE_END 480 * 0.5


#define CME_EXTREME_LIGHT_RANGE_LOWER 6
#define CME_EXTREME_LIGHT_RANGE_UPPER 8
#define CME_EXTREME_HEAVY_RANGE_LOWER 4
#define CME_EXTREME_HEAVY_RANGE_UPPER 6
#define CME_EXTREME_FREQUENCY_LOWER 30 * 0.5
#define CME_EXTREME_FREQUENCY_UPPER 40 * 0.5
#define CME_EXTREME_BUBBLE_BURST_TIME 20 SECONDS
#define CME_EXTREME_END 600 * 0.5

#define CME_ARMAGEDDON_LIGHT_RANGE_LOWER 8
#define CME_ARMAGEDDON_LIGHT_RANGE_UPPER 10
#define CME_ARMAGEDDON_HEAVY_RANGE_LOWER 7
#define CME_ARMAGEDDON_HEAVY_RANGE_UPPER 9
#define CME_ARMAGEDDON_FREQUENCY_LOWER 10 * 0.5
#define CME_ARMAGEDDON_FREQUENCY_UPPER 20 * 0.5
#define CME_ARMAGEDDON_BUBBLE_BURST_TIME 10 SECONDS
#define CME_ARMAGEDDON_END 1200 * 0.5
