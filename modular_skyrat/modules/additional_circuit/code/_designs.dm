//Mining Component
/datum/design/component/mining
	name = "Mining Component"
	id = "comp_mine"
	build_path = /obj/item/circuit_component/mining

//Item Interact Component
/datum/design/component/item_interact
	name = "Item Interact Component"
	id = "comp_iinteract"
	build_path = /obj/item/circuit_component/item_interact

/datum/techweb_node/comp_advanced_interacts
	id = "comp_advanced_interacts"
	display_name = "Advanced Action Components"
	description = "Grants access to more advanced action components for the drone shell."
	prereq_ids = list("movable_shells")
	design_ids = list(
		"comp_mine",
		"comp_iinteract",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)

//Target Scanner Component
/datum/design/component/radar_scanner
	name = "Target Scanner Component"
	id = "comp_tscanner"
	build_path = /obj/item/circuit_component/target_scanner

//Cell Charge Component
/datum/design/component/cell_charge
	name = "Cell Charge Component"
	id = "comp_ccharge"
	build_path = /obj/item/circuit_component/cell_charge

//Reagent Injector Component (Bluespace)
/datum/design/component/bci/reagent_injector_bluespace
	name = "Reagent Injector Component (Bluespace)"
	id = "comp_reagent_injector_bluespace"
	build_path = /obj/item/circuit_component/reagent_injector_bluespace

//Drone Camera
/datum/design/component/drone_camera
	name = "Drone Camera"
	id = "comp_drone_camera"
	build_path = /obj/item/circuit_component/compare/remotecam/drone

//Polaroid Camera Add-On
/datum/design/component/polaroid_camera
	name = "Polaroid Camera Add-On"
	id = "comp_polaroid_camera"
	build_path = /obj/item/circuit_component/compare/remotecam/polaroid

//Eye Camera
/datum/design/component/bci/eye_camera
	name = "Eye Camera"
	id = "comp_eye_camera"
	build_path = /obj/item/circuit_component/compare/remotecam/bci

/datum/techweb_node/adv_shells/New()
	. = ..()
	design_ids += "comp_tscanner"
	design_ids += "comp_ccharge"

/datum/techweb_node/basic_circuitry/New()
	. = ..()
	design_ids += "comp_polaroid_camera"

/datum/techweb_node/bci_shells/New()
	. = ..()
	design_ids += "comp_eye_camera"

/datum/techweb_node/movable_shells_tech/New()
	. = ..()
	design_ids += "comp_drone_camera"

/datum/techweb_node/syndicate_basic/New()
	. = ..()
	design_ids += "comp_reagent_injector_bluespace"
