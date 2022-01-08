/*
	The click handler itself
*/
/datum/click_handler/gun/sustained/kinesis

	fire_proc = /obj/item/rig_module/kinesis/proc/update
	//fire_proc = /obj/item/rig_module/kinesis/proc/schedule_update	//For future
	stop_proc = /obj/item/rig_module/kinesis/proc/release_grip
	get_firing_proc = /obj/item/rig_module/kinesis/proc/is_gripping
	change_target_proc = /obj/item/rig_module/kinesis/proc/changed_target
	start_proc = null	//No start firing proc

/datum/click_handler/gun/sustained/kinesis/resolve_world_target(a, params)
	if(isliving(user) && user.incapacitated(INCAPACITATION_KNOCKOUT))
		return
	return ..()
