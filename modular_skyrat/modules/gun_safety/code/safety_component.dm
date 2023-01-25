/// Component that will prevent a gun from firing if the safety is turned on
/datum/component/gun_safety
	/// Is the safety actually on?
	var/safety_currently_on = TRUE
	/// Holder for the toggle safety action
	var/datum/action/item_action/toggle_safety/toggle_safety_action

/datum/component/gun_safety/Initialize(safety_currently_on)
	. = ..()

	// Obviously gun safety should only apply to guns
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE

	src.safety_currently_on = safety_currently_on
