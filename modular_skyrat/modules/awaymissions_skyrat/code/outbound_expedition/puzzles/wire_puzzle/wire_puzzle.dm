#define WIRE_MAX_LOWER 10
#define WIRE_MAX_UPPER 15
#define WIRE_UNCUT 0
#define WIRE_CUT 1

/* How the fuck wires work
There is a wireset
This wireset has a random amount of colored wires
the conditionals are created around this wireset
there should not be two different wiresets
*/

/datum/outbound_teamwork_puzzle/wires
	name = "Wires"
	tgui_name = "WirePuzzle"
	terminal_name = "wire panel"
	terminal_desc = "A maintenence panel with a latch, some wires are behind it."
	fail_system = "Power"
	/// list of initialized wire datums
	var/list/wires = list()
	/// assoc list of colors - to - wires
	var/list/colors = list()
	/// Max amount of wires possible
	var/wire_amount = OUTBOUND_WIRE_COUNT
	/// What colors of wires are possible
	var/static/list/wire_colors = OUTBOUND_WIRE_COLORS
	/// What wires need to be cut, by numerical position
	var/list/to_cut_wires = list()

/datum/outbound_teamwork_puzzle/wires/New()
	. = ..()
	generate_wires()

/datum/outbound_teamwork_puzzle/wires/proc/generate_wires()
	if(length(wires))
		for(var/datum/wire in wires)
			QDEL_NULL(wire)
		wires.Cut()
	if(length(colors))
		colors.Cut()
	if(length(to_cut_wires))
		to_cut_wires.Cut()
	var/list/possible_colors = wire_colors.Copy()
	for(var/wire_num in 1 to wire_amount)
		var/datum/outbound_puzzle_wire/new_wire = new
		var/picked_color = pick_n_take(possible_colors)
		colors[picked_color] = new_wire
		new_wire.color = picked_color
		wires += new_wire
	addtimer(CALLBACK(src, .proc/check_all_conditionals), 1 SECONDS)

/datum/outbound_teamwork_puzzle/wires/proc/check_all_conditionals()
	OUTBOUND_CONTROLLER
	for(var/datum/outbound_wire_conditional/conditional as anything in outbound_controller.puzzle_controller.wire_conditionals)
		conditional.conditional_check(wires)

/datum/outbound_teamwork_puzzle/wires/proc/wire_interact(datum/outbound_puzzle_wire/target_wire, mob/user, cut_or_pulse)
	OUTBOUND_CONTROLLER
	if(!length(to_cut_wires))
		for(var/datum/outbound_wire_conditional/wire_cond as anything in outbound_controller.puzzle_controller.wire_conditionals)
			for(var/wire_num as anything in wire_cond.acting_wires)
				var/datum/outbound_puzzle_wire/wire_indiv = wires[wire_num]
				if(to_cut_wires[wire_indiv])
					continue
				to_cut_wires[wire_indiv] = wire_cond.cut_or_pulse
	if(target_wire in to_cut_wires)
		var/req_method = to_cut_wires[target_wire]
		if(req_method != cut_or_pulse)
			wrong_wire()
			return
		to_cut_wires -= target_wire
	else
		wrong_wire()
		return
	if(!length(to_cut_wires))
		terminal.balloon_alert_to_viewers("wires fixed", vision_distance = 3)
		SEND_SIGNAL(outbound_controller.puzzle_controller, COMSIG_AWAY_PUZZLE_COMPLETED, src)

/datum/outbound_teamwork_puzzle/wires/proc/wrong_wire()
	OUTBOUND_CONTROLLER
	terminal.balloon_alert_to_viewers("wrong wire cut!")
	var/datum/outbound_ship_system/selected_sys = outbound_controller.ship_systems[fail_system]
	selected_sys.adjust_health(-fail_damage)

/datum/outbound_teamwork_puzzle/wires/ui_data(mob/user)
	var/list/data = list()
	var/list/payload = list()

	for(var/color in colors)
		var/datum/outbound_puzzle_wire/wire = colors[color]
		payload.Add(list(list(
			"color" = color,
			"wire" = REF(wire),
			"cut" = wire.cut,
			"pulsed" = wire.pulsed,
			"disabled" = !!(wire.cut || wire.pulsed)
		)))
	data["wires"] = payload
	return data

/datum/outbound_teamwork_puzzle/wires/ui_act(action, params)
	. = ..()

	var/datum/outbound_puzzle_wire/target_wire = locate(params["wire"])
	var/mob/living/living_usr = usr
	var/obj/item/tool_used
	switch(action)
		if("cut")
			tool_used = living_usr.is_holding_tool_quality(TOOL_WIRECUTTER)
			if(tool_used || isAdminGhostAI(usr))
				if(tool_used && terminal)
					tool_used.play_tool_sound(terminal, 20)
				wire_interact(target_wire, usr, action)
				. = TRUE
			else
				to_chat(living_usr, span_warning("You need wirecutters!"))
		if("pulse")
			tool_used = living_usr.is_holding_tool_quality(TOOL_MULTITOOL)
			if(tool_used || isAdminGhostAI(usr))
				if(tool_used && terminal)
					tool_used.play_tool_sound(terminal, 20)
				wire_interact(target_wire, usr, action)
				. = TRUE
			else
				to_chat(living_usr, span_warning("You need a multitool!"))

#undef WIRE_MAX_LOWER
#undef WIRE_MAX_UPPER
#undef WIRE_UNCUT
#undef WIRE_CUT
