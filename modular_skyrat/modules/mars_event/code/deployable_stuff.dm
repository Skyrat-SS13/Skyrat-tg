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

/obj/item/quickdeploy/barricade/plasteel/rtg
	name = "Deployable RTG"
	desc = "Contains one (1) advanced rtg for your power needs, do not use as emergency heater."
	thing_to_deploy = /obj/machinery/power/rtg/advanced

/obj/item/quickdeploy/barricade/plasteel/autolathe
	name = "Deployable Autolathe"
	desc = "Contains one flat packed autolathe, do not stick hands or advanced tools into material port."
	thing_to_deploy = /obj/machinery/autolathe

/obj/item/quickdeploy/barricade/plasteel/sleeper
	name = "Deployable Medical Sleeper"
	desc = "Contains one flat packed medical sleeper, warning, does not actually put patient to sleep."
	thing_to_deploy = /obj/machinery/sleeper

/obj/item/quickdeploy/barricade/plasteel/cryo
	name = "Deployable Cryostasis Pod"
	desc = "Contains one flat packed cryostasis pod, requires power to function, do not store frozen foods in here."
	thing_to_deploy = /obj/machinery/cryopod

/obj/item/quickdeploy/barricade/plasteel/hydroponics
	name = "Deployable Hydroponics Tray"
	desc = "Don't ask how we kept the water from spilling everywhere while this was packed up, you aren't payed to think like that."
	thing_to_deploy = /obj/machinery/hydroponics/constructable
