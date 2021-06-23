/obj/item/slimecross/charged/pyrite
	colour = "pyrite"
	effect_desc = "Creates a rainbow crayon."

/obj/item/slimecross/charged/pyrite/do_effect(mob/user)
	new /obj/item/toy/crayon/rainbow(src)
	user.visible_message(span_warning("[src] morphs into a narrow cylinder, gaining a rainbow tint!"))
	..()
