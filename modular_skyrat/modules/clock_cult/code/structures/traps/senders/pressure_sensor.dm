/obj/item/clockwork/trap_placer/pressure_sensor
	name = "pressure plate"
	desc = "I wonder what happens if you step on it."
	icon_state = "pressure_sensor"
	result_path = /obj/structure/destructible/clockwork/trap/pressure_sensor

/obj/structure/destructible/clockwork/trap/pressure_sensor
	name = "pressure plate"
	desc = "I wonder what happens if you step on it."
	icon_state = "pressure_sensor"
	unwrench_path = /obj/item/clockwork/trap_placer/pressure_sensor
	component_datum = /datum/component/clockwork_trap/pressure_sensor
	alpha = 60
	layer = SIGIL_LAYER
	max_integrity = 5

/datum/component/clockwork_trap/pressure_sensor
	sends_input = TRUE

/datum/component/clockwork_trap/pressure_sensor/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddComponent(/datum/component/connect_loc_behalf, parent, loc_connections)

/datum/component/clockwork_trap/pressure_sensor/proc/on_entered(datum/source, atom/movable/entered_movable)
	SIGNAL_HANDLER

	//Item's in hands or boxes shouldn't trigger it
	if(!isturf(entered_movable.loc) || !isliving(entered_movable))
		return
	var/mob/living/entered_living = entered_movable
	if(!istype(entered_living))
		return
	if(IS_CLOCK(entered_living))
		return
	if(entered_living.incorporeal_move || (entered_living.movement_type & (FLOATING|FLYING)))
		return
	trigger_connected()
	for(var/obj/structure/destructible/clockwork/trap/clock_trap in get_turf(parent))
		if(clock_trap == parent)
			continue
		SEND_SIGNAL(clock_trap, COMSIG_CLOCKWORK_SIGNAL_RECEIVED)
	playsound(parent, 'sound/machines/click.ogg', 50)
