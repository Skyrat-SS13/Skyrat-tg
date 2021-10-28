#define COMBAT_NOTICE_COOLDOWN 10 SECONDS
GLOBAL_VAR_INIT(combat_indicator_overlay, GenerateCombatOverlay())

/proc/GenerateCombatOverlay()
	var/mutable_appearance/combat_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/combat_indicator.dmi', "combat", FLY_LAYER)
	combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return combat_indicator

/mob/living
	var/combat_indicator = FALSE
	var/nextcombatpopup = 0

/mob/living/proc/combat_indicator_unconscious_signal()
	SIGNAL_HANDLER
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
			var/ciweapon
			if(get_active_held_item())
				ciweapon = get_active_held_item()
				if(istype(ciweapon, /obj/item/gun))
					visible_message(span_boldwarning("[src] raises \the [ciweapon] with their finger on the trigger, ready for combat!"))
				else
					visible_message(span_boldwarning("[src] readies \the [ciweapon] with a tightened grip and offensive stance, ready for combat!"))
			else
				if(issilicon(src))
					visible_message(span_boldwarning("<b>[src] shifts its armour plating into a defensive stance, ready for combat!"))
				if(ishuman(src))
					visible_message(span_boldwarning("[src] raises [p_their()] fists in an offensive stance, ready for combat!"))
				if(isalien(src))
					visible_message(span_boldwarning("[src] hisses in a terrifying stance, claws raised and ready for combat!"))
				else
					visible_message(span_boldwarning("[src] gets ready for combat!"))
		add_overlay(GLOB.combat_indicator_overlay)
		combat_indicator = TRUE
		src.apply_status_effect(STATUS_EFFECT_SURRENDER, src)
		src.log_message("<font color='red'>has turned ON the combat indicator!</font>", LOG_ATTACK)
		RegisterSignal(src, COMSIG_LIVING_STATUS_UNCONSCIOUS, .proc/combat_indicator_unconscious_signal)
	else
		cut_overlay(GLOB.combat_indicator_overlay)
		combat_indicator = FALSE
		src.remove_status_effect(STATUS_EFFECT_SURRENDER, src)
		src.log_message("<font color='blue'>has turned OFF the combat indicator!</font>", LOG_ATTACK)
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

// Surrender shit
/atom/movable/screen/alert/status_effect/surrender/
	desc = "You're either in combat or being held up. Click here to surrender and show that you don't wish to fight. You will be incapacitated. (You can also say '*surrender' at any time to do this.)"

/datum/emote/living/surrender
	message = "drops to the floor and raises their hands defensively! They surrender%s!"

/datum/emote/living/surrender/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/living_user = user
		living_user.Paralyze(200)
		living_user.remove_status_effect(STATUS_EFFECT_SURRENDER, src)
		living_user.set_combat_indicator(FALSE)
