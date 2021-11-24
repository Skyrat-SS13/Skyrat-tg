// CELLS
/datum/design/basic_microfusion_cell
	name = "Basic Microfusion Cell"
	desc = "A basic microfusion cell with a capacity of 1200 MF and and 1 attachment points."
	id = "basic_microfusion_cell"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 200)
	construction_time = 100
	build_path = /obj/item/stock_parts/cell/microfusion
	category = list("Misc","Power Designs","Machinery","initial")

// CELLS
/datum/design/basic_microfusion_phase_emitter
	name = "Basic Microfusion Phase Emitter"
	desc = "A basic microfusion cell with a capacity of 1200 MF and and 1 attachment points"
	id = "basic_microfusion_phase_emitter"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 200)
	construction_time = 100
	build_path = /obj/item/stock_parts/cell/microfusion
	category = list("Misc","Power Designs","Machinery","initial")

/datum/design/enhanced_microfusion_cell
	name = "Enhanced Microfusion Cell"
	desc = "An enhanced microfusion cell with a capacity of 1500 MF and 2 attachment points."
	id = "enhanced_microfusion_cell"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 200, /datum/material/uranium = 200)
	construction_time = 100
	build_path = /obj/item/stock_parts/cell/microfusion/enhanced
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/advanced_microfusion_cell
	name = "advanced Microfusion Cell"
	desc = "An advanced microfusion cell with a capacity of 1700 MF and 3 attachment points."
	id = "advanced_microfusion_cell"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials =  list(/datum/material/iron = 1000, /datum/material/gold = 300, /datum/material/silver = 300, /datum/material/glass = 300, /datum/material/uranium = 300)
	construction_time = 100
	build_path = /obj/item/stock_parts/cell/microfusion/advanced
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/bluespace_microfusion_cell
	name = "Enhanced Microfusion Cell"
	desc = "A bluespace microfusion cell with a capacity of 2000 MF and 4 attachment points."
	id = "bluespace_microfusion_cell"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 300, /datum/material/glass = 300, /datum/material/diamond = 300, /datum/material/uranium = 300, /datum/material/titanium = 300, /datum/material/bluespace = 300)
	construction_time = 100
	build_path = /obj/item/stock_parts/cell/microfusion/enhanced
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

// CELL UPGRADES
/datum/design/microfusion_cell_attachment_rechargable
	name = "Rechargable Microfusion Cell Attachment"
	desc = "An attachment for microfusion cells that allows conversion of KJ to MF in standard chargers."
	id = "microfusion_cell_attachment_rechargable"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/gold = 1000)
	build_path = /obj/item/microfusion_cell_attachment/rechargeable
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusion_cell_attachment_stabaliser
	name = "Stabalisation Microfusion Cell Attachment"
	desc = "Stabalises the internal fusion reaction of microfusion cells."
	id = "microfusion_cell_attachment_stabaliser"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/plasma = 1000)
	build_path = /obj/item/microfusion_cell_attachment/stabaliser
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusion_cell_attachment_overcapacity
	name = "Overcapacity Microfusion Cell Attachment"
	desc = "An attachment for microfusion cells that increases MF capacity."
	id = "microfusion_cell_attachment_overcapacity"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/plasma = 500, /datum/material/gold = 500)
	build_path = /obj/item/microfusion_cell_attachment/overcapacity
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusion_cell_attachment_selfcharging
	name = "Selfcharging Microfusion Cell Attachment"
	desc = "Contains a small amount of infinitely decaying nuclear material, causing the fusion reaction to be self sustaining. WARNING: May cause radiation burns if not stabalised."
	id = "microfusion_cell_attachment_selfcharging"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/diamond = 500, /datum/material/uranium = 1000)
	build_path = /obj/item/microfusion_cell_attachment/selfcharging
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

// GUN UPGRADES
/datum/design/microfusion_gun_attachment_scatter
	name = "Diffuser Microfusion Lens Attachment"
	desc = "Splits the microfusion laser beam entering the lens!"
	id = "microfusion_gun_attachment_scatter"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/diamond = 500, /datum/material/silver = 500)
	build_path = /obj/item/microfusion_gun_attachment/scatter
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

// GUN UPGRADES
/datum/design/microfusion_gun_attachment_focus
	name = "Focusing Microfusion Lens Attachment"
	desc = "Splits the microfusion laser beam entering the lens!"
	id = "microfusion_gun_attachment_focus"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/diamond = 500, /datum/material/silver = 500)
	build_path = /obj/item/microfusion_gun_attachment/focus
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

// GUN UPGRADES
/datum/design/microfusion_gun_attachment_repeater
	name = "Repeating Phase Emitter Upgrade"
	desc = "Upgrades the central phase emitter to repeat twice."
	id = "microfusion_gun_attachment_repeater"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/diamond = 500, /datum/material/alloy/alien = 100)
	build_path = /obj/item/microfusion_gun_attachment/repeater
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
