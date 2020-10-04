
//Skyrat hud aspects
/obj/screen/ammo_counter
	name = "ammo counter"
	icon = 'modular_skyrat/modules/gunsgalore/icons/hud/gun_hud.dmi'
	icon_state = "ammo_counter"
	screen_loc = ui_ammocounter
	invisibility = INVISIBILITY_ABSTRACT

/datum/hud/human/New(mob/living/carbon/human/owner)
	. = ..()
	ammo_counter = new /obj/screen/ammo_counter()
	ammo_counter.hud = src
	infodisplay += ammo_counter
