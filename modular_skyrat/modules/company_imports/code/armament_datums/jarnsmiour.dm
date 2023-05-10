/datum/armament_entry/company_import/blacksteel
	category = BLACKSTEEL_FOUNDATION_NAME
	company_bitflag = CARGO_COMPANY_BLACKSTEEL

// A collection of melee weapons fitting the company's more exotic feeling weapon selection

/datum/armament_entry/company_import/blacksteel/blade
	subcategory = "Bladed Weapons"

/datum/armament_entry/company_import/blacksteel/blade/hunting_knife
	item_type = /obj/item/knife/hunting
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1

/datum/armament_entry/company_import/blacksteel/blade/hatchet
	name = "Blacksteel (TM) hatchet"
	description = "A short handled hatchet forged from Jarnsmiour's signature Blacksteel (TM), quality guaranteed." // Hint: This is a lie
	item_type = /obj/item/hatchet/wooden
	lower_cost = CARGO_CRATE_VALUE * 0.7
	upper_cost = CARGO_CRATE_VALUE * 1.2

/datum/armament_entry/company_import/blacksteel/blade/survival_knife
	item_type = /obj/item/knife/combat/survival
	lower_cost = CARGO_CRATE_VALUE * 1.2
	upper_cost = CARGO_CRATE_VALUE * 1.7

/datum/armament_entry/company_import/blacksteel/blade/bowie_knife
	item_type = /obj/item/storage/belt/bowie_sheath
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/blacksteel/blade/shamshir_sabre
	item_type = /obj/item/storage/belt/sabre/cargo
	lower_cost = CARGO_CRATE_VALUE * 5
	upper_cost = CARGO_CRATE_VALUE * 7
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

// Forging tools, blacksteel company sells the tools and materials they use as well!

/datum/armament_entry/company_import/blacksteel/forging_tools
	subcategory = "Premium Forging Equipment"

/datum/armament_entry/company_import/blacksteel/forging_tools/billows
	item_type = /obj/item/forging/billow
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.4

/datum/armament_entry/company_import/blacksteel/forging_tools/hammer
	item_type = /obj/item/forging/hammer
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.4

/datum/armament_entry/company_import/blacksteel/forging_tools/tongs
	item_type = /obj/item/forging/tongs
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.4

// Fancy sounding and looking bars of metal that most definitely aren't just common metals with a fancy sounding name

/datum/armament_entry/company_import/blacksteel/forging_metals
	subcategory = "Premium Metal Supplies"

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_cobalt
	item_type = /obj/item/stack/sheet/cobolterium/three
	description = "A three-pack of our finest cobolterium alloy, with an unmatched regal blue color for creating the strongest metalworks from."
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_copper
	item_type = /obj/item/stack/sheet/copporcitite/three
	description = "A three-pack of our finest copporcitite alloy, with a powerful, fiery orange color for creating the strongest metalworks from."
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_really_blue_aluminum
	item_type = /obj/item/stack/sheet/tinumium/three
	description = "A three-pack of our finest tinumium alloy, with a mystical faded blue color for creating the strongest metalworks from."
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_brass
	item_type = /obj/item/stack/sheet/brussite/three
	description = "A three-pack of our finest brussite alloy, with a robust yellow color for creating the strongest metalworks from."
	lower_cost = CARGO_CRATE_VALUE
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
