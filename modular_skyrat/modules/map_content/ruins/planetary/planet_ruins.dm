/datum/map_template/ruin/planetary
	prefix = "_maps/RandomRuins/Planet/"
	allow_duplicates = FALSE
	/// A bitfield representing the requirements of the ruin for it to be spawned (Planet properties are checked)
	var/planet_requirements = NONE

/datum/map_template/ruin/planetary/colony
	name = "Colony"
	id = "colony"
	description = "A colony."
	cost = 10
	suffix = "colony.dmm"
	planet_requirements = PLANET_HABITABLE
	unpickable = TRUE

/area/ruin/unpowered/colony

/area/ruin/unpowered/colony/outdoors
	outdoors = TRUE

/area/ruin/unpowered/colony/outdoors/cargo_bay
	name = "Colony Cargo Bay"

/area/ruin/unpowered/colony/external_airlock
	name = "Colony External Airlock"

/area/ruin/unpowered/colony/hallways
	name = "Colony Hallways"

/area/ruin/unpowered/colony/bathroom
	name = "Colony Bathroom"

/area/ruin/unpowered/colony/security
	name = "Colony Security"

/area/ruin/unpowered/colony/armory
	name = "Colony Armory"

/area/ruin/unpowered/colony/atmos
	name = "Colony Atmospherics"

/area/ruin/unpowered/colony/engineering
	name = "Colony Engineering"

/area/ruin/unpowered/colony/dorms
	name = "Colony Dormitories"

/area/ruin/unpowered/colony/mess_hall
	name = "Colony Mess Hall"

/area/ruin/unpowered/colony/medbay
	name = "Colony Medbay"

/area/ruin/unpowered/colony/operating_theatre
	name = "Colony Operating Theatre"

/area/ruin/unpowered/colony/ops
	name = "Colony Operations Center"

/area/ruin/unpowered/colony/secure_storage
	name = "Colony Secure Storage"

/datum/map_template/ruin/planetary/crashed_pod
	name = "Crashed Pod"
	id = "crashed_pod"
	description = "A crashed pod."
	cost = 5
	suffix = "crashed_pod.dmm"
	planet_requirements = PLANET_WRECKAGES

/area/ruin/unpowered/crashed_pod
	name = "Crashed Pod"

/datum/map_template/ruin/planetary/old_pod
	name = "Old Pod"
	id = "old_pod"
	description = "An old pod."
	cost = 5
	suffix = "old_pod.dmm"
	planet_requirements = PLANET_WRECKAGES

/datum/map_template/ruin/planetary/deserted_lab
	name = "Deserted Lab"
	id = "deserted_lab"
	description = "A deserted lab."
	cost = 5
	suffix = "deserted_lab.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/lodge
	name = "Lodge"
	id = "lodge"
	description = "A lodge."
	cost = 5
	suffix = "lodge.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/spider_nest
	name = "Spider Nest"
	id = "spider_nest"
	description = "A spider nest."
	cost = 5
	suffix = "spider_nest.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/archeological_site
	name = "Archeological Site"
	id = "archeological_site"
	description = "An archeological site."
	cost = 5
	suffix = "archeological_site.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/abandoned_factory
	name = "Abandoned Factory"
	id = "abandoned_factory"
	description = "An abandoned factory."
	cost = 5
	suffix = "abandoned_factory.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/old_drill_site
	name = "Old Drill Site"
	id = "old_drill_site"
	description = "An old drill site."
	cost = 5
	suffix = "old_drill_site.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/mining_facility
	name = "Mining Facility"
	id = "mining_facility"
	description = "A mining facility."
	cost = 5
	suffix = "mining_facility.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/abandoned_containment
	name = "Abandoned Containment"
	id = "abandoned_containment"
	description = "A long abandoned base containing a dangerous secret."
	cost = 5
	suffix = "abandoned_containment.dmm"
	planet_requirements = PLANET_HABITABLE

/datum/map_template/ruin/planetary/weather_station
	name = "Weather Station"
	id = "weather_station"
	description = "A dormant weather research station."
	cost = 5
	suffix = "weather_station.dmm"
	planet_requirements = PLANET_HABITABLE
