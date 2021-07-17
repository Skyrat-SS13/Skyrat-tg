/**
 * The basetype for subsets of clothing that can have two different distinct states.
 * The active state can also have a list of actions to give to the user.
 */
/obj/item/clothing/toggle
	/// Stores whether we are currently toggled or not
	var/toggle_active = FALSE
	/// The icon_state to swap to when we toggle
	var/toggle_icon_state
	/// The name of what actually toggles
	var/toggle_name
	/// List of action buttons to give when we are toggled active
	var/list/datum/action/toggle_actions

/obj/item/clothing/toggle/examine(mob/user)
	. = ..()
	. += span_notice("<u>Alt Click</u> to toggle [src]\s [ toggle_name ] [ toggle_active ? "off" : "on" ]")

/obj/item/clothing/toggle/AltClick(mob/user)
	toggle_active = !toggle_active
	on_toggle(user, toggle_active)
	update_appearance()

/obj/item/clothing/toggle/Initialize()
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
	InitializeActions()

/obj/item/clothing/toggle/Destroy()
	toggle_active = FALSE
	if(ismob(loc))
		update_actions(loc)
	QDEL_LIST(toggle_actions)
	toggle_actions = null
	return ..()

/// Here is where you should be creating the actions you want given to the user on toggle/equip
/obj/item/clothing/toggle/proc/InitializeActions()
	return

/obj/item/clothing/toggle/update_icon_state()
	. = ..()
	icon_state = toggle_active ? toggle_icon_state : initial(icon_state)

/obj/item/clothing/toggle/proc/update_actions(mob/user)
	for(var/datum/action/action as anything in toggle_actions)
		if(toggle_active)
			user.actions |= action
		else
			user.actions -= action
	user.update_action_buttons(TRUE)

/obj/item/clothing/toggle/proc/on_toggle(mob/user, toggle_state, silent=FALSE)
	SHOULD_CALL_PARENT(TRUE)
	if(!silent)
		to_chat(user, span_notice("You toggle [src]\s [ toggle_name ] [ toggle_state ? "active" : "inactive" ]."))
	update_actions(user)

/obj/item/clothing/toggle/equipped(mob/user, slot)
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
	update_actions(user)

/obj/item/clothing/toggle/dropped(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	toggle_active = FALSE
	update_actions(user)
	return ..()
