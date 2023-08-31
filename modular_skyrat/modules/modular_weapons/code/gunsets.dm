/*
*	GUNSET BOXES
*/

/obj/item/storage/box/gunset
	name = "gun case"
	desc = "A gun case with foam inserts laid out to fit a weapon, magazines, and gear securely."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "guncase"

	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	inhand_icon_state = "sec-case"

	illustration = null

	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF

	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'

	/// If the guncase sprite shows as visually being opened
	var/opened = FALSE
	/// If the guncase spawns with an ammo pouch
	var/comes_with_pouch = FALSE

//Add this extra line to examine() if you make an armadyne variant: "It has a textured carbon grip, and the <b>[span_red("Armadyne Corporation")]</b> logo etched into the top."

/obj/item/storage/box/gunset/PopulateContents()
	. = ..()
	if(comes_with_pouch)
		new /obj/item/storage/pouch/ammo(src)

/obj/item/storage/box/gunset/update_icon()
	. = ..()
	if(opened)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = initial(icon_state)

/obj/item/storage/box/gunset/AltClick(mob/user)
	. = ..()
	opened = !opened
	update_icon()

/obj/item/storage/box/gunset/attack_self(mob/user)
	. = ..()
	opened = !opened
	update_icon()
