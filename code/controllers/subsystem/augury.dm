SUBSYSTEM_DEF(augury)
	name = "Augury"
	flags = SS_NO_INIT
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/watchers = list()
	var/list/doombringers = list()

	var/list/observers_given_action = list()

/datum/controller/subsystem/augury/stat_entry(msg)
	msg = "W:[watchers.len]|D:[length(doombringers)]"
	return ..()

/datum/controller/subsystem/augury/proc/register_doom(atom/A, severity)
	doombringers[A] = severity
	RegisterSignal(A, COMSIG_QDELETING, PROC_REF(unregister_doom))

/datum/controller/subsystem/augury/proc/unregister_doom(atom/A)
	SIGNAL_HANDLER
	UnregisterSignal(A, COMSIG_QDELETING)
	doombringers -= A

/datum/controller/subsystem/augury/fire()
	var/biggest_doom = null
	var/biggest_threat = null

	for(var/db in doombringers)
		var/datum/d = db
		if(!d || QDELETED(d))
			doombringers -= d
			continue
		var/threat = doombringers[d]
		if((biggest_threat == null) || (biggest_threat < threat))
			biggest_doom = d
			biggest_threat = threat

	if(doombringers.len)
		for(var/i in GLOB.player_list)
			if(isobserver(i) && (!(observers_given_action[i])))
				var/datum/action/innate/augury/A = new
				A.Grant(i)
				observers_given_action[i] = TRUE
	else
		for(var/i in observers_given_action)
			if(observers_given_action[i] && isobserver(i))
				var/mob/dead/observer/O = i
				for(var/datum/action/innate/augury/A in O.actions)
					qdel(A)
			observers_given_action -= i

	for(var/w in watchers)
		if(!w)
			watchers -= w
			continue
		var/mob/dead/observer/O = w
		if(biggest_doom && (!O.orbiting || O.orbiting.parent != biggest_doom))
			O.ManualFollow(biggest_doom)

/datum/action/innate/augury
	name = "Auto Follow Debris"
	button_icon = 'icons/obj/meteor.dmi'
	button_icon_state = "flaming"

/datum/action/innate/augury/Destroy()
	if(owner)
		SSaugury.watchers -= owner
	return ..()

/datum/action/innate/augury/Activate()
	SSaugury.watchers += owner
	to_chat(owner, span_notice("You are now auto-following debris."))
	active = TRUE

/datum/action/innate/augury/Deactivate()
	SSaugury.watchers -= owner
	to_chat(owner, span_notice("You are no longer auto-following debris."))
	active = FALSE
