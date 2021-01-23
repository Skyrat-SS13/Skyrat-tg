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

///////////////////////////////SECURITY

//Glock 17
/obj/item/storage/box/gunset/glock17
	name = "glock-17 supply box"

/obj/item/gun/ballistic/automatic/pistol/g17/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/glock17/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g17/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17/rubber(src)

/obj/item/storage/box/gunset/glock18_hos
	name = "glock-18 supply box"

/obj/item/gun/ballistic/automatic/pistol/g18/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/glock18_hos/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g18/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/hp(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/hp(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/ihdf(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/ihdf(src)

//HOP
/obj/item/storage/box/gunset/pcr
	name = "a-3 pcr supply box"

/obj/item/gun/ballistic/automatic/pcr/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pcr/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pcr/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)

/obj/item/storage/box/gunset/norwind
	name = "lg-2 norwind supply box"

/obj/item/gun/ballistic/automatic/norwind/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/norwind/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/norwind/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)


/////////////////////////////COMMAND

//CAPTAIN
/obj/item/storage/box/gunset/pdh_captain
	name = "pdh 'socom' supply box"

/obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_captain/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/ihdf(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/ihdf(src)

//HOP
/obj/item/storage/box/gunset/pdh_hop
	name = "pdh 'osprey' supply box"

/obj/item/gun/ballistic/automatic/pistol/pdh/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_hop/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src)
