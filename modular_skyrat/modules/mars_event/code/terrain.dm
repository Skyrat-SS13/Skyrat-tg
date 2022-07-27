#define RED_PLANET_ATMOS "co2=40;o2=3;n2=7;TEMP=210"
#define RED_ROCK "#934b33"
#define DARK_ROCK "#2b2b2b"

/turf/open/misc/ironsand/redplanet
	initial_gas_mix = RED_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/asteroid/basalt/redplanet
	baseturfs = /turf/baseturf_bottom
	initial_gas_mix = RED_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/closed/mineral/random/redplanet
	baseturfs = /turf/baseturf_bottom
	mineralChance = 25
	mineralAmt = 10
	color = RED_ROCK
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/bluespace_crystal = 1
	)
	tool_mine_speed = 10 SECONDS

/turf/closed/mineral/random/redplanet/dark
	baseturfs = /turf/open/misc/asteroid/basalt/redplanet
	color = DARK_ROCK

/area/redplanet
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	name = "Hellas Planitia Outdoors"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | NO_ALERTS
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_MINING
	sound_environment = SOUND_AREA_LAVALAND
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	ambient_buzz = 'sound/ambience/magma.ogg'
	outdoors = TRUE
	base_lighting_alpha = 15

/area/redplanet/Initialize(mapload)
	. = ..()
	luminosity = 1
