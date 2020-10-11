/obj/item/after_throw()
	. = ..()
	playsound(loc, 'sound/weapons/punchmiss.ogg', (throwforce ? 50 : 25), TRUE, -1)
