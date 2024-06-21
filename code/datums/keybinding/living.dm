/datum/keybinding/living
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/living/can_use(client/user)
	return isliving(user.mob)

/datum/keybinding/living/resist
	hotkey_keys = list("B")
	name = "resist"
	full_name = "Resist"
	description = "Break free of your current state. Handcuffed? on fire? Resist!"
	keybind_signal = COMSIG_KB_LIVING_RESIST_DOWN

/datum/keybinding/living/resist/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/L = user.mob
	L.resist()
	return TRUE

/datum/keybinding/living/look_up
	// hotkey_keys = list("L") // ORIGINAL
	hotkey_keys = list("P") //SKYRAT EDIT CHANGE - CUSTOMIZATION
	name = "look up"
	full_name = "Look Up"
	description = "Look up at the next z-level.  Only works if directly below open space."
	keybind_signal = COMSIG_KB_LIVING_LOOKUP_DOWN

/datum/keybinding/living/look_up/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/L = user.mob
	L.look_up()
	return TRUE

/datum/keybinding/living/look_up/up(client/user)
	var/mob/living/L = user.mob
	L.end_look_up()
	return TRUE

/datum/keybinding/living/look_down
	// hotkey_keys = list(";") // ORIGINAL
	hotkey_keys = list("\[") //SKYRAT EDIT CHANGE - CUSTOMIZATION
	name = "look down"
	full_name = "Look Down"
	description = "Look down at the previous z-level.  Only works if directly above open space."
	keybind_signal = COMSIG_KB_LIVING_LOOKDOWN_DOWN

/datum/keybinding/living/look_down/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/L = user.mob
	L.look_down()
	return TRUE

/datum/keybinding/living/look_down/up(client/user)
	var/mob/living/L = user.mob
	L.end_look_down()
	return TRUE

/datum/keybinding/living/rest
	hotkey_keys = list("U")
	name = "rest"
	full_name = "Rest"
	description = "Lay down, or get up."
	keybind_signal = COMSIG_KB_LIVING_REST_DOWN

/datum/keybinding/living/rest/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_mob = user.mob
	living_mob.toggle_resting()
	return TRUE

/datum/keybinding/living/toggle_combat_mode
	hotkey_keys = list("F")
	name = "toggle_combat_mode"
	full_name = "Toggle Combat Mode"
	description = "Toggles combat mode. Like Help/Harm but cooler."
	keybind_signal = COMSIG_KB_LIVING_TOGGLE_COMBAT_DOWN


/datum/keybinding/living/toggle_combat_mode/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/user_mob = user.mob
	user_mob.set_combat_mode(!user_mob.combat_mode, FALSE)

/datum/keybinding/living/enable_combat_mode
	hotkey_keys = list("4")
	name = "enable_combat_mode"
	full_name = "Enable Combat Mode"
	description = "Enable combat mode."
	keybind_signal = COMSIG_KB_LIVING_ENABLE_COMBAT_DOWN

/datum/keybinding/living/enable_combat_mode/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/user_mob = user.mob
	user_mob.set_combat_mode(TRUE, silent = FALSE)

/datum/keybinding/living/disable_combat_mode
	hotkey_keys = list("1")
	name = "disable_combat_mode"
	full_name = "Disable Combat Mode"
	description = "Disable combat mode."
	keybind_signal = COMSIG_KB_LIVING_DISABLE_COMBAT_DOWN

/datum/keybinding/living/disable_combat_mode/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/user_mob = user.mob
	user_mob.set_combat_mode(FALSE, silent = FALSE)

/datum/keybinding/living/toggle_move_intent
	hotkey_keys = list("Alt") //SKYRAT EDIT CHANGE - C IS FOR COMBAT INDICATOR - ORIGINAL: hotkey_keys = list("C")
	name = "toggle_move_intent"
	full_name = "Hold to toggle move intent"
	description = "Held down to cycle to the other move intent, release to cycle back"
	keybind_signal = COMSIG_KB_LIVING_TOGGLEMOVEINTENT_DOWN

/datum/keybinding/living/toggle_move_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	M.toggle_move_intent()
	return TRUE

/datum/keybinding/living/toggle_move_intent/up(client/user)
	var/mob/living/M = user.mob
	M.toggle_move_intent()
	return TRUE

/datum/keybinding/living/toggle_move_intent_alternative
	hotkey_keys = list("Unbound")
	name = "toggle_move_intent_alt"
	full_name = "press to cycle move intent"
	description = "Pressing this cycle to the opposite move intent, does not cycle back"
	keybind_signal = COMSIG_KB_LIVING_TOGGLEMOVEINTENTALT_DOWN

/datum/keybinding/living/toggle_move_intent_alternative/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	M.toggle_move_intent()
	return TRUE
