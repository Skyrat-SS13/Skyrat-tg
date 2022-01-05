#define COMBAT_NOTICE_COOLDOWN 10 SECONDS
GLOBAL_VAR_INIT(combat_indicator_overlay, GenerateCombatOverlay())

/proc/GenerateCombatOverlay()
	var/mutable_appearance/combat_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/combat_indicator.dmi', "combat", FLY_LAYER)
	combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return combat_indicator

/mob/living
	var/combat_indicator = FALSE
	var/nextcombatpopup = 0

/// This proc is tied to the COMSIG_MOB_CI_TOGGLED signal and is assigned to the vehicle whenever a mob enters a vehicle/sealed object. If that mob toggles CI, this signal is fired.
/obj/vehicle/sealed/proc/mob_toggled_ci(mob/living/source)
	SIGNAL_HANDLER
	if ((src.max_occupants > src.max_drivers) && (!(source in return_drivers())) && (src.driver_amount() > 0)) // Only returms true if the mob in question has the driver control flags and/or there are drivers.
		return
	combat_indicator_vehicle = source.combat_indicator	// Sync CI between mob and vehicle.
	if (combat_indicator_vehicle)
		if(world.time > vehicle_next_combat_popup) // As of the time of writing, COMBAT_NOTICE_COOLDOWN is 10 secs, so this is asking "has 10 secs past between last activation of CI?"
			vehicle_next_combat_popup = world.time + COMBAT_NOTICE_COOLDOWN
			playsound(src, 'sound/machines/chime.ogg', 10, TRUE)
			flick_emote_popup_on_obj("combat", 20)
			visible_message(span_boldwarning("[src] prepares for combat!"))
		combat_indicator_vehicle = TRUE
	else
		combat_indicator_vehicle = FALSE
	update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

/mob/living/update_overlays()
	. = ..()
	if(combat_indicator)
		. += GLOB.combat_indicator_overlay

/obj/vehicle/sealed/update_overlays()
	. = ..()
	if(combat_indicator_vehicle)
		. += GLOB.combat_indicator_overlay

/mob/living/proc/combat_indicator_unconscious_signal()
	SIGNAL_HANDLER
	if(stat < UNCONSCIOUS) // sanity check because something is calling this signal improperly
		stack_trace("Improper COMSIG_LIVING_STATUS_UNCONSCIOUS sent; mob is not unconscious")
		return
	set_combat_indicator(FALSE)

/// Handles the logic behind setting the combat indicator status.
/mob/living/proc/set_combat_indicator(state)
	if(!CONFIG_GET(flag/combat_indicator))
		return

	if(stat == DEAD)
		combat_indicator = FALSE

	if(combat_indicator == state) // If the mob is dead (should not happen) or if the combat_indicator is the same as state (also shouldnt happen) kill the proc.
		return

	combat_indicator = state

	SEND_SIGNAL(src, COMSIG_MOB_CI_TOGGLED)

	if(combat_indicator)
		if(world.time > nextcombatpopup) // As of the time of writing, COMBAT_NOTICE_COOLDOWN is 10 secs, so this is asking "has 10 secs past between last activation of CI?"
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
		combat_indicator = TRUE
		apply_status_effect(STATUS_EFFECT_SURRENDER, src)
		log_message("<font color='red'>has turned ON the combat indicator!</font>", LOG_ATTACK)
		RegisterSignal(src, COMSIG_LIVING_STATUS_UNCONSCIOUS, .proc/combat_indicator_unconscious_signal) //From now on, whenever this mob falls unconcious, the referenced proc will fire.
	else
		combat_indicator = FALSE
		remove_status_effect(STATUS_EFFECT_SURRENDER, src)
		log_message("<font color='blue'>has turned OFF the combat indicator!</font>", LOG_ATTACK)
		UnregisterSignal(src, COMSIG_LIVING_STATUS_UNCONSCIOUS) //combat_indicator_unconcious_signal will no longer be fired if this mob is unconcious.
	update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

/mob/living/proc/user_toggle_combat_indicator()
	if(stat != CONSCIOUS)
		return
	set_combat_indicator(!combat_indicator) // Set CI status to whatever is the opposite of the current status.

/// This proc is called whenever a mob enters a vehicle/sealed object.
/obj/vehicle/sealed/proc/handle_ci_migration(mob/living/user)
	if(!typesof(user.loc, /obj/vehicle/sealed)) //Sanity check: If the mob's location (not the tile they are on) is NOT a type of vehicle/sealed, kill the proc.
		return
	//If the vehicle can have more passenger seats than driver seats (note: each driver seat counts as a passenger seat) AND both: The mob is not a driver, and the vehicle has a driver, return.
	if ((src.max_occupants > src.max_drivers) && ((!(user in return_drivers())) && (src.driver_amount() > 0)))
		return
	if (user.combat_indicator && !combat_indicator_vehicle) // Finally, if all conditions prior are not met, and the mob has CI enabled and the vehicle doesn't, enable CI.
		combat_indicator_vehicle = TRUE
		update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

/// This proc is called whenever a mob exits a vehicle/sealed obj.
/obj/vehicle/sealed/proc/disable_ci(mob/living/user)
	// If the vehicle can have more occupants than drivers, and either 1. The mob is not a driver and the vehicle has drivers, or 2. The user IS a driver but there is an occupant (drivers count as occupants), return.
	if ((src.max_occupants > src.max_drivers) && ((!(user in return_drivers()) && (src.driver_amount() > 0)) || ((user in return_drivers()) && (src.occupant_amount() > 0))))
		return
	// If the preceding conditions are not met, and the vehicle has CI, look at each occupant to see if there is a non-driver with CI enabled. If yes, stop the proc, if no, disable CI.
	if (combat_indicator_vehicle)
		var/has_occupant_with_ci = FALSE
		if (src.occupant_amount() > src.driver_amount())
			for (var/mob/living/vehicle_occupant in return_occupants())
				if (vehicle_occupant in return_drivers()) //this for loop does not account for multiple clowns in clown cars. i will not account for that. fuck that.
					continue
				if (vehicle_occupant.combat_indicator)
					has_occupant_with_ci = TRUE
					break
		if (!has_occupant_with_ci)
			combat_indicator_vehicle = FALSE
			update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

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
