///Checks that all OPFOR items have an `item_type` associated with them
/datum/unit_test/opfor_items

/datum/unit_test/opfor_items/Run()
	for(var/datum/opposing_force_equipment/opfor_parent in GLOB.opfor_equipment_parents)
		for(var/datum/opposing_force_equipment/opfor_item in subtypesof(opfor_parent))
			if(opfor_item.item_type)
				continue
			Fail("Opposing Force equipment datum [opfor_item] lacks an `item_type`.")
