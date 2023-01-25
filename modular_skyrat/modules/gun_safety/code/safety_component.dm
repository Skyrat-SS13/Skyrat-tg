/// Component that will prevent a gun from firing if the safety is turned on
/datum/component/gun_safety
	/// Is the safety actually on?
	var/safety_currently_on = TRUE
	/// Holder for the toggle safety action
	var/datum/action/item_action/gun_safety_toggle/toggle_safety_action

/datum/component/gun_safety/Initialize(safety_currently_on)
	. = ..()

	// Obviously gun safety should only apply to guns
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE

	src.safety_currently_on = safety_currently_on

	toggle_safety_action = new(src)

	var/obj/item/gun/parent_gun = parent
	parent_gun.add_item_action(toggle_safety_action)

/datum/component/gun_safety/Destroy()
	if(toggle_safety_action)
		QDEL_NULL(toggle_safety_action)
	return ..()

/datum/component/gun_safety/RegisterWithParent()
	RegisterSignal(parent, COMSIG_GUN_TRY_FIRE, PROC_REF(check_if_we_can_actually_shooty))
	RegisterSignal(parent, COMSIG_ITEM_UI_ACTION_CLICK, PROC_REF(we_may_be_toggling_safeties))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/component/gun_safety/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_GUN_TRY_FIRE,
		COMSIG_ITEM_UI_ACTION_CLICK,
		COMSIG_PARENT_EXAMINE,
	))

/// Checks if the safety is currently on, if it is then stops the gun from firing
/datum/component/gun_safety/proc/check_if_we_can_actually_shooty(obj/item/gun/source, mob/living/user, atom/target, flag, params)
	SIGNAL_HANDLER

	if(safety_currently_on)
		user.balloon_alert(user, "safety on!")
		return COMPONENT_CANCEL_GUN_FIRE

/// Calls toggle_safeties if the action type for doing so is used
/datum/component/gun_safety/proc/we_may_be_toggling_safeties(source, user, actiontype)
	SIGNAL_HANDLER

	if(istype(actiontype, toggle_safety_action))
		toggle_safeties(user)

/// Toggles the safeties on or off
/datum/component/gun_safety/proc/toggle_safeties(mob/user)
	safety_currently_on = !safety_currently_on

	toggle_safety_action.button_icon_state = "safety_[safety_currently_on ? "on" : "off"]"
	toggle_safety_action.build_all_button_icons()

	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	user.visible_message(
		span_notice("[user] toggles [src]'s safety [safety_currently_on ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"]."),
		span_notice("You toggle [src]'s safety [safety_currently_on ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].")
	)

// The actual action, used by the component
/datum/action/item_action/gun_safety_toggle
	name = "Toggle Gun Safety"
	button_icon = 'modular_skyrat/modules/gun_safety/icons/actions.dmi'
	button_icon_state = "safety_on"
