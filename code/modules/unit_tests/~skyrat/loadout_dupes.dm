///Checks that loadout items' item_paths are unique
/datum/unit_test/loadout_dupes

/datum/unit_test/loadout_dupes/Run()
	var/list/item_paths = list()
	for(var/datum/loadout_item/item as anything in subtypesof(/datum/loadout_item))
		var/item_path = initial(item.item_path)
		if(item_paths[item_path])
			TEST_FAIL("The same `item_path` appears in more than one `loadout_item`! [item_path] is already being used by [item].")
		item_paths[item_path] = TRUE
