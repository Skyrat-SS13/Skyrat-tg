///Checks that all OPFOR items have a desc, either on the datum itself or the item it's attached to
/datum/unit_test/opfor_item_desc

/datum/unit_test/opfor_item_desc/Run()
	for(var/datum/opposing_force_equipment/opfor_parent as anything in GLOB.opfor_equipment_parents)
		for(var/datum/opposing_force_equipment/opfor_item as anything in subtypesof(opfor_parent))
			if(!length(opfor_item.description) && !length(opfor_item.item_type.desc))
				Fail("Opposing Force equipment datum [opfor_item] lacks a name.")
