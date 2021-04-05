#define COMBAT_NOTICE_COOLDOWN 10 SECONDS
GLOBAL_VAR_INIT(combat_indicator_overlay, GenerateCombatOverlay())
GLOBAL_VAR_INIT(combat_indicator_time, null)


/proc/GenerateCombatOverlay()
	var/mutable_appearance/combat_indicator = mutable_appearance('modular_skyrat/modules/combat_indicator/icons/combat_indicator.dmi', "combat", FLY_LAYER)
	combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return combat_indicator

/mob/living
	var/ci_forced = FALSE //if CI has been forced on us
	var/combat_indicator = FALSE
	var/nextcombatpopup = 0
	var/lastcombatindicator = 0

/mob/living/proc/combat_indicator_unconscious_signal()
	set_combat_indicator(FALSE)

/mob/living/proc/combat_indicator_check()
	. = FALSE
	if(!CONFIG_GET(flag/combat_indicator))
		return TRUE
	if(!client)
		return TRUE
	if(!ishuman(src))
		return TRUE
	if(ci_forced)
		return TRUE
	if(combat_indicator && (lastcombatindicator + GLOB.combat_indicator_time <= world.time))
		return TRUE

/mob/living/proc/set_combat_indicator(state, forced = FALSE) //if something forced CI on us, used to bypass the cooldown on being attacked

	if(combat_indicator == state) //let's save ourselfes the many config_get()s by checking this first
		return

	if(!CONFIG_GET(flag/combat_indicator))
		return

	if(stat == DEAD)
		combat_indicator = FALSE


	combat_indicator = state

	if(combat_indicator)
		if(world.time > nextcombatpopup)
			nextcombatpopup = world.time + COMBAT_NOTICE_COOLDOWN
			lastcombatindicator = world.time
			playsound(src, 'sound/machines/chime.ogg', 10, ignore_walls = FALSE)
			flick_emote_popup_on_mob("combat", 20)
			visible_message("<span class='boldwarning'>[src] gets ready for combat!</span>")
		add_overlay(GLOB.combat_indicator_overlay)
		combat_indicator = TRUE
		if(forced)
			ci_forced = TRUE
		src.log_message("<font color='red'>has turned ON the combat indicator!</font>", INDIVIDUAL_ATTACK_LOG)
		RegisterSignal(src, COMSIG_LIVING_STATUS_UNCONSCIOUS, .proc/combat_indicator_unconscious_signal)
	else
		cut_overlay(GLOB.combat_indicator_overlay)
		combat_indicator = FALSE
		ci_forced = FALSE
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

/datum/config_entry/number/combat_indicator_time
