/datum/scripture/create_structure/sigil_transmission
	name = "Sigil of Transmission"
	desc = "Summons a sigil of transmission, required to power clockwork structures. Will also charge clockwork cyborgs on top of it, and drain power from objects with power." //Readd mention of 2 invokers if you change it back
	tip = "Power structures using this."
	button_icon_state = "Sigil of Transmission"
	power_cost = 100
	invokation_time = 50
	invokation_text = list("Oh great holy one...", "your energy...", "the power of the holy light!")
	summoned_structure = /obj/structure/destructible/clockwork/sigil/transmission
	cogs_required = 0
	//invokers_required = 2
	category = SPELLTYPE_PRESERVATION
