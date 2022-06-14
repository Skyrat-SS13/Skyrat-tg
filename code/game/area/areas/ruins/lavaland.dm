//Lavaland Ruins
//NOTICE: /unpowered means you never get power. Thanks Fikou

/area/ruin/powered/beach

/area/ruin/powered/clownplanet
	name = "\improper Clown Planet"
	ambientsounds = list('sound/ambience/clown.ogg')

/area/ruin/unpowered/gaia
	name = "\improper Patch of Eden"

/area/ruin/powered/snow_biodome

/area/ruin/powered/gluttony

/area/ruin/powered/golem_ship
	name = "\improper Free Golem Ship"

/area/ruin/powered/greed

/area/ruin/unpowered/hierophant
	name = "\improper Hierophant's Arena"

/area/ruin/powered/pride

/area/ruin/powered/seedvault

/area/ruin/unpowered/elephant_graveyard
	name = "\improper Elephant Graveyard"

/area/ruin/powered/graveyard_shuttle
	name = "\improper Elephant Graveyard"

/area/ruin/syndicate_lava_base
	name = "\improper Secret Base"
	ambience_index = AMBIENCE_DANGER

/area/ruin/unpowered/cultaltar
	name = "\improper Cult Altar"
	area_flags = CULT_PERMITTED
	ambience_index = AMBIENCE_SPOOKY

//Syndicate lavaland base

/area/ruin/syndicate_lava_base/engineering
	name = "Interdyne Engineering" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/medbay
	name = "Interdyne Medbay" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/arrivals
	name = "Interdyne Arrivals" // SKYRAT EDIT STEALTH INTERDYNE

/area/ruin/syndicate_lava_base/bar
	name = "\improper Interdyne Bar" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/main
	name = "\improper Interdyne Primary Hallway" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/cargo
	name = "\improper Interdyne Cargo Bay" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/chemistry
	name = "Interdyne Chemistry" // SKYRAT EDIT STEALTH INTERDYNE

/area/ruin/syndicate_lava_base/virology
	name = "Interdyne Virology" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/testlab
	name = "\improper Interdyne Experimentation Lab" // SKYRAT EDIT STEALTH INTERDYNE
	area_flags = XENOBIOLOGY_COMPATIBLE //SKYRAT EDIT ADDITION - MAPPING
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/dormitories
	name = "\improper Interdyne Dormitories" // SKYRAT EDIT STEALTH INTERDYNE
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/telecomms
	name = "\improper Interdyne Telecommunications" // SKYRAT EDIT STEALTH INTERDYNE

//Xeno Nest

/area/ruin/unpowered/xenonest
	name = "The Hive"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
//ash walker nest
/area/ruin/unpowered/ash_walkers
	//SKYRAT EDIT ADDITION BEGIN - ASH WALKER MACHINES FIX
	always_unpowered = FALSE
	power_equip = TRUE
	//SKYRAT EDIT ADDITION END

/area/ruin/unpowered/ratvar
	outdoors = TRUE
