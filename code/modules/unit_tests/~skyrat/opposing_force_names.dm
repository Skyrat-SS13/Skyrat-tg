///Checks that all OPFOR items have a name, either on the datum itself or the item it's attached to
/datum/unit_test/opfor_item_names

/datum/unit_test/opfor_item_names/Run()
	for(var/datum/opposing_force_equipment/opfor_parent in GLOB.opfor_equipment_parents)
		for(var/datum/opposing_force_equipment/opfor_item in subtypesof(opfor_parent))
			if(!length(opfor_item.name) && !length(opfor_item.item_type.name))
				Fail("Opposing Force equipment datum [opfor_item] lacks a name.")
