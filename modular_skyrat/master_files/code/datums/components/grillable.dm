/datum/component/grillable
	/// What type of pollutant we spread around as we are grilleed, can be none
	var/pollutant_type

/datum/component/grillable/Initialize(cook_result, required_cook_time, positive_result, use_large_steam_sprite, list/added_reagents, pollutant_type)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	src.pollutant_type = pollutant_type
