/area/misc/emergency_tent
	name = "\improper Emergency Shelter"
	icon_state = "away"
	static_lighting = TRUE
	requires_power = TRUE
	has_gravity = STANDARD_GRAVITY

/datum/map_template/shelter/tent
	name = "Emergency Tent Shelter"
	shelter_id = "shelter_tent"
	description = "A flimsy structure for a flimsy living, \
	with a few iron wall support members holding up an inflatable \
	wall and airlocks, it's a miracle this thing can even manage \
	to keep the violent storms of the planet at bay."
	mappath = "_maps/skyrat/tent_capsule.dmm"

/obj/item/survivalcapsule/tent
	name = "emergency storm shelter deployment marker"
	desc = "Turns out that bluespace tech isn't all that expensive if all you use it for is a tent and some metal poles!"
	template_id = "shelter_tent"
