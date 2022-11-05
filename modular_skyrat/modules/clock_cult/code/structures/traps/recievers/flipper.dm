/obj/item/clockwork/trap_placer/flipper
	name = "flipper"
	desc = "A steam powered rotating floor panel. When input is received it will fling anyone on top of it."
	icon_state = "pressure_sensor"
	result_path = /obj/structure/destructible/clockwork/trap/flipper
	clockwork_desc = "A floor panel capable of flinging anyone back when triggered."

/obj/structure/destructible/clockwork/trap/flipper
	name = "flipper"
	desc = "A steam powered rotating floor panel. When input is received it will fling anyone on top of it."
	icon_state = "pressure_sensor"
	component_datum = /datum/component/clockwork_trap/flipper
	unwrench_path = /obj/item/clockwork/trap_placer/flipper
	clockwork_desc = "A floor panel capable of flinging anyone back when triggered. However, it does have a cooldown between uses."
	COOLDOWN_DECLARE(flip_cooldown)
	/// Time between possible flips
	var/cooldown_flip = 10 SECONDS

/obj/structure/destructible/clockwork/trap/flipper/examine(mob/user)
	. = ..()

	if(!COOLDOWN_FINISHED(src, flip_cooldown) && IS_CLOCK(user))
		. += span_brass("It's not ready to activate again yet!")

/obj/structure/destructible/clockwork/trap/flipper/proc/flip()
	if(!COOLDOWN_FINISHED(src, flip_cooldown))
		return
	COOLDOWN_START(src, flip_cooldown, cooldown_flip)
	addtimer(CALLBACK(src, .proc/cooldown_done), cooldown_flip)

	flick("flipper", src)

	for(var/atom/movable/movable_atom in get_turf(src))

		if(movable_atom.anchored)
			continue

		movable_atom.throw_at(get_edge_target_turf(src, dir), 6, 3)

/obj/structure/destructible/clockwork/trap/flipper/proc/cooldown_done()
	visible_message(span_brass("[src] whirrs with a loud *CLANK* as it resets."))

/datum/component/clockwork_trap/flipper
	takes_input = TRUE

/datum/component/clockwork_trap/flipper/trigger()
	if(!..())
		return

	var/obj/structure/destructible/clockwork/trap/flipper/flipper_parent = parent
	flipper_parent.flip()
