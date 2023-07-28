/datum/component/leash
	/// whether the leash is enabled or not
	var/enabled = FALSE

/datum/component/leash/on_owner_moved(atom/movable/source)
	if(!enabled)
		return
	return ..()

/datum/component/leash/on_parent_pre_move(atom/movable/source, atom/new_location)
	if(!enabled)
		return
	return ..()

/datum/component/leash/check_distance()
	if(!enabled)
		return
	return ..()

/// Enables or disables the leash, allowing or forbidding the PAI from leaving a specified range
/datum/component/leash/proc/toggle_leash()
	enabled = !enabled
	to_chat(owner, span_warning("Your virtual leash has been [enabled ? "activated" : "deactivated"]!"))
	if(!enabled)
		enabled = TRUE
		check_distance() // yoink them back
