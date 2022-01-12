/*
	This extension attempts to delete an object when nobody is around to see it.
	The target atom is periodically checked for nearby viewers

	This is an expensive process, the interval is set quite long. A minute
*/
#define DELETE_UNSEEN(x)	set_extension(x, /datum/extension/delete_unseen)

/datum/extension/delete_unseen
	name = "delete_unseen"
	base_type = /datum/extension/delete_unseen
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/interval = 1 SECOND//MINUTE
	var/max_range = 20
	var/atom/subject


	var/ongoing_timer



/datum/extension/delete_unseen/New(var/atom/holder)
	.=..()
	subject = holder
	if (QDELETED(subject))
		stop()
		return
	start()

/datum/extension/delete_unseen/Destroy()
	if (ongoing_timer)
		deltimer(ongoing_timer)
		ongoing_timer = null

	subject = null

	.=..()

/datum/extension/delete_unseen/proc/start()
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/delete_unseen/proc/tick), interval, TIMER_STOPPABLE)


/datum/extension/delete_unseen/proc/tick()
	//Safety check first
	if (QDELETED(subject))
		stop()
		return

	//Alright, lets see if anyone is looking yet
	var/list/viewers = subject.get_viewers()
	if (!viewers.len)
		qdel(subject)
		stop()
	else
		ongoing_timer = addtimer(CALLBACK(src, /datum/extension/delete_unseen/proc/tick), interval, TIMER_STOPPABLE)



/datum/extension/delete_unseen/proc/stop()
	if (ongoing_timer)
		deltimer(ongoing_timer)
		ongoing_timer = null

	if (!QDELETED(subject))
		remove_extension(holder, base_type)

