/datum/component/leash
	/// whether the leash is enabled or not
	var/enabled = TRUE

/// Stop listening for any signals
/datum/component/leash/proc/disable_leash()
	if(!enabled)
		return

	enabled = FALSE
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE)

/// Start listening for signals again
/datum/component/leash/proc/enable_leash()
	if(enabled)
		return

	enabled = TRUE
	check_distance() // yoink them back
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_owner_moved))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_parent_pre_move))

/// Enables or disables the leash, allowing or forbidding the PAI from leaving a specified range
/datum/component/leash/proc/toggle_leash()
	to_chat(owner, span_warning("Your virtual leash has been [enabled ? "activated" : "deactivated"]!"))
	if(enabled)
		disable_leash()
	else
		enable_leash()
