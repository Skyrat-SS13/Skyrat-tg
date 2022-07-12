#define WIRE_MAX_LOWER 10
#define WIRE_MAX_UPPER 15
#define WIRE_UNCUT 0
#define WIRE_CUT 1

/* How the fuck wires work
There is a wireset
This wireset has a random amount of colored wires
the conditionals are created around this wireset
there should not be two different wiresets

latenight schizo: wires will need to be regenned each time the event occurs
conditionals are static, wires are not

*/


/datum/outbound_teamwork_puzzle/wires
	name = "Wires"
	tgui_name = "WirePuzzle"
	terminal_name = "wire panel"
	terminal_desc = "A maintenence panel with a latch, some wires are behind it."
	/// list of initialized wire datums
	var/list/wires = list()
	/// Max amount of wires possible
	var/wire_amount = OUTBOUND_WIRE_COUNT
	/// What colors of wires are possible
	var/static/list/wire_colors = OUTBOUND_WIRE_COLORS

/datum/outbound_teamwork_puzzle/wires/New()
	. = ..()
	generate_wires()

/datum/outbound_teamwork_puzzle/wires/proc/generate_wires()
	if(length(wires))
		for(var/datum/wire in wires)
			QDEL_NULL(wire)
		wires.Cut()
	for(var/wire_num in 1 to wire_amount)
		var/datum/outbound_puzzle_wire/new_wire = new
		new_wire.color = pick(wire_colors)
		wires += new_wire

#undef WIRE_MAX_LOWER
#undef WIRE_MAX_UPPER
#undef WIRE_UNCUT
#undef WIRE_CUT
