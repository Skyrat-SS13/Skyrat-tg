/*
*	CME DEFINES
*/

GLOBAL_LIST_INIT(cme_loot_list, list(
	/obj/item/raw_anomaly_core/random = 30,
	/obj/item/stack/sheet/bluespace_crystal = 20,
	/obj/item/stack/sheet/mineral/diamond = 10,
	))

/obj/item/strange

#define CME_UNKNOWN "unknown"
#define CME_MINIMAL "minimal"
#define CME_MODERATE "moderate"
#define CME_EXTREME "extreme"
#define CME_ARMAGEDDON "armageddon"

//Times are SECONDS, they're devided by 2 because that's how long the controller takes to process. 20 deciseconds = 2 seconds. I know, it's dumb as fuck.
//NOT ANYMORE, NOW WE MULTIPLY BY A HALF

#define CME_MINIMAL_LIGHT_RANGE_LOWER 7 //The lowest range for the emp pulse light range.
#define CME_MINIMAL_LIGHT_RANGE_UPPER 10 //The highest range for the emp pulse light range.
#define CME_MINIMAL_HEAVY_RANGE_LOWER 5 //The lowest range for the emp pulse heavy range.
#define CME_MINIMAL_HEAVY_RANGE_UPPER 7 //The highest range for the emp pulse heavy range.
#define CME_MINIMAL_FREQUENCY_LOWER 30 * 0.5 //The lower time range for cme bubbles to appear.
#define CME_MINIMAL_FREQUENCY_UPPER 35 * 0.5 //The higher time range for cme bubbles to appear.
#define CME_MINIMAL_BUBBLE_BURST_TIME 45 SECONDS //The time taken for a cme bubble to pop.
#define CME_MINIMAL_START_LOWER 120 * 0.5 //The lowest amount of time for the event to start from the announcement. - Prep time
#define CME_MINIMAL_START_UPPER 180 * 0.5 //The highest amount of time for the event to start from the announcement. - Prep time
#define CME_MINIMAL_END 60 * 0.5 //The amount of time starting from THE MINIMAL START TIME for the event to end. - How long it actually lasts.

#define CME_MODERATE_LIGHT_RANGE_LOWER 10
#define CME_MODERATE_LIGHT_RANGE_UPPER 15
#define CME_MODERATE_HEAVY_RANGE_LOWER 7
#define CME_MODERATE_HEAVY_RANGE_UPPER 10
#define CME_MODERATE_FREQUENCY_LOWER 25 * 0.5
#define CME_MODERATE_FREQUENCY_UPPER 30 * 0.5
#define CME_MODERATE_BUBBLE_BURST_TIME 35 SECONDS
#define CME_MODERATE_START_LOWER 120 * 0.5
#define CME_MODERATE_START_UPPER 180 * 0.5
#define CME_MODERATE_END 90 * 0.5


#define CME_EXTREME_LIGHT_RANGE_LOWER 15
#define CME_EXTREME_LIGHT_RANGE_UPPER 20
#define CME_EXTREME_HEAVY_RANGE_LOWER 10
#define CME_EXTREME_HEAVY_RANGE_UPPER 13
#define CME_EXTREME_FREQUENCY_LOWER 20 * 0.5
#define CME_EXTREME_FREQUENCY_UPPER 25 * 0.5
#define CME_EXTREME_BUBBLE_BURST_TIME 25 SECONDS
#define CME_EXTREME_START_LOWER 60 * 0.5
#define CME_EXTREME_START_UPPER 120 * 0.5
#define CME_EXTREME_END 120 * 0.5

#define CME_ARMAGEDDON_LIGHT_RANGE_LOWER 25
#define CME_ARMAGEDDON_LIGHT_RANGE_UPPER 30
#define CME_ARMAGEDDON_HEAVY_RANGE_LOWER 20
#define CME_ARMAGEDDON_HEAVY_RANGE_UPPER 25
#define CME_ARMAGEDDON_FREQUENCY_LOWER 5 * 0.5
#define CME_ARMAGEDDON_FREQUENCY_UPPER 7 * 0.5
#define CME_ARMAGEDDON_BUBBLE_BURST_TIME 10 SECONDS
#define CME_ARMAGEDDON_START_LOWER 60 * 0.5
#define CME_ARMAGEDDON_START_UPPER 70 * 0.5
#define CME_ARMAGEDDON_END 300 * 0.5
