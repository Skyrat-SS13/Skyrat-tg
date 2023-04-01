#define DATUM_PATH_LEN 33

///Checks that all OPFOR items have an `item_type` associated with them
/datum/unit_test/opfor_items

/datum/unit_test/opfor_items/Run()
	var/list/subtype_pre = subtypesof(/datum/opposing_force_equipment)
	var/list/compiled_subtypes = list()
	for(var/datum/opposing_force_equipment/opfor as anything in subtype_pre)
		var/path_string = "[opfor]"
		var/partially_cut = splicetext(path_string, 1, DATUM_PATH_LEN, "") // now looks like `parent` or `parent/opforitem`
		var/result_cut = splicetext(partially_cut, 1, findtext(partially_cut, "/"), "") // now will just be /opforitem
		if(!findtext(result_cut, "/"))
			continue
		compiled_subtypes += opfor

	for(var/datum/opposing_force_equipment/opfor_item as anything in compiled_subtypes)
		if(!initial(opfor_item.item_type))
			TEST_FAIL("Opposing Force equipment datum [opfor_item] lacks an `item_type`.")

#undef DATUM_PATH_LEN
