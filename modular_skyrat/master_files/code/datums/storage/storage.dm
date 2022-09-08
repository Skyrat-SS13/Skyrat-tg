// Proc to add holdables list to an existing storage datum
/datum/storage/proc/add_holdable(list/can_hold_list)
	if(can_hold_list)
		var/unique_key = can_hold_list.Join("-")
		if(!GLOB.cached_storage_typecaches[unique_key])
			GLOB.cached_storage_typecaches[unique_key] = typecacheof(can_hold_list)
		can_hold += GLOB.cached_storage_typecaches[unique_key]
