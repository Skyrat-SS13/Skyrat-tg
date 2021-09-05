/obj/effect/abstract/fireplume
	icon = 'icons/effects/fireblue.dmi'
	icon_state = "fire_plume3"
	anchored = TRUE
	animate_movement = NO_STEPS
	move_resist = INFINITY
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 1.5
	light_color = LIGHT_COLOR_CYAN
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = GASFIRE_LAYER

#define FIREPLUME_EXPOSED_TEMP 500

/obj/effect/abstract/fireplume/Initialize(mapload, new_icon_state, new_dir)
	. = ..()
	if(new_icon_state)
		icon_state = "fire_plume[new_icon_state]"
	if(new_dir)
		dir = new_dir
	var/turf/my_turf = loc
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, src, loc_connections)
	for(var/atom/movable/AM in my_turf)
		AM.fire_act(FIREPLUME_EXPOSED_TEMP, CELL_VOLUME)
	QDEL_IN(src, 1 SECONDS)

/obj/effect/abstract/fireplume/proc/on_entered(datum/source, atom/movable/AM, oldLoc)
	SIGNAL_HANDLER
	AM.fire_act(FIREPLUME_EXPOSED_TEMP, CELL_VOLUME)

#undef FIREPLUME_EXPOSED_TEMP

#define FIREPLUME_RANGE_LOW 3
#define FIREPLUME_RANGE_HIGH 6

/datum/fireplume_controller
	var/dir
	var/turf/current_turf
	var/steps_taken = 0
	var/steps_to_take = 0
	var/state_to_set = 3

/datum/fireplume_controller/New(turf/our_turf, our_dir)
	current_turf = our_turf
	dir = our_dir
	steps_to_take = rand(FIREPLUME_RANGE_LOW, FIREPLUME_RANGE_HIGH)
	START_PROCESSING(SSfastprocess, src)
	new /obj/effect/abstract/fireplume(current_turf, state_to_set, dir)

/datum/fireplume_controller/process()
	var/turf/target_turf = get_step(current_turf,dir)
	steps_taken++
	state_to_set = max(1, state_to_set-1)
	if(steps_taken >= steps_to_take)
		qdel(src)
		return
	if(!TURFS_CAN_SHARE(current_turf, target_turf))
		return
	current_turf = target_turf
	new /obj/effect/abstract/fireplume(current_turf, state_to_set, dir)

/datum/fireplume_controller/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

#undef FIREPLUME_RANGE_LOW
#undef FIREPLUME_RANGE_HIGH
