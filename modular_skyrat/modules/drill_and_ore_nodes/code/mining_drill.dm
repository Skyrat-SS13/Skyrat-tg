#define DRILL_MINING_SPEED 40
#define DRILL_ACTIVE_POWER_USAGE 300

/obj/machinery/power/mining_drill
	name = "mining drill"
	desc = "A colossal machine for drilling deep into ground for ores. Make sure there's actually ore underneath, unless you want to mine dust. Needs atleast 2 braces to operate properly. Can be connected to an external source through a terminal, or work off a cell."
	icon = 'icons/obj/machines/mining_drill.dmi'
	icon_state = "mining_drill"
	use_power = NO_POWER_USE
	layer = ABOVE_MOB_LAYER
	idle_power_usage = 0
	active_power_usage = DRILL_ACTIVE_POWER_USAGE
	max_integrity = 200
	integrity_failure = 0.25
	damage_deflection = 10
	resistance_flags = FIRE_PROOF
	interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON

	circuit = /obj/item/circuitboard/machine/mining_drill

	anchored = FALSE
	density = TRUE

	/// Whether it can have external power connected
	var/can_have_external_power = TRUE

	/// Is it active
	var/active = FALSE
	/// Is it powered
	var/powered = FALSE

	/// Reference to our cell
	var/obj/item/stock_parts/cell/cell
	/// Type of the starting cell, if any
	var/starting_cell
	/// Reference to the terminal, for external power
	var/obj/machinery/power/terminal/terminal

	/// Reference to the current ore node we're taking ores from
	var/datum/ore_node/current_node

	/// Speed of mining
	var/mining_speed = DRILL_MINING_SPEED
	/// Direction of the outputted ore
	var/ore_output_direction = SOUTH
	/// Stored ores, for the purpose of batching the mining
	var/list/stored_ores = list()
	/// Used as a timer for dumping the ore
	var/dump_ticker = 0
	/// Used as a timer for mining the ore
	var/mining_progress_ticker = 0

	/// How many braces do we require
	var/required_braces = 2
	/// References to the connected braces
	var/list/connected_braces = list()

	/// Whether we have "errored", means we couldnt find an ore node
	var/errored = FALSE

	/// Whether we use "simple" icon states
	var/simple_icon_states = FALSE

	/// Our sound loop
	var/datum/looping_sound/drill/soundloop

/obj/machinery/power/mining_drill/Destroy()
	QDEL_NULL(soundloop)
	on_deconstruction()
	return ..()

/obj/machinery/power/mining_drill/on_deconstruction()
	dump_ore()
	for(var/i in connected_braces)
		var/obj/machinery/mining_brace/brace = i
		brace.disconnect()
	if(terminal)
		disconnect_terminal()
	if(cell)
		cell.forceMove(get_turf(src))
		cell = null
	if(current_node)
		UnregisterNode()

/obj/machinery/power/mining_drill/proc/RegisterNode(datum/ore_node/node)
	current_node = node
	RegisterSignal(current_node, COMSIG_PARENT_QDELETING, .proc/UnregisterNode)

/obj/machinery/power/mining_drill/proc/UnregisterNode()
	UnregisterSignal(current_node, COMSIG_PARENT_QDELETING, .proc/UnregisterNode)
	current_node = null

/obj/machinery/power/mining_drill/examine(mob/user)
	. = ..()
	if(!powered)
		. += "<span class='warning'>It's not powered.</span>"
	if(required_braces > length(connected_braces))
		. += "<span class='warning'>It's not braced sufficiently.</span>"

/obj/machinery/power/mining_drill/update_icon_state()
	. = ..()
	if(simple_icon_states)
		if(panel_open)
			icon_state = "[initial(icon_state)]_open"
		else if(active && powered && current_node)
			icon_state = "[initial(icon_state)]_active"
		else
			icon_state = initial(icon_state)
		return
	if(panel_open)
		icon_state = "[initial(icon_state)]_open"
	else if(active)
		if(!current_node || !powered)
			icon_state = "[initial(icon_state)]_error"
		else
			var/remaining_ore = current_node.GetRemainingOreAmount()
			var/status = 3
			switch(remaining_ore)
				if(0 to 20)
					status = 3
				if(21 to 40)
					status = 2
				if(41 to 60)
					status = 1
				if(61 to INFINITY)
					status = 0
			icon_state = "[initial(icon_state)]_active[status]"
	else if(anchored)
		icon_state = "[initial(icon_state)]_braced"
	else
		icon_state = initial(icon_state)

/obj/machinery/power/mining_drill/attack_hand(mob/living/carbon/human/user)
	add_fingerprint(user)
	if(panel_open && cell)
		cell.update_icon()
		cell.add_fingerprint(user)
		user.put_in_active_hand(cell)
		to_chat(user, "<span class='notice'>You remove \the [cell].</span>")
		cell = null
		return
	else
		playsound(src, 'sound/machines/microwave/microwave-start.ogg', 50, TRUE) //Couldnt find a better one
		if(active)
			to_chat(user, "<span class='notice'>You turn off [src].</span>")
			turn_off()
		else
			if(panel_open)
				to_chat(user, "<span class='warning'>Close the maintenance panel first!</span>")
			else if(length(connected_braces) < required_braces)
				to_chat(user, "<span class='warning'>\The [src] is not braced sufficiently.</span>")
			else
				to_chat(user, "<span class='notice'>You turn on [src].</span>")
				turn_on()
	return ..()

/obj/machinery/power/mining_drill/attackby(obj/item/W, mob/user, params)
	if(panel_open && can_have_external_power && !terminal && istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/S = W
		if(S.use(5))
			var/tdir = get_dir(user, src)
			terminal = new /obj/machinery/power/terminal(get_turf(user))
			terminal.setDir(tdir)
			terminal.master = src
			to_chat(user, "<span class='notice'>You connect a terminal to [src].</span>")
		else
			to_chat(user, "<span class='warning'>You need 5 cables to wire a terminal for [src].</span>")
		return
	if(panel_open && !cell && istype(W, /obj/item/stock_parts/cell))
		cell = W
		cell.forceMove(src)
		to_chat(user, "<span class='notice'>You insert the cell inside [src].</span>")
		return
	return ..()

/obj/machinery/power/mining_drill/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(active)
		to_chat(user, "<span class='warning'>Turn it off first!</span>")
		return TRUE
	default_deconstruction_screwdriver(user, initial(icon_state), initial(icon_state), I)
	update_icon()
	return TRUE

/obj/machinery/power/mining_drill/Initialize()
	. = ..()
	if(starting_cell)
		cell = new starting_cell
	soundloop = new(list(src), FALSE)
	update_icon()

/obj/machinery/power/mining_drill/proc/pass_power_check()
	if(terminal && terminal.avail() > active_power_usage)
		add_load(active_power_usage)
		return TRUE
	if(cell && cell.charge > active_power_usage)
		cell.charge -= active_power_usage
		return TRUE
	return FALSE

/obj/machinery/power/mining_drill/process()
	if(machine_stat & (BROKEN))
		return
	if(!active)
		return
	//Try power
	if(!active_power_usage || pass_power_check())
		if(!powered)
			powered = TRUE
			playsound(src, 'sound/machines/piston_lower.ogg', 30, TRUE)
			update_icon()
			soundloop.start()
	else
		if(powered)
			powered = FALSE
			playsound(src, 'sound/machines/piston_raise.ogg', 30, TRUE)
			dump_ore()
			update_icon()
			soundloop.stop()
		return

	if(errored)
		return
	//Mine!
	mining_progress_ticker += mining_speed
	if(mining_progress_ticker > 100)
		mining_progress_ticker -= 100
		//Try find node if not connected
		if(!current_node)
			var/datum/ore_node/node = GetNearbyOreNode(get_turf(src))
			if(!node)
				errored = TRUE
				dump_ore()
				update_icon()
				return
			RegisterNode(node)
			update_icon()
		//Mine ore
		if(current_node)
			var/obj/item/mined = current_node.TakeRandomOre()
			if(mined)
				stored_ores += mined
		//Dump if got enough
		dump_ticker++
		if(dump_ticker > 5)
			dump_ore()

/obj/machinery/power/mining_drill/disconnect_terminal()
	if(terminal)
		terminal.master = null
		terminal = null

/obj/machinery/power/mining_drill/wirecutter_act(mob/living/user, obj/item/W)
	. = ..()
	if(terminal && panel_open)
		new /obj/item/stack/cable_coil(get_turf(src), 5)
		terminal.dismantle(user, W)
		return TRUE

/obj/machinery/power/mining_drill/proc/turn_on()
	active = TRUE
	update_icon()
	if(powered)
		soundloop.start()

/obj/machinery/power/mining_drill/proc/turn_off()
	active = FALSE
	errored = FALSE
	dump_ore()
	update_icon()
	if(powered)
		soundloop.stop()

/obj/machinery/power/mining_drill/proc/dump_ore()
	dump_ticker = 0
	var/any_dumps = FALSE
	for(var/i in stored_ores)
		var/obj/item/ITEM = i
		var/turf/T = get_turf(src)
		var/turf/step_turf = get_step(T, ore_output_direction)
		ITEM.forceMove(T)
		if(step_turf)
			ITEM.forceMove(step_turf)
		any_dumps = TRUE
	if(any_dumps)
		playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE)
	stored_ores.Cut()

/obj/machinery/power/mining_drill/ComponentInitialize()
	. = ..()
	//Very mechanical, so EMP proof
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/power/mining_drill/get_cell()
	return cell

/obj/machinery/power/mining_drill/connect_to_network()
	if(terminal)
		terminal.connect_to_network()

/obj/machinery/power/mining_drill/surplus()
	if(terminal)
		return terminal.surplus()
	else
		return 0

/obj/machinery/power/mining_drill/add_load(amount)
	if(terminal?.powernet)
		terminal.add_load(amount)

/obj/machinery/power/mining_drill/avail(amount)
	if(terminal)
		return terminal.avail(amount)
	else
		return 0

/obj/machinery/power/mining_drill/disconnect_terminal()
	if(terminal)
		terminal.master = null
		terminal = null

/obj/machinery/power/mining_drill/RefreshParts()
	var/new_mining_speed = DRILL_MINING_SPEED
	var/new_power_usage = DRILL_ACTIVE_POWER_USAGE
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		new_mining_speed += 5 * L.rating
		new_power_usage += 10 * L.rating
	mining_speed = new_mining_speed
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		new_power_usage -= 10 * M.rating
	active_power_usage = new_power_usage

/obj/machinery/power/mining_drill/cell
	starting_cell = /obj/item/stock_parts/cell/high

/obj/machinery/power/mining_drill/old
	name = "old mining drill"
	desc = "An old mining drill, with a deep well that you can't see the end of."
	icon_state = "mining_drill_old"
	anchored = TRUE
	starting_cell = /obj/item/stock_parts/cell/high/empty
	required_braces = 0
	simple_icon_states = TRUE

/obj/item/circuitboard/machine/mining_drill
	name = "Mining Drill (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/power/mining_drill
	req_components = list(
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stock_parts/manipulator = 3)
	needs_anchored = FALSE

#undef DRILL_MINING_SPEED
#undef DRILL_ACTIVE_POWER_USAGE

/obj/machinery/mining_brace
	name = "mining brace"
	desc = "A machinery brace for an industrial drill. It looks easily two feet thick."
	icon = 'icons/obj/machines/mining_drill.dmi'
	icon_state = "mining_brace"
	use_power = NO_POWER_USE
	layer = ABOVE_MOB_LAYER
	resistance_flags = FIRE_PROOF

	circuit = /obj/item/circuitboard/machine/mining_brace

	anchored = FALSE
	density = TRUE

	var/obj/machinery/power/mining_drill/connected_drill

/obj/machinery/mining_brace/update_icon_state()
	. = ..()
	if(anchored)
		icon_state = "mining_brace_active"
	else
		icon_state = "mining_brace"

/obj/machinery/mining_brace/wrench_act(mob/living/user, obj/item/item)
	if(anchored)
		//Try and disconnect
		if(connected_drill && connected_drill.active)
			to_chat(user, "<span class='warning'>Turn off the drill first!</span>")
		default_unfasten_wrench(user, item, 0)
		disconnect()
	else
		//Try and connect
		var/turf/step_turf = get_step(get_turf(src), dir)
		var/obj/machinery/power/mining_drill/found_drill = locate(/obj/machinery/power/mining_drill) in step_turf
		if(found_drill && found_drill.required_braces)
			default_unfasten_wrench(user, item, 0)
			connect(found_drill)
		else
			to_chat(user, "<span class='warning'>There's no drill to connect to!</span>")
	update_icon()
	return TRUE

/obj/machinery/mining_brace/Destroy()
	on_deconstruction()
	return ..()

/obj/machinery/mining_brace/on_deconstruction()
	if(connected_drill)
		disconnect()
	return ..()

/obj/machinery/mining_brace/proc/disconnect()
	connected_drill.connected_braces -= src
	if(!length(connected_drill.connected_braces))
		connected_drill.anchored = FALSE
		connected_drill.update_icon()
	else if (length(connected_drill.connected_braces) < connected_drill.required_braces)
		connected_drill.turn_off()
	connected_drill = null
	anchored = FALSE

/obj/machinery/mining_brace/proc/connect(obj/machinery/power/mining_drill/passed_drill)
	connected_drill = passed_drill
	connected_drill.connected_braces += src
	connected_drill.anchored = TRUE
	anchored = TRUE
	connected_drill.update_icon_state()

/obj/machinery/mining_brace/ComponentInitialize()
	. = ..()
	//Very mechanical, so EMP proof
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, .proc/can_be_rotated))

/obj/machinery/mining_brace/proc/can_be_rotated(mob/user, rotation_type)
	if(anchored)
		to_chat(user, "<span class='warning'>Disconnect it first!</span>")
		return FALSE
	return TRUE

/obj/item/circuitboard/machine/mining_brace
	name = "Mining Brace (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/mining_brace
	req_components = list()
	needs_anchored = FALSE
