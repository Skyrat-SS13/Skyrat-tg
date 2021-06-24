//Base Medigun Code//
/obj/item/gun/energy/medigun
	name = "MediGun"
	desc = "This is my smart gun, it won't hurt anyone friendly, infact it will make them heal!"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-disabler"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/medical) //The default option that heals Oxygen//
	ammo_x_offset = 2
	w_class = WEIGHT_CLASS_NORMAL
	cell_type = /obj/item/stock_parts/cell/medigun/
	ammo_x_offset = 2
	charge_sections = 3
	has_gun_safety = TRUE
	var/maxcells = 3
	var/cellcount = 0
	var/list/installedcells = list()
//standard MediGun//
/obj/item/gun/energy/medigun/standard


//Medigun Cells//
//Default Cell//
/obj/item/medicell
	name = "Default Medicell"
	desc = "The standard MediCell"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/upgrades.dmi'
	icon_state = "Oxygen1"
	w_class = WEIGHT_CLASS_SMALL
	var/ammo_type = /obj/item/ammo_casing/energy/medical //This is the ammo type that all mediguns come with.

//Tier I cells//
//Brute I//
/obj/item/medicell/brute1
	name = "Brute I Medicell"
	desc = "A small cell with a red glow. Can be used on Mediguns to unlock the Brute I Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Brute1"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute1
//Burn I//
/obj/item/medicell/burn1
	name = "Burn I Medicell"
	desc = "A small cell with a yellow glow. Can be used on Mediguns to unlock the Burn I Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Burn1"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn1
//Toxin I//
/obj/item/medicell/toxin1
	name = "Toxin I Medicell"
	desc = "A small cell with a green glow. Can be used on Mediguns to unlock the Toxin I Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Toxin1"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin1
//End of Tier I Cells/
//Medigun Upgrade//
/obj/item/gun/energy/medigun/attackby(obj/item/medicell/M, mob/user)
	if(cellcount >= maxcells)
		to_chat(usr, span_notice("The Medigun is full, take a cell out to make room"))
	else
		if(!user.transferItemToLoc(M, src))
			return
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_notice("You install the medicell."))
		ammo_type += new M.ammo_type(src)
		installedcells += M
		cellcount += 1

/obj/item/gun/energy/medigun/RightClick(mob/user)
	if(cellcount >= 1)
		to_chat(usr, span_notice("You remove a cell"))
		installedcells[installedcells.len].forceMove(drop_location())
		installedcells.len--
		ammo_type.len--
		cellcount -= 1
	else
		to_chat(usr, span_notice("The Medigun has no cells inside"))
		return ..()
//Procs//
