/// Component that manages a list of plane masters that are dependent on weather
/// Force hides/shows them depending on the weather activity of their z stack
/// Applied to the plane master group that owns them
/datum/component/hide_weather_planes
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/list/datum/weather/active_weather = list()
	var/list/atom/movable/screen/plane_master/plane_masters = list()

/datum/component/hide_weather_planes/Initialize(atom/movable/screen/plane_master/care_about)
	if(!istype(parent, /datum/plane_master_group))
		return COMPONENT_INCOMPATIBLE
	var/datum/plane_master_group/home = parent
	plane_masters += care_about
	RegisterSignal(care_about, COMSIG_QDELETING, PROC_REF(plane_master_deleted))

	var/list/starting_signals = list()
	var/list/ending_signals = list()
	for(var/datum/weather/weather_type as anything in typesof(/datum/weather))
		starting_signals += COMSIG_WEATHER_TELEGRAPH(weather_type)
		ending_signals += COMSIG_WEATHER_END(weather_type)

	RegisterSignals(SSdcs, starting_signals, PROC_REF(weather_started))
	RegisterSignals(SSdcs, ending_signals, PROC_REF(weather_finished))

	if(home.our_hud)
		attach_hud(home.our_hud)
	else
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(new_hud_attached))

/datum/component/hide_weather_planes/Destroy(force)
	hide_planes()
	active_weather = null
	plane_masters = null
	return ..()

/datum/component/hide_weather_planes/InheritComponent(datum/component/new_comp, i_am_original, atom/movable/screen/plane_master/care_about)
	if(!i_am_original)
		return
	var/datum/plane_master_group/home = parent
	var/mob/our_lad = home.our_hud?.mymob
	plane_masters += care_about
	RegisterSignal(care_about, COMSIG_QDELETING, PROC_REF(plane_master_deleted))
	if(length(active_weather))
		care_about.unhide_plane(our_lad)
	else
		care_about.hide_plane(our_lad)

/datum/component/hide_weather_planes/proc/new_hud_attached(datum/source, datum/hud/new_hud)
	SIGNAL_HANDLER
	attach_hud(new_hud)

/datum/component/hide_weather_planes/proc/attach_hud(datum/hud/new_hud)
	RegisterSignal(new_hud, COMSIG_HUD_Z_CHANGED, PROC_REF(z_changed))
	var/mob/eye = new_hud?.mymob?.client?.eye
	var/turf/eye_location = get_turf(eye)
	z_changed(new_hud, eye_location?.z)

/datum/component/hide_weather_planes/proc/plane_master_deleted(atom/movable/screen/plane_master/source)
	SIGNAL_HANDLER
	plane_masters -= source

/datum/component/hide_weather_planes/proc/display_planes()
	var/datum/plane_master_group/home = parent
	var/mob/our_lad = home.our_hud?.mymob
	for(var/atom/movable/screen/plane_master/weather_concious as anything in plane_masters)
		if(weather_concious.force_hidden)
			weather_concious.unhide_plane(our_lad)

/datum/component/hide_weather_planes/proc/hide_planes()
	var/datum/plane_master_group/home = parent
	var/mob/our_lad = home.our_hud?.mymob
	for(var/atom/movable/screen/plane_master/weather_concious as anything in plane_masters)
		if(!weather_concious.force_hidden)
			weather_concious.hide_plane(our_lad)

/datum/component/hide_weather_planes/proc/z_changed(datum/source, new_z)
	SIGNAL_HANDLER
	active_weather = list()
	if(!SSmapping.initialized)
		return
	var/list/connected_levels = SSmapping.get_connected_levels(new_z)
	for(var/datum/weather/active as anything in SSweather.processing)
		if(length(connected_levels & active.impacted_z_levels))
			active_weather += WEAKREF(active)

	if(length(active_weather))
		display_planes()
	else
		hide_planes()

/datum/component/hide_weather_planes/proc/weather_started(datum/source, datum/weather/starting)
	SIGNAL_HANDLER
	var/datum/plane_master_group/home = parent
	var/mob/eye = home.our_hud?.mymob?.client?.eye
	var/turf/viewing_from = get_turf(eye)
	if(!viewing_from)
		return

	var/list/connected_levels = SSmapping.get_connected_levels(viewing_from)
	if(length(connected_levels & starting.impacted_z_levels))
		active_weather += WEAKREF(starting)

	if(!length(active_weather))
		return
	display_planes()

/datum/component/hide_weather_planes/proc/weather_finished(datum/source, datum/weather/stopping)
	SIGNAL_HANDLER
	active_weather -= WEAKREF(stopping)

	if(length(active_weather))
		return
	hide_planes()
