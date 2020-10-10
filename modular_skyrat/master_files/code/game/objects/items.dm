/obj/item/after_throw()
	. = ..()
	playsound(loc, 'sound/weapons/punchmiss.ogg', 50, TRUE, -1)
