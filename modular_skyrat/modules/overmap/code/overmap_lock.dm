/obj/effect/overlay/lock_effect
	icon = 'modular_skyrat/modules/overmap/icons/targeted.dmi'
	icon_state = "locking"
	layer = FLY_LAYER
	plane = GAME_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	mouse_opacity = 0

/datum/overmap_lock
	var/datum/overmap_object/target
	var/datum/overmap_object/shuttle/parent
	var/obj/effect/overlay/lock_effect/effect

	var/is_calibrated = FALSE

/datum/overmap_lock/proc/Resolve()
	var/distance = TWO_POINT_DISTANCE(target.x,target.y,parent.x,parent.y)
	if(distance > OVERMAP_LOCK_RANGE)
		qdel(src)
		return FALSE
	return TRUE

/datum/overmap_lock/New(source, aimed)
	parent = source
	parent.lock = src
	target = aimed
	effect = new
	target.my_visual.vis_contents += effect
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/Destroy)
	RegisterSignal(target, COMSIG_PARENT_QDELETING, .proc/Destroy)

	addtimer(CALLBACK(src, .proc/Calibrate), 3 SECONDS)

/datum/overmap_lock/Destroy()
	parent.LockLost()
	target.my_visual.vis_contents -= effect
	qdel(effect)
	UnregisterSignal(parent, COMSIG_PARENT_QDELETING)
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	parent.lock = null
	target = null
	return ..()

/datum/overmap_lock/proc/Calibrate()
	if(QDELETED(src))
		return
	is_calibrated = TRUE
	effect.icon_state = "locked"
