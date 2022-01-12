/*
	A simple subclass that implements some standard updating behaviour

	useful for statmods that can occasionally change their effects
*/

/datum/extension/updating
	var/update_timer
	flags = EXTENSION_FLAG_IMMEDIATE

/datum/extension/updating/New(var/atom/holder)
	.=..()
	Initialize()
	update()

/datum/extension/updating/proc/Initialize()

/datum/extension/updating/proc/update()


/datum/extension/updating/proc/schedule_update()
	if (update_timer)
		return

	update_timer = addtimer(CALLBACK(src, /datum/extension/updating/proc/scheduled_update),1,TIMER_STOPPABLE)

//Safety check here
/datum/extension/updating/proc/scheduled_update()
	if(update_timer)
		deltimer(update_timer)
		update_timer = null

	if (!QDELETED(holder) && !QDELETED(src))
		update()

//Pings an extension for update
/datum/proc/update_extension(var/etype, var/instant = FALSE)
	var/datum/extension/updating/E = get_or_create_extension(src, etype)
	if (instant)
		E.update()
	else
		E.schedule_update()


