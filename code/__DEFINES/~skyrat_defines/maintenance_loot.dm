
//as of:10/28/2019:
//boxstation: ~153 loot items spawned
//metastation: ~183 loot items spawned
//deltastation: ~165 loot items spawned

//how to balance maint loot spawns:
// 1) Ensure each category has items of approximately the same power level
// 2) Tune weight of each category until average power of a maint loot spawn is acceptable
// 3) Mapping considerations - Loot value should scale with difficulty of acquisition, or an assistaint will run through collecting free gear with no risk

//goal of maint loot:
// 1) Provide random equipment to people who take effort to crawl maint
// 2) Create memorable moments with very rare, crazy items

//Loot tables

//Maintenance loot spawner pools
#define MAINT_TRASH_WEIGHT 4499
#define MAINT_COMMON_WEIGHT 4500
#define MAINT_UNCOMMON_WEIGHT 1000
#define MAINT_ODD_WEIGHT 1 //1 out of 10,000 would give metastation (180 spawns) a 2 in 111 chance of spawning an oddity per round, similar to xeno egg.
#define MAINT_HOLIDAY_WEIGHT 3500 // When holiday loot is enabled, it'll give every loot item a 25% chance of being a holiday item.
#define maint_holiday_weight MAINT_HOLIDAY_WEIGHT
