/*
*	CME EVENT SYSTEM
*	SEE _CME_DEFINES.DM FOR SETTINGS.
*/

/* Welcome to the CME control system.
*
*	This controls the CME event, or coronal mass ejection event, which causes multiple EMP bubbles to form around the station
*	depending on conditons and time. There are currently 4 settings of CME, all of which have settings defined in the
*	cme defines DM file. See that for more info
*
*	Armageddon is truly going to fuck the station, use it sparingly.
*/

/datum/round_event_control/cme
	name = "Coronal Mass Ejection: Random"
	typepath = /datum/round_event/cme
	weight = 0
	max_occurrences = 0
	earliest_start = 45 MINUTES
	category = EVENT_CATEGORY_SPACE
	description = "Spawns a CME event of varied severities"

/datum/round_event/cme
	start_when = 6
	end_when	= 66
	announce_when = 10
	var/cme_intensity
	var/cme_frequency_lower
	var/cme_frequency_upper
	var/list/cme_start_locs = list()

/datum/round_event_control/cme/unknown
	name = "Coronal Mass Ejection: Unknown"
	typepath = /datum/round_event/cme/unknown
	weight = 0
	min_players = 75
	max_occurrences = 0
	description = "Spawns a CME event of a unknown severity"

/datum/round_event/cme/unknown
	cme_intensity = CME_UNKNOWN

/datum/round_event_control/cme/minimal
	name = "Coronal Mass Ejection: Minimal"
	typepath = /datum/round_event/cme/minimal
	weight = 0
	max_occurrences = 0
	description = "Spawns a CME event of minimum severity"

/datum/round_event/cme/minimal
	cme_intensity = CME_MINIMAL

/datum/round_event_control/cme/moderate
	name = "Coronal Mass Ejection: Moderate"
	typepath = /datum/round_event/cme/moderate
	weight = 0
	max_occurrences = 0
	description = "Spawns a CME event of moderate severity"

/datum/round_event/cme/moderate
	cme_intensity = CME_MODERATE

/datum/round_event_control/cme/extreme
	name = "Coronal Mass Ejection: Extreme"
	typepath = /datum/round_event/cme/extreme
	weight = 0
	min_players = 75
	max_occurrences = 0
	description = "Spawns a CME event of extreme severity"

/datum/round_event/cme/extreme
	cme_intensity = CME_EXTREME

/datum/round_event_control/cme/armageddon
	name = "Coronal Mass Ejection: Armageddon"
	typepath = /datum/round_event/cme/armageddon
	weight = 0
	max_occurrences = 0
	description = "Spawns a CME event of Arnageddon severity. WARNING this is round ending severe."

/datum/round_event/cme/armageddon
	cme_intensity = CME_ARMAGEDDON

/datum/round_event/cme/setup()
	if(!cme_intensity)
		cme_intensity = pick(CME_MINIMAL, CME_UNKNOWN, CME_MODERATE, CME_EXTREME)
	switch(cme_intensity)
		if(CME_UNKNOWN)
			cme_frequency_lower = CME_MODERATE_FREQUENCY_LOWER
			cme_frequency_upper = CME_MODERATE_FREQUENCY_UPPER
			start_when = rand(CME_MODERATE_START_LOWER, CME_MODERATE_START_UPPER)
			end_when = start_when + CME_MODERATE_END
		if(CME_MINIMAL)
			cme_frequency_lower = CME_MINIMAL_FREQUENCY_LOWER
			cme_frequency_upper = CME_MINIMAL_FREQUENCY_UPPER
			start_when = rand(CME_MINIMAL_START_LOWER, CME_MINIMAL_START_UPPER)
			end_when = start_when + CME_MINIMAL_END
		if(CME_MODERATE)
			cme_frequency_lower = CME_MODERATE_FREQUENCY_LOWER
			cme_frequency_upper = CME_MODERATE_FREQUENCY_UPPER
			start_when = rand(CME_MODERATE_START_LOWER, CME_MODERATE_START_UPPER)
			end_when = start_when + CME_MODERATE_END
		if(CME_EXTREME)
			cme_frequency_lower = CME_EXTREME_FREQUENCY_LOWER
			cme_frequency_upper = CME_EXTREME_FREQUENCY_UPPER
			start_when = rand(CME_EXTREME_START_LOWER, CME_EXTREME_START_UPPER)
			end_when = start_when + CME_EXTREME_END
		if(CME_ARMAGEDDON)
			cme_frequency_lower = CME_ARMAGEDDON_FREQUENCY_LOWER
			cme_frequency_upper = CME_ARMAGEDDON_FREQUENCY_UPPER
			start_when = rand(CME_ARMAGEDDON_START_LOWER, CME_ARMAGEDDON_START_UPPER)
			end_when = start_when + CME_ARMAGEDDON_END
		else
			message_admins("CME setup failure, aborting.")
			kill()

	for(var/turf/open/floor/T in world)
		var/area/turf_area = get_area(T)
		if(is_station_level(T.z) && !istype(turf_area, /area/solars) && !istype(turf_area, /area/icemoon))
			cme_start_locs += T

/datum/round_event/cme/announce(fake)
	if(fake)
		priority_announce("Critical Coronal mass ejection detected! Expected intensity: [uppertext(cme_intensity)]. Impact in: [rand(200, 300)] seconds. \
		All synthetic and non-organic lifeforms should seek shelter immediately! \
		Ensure all sensitive equipment is shielded.", "Solar Event", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))
	else
		switch(cme_intensity)
			if(CME_UNKNOWN)
				priority_announce("Coronal mass ejection detected! Expected intensity: UNKNOWN. Impact in: [round((start_when * SSevents.wait) * 0.1, 0.1)] seconds. \
				All synthetic and non-organic lifeforms should seek shelter immediately! \
				Neutralize magnetic field bubbles at all costs.", "Solar Event", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))
			if(CME_MINIMAL)
				priority_announce("Coronal mass ejection detected! Expected intensity: [uppertext(cme_intensity)]. Impact in: [round((start_when * SSevents.wait) * 0.1, 0.1)] seconds. \
				All synthetic and non-organic lifeforms should seek shelter immediately! \
				Neutralize magnetic field bubbles at all costs.", "Solar Event", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))
			if(CME_MODERATE)
				priority_announce("Coronal mass ejection detected! Expected intensity: [uppertext(cme_intensity)]. Impact in: [round((start_when * SSevents.wait) * 0.1, 0.1)] seconds. \
				All synthetic and non-organic lifeforms should seek shelter immediately! \
				Neutralize magnetic field bubbles at all costs.", "Solar Event", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))
			if(CME_EXTREME)
				addtimer(CALLBACK(src, PROC_REF(cme_level_callback), SEC_LEVEL_ORANGE, TRUE, FALSE), (round((start_when * SSevents.wait) * 0.1, 0.1)) SECONDS)
				priority_announce("Critical Coronal mass ejection detected! Expected intensity: [uppertext(cme_intensity)]. Impact in: [round((start_when * SSevents.wait) * 0.1, 0.1)] seconds. \
				All synthetic and non-organic lifeforms should seek shelter immediately! \
				Neutralize magnetic field bubbles at all costs.", "Solar Event", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))
			if(CME_ARMAGEDDON)
				addtimer(CALLBACK(src, PROC_REF(cme_level_callback), SEC_LEVEL_GAMMA, TRUE, TRUE), (round((start_when * SSevents.wait) * 0.1, 0.1)) SECONDS)
				priority_announce("Neutron Mass Ejection Detected! Expected intensity: [uppertext(cme_intensity)]. Impact in: [round((start_when * SSevents.wait) * 0.1, 0.1)] seconds. \
				All personnel should proceed to their nearest warpgate for evacuation, the Solar Federation has issued this mandatory alert.", "Solar Event", sound('modular_skyrat/modules/cme/sound/cme_warning.ogg'))

/datum/round_event/cme/tick(seconds_between_ticks)
	if(ISMULTIPLE(activeFor, rand(cme_frequency_lower, cme_frequency_upper)))
		var/turf/spawnpoint = pick(cme_start_locs)
		spawn_cme(spawnpoint, cme_intensity)

/datum/round_event/cme/proc/cme_level_callback(sec_level = SEC_LEVEL_ORANGE, engi = TRUE, maint = FALSE)
	INVOKE_ASYNC(SSsecurity_level, TYPE_PROC_REF(/datum/controller/subsystem/security_level/, minimum_security_level), sec_level, engi, maint)

/datum/round_event/cme/proc/spawn_cme(turf/spawnpoint, intensity)
	if(intensity == CME_UNKNOWN)
		intensity = pick(CME_MINIMAL, CME_MODERATE, CME_EXTREME)
		if(intensity == CME_EXTREME)
			INVOKE_ASYNC(SSsecurity_level, TYPE_PROC_REF(/datum/controller/subsystem/security_level/, minimum_security_level), SEC_LEVEL_ORANGE, TRUE, FALSE)

	var/area/loc_area_name = get_area(spawnpoint)
	minor_announce("WARNING! [uppertext(intensity)] PULSE EXPECTED IN: [loc_area_name.name]", "Solar Flare Log:")
	switch(intensity)
		if(CME_MINIMAL)
			var/obj/effect/cme/spawnedcme = new(spawnpoint)
			announce_to_ghosts(spawnedcme)
		if(CME_MODERATE)
			var/obj/effect/cme/moderate/spawnedcme = new(spawnpoint)
			announce_to_ghosts(spawnedcme)
		if(CME_EXTREME)
			var/obj/effect/cme/extreme/spawnedcme = new(spawnpoint)
			announce_to_ghosts(spawnedcme)
		if(CME_ARMAGEDDON)
			var/obj/effect/cme/armageddon/spawnedcme = new(spawnpoint)
			announce_to_ghosts(spawnedcme)


/datum/round_event/cme/end()
	minor_announce("The station has cleared the solar flare, please proceed to repair electronic failures.", "CME cleared:")


/*
*	CME BUBBLES
*/

/obj/effect/cme
	desc = "A solar ejection projection."
	name = "MINIMAL SOLAR EJECTION"
	icon = 'modular_skyrat/modules/cme/icons/cme_effect.dmi'
	icon_state = "cme_effect"
	color = COLOR_BLUE_LIGHT
	light_range = 5
	light_power = 2
	light_color = COLOR_BLUE_LIGHT
	pixel_x = -32
	pixel_y = -32
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	plane = ABOVE_LIGHTING_PLANE
	can_atmos_pass = ATMOS_PASS_DENSITY
	var/timeleft = CME_MINIMAL_BUBBLE_BURST_TIME
	var/cme_light_range_lower = CME_MINIMAL_LIGHT_RANGE_LOWER
	var/cme_light_range_upper = CME_MINIMAL_LIGHT_RANGE_UPPER
	var/cme_heavy_range_lower = CME_MINIMAL_HEAVY_RANGE_LOWER
	var/cme_heavy_range_upper = CME_MINIMAL_HEAVY_RANGE_UPPER
	var/neutralized = FALSE

/obj/effect/cme/moderate
	name = "MODERATE SOLAR EJECTION"
	color = COLOR_VIVID_YELLOW
	light_color = COLOR_VIVID_YELLOW
	timeleft = CME_MODERATE_BUBBLE_BURST_TIME
	cme_light_range_lower = CME_MODERATE_LIGHT_RANGE_LOWER
	cme_light_range_upper = CME_MODERATE_LIGHT_RANGE_UPPER
	cme_heavy_range_lower = CME_MODERATE_HEAVY_RANGE_LOWER
	cme_heavy_range_upper = CME_MODERATE_HEAVY_RANGE_UPPER

/obj/effect/cme/extreme
	name = "EXTREME SOLAR EJECTION"
	color = COLOR_RED
	light_color = COLOR_RED
	timeleft = CME_EXTREME_BUBBLE_BURST_TIME
	cme_light_range_lower = CME_EXTREME_LIGHT_RANGE_LOWER
	cme_light_range_upper = CME_EXTREME_LIGHT_RANGE_UPPER
	cme_heavy_range_lower = CME_EXTREME_HEAVY_RANGE_LOWER
	cme_heavy_range_upper = CME_EXTREME_HEAVY_RANGE_UPPER

/obj/effect/cme/armageddon
	name = "ARMAGEDDON SOLAR EJECTION"
	color = COLOR_VIOLET
	light_color = COLOR_VIOLET
	timeleft = CME_ARMAGEDDON_BUBBLE_BURST_TIME
	cme_light_range_lower = CME_ARMAGEDDON_LIGHT_RANGE_LOWER
	cme_light_range_upper = CME_ARMAGEDDON_LIGHT_RANGE_UPPER
	cme_heavy_range_lower = CME_ARMAGEDDON_HEAVY_RANGE_LOWER
	cme_heavy_range_upper = CME_ARMAGEDDON_HEAVY_RANGE_UPPER

/obj/effect/cme/Initialize(mapload)
	. = ..()
	playsound(src,'sound/weapons/resonator_fire.ogg',75,TRUE)
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.atmos_spawn_air("o2=15;plasma=15;TEMP=5778")
	addtimer(CALLBACK(src, PROC_REF(burst)), timeleft)

/obj/effect/cme/proc/burst()
	if(neutralized)
		visible_message(span_notice("[src] fizzles out into nothingness."))
		new /obj/effect/particle_effect/fluid/smoke/bad(loc)
		qdel(src)
		return
	var/pulse_range_light = rand(cme_light_range_lower, cme_light_range_upper)
	var/pulse_range_heavy = rand(cme_heavy_range_lower, cme_heavy_range_upper)
	empulse(src, pulse_range_heavy, pulse_range_light)
	playsound(src,'sound/weapons/resonator_blast.ogg',100,TRUE)
	explosion(src, 0, 0, 2, flame_range = 3)
	playsound(src,'modular_skyrat/modules/cme/sound/cme.ogg', 100)
	qdel(src)

/obj/effect/cme/armageddon/burst()
	if(neutralized)
		visible_message(span_notice("[src] fizzles out into nothingness."))
		new /obj/effect/particle_effect/fluid/smoke/bad(loc)
		qdel(src)
		return
	var/pulse_range_light = rand(cme_light_range_lower, cme_light_range_upper)
	var/pulse_range_heavy = rand(cme_heavy_range_lower, cme_heavy_range_upper)
	empulse(src, pulse_range_heavy, pulse_range_light)
	explosion(src, 0, 3, 10, flame_range = 10)
	playsound(src,'sound/weapons/resonator_blast.ogg',100,TRUE)
	playsound(src,'modular_skyrat/modules/cme/sound/cme.ogg', 100)
	qdel(src)

/obj/effect/cme/singularity_pull()
	burst()

/obj/effect/cme/proc/anomalyNeutralize()
	playsound(src,'sound/weapons/resonator_blast.ogg',100,TRUE)
	new /obj/effect/particle_effect/fluid/smoke/bad(loc)
	color = COLOR_WHITE
	light_color = COLOR_WHITE
	neutralized = TRUE
	var/atom/movable/loot = pick_weight(GLOB.cme_loot_list)
	new loot(loc)

/obj/effect/cme/extreme/anomalyNeutralize()
	playsound(src,'sound/weapons/resonator_blast.ogg',100,TRUE)
	new /obj/effect/particle_effect/fluid/smoke/bad(loc)
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.atmos_spawn_air("o2=30;plasma=30;TEMP=5778")
	color = COLOR_WHITE
	light_color = COLOR_WHITE
	neutralized = TRUE
	var/atom/movable/loot = pick_weight(GLOB.cme_loot_list)
	new loot(loc)

/obj/effect/cme/armageddon/anomalyNeutralize()
	playsound(src,'sound/weapons/resonator_blast.ogg',100,TRUE)
	new /obj/effect/particle_effect/fluid/smoke/bad(loc)
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.atmos_spawn_air("o2=30;plasma=80;TEMP=5778")
	color = COLOR_WHITE
	light_color = COLOR_WHITE
	neutralized = TRUE
	var/atom/movable/loot = pick_weight(GLOB.cme_loot_list)
	new loot(loc)
