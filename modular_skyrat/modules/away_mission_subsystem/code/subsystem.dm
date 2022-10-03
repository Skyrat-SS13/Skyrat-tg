/**  SSaway_missions
* This SS is a bit of a strange one. It will go mostly unused except when certain away missions are initialized.
* The SS works by hooking into a `/datum/away_controller` subtype, which is based on the name of the away mission.
* For example, the away mission "Outbomb Cuban Pete" would require the controller's path to be `/datum/away_controller/outbomb_cuban_pete`.
* The subsystem itself shouldn't be used for much but to simply pass on to the away controller, because the SS is genericized for all away missions.
*/
SUBSYSTEM_DEF(away_missions)
	name = "Away Missions"
	init_order = INIT_ORDER_AWAY_MISSION
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 10 MINUTES
	/// Relevant away controller
	var/datum/away_controller/selected_controller

/datum/controller/subsystem/away_missions/Initialize(start_timeofday)
	. = ..()
	RegisterSignal(src, COMSIG_AWAY_MISSION_LOADED, .proc/controller_setup)

/datum/controller/subsystem/away_missions/Recover()
	selected_controller = SSaway_missions.selected_controller

/datum/controller/subsystem/away_missions/fire(resumed)
	if(selected_controller)
		selected_controller.fire()

/// Selects the away controller corresponding to the loaded away mission
/datum/controller/subsystem/away_missions/proc/controller_setup(datum/source, mapname)
	SIGNAL_HANDLER
	var/regex/sanitizing_regex = regex(@"([^A-Za-z])")
	var/regex/clean_up_regex = regex(@"[^/]*\/")
	var/regex/clean_up_regex2 = regex(@"(\..*)")
	var/chosen_path = replacetext(mapname, sanitizing_regex, "_")
	chosen_path = replacetext(chosen_path, clean_up_regex, "")
	chosen_path = replacetext(chosen_path, clean_up_regex2, "")
	chosen_path = text2path("/datum/away_controller/[lowertext(replacetext(chosen_path, clean_up_regex, ""))]") //this donut work with "outbound_expedition.dmm custom"
	if(!ispath(chosen_path)) //check if this passes or fails on improper paths
		return
	selected_controller = new chosen_path
	wait = selected_controller.ss_delay
	UnregisterSignal(src, COMSIG_AWAY_MISSION_LOADED)
