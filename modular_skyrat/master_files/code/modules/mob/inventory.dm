/mob/dropItemToGround(obj/item/I, force = FALSE, silent = FALSE) //No random pos on ground pls.
	. = ..()
	if(. && I)
		I.pixel_x = 0
		I.pixel_y = 0
