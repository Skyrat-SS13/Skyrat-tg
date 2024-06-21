GLOBAL_LIST_EMPTY(all_wormholes) // So we can pick wormholes to teleport to

/datum/round_event_control/wormholes
	name = "Wormholes"
	typepath = /datum/round_event/wormholes
	max_occurrences = 3
	weight = 2
	min_players = 2
	category = EVENT_CATEGORY_SPACE
	description = "Space time anomalies appear on the station, randomly teleporting people who walk into them."
	min_wizard_trigger_potency = 3
	max_wizard_trigger_potency = 7

/datum/round_event/wormholes
	announce_when = 10
	end_when = 60

	var/list/pick_turfs = list()
	var/list/wormholes = list()
	var/shift_frequency = 3
	var/number_of_wormholes = 400

/datum/round_event/wormholes/setup()
	announce_when = rand(0, 20)
	end_when = rand(40, 80)

/datum/round_event/wormholes/start()
	for(var/turf/open/floor/valid in GLOB.station_turfs)
		pick_turfs += valid

	for(var/i in 1 to number_of_wormholes)
		var/turf/T = pick(pick_turfs)
		wormholes += new /obj/effect/portal/wormhole(T, 0, null, FALSE)
		playsound(T, SFX_PORTAL_CREATED, 20, TRUE, SILENCED_SOUND_EXTRARANGE) // much much quieter

/datum/round_event/wormholes/announce(fake)
	priority_announce("Space-time anomalies detected on the station. There is no additional data.", "Anomaly Alert", ANNOUNCER_SPANOMALIES)

/datum/round_event/wormholes/tick()
	if(activeFor % shift_frequency == 0)
		for(var/obj/effect/portal/wormhole/O as anything in wormholes)
			var/turf/T = pick(pick_turfs)
			if(isopenturf(T))
				O.forceMove(T)
				playsound(T, SFX_PORTAL_CREATED, 20, TRUE, SILENCED_SOUND_EXTRARANGE)

/datum/round_event/wormholes/end()
	QDEL_LIST(wormholes)
	wormholes = null

/obj/effect/portal/wormhole
	name = "wormhole"
	desc = "It looks highly unstable; It could close at any moment."
	icon = 'icons/obj/anomaly.dmi'
	icon_state = "anom"
	mech_sized = TRUE
	light_on = FALSE
	wibbles = FALSE

/obj/effect/portal/wormhole/Initialize(mapload, _creator, _lifespan = 0, obj/effect/portal/_linked, automatic_link = FALSE, turf/hard_target_override)
	. = ..()
	GLOB.all_wormholes += src

/obj/effect/portal/wormhole/Destroy()
	. = ..()
	GLOB.all_wormholes -= src

/obj/effect/portal/wormhole/teleport(atom/movable/M)
	if(iseffect(M)) //sparks don't teleport
		return
	if(M.anchored)
		if(!(ismecha(M) && mech_sized))
			return

	if(ismovable(M))
		if(GLOB.all_wormholes.len)
			var/obj/effect/portal/wormhole/P = pick(GLOB.all_wormholes)
			if(P && isturf(P.loc))
				hard_target = P.loc
		if(!hard_target)
			return
		var/turf/start_turf = get_turf(M)
		if(do_teleport(M, hard_target, 1, null, null, channel = TELEPORT_CHANNEL_WORMHOLE)) ///You will appear adjacent to the beacon
			playsound(start_turf, SFX_PORTAL_ENTER, 50, 1, SHORT_RANGE_SOUND_EXTRARANGE)
			playsound(hard_target, SFX_PORTAL_ENTER, 50, 1, SHORT_RANGE_SOUND_EXTRARANGE)
