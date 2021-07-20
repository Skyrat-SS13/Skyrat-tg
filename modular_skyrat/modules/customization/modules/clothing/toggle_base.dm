var/toggle_name


/datum/component/toggle_clothes
	var/toggled = FALSE
	var/toggled_icon_state

/datum/component/toggle_clothes/Initialize(toggled_icon_state)
	if(!isclothing(parent))
		return COMPONENT_INCOMPATIBLE

	if(!toggled_icon_state)
		return COMPONENT_INCOMPATIBLE

	src.toggled_icon_state = toggled_icon_state

	RegisterSignal(parent, COMSIG_CLICK_ALT, proc/toggle_clothes)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, proc/on_examine)

/datum/component/toggle_clothes/proc/toggle_clothes(objitem/clothing/source, mob/living/clicker)
	SIGNAL_HANDLER

  toggled = !toggled
  source.icon_state = (toggled ? toggled_icon_state : initial(source.icon_state))

/datum/element/toggle_clothes/proc/on_examine(objitem/clothing/source, mob/living/clicker)
	SIGNAL_HANDLER

	examine_list += span_boldnotice("This item is toggleable!")
	examine_list += span_notice("Alt click to toggle!.")
