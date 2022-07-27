#define RED_PLANET_ATMOS "co2=40;o2=3;n2=7;TEMP=210"
#define RED_ROCK "#934b33"

/turf/open/misc/ironsand/redplanet
	initial_gas_mix = RED_PLANET_ATMOS

/turf/open/misc/asteroid/basalt/redplanet
	baseturfs = /turf/baseturf_bottom
	initial_gas_mix = RED_PLANET_ATMOS

/turf/closed/mineral/random/redplanet
	baseturfs = /turf/baseturf_bottom
	color = RED_ROCK

/area/redplanet
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
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
