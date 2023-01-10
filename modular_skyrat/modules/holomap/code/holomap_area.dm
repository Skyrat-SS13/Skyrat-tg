/*
** Holomap vars and procs on /area
*/

/area
	/// Color of this area on holomaps.
	var/holomap_color = null

/// Whether the turfs in the area should be drawn onto the "base" holomap.
/area/proc/holomapAlwaysDraw()
	return TRUE

/area/shuttle/holomapAlwaysDraw()
	return FALSE

// Command
/area/station/command
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
/area/station/ai_monitored
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

// Security
/area/station/security
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
/area/station/ai_monitored/security
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

// Science
/area/station/science
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

// Medical
/area/station/medical
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

// Engineering
/area/station/engineering
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/maintenance/department/engine
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/maintenance/department/engineering
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/maintenance/department/electrical
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/tcommsat
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/maintenance/disposal/incinerator
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/maintenance/solars
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/construction
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/hallway/secondary/construction
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

// Service
/area/station/service
	holomap_color = HOLOMAP_AREACOLOR_CIV

// Cargo
/area/station/cargo
	holomap_color = HOLOMAP_AREACOLOR_CARGO
/area/station/maintenance/disposal
	holomap_color = HOLOMAP_AREACOLOR_CARGO

// Mining base
/area/mine
	holomap_color = HOLOMAP_AREACOLOR_CARGO
/area/mine/laborcamp
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
/area/mine/mechbay
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
/area/mine/cafeteria
	holomap_color = HOLOMAP_AREACOLOR_DORMS
/area/mine/maintenance
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/mine/maintenance/service
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/mine/maintenance/service/disposals
	holomap_color = HOLOMAP_AREACOLOR_CARGO
/area/mine/living_quarters
	holomap_color = HOLOMAP_AREACOLOR_DORMS
/area/mine/hydroponics
	holomap_color = HOLOMAP_AREACOLOR_CIV
/area/mine/medical
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

// Hallways
/area/station/hallway
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
/area/station/hallway/secondary/command
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
/area/station/hallway/secondary/service
	holomap_color = HOLOMAP_AREACOLOR_CIV
/area/station/hallway/secondary/exit/departure_lounge
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE
/area/station/hallway/secondary/entry
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

// Maints
/area/station/maintenance
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/station/service/library/abandoned
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/station/service/abandoned_gambling_den
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/station/medical/abandoned
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/station/science/research/abandoned
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/station/commons/vacant_room/office
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE
/area/station/service/hydroponics/garden/abandoned
	holomap_color = HOLOMAP_AREACOLOR_MAINTENANCE

// Dorms
/area/station/commons
	holomap_color = HOLOMAP_AREACOLOR_DORMS
/area/station/common
	holomap_color = HOLOMAP_AREACOLOR_DORMS
/area/station/holodeck
	holomap_color = HOLOMAP_AREACOLOR_DORMS

// Heads
/area/station/command/heads_quarters/captain
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
/area/station/command/heads_quarters/hop
	holomap_color = HOLOMAP_AREACOLOR_CIV
/area/station/command/heads_quarters/rd
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
/area/station/command/heads_quarters/ce
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
/area/station/command/heads_quarters/hos
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
/area/station/command/heads_quarters/cmo
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
/area/station/command/heads_quarters/qm
	holomap_color = HOLOMAP_AREACOLOR_CARGO
