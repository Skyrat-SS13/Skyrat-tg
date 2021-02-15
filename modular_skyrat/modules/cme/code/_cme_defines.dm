////////////////////////
//CME DEFINES FILE!
///////////////////////

#define CME_RANDOM			"random"
#define CME_MINIMAL			"minimal"
#define CME_MODERATE		"moderate"
#define CME_EXTREME 		"extreme"
#define CME_ARMAGEDDON		"armageddon"

//Times are SECONDS, they're devided by 2 because that's how long the controller takes to process. 20 deciseconds = 2 seconds. I know, it's dumb as fuck.

#define CME_MINIMAL_LIGHT_RANGE_LOWER 		7 			//The lowest range for the emp pulse light range.
#define CME_MINIMAL_LIGHT_RANGE_UPPER 		10			//The highest range for the emp pulse light range.
#define CME_MINIMAL_HEAVY_RANGE_LOWER 		5			//The lowest range for the emp pulse heavy range.
#define CME_MINIMAL_HEAVY_RANGE_UPPER		7			//The highest range for the emp pulse heavy range.
#define CME_MINIMAL_FREQUENCY_LOWER 		25 / 2		//The lower time range for cme bubbles to appear.
#define CME_MINIMAL_FREQUENCY_UPPER 		30 / 2		//The higher time range for cme bubbles to appear.
#define CME_MINIMAL_BUBBLE_BURST_TIME 		40 SECONDS		//The time taken for a cme bubble to pop.
#define CME_MINIMAL_START_LOWER 			180 / 2		//The lowest amount of time for the event to start from the announcement. - Prep time
#define CME_MINIMAL_START_UPPER				240 / 2		//The highest amount of time for the event to start from the announcement. - Prep time
#define CME_MINIMAL_END						240 / 2		//The amount of time starting from THE MINIMAL START TIME for the event to end. - How long it actually lasts.

#define CME_MODERATE_LIGHT_RANGE_LOWER 		10
#define CME_MODERATE_LIGHT_RANGE_UPPER 		15
#define CME_MODERATE_HEAVY_RANGE_LOWER 		7
#define CME_MODERATE_HEAVY_RANGE_UPPER 		10
#define CME_MODERATE_FREQUENCY_LOWER 		20 / 2
#define CME_MODERATE_FREQUENCY_UPPER 		25 / 2
#define CME_MODERATE_BUBBLE_BURST_TIME 		30 SECONDS
#define CME_MODERATE_START_LOWER 			120 / 2
#define CME_MODERATE_START_UPPER			180 / 2
#define CME_MODERATE_END					300 / 2

#define CME_EXTREME_LIGHT_RANGE_LOWER 		15
#define CME_EXTREME_LIGHT_RANGE_UPPER 		20
#define CME_EXTREME_HEAVY_RANGE_LOWER 		10
#define CME_EXTREME_HEAVY_RANGE_UPPER 		13
#define CME_EXTREME_FREQUENCY_LOWER 		15 / 2
#define CME_EXTREME_FREQUENCY_UPPER 		20 / 2
#define CME_EXTREME_BUBBLE_BURST_TIME 		20 SECONDS
#define CME_EXTREME_START_LOWER 			60 /2
#define CME_EXTREME_START_UPPER				120 / 2
#define CME_EXTREME_END						360 / 2

#define CME_ARMAGEDDON_LIGHT_RANGE_LOWER 	25
#define CME_ARMAGEDDON_LIGHT_RANGE_UPPER 	30
#define CME_ARMAGEDDON_HEAVY_RANGE_LOWER 	20
#define CME_ARMAGEDDON_HEAVY_RANGE_UPPER 	25
#define CME_ARMAGEDDON_FREQUENCY_LOWER 		5 / 2
#define CME_ARMAGEDDON_FREQUENCY_UPPER 		7 / 2
#define CME_ARMAGEDDON_BUBBLE_BURST_TIME 	10 SECONDS
#define CME_ARMAGEDDON_START_LOWER 			60 / 2
#define CME_ARMAGEDDON_START_UPPER			70 / 2
#define CME_ARMAGEDDON_END					1200 / 2
