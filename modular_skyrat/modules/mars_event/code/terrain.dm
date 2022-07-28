#define ULTRA_THIN_MOON_ATMOS "hydrogen=5;helium=3;TEMP=94"
#define MOON_ROCK "#a3a3a3"

/turf/open/misc/asteroid/basalt/moon
	initial_gas_mix = ULTRA_THIN_MOON_ATMOS
	planetary_atmos = TRUE
	name = "lunar regolith"
	baseturfs = /turf/baseturf_bottom
	icon = 'modular_skyrat/modules/mars_event/icons/moon_tiles.dmi'
	icon_state = "moon"
	base_icon_state = "moon"
	floor_variance = 25
	digResult = /obj/item/stack/ore/glass/moon
	broken_state = "moon_dug"

/obj/item/stack/ore/glass/moon
	name = "lunar regolith"
	icon_state = "volcanic_sand"
	inhand_icon_state = "volcanic_sand"
	singular_name = "lunar regolith pile"
	points = 2 //HOLY SHIT TWO POINTS!!
	mats_per_unit = list(
		/datum/material/glass = MINERAL_MATERIAL_AMOUNT * 0.75,
		/datum/material/iron = MINERAL_MATERIAL_AMOUNT * 0.25
	)
	mine_experience = 1 //its sand but EPIC!!!!
	merge_type = /obj/item/stack/ore/glass/moon

/turf/closed/mineral/random/moonrock
	baseturfs = /turf/baseturf_bottom
	mineralChance = 25
	mineralAmt = 10
	color = MOON_ROCK
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
	base_lighting_alpha = 45

/area/redplanet/Initialize(mapload)
	. = ..()
	luminosity = 1
