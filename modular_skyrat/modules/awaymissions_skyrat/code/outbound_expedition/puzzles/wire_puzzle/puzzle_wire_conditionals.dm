/**
 * Conditionals are the orders to cut certain wires in certain scenarios for the wire cutting puzzle
 * There'll be a set of them that are created at roundstart, exactly how many, their order, and what they are is variable
 * They all follow the concept of "If X, do Y, else do Z"
 */


/datum/outbound_wire_conditional
	/// Text that describes the conditional
	var/desc = ""
	/// What wire(s) need to get cut or pulsed in the end
	var/list/acting_wires = list()
	/// Does this need cutting or pulsing
	var/cut_or_pulse = "cut"
	/// What wires does this check logic on
	var/list/logic_wires = list()

/datum/outbound_wire_conditional/New()
	. = ..()
	set_up_condition()

/// The check to see if it was right or wrong. Potentially depreciated.
/datum/outbound_wire_conditional/proc/conditional_check()
	return

/**
 * Creates the condition that should be met to cut a certain wire
 * Shouldn't be rerolled on an already-set conditional but has the capability to do so
*/
/datum/outbound_wire_conditional/proc/set_up_condition()
	SHOULD_CALL_PARENT(TRUE)
	cut_or_pulse = pick("pulse", "cut")
	acting_wires.Cut()
	desc = ""
	logic_wires.Cut()


////////////////////////////////////////////
//HOLY SHIT TEST THIS ENTIRE FILE THOROUGHLY
//THIS IS DONE AFTER A FIVE HOUR CODE BINGE, LIKELY NOT WORKING
////////////////////////////////////////////


// If certain wires are a certain color, cut X wire
/datum/outbound_wire_conditional/onecolor

/datum/outbound_wire_conditional/onecolor/set_up_condition()
	..()

	var/chosen_color = pick(OUTBOUND_WIRE_COLORS)

	var/wire_check = 0
	switch(rand(1, 10))
		if(1 to 4)
			wire_check = 1
		if(5 to 7)
			wire_check = 2
		if(8 to 9)
			wire_check = 3
		if(10)
			wire_check = 4

	var/list/selected_wires = list()
	for(var/i in 1 to wire_check)
		selected_wires |= rand(1, OUTBOUND_WIRE_COUNT)

	acting_wires |= rand(1, OUTBOUND_WIRE_COUNT)

	var/acting_wire_text = ""
	for(var/wire in acting_wires)
		acting_wire_text += "[wire][wire == acting_wires[length(acting_wires)] ? "" : (wire == acting_wires[length(acting_wires) - 1] ? " and " : ", ")]"

	var/wire_text = ""
	for(var/wire in selected_wires)
		wire_text += "[wire][wire == selected_wires[length(selected_wires)] ? "" : (wire == selected_wires[length(selected_wires) - 1] ? " or " : ", ")]"

	logic_wires.Insert(1, selected_wires)

	var/multiple_check = length(selected_wires) > 1 ? TRUE : FALSE
	desc = "If the wire[multiple_check ? "s" : ""] in the [wire_text] position[multiple_check ? "s are" : " is"] [chosen_color], then [cut_or_pulse] the [acting_wire_text]." //chosen_color will be a hexcode, fix later

// If certain wires are A, B, or C color, cut X wire
/datum/outbound_wire_conditional/multicolor

/datum/outbound_wire_conditional/multicolor/set_up_condition()
	..()

	var/color_check = 0
	switch(rand(1, 10))
		if(1 to 3)
			color_check = 2
		if(4 to 7)
			color_check = 3
		if(8 to 9)
			color_check = 4
		if(10)
			color_check = 5

	var/wire_check = 0
	switch(rand(1, 10))
		if(1 to 4)
			wire_check = 1
		if(5 to 7)
			wire_check = 2
		if(8 to 9)
			wire_check = 3
		if(10)
			wire_check = 4

	var/list/selected_wires = list()
	for(var/i in 1 to wire_check)
		selected_wires |= rand(1, OUTBOUND_WIRE_COUNT)

	var/list/selected_colors = list()
	for(var/i in 1 to color_check)
		selected_colors |= pick(OUTBOUND_WIRE_COLORS)

	acting_wires |= rand(1, OUTBOUND_WIRE_COUNT)
	var/acting_wire_text = ""

	for(var/wire in acting_wires)
		acting_wire_text += "[wire][wire == acting_wires[length(acting_wires)] ? "" : (wire == acting_wires[length(acting_wires) - 1] ? " and " : ", ")]"

	var/wire_text = ""
	for(var/wire in selected_wires)
		wire_text += "[wire][wire == selected_wires[length(selected_wires)] ? "" : (wire == selected_wires[length(selected_wires) - 1] ? " or " : ", ")]"

	var/color_text = ""
	for(var/color in selected_colors)
		color_text += "[color][color == selected_colors[length(selected_colors)] ? "" : (color == selected_colors[length(selected_colors) - 1] ? " or " : ", ")]]"

	logic_wires.Insert(1, selected_wires)

	var/multiple_check = length(selected_wires) > 1 ? TRUE : FALSE
	desc = "If the wire[multiple_check ? "s" : ""] in the [wire_text] position[multiple_check ? "s are" : " is"] [color_text], then [cut_or_pulse] the [acting_wire_text]." //chosen_color will be a hexcode, fix later

// If X wire is Y color, cut wires A, B, and C
/datum/outbound_wire_conditional/multiwire

/datum/outbound_wire_conditional/multiwire/set_up_condition()
	..()

	var/chosen_color = pick(OUTBOUND_WIRE_COLORS)
	var/chosen_wire = rand(1, OUTBOUND_WIRE_COUNT)

	var/acting_wire_check = 0
	switch(rand(1, 10))
		if(1 to 4)
			acting_wire_check = 1
		if(5 to 7)
			acting_wire_check = 2
		if(8 to 9)
			acting_wire_check = 3
		if(10)
			acting_wire_check = 4

	for(var/i in 1 to acting_wire_check)
		acting_wires |= rand(1, OUTBOUND_WIRE_COUNT)

	var/acting_wire_text = ""
	for(var/wire in acting_wires)
		acting_wire_text += "[wire][wire == acting_wires[length(acting_wires)] ? "" : (wire == acting_wires[length(acting_wires) - 1] ? " and " : ", ")]"

	logic_wires.Insert(1, chosen_wire)

	var/multiple_check = length(acting_wires) > 1 ? TRUE : FALSE
	desc = "If the wire in the [chosen_wire] position is [chosen_color], then [cut_or_pulse] the [acting_wire_text] wire[multiple_check ? "s" : ""]." //chosen_color will be a hexcode, fix later

// If the amount of wires is even, cut X, else cut Y
/datum/outbound_wire_conditional/evenorodd

/datum/outbound_wire_conditional/evenorodd/set_up_condition()
	..()

	var/even_wire = rand(1, OUTBOUND_WIRE_COUNT)
	var/odd_wire
	while(!odd_wire || (odd_wire == even_wire))
		odd_wire = rand(1, OUTBOUND_WIRE_COUNT)

	var/even_or_odd = pick("even", "odd")
	if(even_or_odd == "even")
		acting_wires |= even_wire
	else
		acting_wires |= odd_wire

	// No logic wires here

	desc = "If there are an even amount of wires, cut [even_wire], else cut [odd_wire]."
