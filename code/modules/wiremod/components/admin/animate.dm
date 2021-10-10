#define COMP_ANIMATE_ATOM "Object"
#define COMP_ANIMATE_FILTER "Filter"

/obj/item/circuit_component/begin_animation
	display_name = "Begin Animation"
	desc = "Begins an animation on the target. Create animation steps by chaining \"Animation Step\" components off of the \"Perform Animation\" port."
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL|CIRCUIT_FLAG_INSTANT|CIRCUIT_FLAG_ADMIN

	var/datum/port/input/target

	var/datum/port/input/animation_loops

	var/datum/port/output/animate_event

/obj/item/circuit_component/begin_animation/populate_ports()
	target = add_input_port("Target", PORT_TYPE_ATOM)
	animation_loops = add_input_port("Loops", PORT_TYPE_NUMBER)
	animate_event = add_output_port("Perform Animation", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/begin_animation/input_received(datum/port/input/port, list/return_values)
	if(!target.value)
		return

	SScircuit_component.queue_instant_run()
	animate_event.set_output(COMPONENT_SIGNAL)
	var/list/result = SScircuit_component.execute_instant_run()

	if(!result)
		return

	var/atom/target_atom = target.value
<<<<<<< HEAD
	var/last_step_used_filter = FALSE
	if(result["animation_steps"])
		animate(target_atom, pixel_x = pixel_x, time = 0, loop = animation_loops.value, flags = ANIMATION_PARALLEL) //Just to start the animation
		for(var/list/step in result["animation_steps"])
			if(step["filter"])
				var/filter = target_atom.get_filter(step["filter"])
				if(filter)
					last_step_used_filter = TRUE
					animate(filter, step["vars"], time = step["time"], easing = step["easing"], flags = step["flags"])
					var/list/filter_params = target_atom.filter_data[step["filter"]]
					for(var/param in step["vars"])
						if(filter_params.Find(param))
							filter_params[param] = step["vars"][param]
			else
				if(last_step_used_filter)
					last_step_used_filter = FALSE
					animate(target_atom, step["vars"], time = step["time"], easing = step["easing"], flags = step["flags"])
				else
					animate(time = step["time"], step["vars"], easing = step["easing"], flags = step["flags"])
=======
	if(!isatom(target_atom))
		return

	var/target_for_animation = target_atom
	if(atom_or_filter.value == COMP_ANIMATE_FILTER)
		target_for_animation = target_atom.get_filter(filter_target.value)

	if(!target_for_animation)
		return

	if(!isatom(target_atom))
		return
	target_atom.datum_flags |= DF_VAR_EDITED

	var/extra_flags = NONE
	if(parallel.value)
		extra_flags |= ANIMATION_PARALLEL

	var/list/first_step = popleft(result["animation_steps"])
	animate(target_for_animation, time = first_step["time"], first_step["vars"], loop = animation_loops.value, easing = first_step["easing"], flags = first_step["flags"]|extra_flags)
	for(var/list/step as anything in result["animation_steps"])
		animate(time = step["time"], step["vars"], easing = step["easing"], flags = step["flags"])
		if(atom_or_filter.value == COMP_ANIMATE_FILTER)
			var/list/filter_params = target_atom.filter_data[filter_target.value]
			for(var/param in step["vars"])
				if(filter_params.Find(param))
					filter_params[param] = step["vars"][param]
>>>>>>> 0ebf4891ada (Fixes bugs with admin circuits, expands upon some admin circuit components and fixes duplicator runtiming when a port doesn't exist. (#61948))

/obj/item/circuit_component/animation_step
	display_name = "Animation Step"
	desc = "Perform a single animation step. The input of this component should be connected, directly or indirectly, to the \"Perform Animation\" port of a \"Begin Animation\" component."

	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL|CIRCUIT_FLAG_ADMIN

	var/datum/port/input/option/atom_or_filter

	var/datum/port/input/animation_variables

	var/datum/port/input/animation_filter

	var/datum/port/input/animation_time
	var/datum/port/input/animation_easing
	var/datum/port/input/animation_flags

/obj/item/circuit_component/animation_step/populate_options()
	var/static/list/component_options = list(
		COMP_ANIMATE_ATOM,
		COMP_ANIMATE_FILTER,
	)

	atom_or_filter = add_option_port("Target", component_options)

/obj/item/circuit_component/animation_step/populate_ports()
	animation_variables = add_input_port("Variables", PORT_TYPE_ASSOC_LIST(PORT_TYPE_STRING, PORT_TYPE_ANY), order = 1.66)
	animation_time = add_input_port("Time", PORT_TYPE_NUMBER, order = 1.66)
	animation_easing = add_input_port("Easing", PORT_TYPE_NUMBER, order = 1.66)
	animation_flags = add_input_port("Flags", PORT_TYPE_NUMBER, order = 1.66)

/obj/item/circuit_component/animation_step/pre_input_received(datum/port/input/port)
	if(port == atom_or_filter)
		if((atom_or_filter.value == COMP_ANIMATE_ATOM) && animation_filter)
			remove_input_port(animation_filter)
			animation_filter = null
		else if((atom_or_filter.value == COMP_ANIMATE_FILTER) && !animation_filter)
			animation_filter = add_input_port("Filter Name", PORT_TYPE_STRING, order = 1.33)

/obj/item/circuit_component/animation_step/input_received(datum/port/input/port, list/return_values)
	if(!return_values)
		return

	if(!return_values["animation_steps"])
		return_values["animation_steps"] = list()

	var/list/variables = animation_variables.value

	var/list/step = list(
		"vars" = variables.Copy(),
		"time" = animation_time.value,
		"easing" = animation_easing.value,
		"flags" = animation_flags.value
	)

	if(atom_or_filter.value == COMP_ANIMATE_FILTER)
		step["filter"] = animation_filter.value

	return_values["animation_steps"] += list(step)

#undef COMP_ANIMATE_ATOM
#undef COMP_ANIMATE_FILTER
