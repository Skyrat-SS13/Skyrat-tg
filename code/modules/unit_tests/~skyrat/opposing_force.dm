#define DATUM_PATH_LEN 33

///Checks that all OPFOR items have an `item_type` associated with them
/datum/unit_test/opfor_items

/datum/unit_test/opfor_items/Run()
	var/list/subtype_pre = subtypesof(/datum/opposing_force_equipment)
	var/list/compiled_subtypes = list()
	var/list/dupe_check = list()
	for(var/datum/opposing_force_equipment/opfor as anything in subtype_pre)
		var/path_string = "[opfor]"
		var/partially_cut = splicetext(path_string, 1, DATUM_PATH_LEN, "") // now looks like `parent` or `parent/opforitem`
		var/result_cut = splicetext(partially_cut, 1, findtext(partially_cut, "/"), "") // now will just be /opforitem
		if(!findtext(result_cut, "/"))
			continue
		compiled_subtypes += opfor

	for(var/datum/opposing_force_equipment/opfor_item as anything in compiled_subtypes)
		//var/datum/opposing_force_equipment/opfor_obj = new opfor()
		if(!initial(opfor_item.item_type))
			Fail("Opposing Force equipment datum [opfor_item] lacks an `item_type`.")
		var/obj/dupe_scan = dupe_check.Find(initial(opfor_item.item_type))
		if(dupe_scan)
			Fail("Opposing Force Equipment datum [opfor_item] has the same item type ([dupe_scan]) as another datum.")
		if(!istype(initial(opfor_item.item_type), /obj/effect/gibspawner/generic)) //Dupes here are intentional with the gibspawner
			dupe_check += initial(opfor_item.item_type)
		//qdel(opfor_obj)

#undef DATUM_PATH_LEN
