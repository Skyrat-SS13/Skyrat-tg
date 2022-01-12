/*
	this tiny extension is really just a holder for a timer handle

	It is applied to objects that undergo pixel movement. Their animate_movement var is set to NO_STEPS to disable movement sliding during this period.
	This var needs to be reset to SLIDE_STEPS after its done, or movement will be janky forevermore
	However, if it is reset immediately after doing the move, the animation still attempts to play for clients.

	So to make things look right, we need to wait a few brief moments until the move finishes, and THEN reset this var
*/

/datum/extension/reset_move_animation
	name = "Conditional move"
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE
	var/reset_handle
	var/atom/movable/AM

/datum/extension/reset_move_animation/New(var/datum/holder)
	.=..()
	AM = holder

/datum/extension/reset_move_animation/Destroy()
	if (reset_handle)
		deltimer(reset_handle)
		reset_handle = null
	AM = null
	.=..()

/datum/extension/reset_move_animation/proc/update(var/newtime)
	if (reset_handle)
		deltimer(reset_handle)

	reset_handle = addtimer(CALLBACK(src, /datum/extension/reset_move_animation/proc/finish), newtime, TIMER_STOPPABLE)


/datum/extension/reset_move_animation/proc/finish()
	//If the thing is still held in kinesis, we don't want to change this value yet
	if (AM.kinesis_gripped())
		update(4)
		return

	AM.reset_move_animation()

/proc/set_delayed_move_animation_reset(var/atom/movable/AM, var/time)
	var/datum/extension/reset_move_animation/RMA = get_or_create_extension(AM, /datum/extension/reset_move_animation)
	RMA.update(time)