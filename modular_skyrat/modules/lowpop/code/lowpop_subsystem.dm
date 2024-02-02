#define LOWPOP_ON_MESSAGE "Due to staffing issues, we have enacted the 'critically low staff' protocol. We will periodically use our high-intensity electron beam to recharge your SMES arrays."
#define LOWPOP_OFF_MESSAGE "As the staffing issues have been resolved, we have resumed normal staffing protocol. Automatic SMES recharging will no longer occur."
#define RECHARGE_THRESHOLD 70

// A subsystem for handling lowpop affairs.
SUBSYSTEM_DEF(lowpop)
	name = "Lowpop Control Measures"
	wait = 5 MINUTES
	runlevels = RUNLEVEL_GAME
	/// Are lowpop measures currently in effect?
	var/lowpop_active = FALSE
	/// List of atmos machinery we set no power to
	var/static/list/atmos_machinery_no_power = list(
		/obj/machinery/atmospherics/components/trinary,
		/obj/machinery/atmospherics/components/binary,
	)

/datum/controller/subsystem/lowpop/Initialize()
	if(!CONFIG_GET(flag/lowpop_measures_enabled))
		can_fire = FALSE
		return SS_INIT_NO_NEED
	wait = CONFIG_GET(number/lowpop_subsystem_fire)
	if(LAZYLEN(GLOB.player_list) > CONFIG_GET(number/lowpop_threshold)) // Don't announce it if we're not within the threshold. We use player list as people haven't spawned in yet.
		return SS_INIT_SUCCESS
	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(lowpop_check))
	return SS_INIT_SUCCESS

/**
 * Roundstart check
 *
 * We check at roundstart if we should activate the measures.
 */

/datum/controller/subsystem/lowpop/proc/lowpop_check()
	if(get_active_player_count(TRUE, FALSE, FALSE) > CONFIG_GET(number/lowpop_threshold))
		disable_lowpop_measures()
	else
		enable_lowpop_measures()

/datum/controller/subsystem/lowpop/proc/send_announcement(message)
	priority_announce(message, "Staffing Bureau")

/datum/controller/subsystem/lowpop/fire(resumed)
	lowpop_check()
	if (lowpop_active)
		power_restore()

/datum/controller/subsystem/lowpop/proc/enable_lowpop_measures()
	if (lowpop_active)
		return
	lowpop_active = TRUE
	update_power_changes()
	addtimer(CALLBACK(src, PROC_REF(send_announcement), LOWPOP_ON_MESSAGE), rand(10 SECONDS, 30 SECONDS))

/datum/controller/subsystem/lowpop/proc/disable_lowpop_measures()
	if (!lowpop_active)
		return
	lowpop_active = FALSE
	update_power_changes()
	addtimer(CALLBACK(src, PROC_REF(send_announcement), LOWPOP_OFF_MESSAGE), rand(10 SECONDS, 30 SECONDS))

/**
 * Changes the power requirements of some things.
 */
/datum/controller/subsystem/lowpop/proc/update_power_changes()
	for(var/obj/machinery/atmospherics/atmos_device as anything in GLOB.atmos_components)
		if(is_type_in_list(atmos_device, atmos_machinery_no_power))
			if(lowpop_active)
				atmos_device.update_use_power(NO_POWER_USE)
			else
				atmos_device.update_use_power(initial(atmos_device.use_power))

/**
 * Here we check a few things, namely, if the SMES on station are more than percent critically low, we recharge!
 */
/datum/controller/subsystem/lowpop/proc/power_restore()
	var/list/all_smes = SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/smes)
	var/list/valid_smes = list()

	for(var/obj/machinery/power/smes/smes as anything in all_smes)
		// check if its the right z level
		if(!is_station_level(smes.z))
			continue
		LAZYADD(valid_smes, smes)

	// recharge all those smes if we're out of power!
	for(var/obj/machinery/power/smes/smes as anything in valid_smes)
		smes.charge = smes.capacity
		smes.input_level = smes.input_level_max
		smes.output_level = smes.output_level_max * 0.8
		smes.output_attempt = TRUE
		smes.update_appearance()
		smes.power_change()

	minor_announce("All SMESs on [station_name()] have been recharged via electron beam.", "Power Systems Recharged")
