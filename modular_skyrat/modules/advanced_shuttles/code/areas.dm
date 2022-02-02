/area/shuttle/escape/no_light
	area_flags = UNIQUE_AREA | NO_ALERTS | AREA_USES_STARLIGHT

/area/shuttle/arrival/no_light
	static_lighting = FALSE

/area/shuttle/mining/no_light
	static_lighting = FALSE

/area/shuttle/supply/no_light
	static_lighting = FALSE

/area/shuttle/transport/no_light
	static_lighting = FALSE

//Unique Areas -----
/area/centcom/interlink
	name = "The Interlink"

/area/centcom/interlink/rep
	name = "Nanotrasen Representative's Auxilliary Office"

/area/centcom/interlink/bluie
	name = "Blueshield's Auxilliary Office"

/area/centcom/interlink/the_toilet	//Wooooooo spooky
	name = "Interlink Toilet"
	ambience_index = AMBIENCE_MAINT
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/centcom/interlink/dorms
	name = "Interlink Dormitories"

/area/centcom/interlink/dorms/one
	name = "Interlink Dorm 1"

/area/centcom/interlink/dorms/two
	name = "Interlink Dorm 2"

/area/centcom/interlink/dorms/three
	name = "Interlink Dorm 3"

/area/centcom/interlink/dorms/bigone
	name = "Interlink Lodge 1"

/area/centcom/interlink/dorms/bigtwo
	name = "Interlink Lodge 2"

/area/centcom/interlink/dorms/bigthree
	name = "Interlink Lodge 3"

/area/centcom/interlink/dorms/bigfour
	name = "Interlink Lodge 4"

/area/centcom/evac/interlink	//Renamed version for CC, still on the /evac/ path so endround statuses arent changed
	name = "Interlink Evacuation Docks"

/area/shuttle/arrival
	name = "NTV Relay"

/area/shuttle/supply/cockpit
	name = "NLV Consign Cockpit"

/area/shuttle/mining/advanced
	name = "NMC Phoenix"

/area/shuttle/mining/advanced/public
	name = "NMC Chimera"

/area/shuttle/mining/large/advanced
	name = "NMC Manticore"

/area/shuttle/labor/advanced
	name = "NMC Drudge"
