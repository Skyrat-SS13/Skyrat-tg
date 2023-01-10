//
// Holo-Minimaps Generation Subsystem handles initialization of the holo minimaps.
// Look in code/modules/holomap/generate_holomap.dm to find generateholomaps()
//
SUBSYSTEM_DEF(holomaps)
	name = "Holomaps"
	init_order = -2
	flags = SS_NO_FIRE

	var/static/list/holomaps = list()
	var/static/list/extra_holomaps = list()
	var/static/list/station_holomaps = list()
	var/static/list/holomap_z_transitions = list()
	var/static/list/list/holomap_position_to_name = list()

/datum/controller/subsystem/holomaps/Recover()
	flags |= SS_NO_INIT // Make extra sure we don't initialize twice.

/datum/controller/subsystem/holomaps/Initialize(timeofday)
	return generate_holomaps() ? SS_INIT_SUCCESS : SS_INIT_FAILURE
