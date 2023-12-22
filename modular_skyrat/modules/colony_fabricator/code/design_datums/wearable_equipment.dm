// Machine categories

#define FABRICATOR_CATEGORY_WEARABLES "/Wearable Equipment"
#define FABRICATOR_SUBCATEGORY_COMMUNICATION "/Communications"
#define FABRICATOR_SUBCATEGORY_RESPIRATOR "/Respiration"
#define FABRICATOR_SUBCATEGORY_HAZARD_SUIT "/Hazardous Environment"

// Techweb node that shouldnt show up anywhere ever specifically for the fabricator to work with

/datum/techweb_node/colony_fabricator_wearables
	id = "colony_fabricator_wearables"
	display_name = "Colony Fabricator Wearable Equipment Designs"
	description = "Contains all of the colony fabricator's wearables designs."
	design_ids = list(
		"frontier_headset",
		"frontier_gas_mask",
		"frontier_hazard_suit",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000000000000000) // God save you
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

// Radio headset able to transmit comms like a station bounced radio would

/datum/design/frontier_headset
	name = "Frontier Radio Headset"
	id = "frontier_headset"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT, // The silver is the antenna that lets this not be subspace only
	)
	build_path = /obj/item/radio/headset/headset_frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_WEARABLES + FABRICATOR_SUBCATEGORY_COMMUNICATION,
	)
	construction_time = 10 SECONDS

// Gas mask with more filter slots

/datum/design/frontier_gas_mask
	name = "Frontier Gas Mask"
	id = "frontier_gas_mask"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_WEARABLES + FABRICATOR_SUBCATEGORY_RESPIRATOR,
	)
	construction_time = 10 SECONDS

// Gas mask with more filter slots

/datum/design/frontier_hazard_suit
	name = "Frontier Hazard Protective MOD Control Unit"
	desc = "The pinnacle of frontier cheap technology. Suits such as these are made specifically for the rare emergency that creates a hazard \
		environment that other equipment just can't quite handle. Often, these suits are able to protect their users \
		from not only electricity, but also radiation, biological hazards, other people, so on. This suit will not, \
		however, protect you from yourself."
	id = "frontier_hazard_suit"
	build_type = COLONY_FABRICATOR
	// This materials list is all of the parts it takes to make this suit minus the cost of the (pretty poor) cell
	materials = list(
		/datum/material/iron = ((SHEET_MATERIAL_AMOUNT * 23) + (SMALL_MATERIAL_AMOUNT * 15)),
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3.5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = ((SHEET_MATERIAL_AMOUNT) + (SMALL_MATERIAL_AMOUNT * 7.5)),
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/mod/control/pre_equipped/frontier_colonist
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_WEARABLES + FABRICATOR_SUBCATEGORY_HAZARD_SUIT,
	)
	construction_time = 1 MINUTES

#undef FABRICATOR_CATEGORY_WEARABLES
#undef FABRICATOR_SUBCATEGORY_COMMUNICATION
#undef FABRICATOR_SUBCATEGORY_RESPIRATOR
#undef FABRICATOR_SUBCATEGORY_HAZARD_SUIT
