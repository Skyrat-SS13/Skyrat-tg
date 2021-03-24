///////////////
//GUNSET BOXES
//////////////

/obj/item/storage/box/gunset
	name = "gun supply box"
	desc = "An Armadyne weapons supply box."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "box"
	var/box_state = "box"
	var/opened = FALSE
	inhand_icon_state = "sec-case"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_BULKY
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'
	foldable = FALSE
	illustration = null

/obj/item/storage/box/gunset/PopulateContents()
	. = ..()
	new /obj/item/storage/bag/ammo(src)
	new /obj/item/gun_maintenance_supplies(src)

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


/////////////////
//SIDEARM TOKEN GUNSETS
////////////////

//G-17
/obj/item/storage/box/gunset/glock17
	name = "glock-17 supply box"

/obj/item/gun/ballistic/automatic/pistol/g17/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/glock17/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g17/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)

//LADON
/obj/item/storage/box/gunset/ladon
	name = "p-3 ladon supply box"

/obj/item/gun/ballistic/automatic/pistol/ladon/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/ladon/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/ladon/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon(src)

//PDH
/obj/item/storage/box/gunset/pdh_peacekeeper
	name = "pdh peacekeeper supply box"

/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_peacekeeper/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)

// MK-58
/obj/item/storage/box/gunset/ladon
	name = "mk-58 supply box"

/obj/item/gun/ballistic/automatic/pistol/mk58/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/mk58/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/mk58/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58(src)
	new /obj/item/ammo_box/magazine/multi_sprite/mk58(src)

//CROON
/obj/item/storage/box/gunset/croon
	name = "mk-58 supply box"

/obj/item/gun/ballistic/automatic/croon/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/croon/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/croon/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon(src)
	new /obj/item/ammo_box/magazine/multi_sprite/croon(src)

//MAKAROV
/obj/item/storage/box/gunset/makarov
	name = "makarov supply box"

/obj/item/gun/ballistic/automatic/pistol/makarov/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/makarov/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/makarov/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)

//DOZER
/obj/item/storage/box/gunset/dozer
	name = "dozer supply box"

/obj/item/gun/ballistic/automatic/dozer/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/dozer/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/dozer/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer(src)
	new /obj/item/ammo_box/magazine/multi_sprite/dozer(src)

//ZETA
/obj/item/storage/box/gunset/zeta
	name = "zeta supply box"

/obj/item/storage/box/gunset/zeta/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/zeta(src)
	new /obj/item/ammo_box/revolver/multi_sprite/zeta(src)
	new /obj/item/ammo_box/revolver/multi_sprite/zeta(src)

//REVOLUTION
/obj/item/storage/box/gunset/revolution
	name = "revolution supply box"

/obj/item/storage/box/gunset/revolution/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/revolution(src)
	new /obj/item/ammo_box/revolver/multi_sprite/revolution(src)
	new /obj/item/ammo_box/revolver/multi_sprite/revolution(src)


/////////////////
//PRIMARY TOKEN GUNSETS
////////////////
/obj/item/storage/box/gunset/pcr
	name = "a-3 pcr supply box"

/obj/item/gun/ballistic/automatic/pcr/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pcr/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pcr/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pcr(src)

/obj/item/storage/box/gunset/norwind
	name = "lg-2 norwind supply box"

/obj/item/gun/ballistic/automatic/norwind/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/norwind/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/norwind/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/norwind(src)

/obj/item/storage/box/gunset/ostwind
	name = "ostwind supply box"

/obj/item/gun/ballistic/automatic/ostwind/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/ostwind/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/ostwind/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ostwind(src)

/obj/item/storage/box/gunset/vintorez
	name = "vintorez supply box"

/obj/item/gun/ballistic/automatic/vintorez/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/vintorez/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/vintorez/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/vintorez(src)
	new /obj/item/ammo_box/magazine/multi_sprite/vintorez(src)
	new /obj/item/ammo_box/magazine/multi_sprite/vintorez(src)
	new /obj/item/ammo_box/magazine/multi_sprite/vintorez(src)

/obj/item/storage/box/gunset/pitbull
	name = "pitbull supply box"

/obj/item/gun/ballistic/automatic/pitbull/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pitbull/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pitbull/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pitbull(src)

/////////////////
//JOB SPECIFIC GUNSETS
////////////////

//CAPTAIN
/obj/item/storage/box/gunset/pdh_captain
	name = "pdh 'socom' supply box"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_captain/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/alt/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)

//HOS
/obj/item/storage/box/gunset/glock18_hos
	name = "glock-18 supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/g18/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/glock18_hos/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g18/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/hp(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18/hp(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g18(src)

//HOP
/obj/item/storage/box/gunset/pdh_hop
	name = "pdh 'osprey' supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/pdh/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_hop/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh/rubber(src) //HOP gets one mag of rubbers.
	new /obj/item/ammo_box/magazine/multi_sprite/pdh(src)

//CORPO
/obj/item/storage/box/gunset/pdh_corpo
	name = "pdh 'corporate' supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/pdh/corpo/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/pdh_corpo/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/corpo/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo(src)


//SECURITY MEDIC
/obj/item/storage/box/gunset/security_medic
	name = "firefly supply box"
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/gun/ballistic/automatic/pistol/firefly/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/security_medic/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/firefly/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/firefly/ihdf(src) //Medic gets one mag of IHDF due to prisoners/etc being rowdy.
	new /obj/item/ammo_box/magazine/multi_sprite/firefly/rubber(src) //Similar to the above
	new /obj/item/ammo_box/magazine/multi_sprite/firefly(src)


//Blaster
/obj/item/storage/box/gunset/blaster
	name = "blaster supply box"


/obj/item/storage/box/gunset/blaster/PopulateContents()
	. = ..()
	new /obj/item/gun/energy/laser/hitscan(src)
