/datum/design/health_hud_prescription
	name = "Prescription Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status. This one has a prescription lens."
	id = "health_hud_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/health/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_prescription
	name = "Prescription Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status. This one has a prescription lens."
	id = "security_hud_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/security/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_prescription
	name = "Prescription Diagnostic HUD"
	desc = "A HUD used to analyze and determine faults within robotic machinery. This one has a prescription lens."
	id = "diagnostic_hud_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/gold = 350)
	build_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mesons_prescription
	name = "Prescription Optical Meson Scanners"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting condition. Prescription lens has been added into this design."
	id = "mesons_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/meson/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/engine_goggles_prescription
	name = "Prescription Engineering Scanner Goggles"
	desc = "Goggles used by engineers. The Meson Scanner mode lets you see basic structural and terrain layouts through walls, regardless of lighting condition. The T-ray Scanner mode lets you see underfloor objects such as cables and pipes. Prescription lens has been added into this design."
	id = "engine_goggles_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/plasma = 100, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/meson/engine/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tray_goggles_prescription
	name = "Prescription Optical T-Ray Scanners"
	desc = "Used by engineering staff to see underfloor objects such as cables and pipes.  Prescription lens has been added into this design."
	id = "tray_goggles_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 150)
	build_path = /obj/item/clothing/glasses/meson/engine/tray/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
