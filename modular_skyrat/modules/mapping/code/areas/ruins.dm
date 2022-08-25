// Skyrat area ruins

/area/ruin/powered/miningfacility
	name = "Abandoned Nanotrasen Mining Facility"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/ambience/title3.ogg') //Classic vibes

/area/ruin/powered/crashedshuttle
	name = "Crashed Shuttle"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/ambience/ambiodd.ogg')

/area/ruin/powered/cozycabin
	name = "Cozy Cabin"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/ambience/ambicha1.ogg', 'sound/ambience/ambicha2.ogg', 'sound/ambience/ambicha3.ogg')

/area/ruin/powered/biodome
	name = "Jungle Biodome"
	icon_state = "dk_yellow"

//NOT FOR ROCKPLANET RUINS, LOOK IN THE FOLDER JUST ABOVE THIS
/area/rockplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_ASTEROID

/area/rockplanet/surface
	name = "Rockplanet"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_CREEPY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | NO_ALERTS
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/rockplanet/underground
	name = "Rockplanet Caves"
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambience_index = AMBIENCE_CREEPY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | NO_ALERTS
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/rockplanet/surface/outdoors
	name = "Rockplanet Wastes"
	outdoors = TRUE

/area/rockplanet/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | NO_ALERTS
	map_generator = /datum/map_generator/cave_generator/rockplanet

/area/rockplanet/surface/outdoors/unexplored/danger //megafauna will also spawn here
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS

/area/rockplanet/surface/outdoors/explored
	name = "Rockplanet Labor Camp"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NO_ALERTS

/area/security/checkpoint/auxiliary/has_gravity
	name = "Security Checkpoint - Rockplanet"	//Duplicate name bad
	has_gravity = TRUE //The fact I need to force this is stupid as hell
