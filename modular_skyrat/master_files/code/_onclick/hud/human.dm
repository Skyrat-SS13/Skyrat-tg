
//Skyrat hud aspects

/datum/hud/human/New(mob/living/carbon/human/owner)
	. = ..()
	ammo_counter = new /atom/movable/screen/ammo_counter()
	ammo_counter.hud = src
	infodisplay += ammo_counter
