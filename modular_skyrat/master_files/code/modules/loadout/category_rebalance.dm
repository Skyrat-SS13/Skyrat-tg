/datum/loadout_category/pocket
	max_allowed = 3

/datum/loadout_category/toys
	VAR_PRIVATE/max_allowed = 3

/datum/loadout_category/toys/New()
	. = ..()
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/toys/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/toys/other_toys_items = list()
	for(var/datum/loadout_item/toys/other_toys_item in all_loadout_items)
		other_toys_items += other_toys_item

	if(length(other_toys_items) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_toys_items[1])
	return TRUE
