/obj/machinery/atmospherics/components/unary/delam_scram
	icon = 'modular_skyrat/modules/delam_emergency_stop/icons/scram.dmi'
	icon_state = "dispenser-idle"
	name = "delamination suppression system"
	desc = "The latest model in Nakamura Engineering's line of delamination suppression systems. You don't want to be in the chamber when it's activated! \
	Come to think of it, CentCom would rather you didn't activate it at all. These things are expensive!"
	use_power = IDLE_POWER_USE
	can_unwrench = FALSE // comedy option, what if unwrenching trying to steal it throws you into the crystal for a nice dusting
	shift_underlay_only = FALSE
	hide = TRUE
	piping_layer = PIPING_LAYER_MAX
	pipe_state = "injector"
	resistance_flags = FIRE_PROOF | FREEZE_PROOF | UNACIDABLE

	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 4
	///Rate of operation of the device
	var/volume_rate = 33
	///weakref to our SM
	var/datum/weakref/my_sm
	///Our internal radio
	var/obj/item/radio/radio
	///The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng
	///radio channels, need null to actually broadcast on common, lol.
	var/emergency_channel = null
	var/warning_channel = RADIO_CHANNEL_ENGINEERING

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
	return ..()

/obj/machinery/atmospherics/components/unary/delam_scram/proc/marry_sm()
	my_sm = WEAKREF(GLOB.main_supermatter_engine)

/obj/machinery/atmospherics/components/unary/delam_scram/update_icon_nopipes()
	return

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

/obj/machinery/atmospherics/components/unary/delam_scram/proc/panic_time(source, trigger_reason)
	SIGNAL_HANDLER

	if(on)
		return

	if(world.time - SSticker.round_start_time > 30 MINUTES && trigger_reason != DIVINE_INTERVENTION)
		playsound(src, 'sound/misc/compiler-failure.ogg', 100, FALSE, 20, ignore_walls = TRUE, use_reverb = TRUE)
		audible_message(span_danger("The [src] makes a series of sad beeps. The internal charge only lasts about 30 minutes... what a feat of engineering!"))
		stack_trace("Delam SCRAM was triggered with an invalid time or trigger reason!")
		return

	if(trigger_reason == DIVINE_INTERVENTION)
		investigate_log("Delam SCRAM was activated by admin intervention", INVESTIGATE_ATMOS)
	else
		investigate_log("Delam SCRAM was activated by [trigger_reason ? "automatic safeties" : "manual intervention"]", INVESTIGATE_ATMOS)
	radio.talk_into(src, "DELAMINATION SUPPRESSION SYSTEM FIRING IN 5 SECONDS. EVACUATE SUPERMATTER ENGINE ROOM!", emergency_channel)
	SSpersistence.delam_highscore = SSpersistence.rounds_since_engine_exploded // yeah that's right Skyrat, no more cheating the counter by deleting the SM
	SSpersistence.rounds_since_engine_exploded = MISTAKES_WERE_MADE
	for(var/obj/machinery/incident_display/sign as anything in GLOB.map_delamination_counters)
		sign.update_delam_count(MISTAKES_WERE_MADE)
	addtimer(CALLBACK(src, PROC_REF(put_on_a_show)), 5 SECONDS)
	// fight power with power
	INVOKE_ASYNC(SSnightshift, TYPE_PROC_REF(/datum/controller/subsystem/nightshift, suck_light_power))

/obj/machinery/atmospherics/components/unary/delam_scram/proc/put_on_a_show()
	var/obj/machinery/power/supermatter_crystal/engine/angry_sm = my_sm?.resolve()
	on = TRUE
	playsound(src, 'sound/machines/hypertorus/HFR_critical_explosion.ogg', 100, FALSE, 40, ignore_walls = TRUE, use_reverb = TRUE)
	alert_sound_to_playing('sound/misc/earth_rumble_distant3.ogg', override_volume = TRUE)
	// good job at kneecapping the crystal, engineers
	angry_sm.modify_filter(name = "ray", new_params = list(
		color = SUPERMATTER_TESLA_COLOUR,
	))
	angry_sm.set_light_color(SUPERMATTER_TESLA_COLOUR)
	// don't vent the delam juice as it works its magic
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubby_boi in range(3, src))
		scrubby_boi.on = FALSE
		scrubby_boi.update_appearance()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/venti_boi in range(3, src))
		venti_boi.on = FALSE
		venti_boi.update_appearance()
	// the windows can only protect you for so long
	for(var/obj/structure/window/reinforced/plasma/fucked_window in range(3, src))
		addtimer(CALLBACK(fucked_window, TYPE_PROC_REF(/obj/structure/window/reinforced/plasma, delam_explode)), rand(13 SECONDS, 15 SECONDS))
	addtimer(CALLBACK(SSnightshift, TYPE_PROC_REF(/datum/controller/subsystem/nightshift, restore_light_power)), rand(19 SECONDS, 21 SECONDS))
	addtimer(CALLBACK(src, PROC_REF(goodbye_friends)), 9 SECONDS)
	update_appearance()

/obj/structure/window/reinforced/plasma/proc/delam_explode()
	visible_message(span_danger("The [src] shatters in the freon fire!"))
	explosion(src, 0, 0, 0, 3, 5)
	qdel(src)

/obj/machinery/atmospherics/components/unary/delam_scram/proc/goodbye_friends()
	var/obj/machinery/power/supermatter_crystal/engine/damaged_sm = my_sm?.resolve()
	damaged_sm.name = "partially delaminated supermatter crystal"
	damaged_sm.desc = "This crystal has seen better days, the glow seems off and the shards look brittle. Central says it's still \"relatively safe.\" They'd never lie to us, right?"
	damaged_sm.explosion_power = SUPERMATTER_DAMAGED // if you fuck up again, yeesh
	if(damaged_sm.damage > 100)
		damaged_sm.damage = 100
	damaged_sm.internal_energy = MISTAKES_WERE_MADE
	for(var/obj/machinery/power/energy_accumulator/tesla_coil/zappy_boi in range(3, src))
		zappy_boi.stored_energy = 0
	// good job buddy, sacrificing yourself for the greater good
	playsound(src, 'sound/misc/compiler-failure.ogg', 80, FALSE, 20, ignore_walls = TRUE, use_reverb = TRUE)
	audible_message(span_danger("The [src] beeps a sorrowful melody!"))
	visible_message(span_danger("The [src] collapses into a pile of twisted metal and foam!"))
	deconstruct(FALSE)

/obj/machinery/atmospherics/components/unary/delam_scram/New()
	. = ..()
	var/datum/gas_mixture/delam_juice = new
	delam_juice.add_gases(/datum/gas/freon)
	delam_juice.gases[/datum/gas/freon][MOLES] = 64000
	delam_juice.temperature = 120
	airs[1] = delam_juice

/datum/controller/subsystem/nightshift/proc/suck_light_power()
	SSnightshift.can_fire = FALSE
	for(var/obj/machinery/power/apc/light_to_suck in GLOB.machines)
		light_to_suck.lighting = APC_CHANNEL_OFF
		light_to_suck.nightshift_lights = TRUE
		light_to_suck.update_appearance()
		light_to_suck.update()

/datum/controller/subsystem/nightshift/proc/restore_light_power()
	for(var/obj/machinery/power/apc/light_to_restore in GLOB.machines)
		light_to_restore.lighting = APC_CHANNEL_AUTO_ON
		light_to_restore.update_appearance()
		light_to_restore.update()

/obj/machinery/button/delam_scram
	name = "supermatter emergency stop"
	desc = "Your last hope to try and save the crystal during a delamination. \
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
	///who pushed the big red button
	var/who_did_it
	///our internal radio
	var/obj/item/radio/radio
	///radio key
	var/radio_key = /obj/item/encryptionkey/headset_eng

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

/obj/machinery/button/delam_scram/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(button_stage == BUTTON_IDLE)
		visible_message(span_danger("A biscuit card falls out of the [src]!"))
		user.put_in_hands(new /obj/item/folder/biscuit/confidential/delam(get_turf(user)))
		button_stage = BUTTON_AWAKE
		return

	if(button_stage != BUTTON_AWAKE)
		return

	if(world.time - SSticker.round_start_time > 30 MINUTES)
		playsound(src.loc, 'sound/misc/compiler-failure.ogg', 50, FALSE, 15)
		audible_message(span_danger("The [src] makes a series of sad beeps. The internal charge only lasts about 30 minutes... what a feat of engineering!"))
		burn_out()
		return

	button_stage = BUTTON_ARMED
	update_appearance()
	radio.talk_into(src, "SUPERMATTER EMERGENCY STOP BUTTON ARMED!", RADIO_CHANNEL_ENGINEERING)
	visible_message(span_danger("[user] swings open the plastic cover of the [src]!"))
	message_admins("[ADMIN_LOOKUPFLW(user)] just opened the cover of the [src].")
	investigate_log("[key_name(user)] opened the cover of the [src].", INVESTIGATE_ATMOS)
	if(tgui_alert(usr, "You really sure that you want to push this?", "It looked scarier on HBO.", list("No", "Yes")) != "Yes")
		button_stage = BUTTON_AWAKE
		visible_message(span_danger("[user] slowly closes the plastic cover of the [src]!"))
		update_appearance()
		return
	who_did_it = user.ckey
	playsound(src, 'sound/machines/high_tech_confirm.ogg', 50, FALSE, 15, ignore_walls = TRUE, use_reverb = TRUE)
	button_stage = BUTTON_PUSHED
	visible_message(span_danger("[user] smashes the [src] with their hand!"))
	message_admins("[ADMIN_LOOKUPFLW(user)] pushed the [src]!")
	investigate_log("[key_name(user)] pushed the [src]!", INVESTIGATE_ATMOS)
	flick_overlay_view("[base_icon_state]-overlay-active", 20 SECONDS)
	SEND_GLOBAL_SIGNAL(COMSIG_MAIN_SM_DELAMINATING, BUTTON_PUSHED)
	for(var/obj/machinery/door/airlock/escape_route in range(7, src))
		if(istype(escape_route, /obj/machinery/door/airlock/command))
			continue
		INVOKE_ASYNC(escape_route, TYPE_PROC_REF(/obj/machinery/door/airlock, temp_emergency_exit), 45 SECONDS)
	notify_ghosts(
		"The [src] has been pushed!",
		source = src,
		header = "Mistakes Were Made",
		action = NOTIFY_ORBIT,
		ghost_sound = 'sound/machines/warning-buzzer.ogg',
		notify_volume = 75
	)

/obj/machinery/button/delam_scram/proc/burn_out()
	if(!(machine_stat & BROKEN))
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

/obj/machinery/power/supermatter_crystal/Destroy() // I wish I could set the sign to negatives if you manage to still screw it up
	if(is_main_engine && GLOB.main_supermatter_engine == src)
		SSpersistence.delam_highscore = SSpersistence.rounds_since_engine_exploded
		SSpersistence.rounds_since_engine_exploded = MISTAKES_WERE_MADE
		for (var/obj/machinery/incident_display/sign as anything in GLOB.map_delamination_counters)
			sign.update_delam_count(MISTAKES_WERE_MADE)
	return ..()

/obj/machinery/power/emitter/LateInitialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_MAIN_SM_DELAMINATING, PROC_REF(emergency_stop))

/obj/machinery/power/emitter/proc/emergency_stop()
	SIGNAL_HANDLER

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
