/obj/item/clockwork/trap_placer/flipper
	name = "flipper"
	desc = "A steam powered rotating floor panel. When input is received it will fling anyone on top of it."
	icon_state = "pressure_sensor"
	result_path = /obj/structure/destructible/clockwork/trap/flipper

/obj/structure/destructible/clockwork/trap/flipper
	name = "flipper"
	desc = "A steam powered rotating floor panel. When input is received it will fling anyone on top of it."
	icon_state = "pressure_sensor"
	component_datum = /datum/component/clockwork_trap/flipper
	unwrench_path = /obj/item/clockwork/trap_placer/flipper
	COOLDOWN_DECLARE(flip_cooldown)

/obj/structure/destructible/clockwork/trap/flipper/proc/flip()
	if(!COOLDOWN_FINISHED(src, flip_cooldown))
		return
	COOLDOWN_START(src, flip_cooldown, 20 SECONDS)
	flick("flipper", src)
	for(var/atom/movable/movable_atom in get_turf(src))
		if(movable_atom.anchored)
			continue
		movable_atom.throw_at(get_edge_target_turf(src, dir), 6, 4)

/datum/component/clockwork_trap/flipper
	takes_input = TRUE

/datum/component/clockwork_trap/flipper/trigger()
	if(!..())
		return
	var/obj/structure/destructible/clockwork/trap/flipper/flipper_parent = parent
	flipper_parent.flip()
