#define LOWPOP_ON_MESSAGE "Due to staffing issues, we have enacted the 'critically low staff' protocol. We will periodically use our high-intensity electron beam to recharge your SMES arrays."
#define LOWPOP_OFF_MESSAGE "As the staffing issues have been resolved, we have resumed normal staffing protocol. Automatic SMES recharging will no longer occur."
#define SMES_CRITICALLY_LOW_PERCENTAGE 5
#define RECHARGE_THRESHOLD 70

// A subsystem for handling lowpop affairs.
SUBSYSTEM_DEF(lowpop)
	name = "Lowpop Control Measures"
	wait = 10 MINUTES
	runlevels = RUNLEVEL_GAME
	/// Since the last fire, were the measures on or off?
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
	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(roundstart_check))
	return SS_INIT_SUCCESS

/**
 * Roundstart check
 *
 * We check at roundstart if we should activate the measures.
 */
/datum/controller/subsystem/lowpop/proc/roundstart_check()
	if(get_active_player_count(TRUE, FALSE, FALSE) > CONFIG_GET(number/lowpop_threshold))
		disable_lowpop_measures()
		return // If we go above it don't do it!
	enable_lowpop_measures()
	addtimer(CALLBACK(src, PROC_REF(send_announcement), LOWPOP_ON_MESSAGE), rand(10 SECONDS, 30 SECONDS))

/datum/controller/subsystem/lowpop/proc/send_announcement(message)
	priority_announce(message, "Staffing Bureau")


/datum/controller/subsystem/lowpop/fire(resumed)
	var/fire_population_count = get_active_player_count(TRUE, FALSE, FALSE)
	if(fire_population_count <= CONFIG_GET(number/lowpop_threshold)) // Oh no, we went below the threshold.
		enable_lowpop_measures()
	if(!lowpop_active)
		return
	// First, check if we need to turn these measures off.
	if(fire_population_count > CONFIG_GET(number/lowpop_threshold))
		// Okay, we're high enough again, lets turn it off, and let everyone know!
		disable_lowpop_measures()
		addtimer(CALLBACK(src, PROC_REF(send_announcement), LOWPOP_OFF_MESSAGE), rand(10 SECONDS, 30 SECONDS))
		return

	power_restore()

/datum/controller/subsystem/lowpop/proc/enable_lowpop_measures()
	lowpop_active = TRUE
	update_power_changes()


/datum/controller/subsystem/lowpop/proc/disable_lowpop_measures()
	lowpop_active = FALSE
	update_power_changes()

/**
 * Changes the power requirements of some things.
 */
/datum/controller/subsystem/lowpop/proc/update_power_changes()
	if(lowpop_active)
		for(var/obj/machinery/atmospherics/atmos_device as anything in GLOB.atmos_components)
			if(is_type_in_list(atmos_device, atmos_machinery_no_power))
				atmos_device.update_use_power(NO_POWER_USE)
	else
		for(var/obj/machinery/atmospherics/atmos_device as anything in GLOB.atmos_components)
			if(is_type_in_list(atmos_device, atmos_machinery_no_power))
				atmos_device.update_use_power(initial(atmos_device.use_power))
/**
 * Here we check a few things, namely, if the SMES on station are more than percent critically low, we recharge!
 */
/datum/controller/subsystem/lowpop/proc/power_restore()
	var/list/all_smes = SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/smes)
	var/list/critically_low_smes = list()
	var/list/valid_smes = list()

	for(var/obj/machinery/power/smes/smes as anything in all_smes)
		// check if its the right z level
		if(!is_station_level(smes.z))
			continue
		LAZYADD(valid_smes, smes)
		// check if it's actually low on power
		if((smes.charge / smes.capacity * 100) < SMES_CRITICALLY_LOW_PERCENTAGE)
			LAZYADD(critically_low_smes, smes)

	// check if enough of them are out of power
	if((LAZYLEN(critically_low_smes) / LAZYLEN(valid_smes) * 100) < RECHARGE_THRESHOLD)
		return

	// recharge all those smes if we're out of power!
	for(var/obj/machinery/power/smes/smes as anything in valid_smes)
		smes.charge = smes.capacity
		smes.output_level = smes.output_level_max
		smes.output_attempt = TRUE
		smes.update_appearance()
		smes.power_change()

	minor_announce("All SMESs on [station_name()] have been recharged via electron beam.", "Power Systems Recharged")
