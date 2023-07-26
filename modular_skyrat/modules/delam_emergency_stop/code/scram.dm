#define DELAM_MACHINE_POWER_CONSUMPTION 375
#define SM_PREVENT_EXPLOSION_THRESHOLD 100
#define SM_COOLING_MIXTURE_MOLES 64000
#define SM_COOLING_MIXTURE_TEMP 120
#define DAMAGED_SUPERMATTER_COLOR list(1,0.1,0.2,0, 0,0.9,0.1,0, 0.1,-0.05,0.85,0, 0,0,0,0.9, 0,0,0,0)
#define MISTAKES_WERE_MADE 0
#define MANUAL_INTERVENTION 0
#define AUTOMATIC_SAFETIES 1
#define BUTTON_PUSHED 0
#define BUTTON_IDLE 1
#define BUTTON_AWAKE 2
#define BUTTON_ARMED 3
#define SM_DAMAGED_EXPLOSION_POWER 41
#define SHATTER_DEVASTATION_RANGE 0
#define SHATTER_HEAVY_RANGE 0
#define SHATTER_LIGHT_RANGE 0
#define SHATTER_FLAME_RANGE 3
#define SHATTER_FLASH_RANGE 5
#define SHATTER_MIN_TIME 13 SECONDS
#define SHATTER_MAX_TIME 15 SECONDS
#define POWER_CUT_MIN_DURATION 19 SECONDS
#define POWER_CUT_MAX_DURATION 21 SECONDS
#define AIR_INJECT_RATE 33
#define BUTTON_SOUND_RANGE 7
#define BUTTON_SOUND_FALLOFF_DISTANCE 7
#define MACHINE_SOUND_RANGE 15
#define MACHINE_RUMBLE_SOUND_RANGE 30
#define MACHINE_SOUND_FALLOFF_DISTANCE 10

/// An atmos device that uses freezing cold air to attempt an emergency shutdown of the supermatter engine
/obj/machinery/atmospherics/components/unary/delam_scram
	icon = 'modular_skyrat/modules/delam_emergency_stop/icons/scram.dmi'
	icon_state = "dispenser-idle"
	name = "\improper delamination suppression system"
	desc = "The latest model in Nakamura Engineering's line of delamination suppression systems.<br>You don't want to be in the chamber when it's activated!<br>\
		Come to think of it, CentCom would rather you didn't activate it at all.<br>These things are expensive!"
	use_power = IDLE_POWER_USE
	can_unwrench = FALSE // comedy option, what if unwrenching trying to steal it throws you into the crystal for a nice dusting
	shift_underlay_only = FALSE
	hide = TRUE
	piping_layer = PIPING_LAYER_MAX
	pipe_state = "injector"
	resistance_flags = FIRE_PROOF | FREEZE_PROOF | UNACIDABLE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 4

	///Rate of operation of the device (L/s)
	var/volume_rate = AIR_INJECT_RATE
	///weakref to our SM
	var/datum/weakref/my_sm
	///Our internal radio
	var/obj/item/radio/radio
	///The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng
	///Radio channels, need null to actually broadcast on common, lol
	var/emergency_channel = null
	var/warning_channel = RADIO_CHANNEL_ENGINEERING
	///If someone -really- wants the SM to explode
	var/admin_disabled = FALSE


/obj/machinery/atmospherics/components/unary/delam_scram/Initialize(mapload)
	. = ..()

	return INITIALIZE_HINT_LATELOAD

/obj/machinery/atmospherics/components/unary/delam_scram/LateInitialize()
	. = ..()
	if(isnull(id_tag))
		id_tag = "SCRAM"

	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

	marry_sm()
	RegisterSignal(SSdcs, COMSIG_MAIN_SM_DELAMINATING, PROC_REF(panic_time))

/obj/machinery/atmospherics/components/unary/delam_scram/Destroy()
	QDEL_NULL(radio)
	my_sm = null
	return ..()

/// Sets the weakref to the SM
/obj/machinery/atmospherics/components/unary/delam_scram/proc/marry_sm()
	my_sm = WEAKREF(GLOB.main_supermatter_engine)

/obj/machinery/atmospherics/components/unary/delam_scram/update_icon_nopipes()
	return

/**
 * The atmos code is functionally identical to /obj/machinery/atmospherics/components/unary/outlet_injector
 * However this is a hardened all-in-one unit that can't have its controls
 * tampered with like an outlet injector
*/
/obj/machinery/atmospherics/components/unary/delam_scram/process_atmos()
	..()
	if(!on || !is_operational)
		return

	var/turf/location = get_turf(loc)

	if(isclosedturf(location))
		return

	var/datum/gas_mixture/air_contents = airs[1]

	if(air_contents.temperature > 0)
		var/transfer_moles = (air_contents.return_pressure() * volume_rate) / (air_contents.temperature * R_IDEAL_GAS_EQUATION)

		if(!transfer_moles)
			return

		var/datum/gas_mixture/removed = air_contents.remove(transfer_moles)

		location.assume_air(removed)
		update_parents()

/// Signal handler for the emergency stop button/automated system
/obj/machinery/atmospherics/components/unary/delam_scram/proc/panic_time(source, trigger_reason)
	SIGNAL_HANDLER

	if(!prereq_check())
		return

	send_warning(source, trigger_reason)

/// Check for admin intervention or a fault in the signal validation, we don't exactly want to fire this on accident
/obj/machinery/atmospherics/components/unary/delam_scram/proc/prereq_check(source, trigger_reason)
	if(on)
		return FALSE

	if(admin_disabled)
		investigate_log("Delam SCRAM tried to activate but an admin disabled it", INVESTIGATE_ATMOS)
		playsound(src, 'sound/misc/compiler-failure.ogg', 100, FALSE, MACHINE_SOUND_RANGE, ignore_walls = TRUE, use_reverb = TRUE, falloff_distance = MACHINE_SOUND_FALLOFF_DISTANCE)
		radio.talk_into(src, "System fault! Unable to trigger.", warning_channel)
		audible_message(span_danger("[src] makes a series of sad beeps. Someone has corrupted its software!"))
		return FALSE

	if(world.time - SSticker.round_start_time > 30 MINUTES && trigger_reason != DIVINE_INTERVENTION)
		playsound(src, 'sound/misc/compiler-failure.ogg', 100, FALSE, MACHINE_SOUND_RANGE, ignore_walls = TRUE, use_reverb = TRUE, falloff_distance = MACHINE_SOUND_FALLOFF_DISTANCE)
		audible_message(span_danger("[src] makes a series of sad beeps. The internal charge only lasts about 30 minutes... what a feat of engineering!"))
		investigate_log("Delam SCRAM signal was received but failed precondition check. (Round time or trigger reason)", INVESTIGATE_ATMOS)
		return FALSE

	return TRUE

/// Tells the station (they probably already know) and starts the procedure
/obj/machinery/atmospherics/components/unary/delam_scram/proc/send_warning(source, trigger_reason)
	if(trigger_reason == DIVINE_INTERVENTION)
		investigate_log("Delam SCRAM was activated by admin intervention", INVESTIGATE_ATMOS)
		notify_ghosts(
			"[src] has been activated!",
			source = src,
			header = "Divine Intervention",
			action = NOTIFY_ORBIT,
			ghost_sound = 'sound/machines/warning-buzzer.ogg',
			notify_volume = 75,
		)
	else
		var/reason
		switch(trigger_reason)
			if(AUTOMATIC_SAFETIES)
				reason = "automatic safeties"
			if(MANUAL_INTERVENTION)
				reason = "manual intervention"

		investigate_log("Delam SCRAM was activated by [reason]", INVESTIGATE_ATMOS)
		// They're probably already deadchat engineering discussing what you did wrong
		notify_ghosts(
			"[src] has been activated!",
			source = src,
			header = "Mistakes Were Made",
			action = NOTIFY_ORBIT,
			ghost_sound = 'sound/machines/warning-buzzer.ogg',
			notify_volume = 75,
		)

	radio.talk_into(src, "DELAMINATION SUPPRESSION SYSTEM FIRING IN 5 SECONDS. EVACUATE THE SUPERMATTER ENGINE ROOM!", emergency_channel)

	// fight power with power
	addtimer(CALLBACK(src, PROC_REF(put_on_a_show)), 5 SECONDS)
	INVOKE_ASYNC(SSnightshift, TYPE_PROC_REF(/datum/controller/subsystem/nightshift, suck_light_power))

/// Stop the delamination. Let the fireworks begin
/obj/machinery/atmospherics/components/unary/delam_scram/proc/put_on_a_show()
	var/obj/machinery/power/supermatter_crystal/engine/angry_sm = my_sm?.resolve()
	if(!angry_sm)
		return

	// Fire bell close, that nice 'are we gonna die?' rumble out far
	on = TRUE
	playsound(src, 'sound/machines/hypertorus/HFR_critical_explosion.ogg', 100, FALSE, MACHINE_RUMBLE_SOUND_RANGE, ignore_walls = TRUE, use_reverb = TRUE, falloff_distance = MACHINE_SOUND_FALLOFF_DISTANCE)
	alert_sound_to_playing('sound/misc/earth_rumble_distant3.ogg', override_volume = TRUE)
	update_appearance()

	// Good job at kneecapping the crystal, engineers
	// Make the crystal look cool (can escape a delam, but not puns)
	angry_sm.modify_filter(name = "ray", new_params = list(
		color = SUPERMATTER_TESLA_COLOUR,
	))
	angry_sm.color = DAMAGED_SUPERMATTER_COLOR
	angry_sm.set_light_color(SUPERMATTER_TESLA_COLOUR)
	angry_sm.update_appearance()

	// Don't vent the delam juice as it works its magic
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubby_boi in range(3, src))
		scrubby_boi.on = FALSE
		scrubby_boi.update_appearance()

	for(var/obj/machinery/atmospherics/components/unary/vent_pump/venti_boi in range(3, src))
		venti_boi.on = FALSE
		venti_boi.update_appearance()

	// The windows can only protect you for so long
	for(var/obj/structure/window/reinforced/plasma/fucked_window in range(3, src))
		addtimer(CALLBACK(fucked_window, TYPE_PROC_REF(/obj/structure/window/reinforced/plasma, shatter_window)), rand(SHATTER_MIN_TIME, SHATTER_MAX_TIME))

	// Let the gas work for a few seconds to cool the crystal. If it has damage beyond repair, heal it a bit
	addtimer(CALLBACK(src, PROC_REF(prevent_explosion)), 9 SECONDS)

	// Restore the power that we were 'channelling' to the SM
	addtimer(CALLBACK(SSnightshift, TYPE_PROC_REF(/datum/controller/subsystem/nightshift, restore_light_power)), rand(POWER_CUT_MIN_DURATION, POWER_CUT_MAX_DURATION))

/// Shatter the supermatter chamber windows
/obj/structure/window/reinforced/plasma/proc/shatter_window()
	visible_message(span_danger("[src] shatters in the freon fire!"))
	explosion(src, SHATTER_DEVASTATION_RANGE, SHATTER_HEAVY_RANGE, SHATTER_LIGHT_RANGE, SHATTER_FLAME_RANGE, SHATTER_FLASH_RANGE)
	qdel(src)

/// The valiant little machine falls apart, one time use only!
/obj/machinery/atmospherics/components/unary/delam_scram/proc/goodbye_friends()

	// good job buddy, sacrificing yourself for the greater good
	playsound(src, 'sound/misc/compiler-failure.ogg', 100, FALSE, MACHINE_SOUND_RANGE, ignore_walls = TRUE, use_reverb = TRUE, falloff_distance = MACHINE_SOUND_FALLOFF_DISTANCE)
	visible_message(span_danger("[src] beeps a sorrowful melody and collapses into a pile of twisted metal and foam!"), blind_message = span_danger("[src] beeps a sorrowful melody!"))
	deconstruct(FALSE)

/// Drain the internal energy, if the crystal damage is above 100 we heal it a bit. Not much, but should be good to let them recover.
/obj/machinery/atmospherics/components/unary/delam_scram/proc/prevent_explosion()
	var/obj/machinery/power/supermatter_crystal/engine/damaged_sm = my_sm?.resolve()
	if(!damaged_sm)
		return

	damaged_sm.name = "partially delaminated supermatter crystal"
	damaged_sm.desc = "This crystal has seen better days, the glow seems off and the shards look brittle. Central says it's still \"relatively safe.\" They'd never lie to us, right?"
	damaged_sm.explosion_power = SM_DAMAGED_EXPLOSION_POWER // if you fuck up again, yeesh

	if(damaged_sm.damage > SM_PREVENT_EXPLOSION_THRESHOLD)
		damaged_sm.damage = SM_PREVENT_EXPLOSION_THRESHOLD

	damaged_sm.internal_energy = MISTAKES_WERE_MADE
	for(var/obj/machinery/power/energy_accumulator/tesla_coil/zappy_boi in range(3, src))
		zappy_boi.stored_energy = MISTAKES_WERE_MADE

/obj/machinery/atmospherics/components/unary/delam_scram/New()
	. = ..()
	var/datum/gas_mixture/delam_juice = new
	delam_juice.add_gases(/datum/gas/freon)
	delam_juice.gases[/datum/gas/freon][MOLES] = SM_COOLING_MIXTURE_MOLES
	delam_juice.temperature = SM_COOLING_MIXTURE_TEMP
	airs[1] = delam_juice

/// Dims the lights and consumes a bit of APC power, summoning that electricity to stop the delam... somehow
/datum/controller/subsystem/nightshift/proc/suck_light_power()
	SSnightshift.can_fire = FALSE
	for(var/obj/machinery/power/apc/light_to_suck as anything in SSmachines.get_machines_by_type(/obj/machinery/power/apc))
		light_to_suck.cell.charge -= DELAM_MACHINE_POWER_CONSUMPTION
		light_to_suck.lighting = APC_CHANNEL_OFF
		light_to_suck.nightshift_lights = TRUE
		light_to_suck.update_appearance()
		light_to_suck.update()

/// Restores the lighting after the delam suppression
/datum/controller/subsystem/nightshift/proc/restore_light_power()
	SSnightshift.can_fire = TRUE
	for(var/obj/machinery/power/apc/light_to_restore as anything in SSmachines.get_machines_by_type(/obj/machinery/power/apc))
		light_to_restore.lighting = APC_CHANNEL_AUTO_ON
		light_to_restore.update_appearance()
		light_to_restore.update()

/// A big red button you can smash to stop the supermatter engine, oh how tempting!
/obj/machinery/button/delam_scram
	name = "\improper supermatter emergency stop button"
	desc = "Your last hope to try and save the crystal during a delamination.<br>\
		While it is indeed a big red button, pressing it outside of an emergency \
		will probably get the engineering department out for your blood."
	icon = 'modular_skyrat/modules/delam_emergency_stop/icons/scram.dmi'
	can_alter_skin = FALSE
	silicon_access_disabled = TRUE
	resistance_flags = FREEZE_PROOF | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	light_color = LIGHT_COLOR_INTENSE_RED
	light_power = 0.7
	///one use only!
	var/button_stage = BUTTON_IDLE
	///our internal radio
	var/obj/item/radio/radio
	///radio key
	var/radio_key = /obj/item/encryptionkey/headset_eng
	COOLDOWN_DECLARE(scram_button)

/obj/machinery/button/delam_scram/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/button/delam_scram/Destroy()
	QDEL_NULL(radio)
	return ..()

/obj/machinery/button/delam_scram/screwdriver_act(mob/living/user, obj/item/tool)
	return TRUE

/obj/machinery/button/delam_scram/emag_act(mob/user)
	return

/// Proc for arming the red button, it hasn't been pushed yet
/obj/machinery/button/delam_scram/attack_hand(mob/user, list/modifiers)
	. = ..()

	if((machine_stat & BROKEN))
		return

	if(!COOLDOWN_FINISHED(src, scram_button))
		balloon_alert(user, "on cooldown!")
		return

	if(!validate_suppression_status())
		playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, FALSE, BUTTON_SOUND_RANGE, falloff_distance = BUTTON_SOUND_FALLOFF_DISTANCE)
		audible_message(span_danger("[src] makes a sad buzz and goes dark. Did someone activate it already?")) // Look through the window, buddy
		burn_out()
		return

	if(.)
		return

	// Give them a cheeky instructions card. But only one! If you lost it, question your engineering prowess in this moment
	if(button_stage == BUTTON_IDLE)
		visible_message(span_danger("A biscuit card falls out of [src]!"))
		user.put_in_hands(new /obj/item/folder/biscuit/confidential/delam(get_turf(user)))
		button_stage = BUTTON_AWAKE
		return

	if(button_stage != BUTTON_AWAKE)
		return

	COOLDOWN_START(src, scram_button, 15 SECONDS)

	// For roundstart only, after that it's on you!
	if(world.time - SSticker.round_start_time > 30 MINUTES)
		playsound(src.loc, 'sound/misc/compiler-failure.ogg', 50, FALSE, BUTTON_SOUND_RANGE, falloff_distance = BUTTON_SOUND_FALLOFF_DISTANCE)
		audible_message(span_danger("[src] makes a series of sad beeps. The internal charge only lasts about 30 minutes... what a feat of engineering! Looks like it's all on you to save the day."))
		burn_out()
		return

	// You thought you could sneak this one by your coworkers?
	button_stage = BUTTON_ARMED
	update_appearance()
	radio.talk_into(src, "SUPERMATTER EMERGENCY STOP BUTTON ARMED!", RADIO_CHANNEL_ENGINEERING)
	visible_message(span_danger("[user] swings open the plastic cover on [src]!"))

	// Let the admins know someone's fucked up
	message_admins("[ADMIN_LOOKUPFLW(user)] just uncovered [src].")
	investigate_log("[key_name(user)] uncovered [src].", INVESTIGATE_ATMOS)

	confirm_action(user)

/// Confirms with the user that they really want to push the red button. Do it, you won't!
/obj/machinery/button/delam_scram/proc/confirm_action(mob/user, list/modifiers)
	if(tgui_alert(usr, "Are you really sure that you want to push this?", "It looked scarier on HBO.", list("No", "Yes")) != "Yes")
		button_stage = BUTTON_AWAKE
		visible_message(span_danger("[user] slowly closes the plastic cover on [src]!"))
		update_appearance()
		return

	// Make scary sound and flashing light
	playsound(src, 'sound/machines/high_tech_confirm.ogg', 50, FALSE, BUTTON_SOUND_RANGE, ignore_walls = TRUE, use_reverb = TRUE, falloff_distance = BUTTON_SOUND_FALLOFF_DISTANCE)
	button_stage = BUTTON_PUSHED
	visible_message(span_danger("[user] smashes [src] with their hand!"))
	message_admins("[ADMIN_LOOKUPFLW(user)] pushed [src]!")
	investigate_log("[key_name(user)] pushed [src]!", INVESTIGATE_ATMOS)
	flick_overlay_view("[base_icon_state]-overlay-active", 20 SECONDS)

	// No going back now!
	SEND_GLOBAL_SIGNAL(COMSIG_MAIN_SM_DELAMINATING, MANUAL_INTERVENTION)

	// Temporarily let anyone escape the engine room before it becomes spicy
	for(var/obj/machinery/door/airlock/escape_route in range(7, src))
		if(istype(escape_route, /obj/machinery/door/airlock/command))
			continue

		INVOKE_ASYNC(escape_route, TYPE_PROC_REF(/obj/machinery/door/airlock, temp_emergency_exit), 45 SECONDS)

/// When the button is pushed but it's too late to save you!
/obj/machinery/button/delam_scram/proc/burn_out()
	if(!(machine_stat & BROKEN))
		src.desc += span_warning("The light is off, indicating it is not currently functional.")
		set_machine_stat(machine_stat | BROKEN)
		update_appearance()

/obj/machinery/button/delam_scram/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][skin]"
	if(button_stage == BUTTON_ARMED)
		icon_state += "-armed"
	else if(button_stage == BUTTON_PUSHED)
		icon_state += "-armed"
	else if(machine_stat & (NOPOWER|BROKEN))
		icon_state += "-nopower"

/obj/machinery/power/emitter/LateInitialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_MAIN_SM_DELAMINATING, PROC_REF(emergency_stop))

/obj/machinery/power/emitter/proc/emergency_stop()
	SIGNAL_HANDLER

	var/area/my_area = get_area(src)
	if(!istype(my_area, /area/station/engineering))
		return

	active = FALSE
	update_appearance()

/obj/item/folder/biscuit/confidential/delam
	name = "NT-approved delam emergency procedure"
	contained_slip = /obj/item/paper/paperslip/corporate/fluff/delam_procedure
	layer = SIGN_LAYER

/obj/item/paper/paperslip/corporate/fluff/delam_procedure/Initialize(mapload)
	name = "delam emergency procedure"
	desc = "Now you're a REAL engineer!"
	default_raw_text = "<b>EMERGENCY PROCEDURE: SUPERMATTER DELAMINATION</b><br><br>\
		<b>So you've found yourself in a bit of a pickle with a delamination of a supermatter reactor.<br>Don't worry, saving the day is just a few steps away!</b><br><br>\
		- Locate the ever-elusive red emergency stop button. It's probably hiding in plain sight, so take your time, have a laugh, and enjoy the anticipation. Remember, it's like a treasure hunt, only with the added bonus of preventing a nuclear disaster.<br><br>\
		- Once you've uncovered the button, muster all your courage and push it like there's no tomorrow. Well, actually, you're pushing it to ensure there is a tomorrow. But hey, who doesn't love a little paradoxical button-pushing?<br><br>\
		- Prepare for the impending suppression of the supermatter engine room, because things are about to get real quiet. Just make sure everyone has evacuated, or else they'll be in for a surprise. The system needs its space, and it's not known for being the friendliest neighbour.<br><br>\
		- After the delamination is successfully suppressed, take a moment to appreciate the delicate beauty of crystal-based electricity. Take a look around and fix any damage to those fragile glass components. Feel free to put on your finest overalls and channel your inner engiborg while doing so.<br><br>\
		- Keep an eye out for fires and the infamous air mix. It's always an adventure trying to strike the perfect balance between breathable air and potential suffocation. Remember, oxygen plus a spark equals fireworks – the kind you definitely don't want inside a reactor.<br><br>\
		- To avoid singeing your eyebrows off, consider enlisting the help of a synth or a trusty borg. After all, nothing says \"safety first\" like outsourcing your firefighting to non-living, non-breathing assistants.<br><br>\
		- Clear out any lightly radioactive debris (The cargo department will probably love to dispose it for you.)<br><br>\
		- Finally, revel in the satisfaction of knowing that you've single-handedly prevented a delamination. But, of course, don't forget to feel guilty because SAFETY MOTH Knows. SAFETY MOTH knows everything. It's always watching, judging, and probably taking notes for its next safety briefing. So bask in the glory of your heroism, but know that the all-knowing Moff is onto you.<br><br>\
		<b>(Optional step, for the true daredevils out there)</b><br><br>\
		- When it comes time for your second attempt at starting the SM: Fold these instructions into a paper plane, give it a good toss towards the crystal, and watch it soar through the air. Because nothing says \"I'm dealing with a potentially catastrophic situation\" like engaging in some whimsical paper airplane shenanigans.<br><br>\
		<b>Hopefully you'll never need to use this. However, good luck!</b>"
	return ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/atmospherics/components/unary/delam_scram, 0)

#undef DELAM_MACHINE_POWER_CONSUMPTION
#undef DAMAGED_SUPERMATTER_COLOR
#undef SM_PREVENT_EXPLOSION_THRESHOLD
#undef SM_COOLING_MIXTURE_MOLES
#undef SM_COOLING_MIXTURE_TEMP
#undef MISTAKES_WERE_MADE
#undef MANUAL_INTERVENTION
#undef AUTOMATIC_SAFETIES
#undef BUTTON_PUSHED
#undef BUTTON_IDLE
#undef BUTTON_AWAKE
#undef BUTTON_ARMED
#undef SM_DAMAGED_EXPLOSION_POWER
#undef SHATTER_DEVASTATION_RANGE
#undef SHATTER_HEAVY_RANGE
#undef SHATTER_LIGHT_RANGE
#undef SHATTER_FLAME_RANGE
#undef SHATTER_FLASH_RANGE
#undef SHATTER_MIN_TIME
#undef SHATTER_MAX_TIME
#undef POWER_CUT_MIN_DURATION
#undef POWER_CUT_MAX_DURATION
#undef AIR_INJECT_RATE
#undef BUTTON_SOUND_RANGE
#undef BUTTON_SOUND_FALLOFF_DISTANCE
#undef MACHINE_SOUND_RANGE
#undef MACHINE_RUMBLE_SOUND_RANGE
#undef MACHINE_SOUND_FALLOFF_DISTANCE
