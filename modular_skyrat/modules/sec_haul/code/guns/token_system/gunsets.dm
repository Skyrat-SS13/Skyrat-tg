///////////////
//GUNSET BOXES
//////////////

/obj/item/storage/box/gunset
	name = "gun supply box"
	desc = "A box with gun and ammo in. Remind me why you're seeing this again?"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "box_1"
	var/box_state = "box_1"
	var/opened = FALSE
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'
	foldable = FALSE
	illustration = null
	var/radial_icon = ""

/obj/item/storage/box/gunset/glock17/PopulateContents()
	. = ..()
	new /obj/item/storage/bag/ammo(src)

/obj/item/storage/box/gunset/Initialize(mapload)
	. = ..()
	var/box_type = rand(1, 5)
	box_state = "box_[box_type]"
	update_icon()

/obj/item/storage/box/gunset/update_icon()
	. = ..()
	if(opened)
		icon_state = "[box_state]-open"
	else
		icon_state = box_state

/obj/item/storage/box/gunset/AltClick(mob/user)
	. = ..()
	opened = TRUE
	update_icon()


/obj/item/storage/box/gunset/attack_self(mob/user)
	. = ..()
	opened = TRUE
	update_icon()

///////////////////
//GUN SETS
//////////////////

//Glock 17
/obj/item/storage/box/gunset/glock17
	name = "Glock-17 Gun Supply"
	radial_icon = "g17"

/obj/item/gun/ballistic/automatic/pistol/g17/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/glock17/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g17/nomag
	new /obj/item/ammo_box/magazine/multi_sprite/g17
	new /obj/item/ammo_box/magazine/multi_sprite/g17
	new /obj/item/ammo_box/magazine/multi_sprite/g17

//
