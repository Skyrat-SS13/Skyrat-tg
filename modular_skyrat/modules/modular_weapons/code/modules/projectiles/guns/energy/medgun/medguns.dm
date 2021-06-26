//Base Medigun Code//
/obj/item/gun/energy/medigun
	name = "MediGun"
	desc = "This is my smart gun, it won't hurt anyone friendly, infact it will make them heal! Please tell github if you somehow manage to get this gun."
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

/obj/item/gun/energy/medigun/examine(mob/user)
	. = ..()
	if(maxcells)
		. += "<b>[cellcount]</b> out of <b>[maxcells]</b> cell slots are filled."
		. += span_info("You can use right click to remove the most recently inserted Medicell from the chamber.")
		for(var/A in installedcells)
			var/obj/item/medicell/M = A
			. += span_notice("There is \a [M] in the chamber.")

//standard MediGun// This is what you will get from Cargo, most likely.
/obj/item/gun/energy/medigun/standard
	name = "VeyMedical CWM-479 Cell Powered Medigun"
	desc = "This is the standard model Medigun produced by Vey-Med, meant for healing in less than ideal scenarios. The Medicell chamber is rated to fit three cells"

//Upgarded Medigun//
/obj/item/gun/energy/medigun/upgraded
	name = "VeyMedical CWM-479-FC Cell Powered Medigun"
	desc = "This is the upgraded version of the standard CWM-497 Medigun, the battery inside is upgraded to better work with chargers along with having more capacity."
	cell_type = /obj/item/stock_parts/cell/medigun/upgraded

//CMO and CC MediGun
/obj/item/gun/energy/medigun/cmo
	name = "VeyMedical CWM-479-CC Cell Powered Medigun"
	desc = "The most advanced version of the CWM-479 line of mediguns, it features slots for six cells and a auto recharging battery"
	cell_type = /obj/item/stock_parts/cell/medigun/experimental
	maxcells = 6
	selfcharge = 1
	can_charge = FALSE
	//Medigun Cells// Spritework is done by Arctaisia!
//Default Cell//
/obj/item/medicell
	name = "Default Medicell"
	desc = "The standard MediCell"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/upgrades.dmi'
	icon_state = "Oxygen1"
	w_class = WEIGHT_CLASS_SMALL
	var/ammo_type = /obj/item/ammo_casing/energy/medical //This is the ammo type that all mediguns come with.

/obj/item/medicell/Initialize()
	. =..()
	AddElement(/datum/element/item_scaling, 0.5, 1)
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
//Tier II Cells/
//Brute II//
/obj/item/medicell/brute2
	name = "Brute II Medicell"
	desc = "A small cell with a intense red glow. Can be used on Mediguns to unlock the Brute II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Brute1"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute2
//Burn II//
/obj/item/medicell/burn2
	name = "Burn II Medicell"
	desc = "A small cell with a intense yellow glow. Can be used on Mediguns to unlock the Burn II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Burn1"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn2
//Toxin II//
/obj/item/medicell/toxin2
	name = "Toxin II Medicell"
	desc = "A small cell with a intense green glow. Can be used on Mediguns to unlock the Toxin II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Toxin1"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin2
//Oxygen II//
/obj/item/medicell/oxy2
	name = "Oxygen II Medicell"
	desc = "A small cell with a intense blue glow. Can be used on Mediguns to unlock the Oxygen II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Oxygen1"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy2
//End of Tier II
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
