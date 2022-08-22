#define RED_PLANET_ATMOS "co2=40;o2=3;n2=7;TEMP=347"
#define DARK_ROCK "#2b2b2b"

/turf/open/misc/ironsand/redplanet
	initial_gas_mix = RED_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/ironsand/redplanet/randomrocks

/turf/open/misc/ironsand/redplanet/randomrocks/Initialize(mapload)
	. = ..()

	if(prob(2))
		new /obj/structure/flora/rock/style_random(get_turf(src))
	else if(prob(2))
		new /obj/structure/flora/rock/pile/style_random(get_turf(src))

/turf/open/misc/asteroid/basalt/redplanet
	baseturfs = /turf/baseturf_bottom
	initial_gas_mix = RED_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/asteroid/basalt/redplanet/randomrocks

/turf/open/misc/asteroid/basalt/redplanet/randomrocks/Initialize(mapload)
	. = ..()

	if(prob(2))
		new /obj/structure/flora/rock/style_random(get_turf(src))
	else if(prob(2))
		new /obj/structure/flora/rock/pile/style_random(get_turf(src))
	else if(prob(1))
		new /obj/structure/ore_vein/iron/more_than_one_ore(get_turf(src))

/obj/structure/ore_vein/iron/more_than_one_ore
	ore_amount = 7
	regeneration_time = 30 SECONDS

/turf/open/lava/smooth/redplanet
	initial_gas_mix = RED_PLANET_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/lava/smooth/redplanet

/turf/closed/mineral/random/dark_lavaland_rock
	baseturfs = /turf/baseturf_bottom
	mineralChance = 25
	mineralAmt = 10
	color = DARK_ROCK
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

/area/lavaplanet
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	name = "Molten Valley Outdoors"
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
	base_lighting_alpha = 45

/area/lavaplanet/Initialize(mapload)
	. = ..()
	luminosity = 1
