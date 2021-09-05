//Bitflags for overmap_flags
#define OV_SHOWS_ON_SENSORS (1<<0)
#define OV_CAN_BE_TARGETED (1<<1)
#define OV_CAN_BE_SCANNED (1<<2)
#define OV_CAN_BE_TRANSPORTED (1<<3)
#define OV_CAN_BE_ATTACKED (1<<4)

//Defines for helm command types
#define HELM_IDLE 0
#define HELM_FULL_STOP 1
#define HELM_MOVE_TO_DESTINATION 2
#define HELM_TURN_TO_DESTINATION 3
#define HELM_FOLLOW_SENSOR_LOCK 4
#define HELM_TURN_TO_SENSOR_LOCK 5

#define TARGET_IDLE 0
#define TARGET_FIRE_ONCE 1
#define TARGET_KEEP_FIRING 2
#define TARGET_SCAN 3
#define TARGET_BEAM_ON_BOARD 4

#define SHUTTLE_TAB_GENERAL 0
#define SHUTTLE_TAB_ENGINES 1
#define SHUTTLE_TAB_HELM 2
#define SHUTTLE_TAB_SENSORS 3
#define SHUTTLE_TAB_TARGET 4
#define SHUTTLE_TAB_DOCKING 5

#define SHUTTLE_SLOWDOWN_MARGIN 1
#define SHUTTLE_MINIMUM_VELOCITY 0.1
#define SHUTTLE_MAXIMUM_DOCKING_SPEED 0.2
#define VECTOR_LENGTH(x,y) sqrt(x**2+y**2)
#define TWO_POINT_DISTANCE(xa,ya,xb,yb) sqrt(((yb-ya)**2) + ((xa-xb)**2))
#define TWO_POINT_DISTANCE_OV(o1,o2) TWO_POINT_DISTANCE(o1.x,o1.y,o2.x,o2.y)
#define IN_LOCK_RANGE(o1,o2) (TWO_POINT_DISTANCE_OV(o1,o2) <= OVERMAP_LOCK_RANGE)
#define SENSOR_RADIUS 4
#define OVERMAP_LOCK_RANGE 2

#define SHUTTLE_ICON_IDLE 1
#define SHUTTLE_ICON_FORWARD 2
#define SHUTTLE_ICON_BACKWARD 3

//Projectiles
#define OVERMAP_PROJECTILE_COLLISION_DISTANCE 5
//Damage types
#define OV_DAMTYPE_LASER 1
#define OV_DAMTYPE_BALLISTIC 2
#define OV_DAMTYPE_MINING 3

#define SHUTTLE_CAN_USE_DOCK		(1<<0)
#define SHUTTLE_CAN_USE_ENGINES		(1<<1)
#define SHUTTLE_CAN_USE_SENSORS		(1<<2)
#define SHUTTLE_CAN_USE_TARGET		(1<<3)
#define ALL_SHUTTLE_CAPABILITY (SHUTTLE_CAN_USE_DOCK|SHUTTLE_CAN_USE_ENGINES|SHUTTLE_CAN_USE_SENSORS|SHUTTLE_CAN_USE_TARGET)
#define STATION_SHUTTLE_CAPABILITY (SHUTTLE_CAN_USE_ENGINES|SHUTTLE_CAN_USE_SENSORS|SHUTTLE_CAN_USE_TARGET)
#define PLANET_SHUTTLE_CAPABILITY (SHUTTLE_CAN_USE_SENSORS|SHUTTLE_CAN_USE_TARGET)

//Generaton stuff
#define ORE_ROCK_PER_TILE_CHANCE 9

#define TRANSPORTABLE_LOOT_CHANCE_PER_TILE 7
#define TRANSPORTABLE_LOOT_TABLE list(/datum/overmap_object/transportable/debris = 60, \
									/datum/overmap_object/transportable/wreckage = 5, \
									/datum/overmap_object/transportable/trash = 20, \
									/datum/overmap_object/transportable/wreckage/high_value = 1)
#define TRANSPORTABLE_SPECIAL_ON_DEBRIS_CHANCE 2
#define TRANSPORTABLE_SPECIAL_LOOT_TABLE list(/datum/overmap_object/transportable/wreckage/high_value = 100)

//Amount of hazard clusters being spawned
#define DEFAULT_HAZARD_CLUSTER_AMOUNT 42
//Their "dropoff", which is a value which will be subtracted every time a node spreads, into a chance to continue spreading. Higher dropoff = smaller nodes
#define DEFAULT_HAZARD_CLUSTER_DROPOFF 4
//All overmap hazards to be seeded randomly by default
#define DEFAULT_OVERMAP_HAZARDS list(/datum/overmap_object/hazard/asteroid, \
									/datum/overmap_object/hazard/dust, \
									/datum/overmap_object/hazard/electrical_storm,\
									/datum/overmap_object/hazard/ion_storm,\
									/datum/overmap_object/hazard/carp_school)

//OVERMAP LAYERS

#define OVERMAP_LAYER_LOWEST 3
#define OVERMAP_LAYER_HAZARD 3.1
#define OVERMAP_LAYER_PLANET 3.2
#define OVERMAP_LAYER_STATION 3.3
#define OVERMAP_LAYER_LOOT 3.4
#define OVERMAP_LAYER_SHIP 3.5
#define OVERMAP_LAYER_SHUTTLE 3.6
#define OVERMAP_LAYER_PROJECTILE 3.7

//Helpful getters
#define STATION_OVERMAP_OBJECT SSmapping.station_overmap_object
#define STATION_WEATHER_CONTROLLER SSmapping.station_overmap_object.weather_controller

///Due to the lack of even knowing where to put it in, I'm putting my helper defines stuff here - Azarak
#define CHECK_AND_PICK_OR_NULL(some_list) some_list ? pick(some_list) : null

//List of all the planets we can spawn roundstart, with an associated weight. Planets with less features are rarer
#define SPAWN_PLANET_WEIGHT_LIST list(/datum/planet_template/volcanic_planet = 100, \
					/datum/planet_template/snow_planet = 100, \
					/datum/planet_template/shrouded_planet = 50, \
					/datum/planet_template/lush_planet = 100, \
					/datum/planet_template/jungle_planet = 100, \
					/datum/planet_template/desert_planet = 100, \
					/datum/planet_template/chlorine_planet = 50, \
					/datum/planet_template/barren_planet = 50)

//Planetary proprties for ruins to check
#define PLANET_HABITABLE (1<<0)
#define PLANET_WATER (1<<1)
#define PLANET_WRECKAGES (1<<2)
#define PLANET_VOLCANIC (1<<3)
#define PLANET_ICE (1<<4)
#define PLANET_REMOTE (1<<5)

#define TRANSIT_VELOCITY_NEGLIGIBLE 0
#define TRANSIT_VELOCITY_LOW 1
#define TRANSIT_VELOCITY_MEDIUM 2
#define TRANSIT_VELOCITY_HIGH 3
