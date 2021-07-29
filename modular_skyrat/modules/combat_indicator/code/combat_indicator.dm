#define COMBAT_NOTICE_COOLDOWN 10 SECONDS
GLOBAL_VAR_INIT(combat_indicator_overlay, GenerateCombatOverlay())

/proc/GenerateCombatOverlay()
	var/mutable_appearance/combat_indicator = mutable_appearance('modular_skyrat/modules/combat_indicator/icons/combat_indicator.dmi', "combat", FLY_LAYER)
	combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return combat_indicator

/mob/living
	var/combat_indicator = FALSE
	var/nextcombatpopup = 0

/mob/living/proc/combat_indicator_unconscious_signal()
	set_combat_indicator(FALSE)

/mob/living/proc/set_combat_indicator(state)
	if(!CONFIG_GET(flag/combat_indicator))
		return

	if(stat == DEAD)
		combat_indicator = FALSE

	if(combat_indicator == state)
		return

	combat_indicator = state

	if(combat_indicator)
		if(world.time > nextcombatpopup)
			nextcombatpopup = world.time + COMBAT_NOTICE_COOLDOWN
			playsound(src, 'sound/machines/chime.ogg', 10, ignore_walls = FALSE)
			flick_emote_popup_on_mob("combat", 20)
			visible_message("<span class='boldwarning'>[src] gets ready for combat!</span>")
		add_overlay(GLOB.combat_indicator_overlay)
		combat_indicator = TRUE
		src.log_message("<font color='red'>has turned ON the combat indicator!</font>", INDIVIDUAL_ATTACK_LOG)
		RegisterSignal(src, COMSIG_LIVING_STATUS_UNCONSCIOUS, .proc/combat_indicator_unconscious_signal)
	else
		cut_overlay(GLOB.combat_indicator_overlay)
		combat_indicator = FALSE
		src.log_message("<font color='blue'>has turned OFF the combat indicator!</font>", INDIVIDUAL_ATTACK_LOG)
		UnregisterSignal(src, COMSIG_LIVING_STATUS_UNCONSCIOUS)

/mob/living/proc/user_toggle_combat_indicator()
	if(stat != CONSCIOUS)
		return
	set_combat_indicator(!combat_indicator)

#undef COMBAT_NOTICE_COOLDOWN

/datum/keybinding/living/combat_indicator
	hotkey_keys = list("C")
	name = "combat_indicator"
	full_name = "Combat Indicator"
	description = "Indicates that you're escalating to mechanics. YOU NEED TO USE THIS"
	keybind_signal = COMSIG_KB_LIVING_COMBAT_INDICATOR

/datum/keybinding/living/combat_indicator/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/L = user.mob
	L.user_toggle_combat_indicator()

/datum/config_entry/flag/combat_indicator
