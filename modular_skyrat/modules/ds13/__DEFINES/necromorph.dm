// Subsytems
#define SS_INIT_NECROMORPH       4


//Faction strings
#define FACTION_NECROMORPH	"necromorph"
#define ROLE_NECROMORPH "necromorph"

//Spawning methods for things purchased at necroshop
#define SPAWN_POINT		1	//The thing is spawned in a random clear tile around a specified spawnpoint
#define SPAWN_PLACE		2	//The thing is manually placed by the user on a viable corruption tile

#define NECROMORPH_ACID_POWER	3.5	//Damage per unit of necromorph organic acid, used by many things
#define NECROMORPH_FRIENDLY_FIRE_FACTOR	0.5	//All damage dealt by necromorphs TO necromorphs, is multiplied by this
#define NECROMORPH_ACID_COLOR	"#946b36"

//Minimum power levels for bioblasts to trigger the appropriate ex_act tier
#define BIOBLAST_TIER_1	120
#define BIOBLAST_TIER_2	60
#define BIOBLAST_TIER_3	30



//Errorcodes returned from a biomass source
#define MASS_READY	"ready"	//Nothing is wrong, ready to absorb
#define MASS_ACTIVE	"active"//The source is ready to absorb, but it needs to be handled carefully and asked each time you absorb from it
#define MASS_PAUSE	"pause"	//Not ready to deliver, but keep this source in the list and check again next tick
#define MASS_EXHAUST	"exhaust"	//All mass is gone, delete this source
#define MASS_FAIL	"fail"	//The source can't deliver anymore, maybe its not in range of where it needs to be



#define CORRUPTION_SPREAD_RANGE	12	//How far from the source corruption spreads
#define MAW_EAT_RANGE	2	//Nom distance of a maw node


//Biomass harvest defines. These are quantites per second that a machine gives when under the grip of a harvester
//Remember that there are often 10+ of any such machine in its appropriate room, and each gives a quantity
#define BIOMASS_HARVEST_LARGE	0.04
#define BIOMASS_HARVEST_MEDIUM	0.03
#define BIOMASS_HARVEST_SMALL	0.015

//This is intended for use with active sources which have a limited total quantity to distribute.
//Don't allow infinite sources to give out biomass at this rate
#define BIOMASS_HARVEST_ACTIVE	0.1

//Not for gameplay use, debugging only
#define BIOMASS_HARVEST_DEBUG	10

//Items in vendors are worth this* their usual biomass, to make them last longer as sources
#define VENDOR_BIOMASS_MULT	5

//One unit (10ml) of purified liquid biomass can be multiplied by this value to create one kilogram of solid biomass
#define REAGENT_TO_BIOMASS	0.01

#define BIOMASS_TO_REAGENT	100



#define PLACEMENT_FLOOR	"floor"
#define PLACEMENT_WALL	"wall"

//Necromorph species
#define SPECIES_NECROMORPH 	"Necromorph"
#define SPECIES_NECROMORPH_DIVIDER 	"Divider"
#define SPECIES_NECROMORPH_DIVIDER_COMPONENT 	"Divider Component"
#define SPECIES_NECROMORPH_SLASHER 	"Slasher"
#define SPECIES_NECROMORPH_SLASHER_DESICCATED "Ancient Slasher"
#define SPECIES_NECROMORPH_SLASHER_ENHANCED 	"Enhanced Slasher"
#define SPECIES_NECROMORPH_SPITTER	"Spitter"
#define SPECIES_NECROMORPH_PUKER	"Puker"
#define SPECIES_NECROMORPH_BRUTE	"Brute"
#define SPECIES_NECROMORPH_EXPLODER	"Exploder"
#define SPECIES_NECROMORPH_TRIPOD	"Tripod"
#define SPECIES_NECROMORPH_TWITCHER	"Twitcher"
#define SPECIES_NECROMORPH_LEAPER 	"Leaper"
#define SPECIES_NECROMORPH_LEAPER_ENHANCED 	"Enhanced Leaper"
#define	SPECIES_NECROMORPH_LURKER	"Lurker"
#define SPECIES_NECROMORPH_UBERMORPH	"Ubermorph"


//Graphical variants
#define SPECIES_NECROMORPH_BRUTE_FLESH	"BruteF"

#define SPECIES_ALL_NECROMORPHS SPECIES_NECROMORPH,\
SPECIES_NECROMORPH_SLASHER,\
SPECIES_NECROMORPH_SLASHER_ENHANCED,\
SPECIES_NECROMORPH_SPITTER,\
SPECIES_NECROMORPH_PUKER,\
SPECIES_NECROMORPH_BRUTE,\
SPECIES_NECROMORPH_EXPLODER,\
SPECIES_NECROMORPH_BRUTE_FLESH,\
SPECIES_NECROMORPH_TWITCHER,\
SPECIES_NECROMORPH_LEAPER,\
SPECIES_NECROMORPH_LEAPER_ENHANCED,\
SPECIES_NECROMORPH_LURKER,\
SPECIES_NECROMORPH_UBERMORPH


#define STANDARD_CLOTHING_EXCLUDE_SPECIES	list("exclude", SPECIES_NABBER,SPECIES_ALL_NECROMORPHS)

//Mode
#define MODE_MARKER "marker"
#define MODE_UNITOLOGIST "unitologist"
#define MODE_UNITOLOGIST_SHARD "unitologist_shardbearer"





