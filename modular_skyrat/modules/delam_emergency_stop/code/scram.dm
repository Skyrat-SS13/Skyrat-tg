#define BUTTON_PUSHED 0
#define MINI_DELAMINATION 14
#define DAMAGED_SM_LIMIT 295

/obj/machinery/atmospherics/components/unary/delam_scram
	icon_state = "inje_map-3"

	name = "reactor emergency scram"
	desc = "An expensive delamination suppression system. You don't want to be in the chamber when it's activated!"

	use_power = IDLE_POWER_USE
	can_unwrench = FALSE // comedy option, what if unwrenching trying to steal it throws you into the crystal for a nice dusting
	shift_underlay_only = FALSE
	hide = TRUE
	layer = GAS_SCRUBBER_LAYER
	pipe_state = "injector"
	resistance_flags = FIRE_PROOF | FREEZE_PROOF | UNACIDABLE

	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.25
	///Rate of operation of the device
	var/volume_rate = 33
	///if we're byond the point of no return
	var/scram_triggered = FALSE
	///weakref to our SM
	var/datum/weakref/my_sm
	///Our internal radio
	var/obj/item/radio/radio
	///The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng
	///radio channels, need null to actually broadcast on common, lol.
	var/emergency_channel = null
	var/warning_channel = RADIO_CHANNEL_ENGINEERING
	var/emitter_area
	var/scrubber_area

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

	var/obj/machinery/power/supermatter_crystal/engine/sm_crystal = my_sm?.resolve()
	if(sm_crystal)
		RegisterSignal(sm_crystal, COMSIG_MAIN_SM_DELAMINATING, PROC_REF(go_time))

	emitter_area = get_area_instance_from_text("/area/station/engineering/supermatter/room")
	scrubber_area = get_area_instance_from_text("/area/station/engineering/supermatter")

/obj/machinery/atmospherics/components/unary/delam_scram/Destroy()
	QDEL_NULL(radio)
	return ..()

/obj/machinery/atmospherics/components/unary/delam_scram/proc/marry_sm()
	my_sm = WEAKREF(GLOB.main_supermatter_engine)

/obj/machinery/atmospherics/components/unary/delam_scram/update_icon_nopipes()
	cut_overlays()
	if(showpipe)
		// everything is already shifted so don't shift the cap
		add_overlay(get_pipe_image(icon, "inje_cap", initialize_directions, pipe_color))

	if(!nodes[1] || !on || !is_operational)
		icon_state = "inje_off"
	else
		icon_state = "inje_on"

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

/obj/machinery/atmospherics/components/unary/delam_scram/proc/go_time(source, trigger_reason)
	SIGNAL_HANDLER

	if(on)
		return

	message_admins("Delam SCRAM activated!")
	investigate_log("Delam SCRAM was hit by [key_name(usr)]", INVESTIGATE_ATMOS)
	radio.talk_into(src, "DELAMINATION SUPPRESSION SYSTEM ARMED. EVACUATE SUPERMATTER ENGINE ROOM!", emergency_channel)
	SSpersistence.delam_highscore = SSpersistence.rounds_since_engine_exploded
	SSpersistence.rounds_since_engine_exploded = BUTTON_PUSHED
	for(var/obj/machinery/incident_display/sign as anything in GLOB.map_delamination_counters)
		sign.update_delam_count(BUTTON_PUSHED)
	arm_delam_scram()

/obj/machinery/atmospherics/components/unary/delam_scram/proc/arm_delam_scram()
	addtimer(CALLBACK(src, PROC_REF(put_on_a_show)), 5 SECONDS)

/obj/machinery/atmospherics/components/unary/delam_scram/proc/put_on_a_show()
	var/obj/machinery/power/supermatter_crystal/engine/angry_sm = my_sm?.resolve()
	on = TRUE
	// fight power with power
	INVOKE_ASYNC(SSnightshift, TYPE_PROC_REF(/datum/controller/subsystem/nightshift, suck_light_power))
	// good job at kneecapping the crystal, engineers
	angry_sm.modify_filter(name = "ray", new_params = list(
		color = SUPERMATTER_TESLA_COLOUR,
	))
	angry_sm.set_light_color(SUPERMATTER_TESLA_COLOUR)
	// don't assume these dummies turned off the emitters
	for(var/obj/machinery/power/emitter/shooty_boi in emitter_area)
		shooty_boi.active = FALSE
		shooty_boi.update_appearance()
	// don't vent the delam juice as it works its magic
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubby_boi in scrubber_area)
		scrubby_boi.on = FALSE
		scrubby_boi.update_appearance()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/venti_boi in scrubber_area)
		venti_boi.on = FALSE
		venti_boi.update_appearance()
	// the windows can only protect you for so long
	for(var/obj/structure/window/reinforced/plasma/fucked_window in range(3, src))
		addtimer(CALLBACK(fucked_window, TYPE_PROC_REF(/obj/structure/window/reinforced/plasma, delam_explode)), rand(13 SECONDS, 15 SECONDS))
	addtimer(CALLBACK(SSnightshift, TYPE_PROC_REF(/datum/controller/subsystem/nightshift, restore_light_power)), rand(13 SECONDS, 15 SECONDS))
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
	damaged_sm.explosion_power = MINI_DELAMINATION
	if(damaged_sm.damage > 100)
		damaged_sm.damage = 100
	damaged_sm.internal_energy = BUTTON_PUSHED
	for(var/obj/machinery/power/energy_accumulator/tesla_coil/zappy_boi in scrubber_area)
		zappy_boi.stored_energy = 0
	// good job buddy, sacrificing yourself for the greater good
	visible_message(span_danger("The [src] beeps a sorrowful melody and collapses into a pile of twisted metal and foam!"))
	deconstruct(FALSE)

/obj/machinery/atmospherics/components/unary/delam_scram/New()
	. = ..()
	var/datum/gas_mixture/delam_juice = new
	delam_juice.add_gases(/datum/gas/freon)
	delam_juice.gases[/datum/gas/freon][MOLES] = 64000
	delam_juice.temperature = 80
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

#undef BUTTON_PUSHED
#undef MINI_DELAMINATION
