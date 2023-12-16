/obj/structure/showcase/fake_cafe_console
	name = "civilian console"
	desc = "A stationary computer. This one comes preloaded with generic programs."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fake_cafe_console/power
	name = "power monitoring console"
	desc = "It monitors power levels across the station."

/obj/structure/showcase/fake_cafe_console/power/Initialize(mapload)
	. = ..()
	add_overlay("power")
	add_overlay("power_key")

/obj/structure/showcase/fake_cafe_console/communications
	name = "communications console"
	desc = "A console used for high-priority announcements and emergencies."

/obj/structure/showcase/fake_cafe_console/communications/Initialize(mapload)
	. = ..()
	add_overlay("comm")
	add_overlay("tech_key")

/obj/structure/showcase/fake_cafe_console/rd
	name = "R&D Console"
	desc = "A console used to interface with R&D tools."

/obj/structure/showcase/fake_cafe_console/rd/Initialize(mapload)
	. = ..()
	add_overlay("rdcomp")
	add_overlay("rd_key")

