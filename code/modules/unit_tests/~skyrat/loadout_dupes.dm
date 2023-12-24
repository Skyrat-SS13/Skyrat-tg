///Checks that loadout items' item_paths are unique to the category of loadout item it belongs to
/datum/unit_test/loadout_dupes

/datum/unit_test/loadout_dupes/Run()
	var/list/item_paths = list()
	for(var/datum/loadout_item/item as anything in subtypesof(/datum/loadout_item))
		var/loadout_item_category = initial(item.category)
		var/item_path = initial(item.item_path)
		if(item_paths[item_path] == loadout_item_category)
			TEST_FAIL("Duplicate loadout item! [item_path] is already being used by [item].")
		if(isnull(item_path)) // can be null, for subcategories of loadout items
			continue

		item_paths[item_path] = loadout_item_category
