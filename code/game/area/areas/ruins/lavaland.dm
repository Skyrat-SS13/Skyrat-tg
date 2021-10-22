//Lavaland Ruins
//NOTICE: /unpowered means you never get power. Thanks Fikou

/area/ruin/powered/beach
	icon_state = "dk_yellow"

/area/ruin/powered/clownplanet
	name = "\improper Clown Planet"
	icon_state = "dk_yellow"
	ambientsounds = list('sound/ambience/clown.ogg')

/area/ruin/unpowered/gaia
	name = "\improper Patch of Eden"
	icon_state = "dk_yellow"

/area/ruin/powered/snow_biodome
	icon_state = "dk_yellow"

/area/ruin/powered/gluttony
	icon_state = "dk_yellow"

/area/ruin/powered/golem_ship
	name = "\improper Free Golem Ship"
	icon_state = "dk_yellow"

/area/ruin/powered/greed
	icon_state = "dk_yellow"

/area/ruin/unpowered/hierophant
	name = "\improper Hierophant's Arena"
	icon_state = "dk_yellow"

/area/ruin/powered/pride
	icon_state = "dk_yellow"

/area/ruin/powered/seedvault
	icon_state = "dk_yellow"

/area/ruin/unpowered/elephant_graveyard
	name = "\improper Elephant Graveyard"
	icon_state = "dk_yellow"

/area/ruin/powered/graveyard_shuttle
	name = "\improper Elephant Graveyard"
	icon_state = "green"

/area/ruin/syndicate_lava_base
	name = "\improper Secret Base"
	icon_state = "dk_yellow"
	ambience_index = AMBIENCE_DANGER

/area/ruin/unpowered/cultaltar
	name = "\improper Cult Altar"
	area_flags = CULT_PERMITTED
	ambience_index = AMBIENCE_SPOOKY

//Syndicate lavaland base

/area/ruin/syndicate_lava_base/engineering
	name = "Syndicate Lavaland Engineering"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/medbay
	name = "Syndicate Lavaland Medbay"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/arrivals
	name = "Syndicate Lavaland Arrivals"

/area/ruin/syndicate_lava_base/bar
	name = "\improper Syndicate Lavaland Bar"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/main
	name = "\improper Syndicate Lavaland Primary Hallway"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/cargo
	name = "\improper Syndicate Lavaland Cargo Bay"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/chemistry
	name = "Syndicate Lavaland Chemistry"

/area/ruin/syndicate_lava_base/virology
	name = "Syndicate Lavaland Virology"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/testlab
	name = "\improper Syndicate Lavaland Experimentation Lab"
	area_flags = XENOBIOLOGY_COMPATIBLE //SKYRAT EDIT ADDITION - MAPPING
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/dormitories
	name = "\improper Syndicate Lavaland Dormitories"
	always_unpowered = FALSE // SKYRAT EDIT ADDITION - SYNDIEBROKE

/area/ruin/syndicate_lava_base/telecomms
	name = "\improper Syndicate Lavaland Telecommunications"

//Xeno Nest

/area/ruin/unpowered/xenonest
	name = "The Hive"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
//ash walker nest
/area/ruin/unpowered/ash_walkers
	icon_state = "red"
	//SKYRAT EDIT ADDITION BEGIN - ASH WALKER MACHINES FIX
	always_unpowered = FALSE
	power_equip = TRUE
	//SKYRAT EDIT ADDITION END

/area/ruin/unpowered/ratvar
	icon_state = "dk_yellow"
	outdoors = TRUE
