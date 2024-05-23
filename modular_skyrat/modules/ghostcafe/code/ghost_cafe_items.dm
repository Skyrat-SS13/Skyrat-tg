/obj/structure/showcase/fake_cafe_console
	name = "civilian console"
	desc = "A stationary computer. This one comes preloaded with generic programs."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fake_cafe_console/rd
	name = "R&D Console"
	desc = "A console used to interface with R&D tools."

/obj/structure/showcase/fake_cafe_console/rd/Initialize(mapload)
	. = ..()
	add_overlay("rdcomp")
	add_overlay("rd_key")

