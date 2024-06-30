/datum/armament_entry/company_import/blacksteel
	category = COMPANY_NAME_BLACKSTEEL_FOUNDATION
	company_bitflag = CARGO_COMPANY_BLACKSTEEL

// A collection of melee weapons fitting the company's more exotic feeling weapon selection

/datum/armament_entry/company_import/blacksteel/blade
	subcategory = "Bladed Weapons"

/datum/armament_entry/company_import/blacksteel/blade/hunting_knife
	item_type = /obj/item/knife/hunting
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/blacksteel/blade/survival_knife
	item_type = /obj/item/knife/combat/survival
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/blacksteel/blade/bowie_knife
	item_type = /obj/item/storage/belt/bowie_sheath
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/blacksteel/blade/shamshir_sabre
	item_type = /obj/item/storage/belt/sabre/cargo
	cost = PAYCHECK_COMMAND * 3

// Forging tools, blacksteel company sells the tools and materials they use as well!

/datum/armament_entry/company_import/blacksteel/forging_tools
	subcategory = "Premium Forging Equipment"

/datum/armament_entry/company_import/blacksteel/forging_tools/billows
	item_type = /obj/item/forging/billow
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/blacksteel/forging_tools/hammer
	item_type = /obj/item/forging/hammer
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/blacksteel/forging_tools/tongs
	item_type = /obj/item/forging/tongs
	cost = PAYCHECK_LOWER

// Fancy sounding and looking bars of metal that most definitely aren't just common metals with a fancy sounding name

/datum/armament_entry/company_import/blacksteel/forging_metals
	subcategory = "Premium Metal Supplies"

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_cobalt
	item_type = /obj/item/stack/sheet/cobolterium/three
	description = "A three-pack of our finest cobolterium alloy, with an unmatched regal blue color for creating the strongest metalworks from."
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_copper
	item_type = /obj/item/stack/sheet/copporcitite/three
	description = "A three-pack of our finest copporcitite alloy, with a powerful, fiery orange color for creating the strongest metalworks from."
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_really_blue_aluminum
	item_type = /obj/item/stack/sheet/tinumium/three
	description = "A three-pack of our finest tinumium alloy, with a mystical faded blue color for creating the strongest metalworks from."
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/blacksteel/forging_metals/fake_brass
	item_type = /obj/item/stack/sheet/brussite/three
	description = "A three-pack of our finest brussite alloy, with a robust yellow color for creating the strongest metalworks from."
	cost = PAYCHECK_CREW
