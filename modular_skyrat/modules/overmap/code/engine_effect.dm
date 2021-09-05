/datum/component/engine_effect
	/// Whether the shuttle is currently spewing exhaust fumes and playing a looped sound
	var/is_flaming = FALSE
	/// The time when we should stop processing, get's bumped up every time we get drawn thrust
	var/stop_flame_time = 0
	/// Our looped sound for when we are flaming
	var/datum/looping_sound/engine/looped_sound

/datum/component/engine_effect/Initialize()
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	looped_sound = new(list(parent), FALSE)

/datum/component/engine_effect/Destroy()
	if(is_flaming)
		StopFlaming()
	qdel(looped_sound)
	return ..()

/datum/component/engine_effect/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ENGINE_DRAWN_POWER, .proc/DrawnPower)

/datum/component/embedded/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ENGINE_DRAWN_POWER)

/datum/component/engine_effect/proc/DrawnPower()
	stop_flame_time = world.time + 3 SECONDS
	if(!is_flaming)
		StartFlaming()

/datum/component/engine_effect/proc/StartFlaming()
	is_flaming = TRUE
	looped_sound.start()
	START_PROCESSING(SSobj, src)
	DoFirePlume()

/datum/component/engine_effect/proc/StopFlaming()
	is_flaming = FALSE
	looped_sound.stop()
	STOP_PROCESSING(SSobj, src)

/datum/component/engine_effect/proc/DoFirePlume()
	var/atom/movable/movable_parent = parent
	var/turf/dump_place = get_turf(movable_parent)
	dump_place = get_step(dump_place,movable_parent.dir)
	if(!dump_place.is_blocked_turf(TRUE))
		new /datum/fireplume_controller(dump_place, movable_parent.dir)

/datum/component/engine_effect/process()
	if(world.time > stop_flame_time)
		StopFlaming()
		return
	if(prob(80))
		DoFirePlume()
