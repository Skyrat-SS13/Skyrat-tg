/datum/extension/base_icon_state
	expected_type = /atom
	base_type = /datum/extension/base_icon_state
	var/base_icon_state

/datum/extension/base_icon_state/New(var/holder, var/base_icon_state)
	..()
	src.base_icon_state = base_icon_state
