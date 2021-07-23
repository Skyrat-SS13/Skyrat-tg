//Base Medigun Code//
/obj/item/gun/energy/medigun
	name = "MediGun"
	desc = "This is my smart gun, it won't hurt anyone friendly, infact it will make them heal! Please tell github if you somehow manage to get this gun."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun" //Fits best with how the medigun looks, might be changed in the future
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
		. += span_info("You can use AltClick with an empty hand to remove the most recently inserted Medicell from the chamber.")
		for(var/cell in installedcells)
			var/obj/item/medicell/medicell = cell
			. += span_notice("There is \a [medicell] loaded in the chamber.")

//standard MediGun// This is what you will get from Cargo, most likely.
/obj/item/gun/energy/medigun/standard
	name = "VeyMedical CWM-479 Cell Powered Medigun"
	desc = "This is the standard model Medigun produced by Vey-Med, meant for healing in less than ideal scenarios. The Medicell chamber is rated to fit three cells"

//Upgarded Medigun//
/obj/item/gun/energy/medigun/upgraded
	name = "VeyMedical CWM-479-FC Cell Powered Medigun"
	desc = "This is the upgraded version of the standard CWM-497 Medigun, the battery inside is upgraded to better work with chargers along with having more capacity."
	cell_type = /obj/item/stock_parts/cell/medigun/upgraded

/obj/item/gun/energy/medigun/upgraded/Initialize()
	..()
	var/mutable_appearance/fastcharge_medigun = mutable_appearance('modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi', "medigun_fastcharge")
	add_overlay(fastcharge_medigun)

//CMO and CC MediGun
/obj/item/gun/energy/medigun/cmo
	name = "VeyMedical CWM-479-CC Cell Powered Medigun"
	desc = "The most advanced version of the CWM-479 line of mediguns, it features slots for six cells and a auto recharging battery"
	cell_type = /obj/item/stock_parts/cell/medigun/experimental
	maxcells = 6
	selfcharge = 1
	can_charge = FALSE

/obj/item/gun/energy/medigun/cmo/Initialize()
	..()
	var/mutable_appearance/cmo_medigun = mutable_appearance('modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi', "medigun_cmo")
	add_overlay(cmo_medigun)

//Upgrade Kit//
/obj/item/upgradekit/medigun/charge
	name = "VeyMedical CWM-479 upgrade kit"
	desc = "Upgardes the internal battery inside of the medigun, allowing for faster charging and a higher cell capacity. Any cells inside of the origingal medigun during the upgrade process will be lost!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "plasticbox"
//
	//Medigun Cells// Spritework is done by Arctaisia!
//Default Cell//
/obj/item/medicell
	name = "Default Medicell"
	desc = "The standard oxygen cell, most guns come with this already installed."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/upgrades.dmi'
	icon_state = "Oxy1"
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
	icon_state = "Brute2"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute2
//Burn II//
/obj/item/medicell/burn2
	name = "Burn II Medicell"
	desc = "A small cell with a intense yellow glow. Can be used on Mediguns to unlock the Burn II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Burn2"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn2
//Toxin II//
/obj/item/medicell/toxin2
	name = "Toxin II Medicell"
	desc = "A small cell with a intense green glow. Can be used on Mediguns to unlock the Toxin II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Toxin2"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin2
//Oxygen II//
/obj/item/medicell/oxy2
	name = "Oxygen II Medicell"
	desc = "A small cell with a intense blue glow. Can be used on Mediguns to unlock the Oxygen II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Oxy2"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy2
//End of Tier II
//Tier III Cells/
//Brute III//
/obj/item/medicell/brute3
	name = "Brute III Medicell"
	desc = "A small cell with a intense red glow. Can be used on Mediguns to unlock the Brute II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Brute3"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute3
//Burn III//
/obj/item/medicell/burn3
	name = "Burn III Medicell"
	desc = "A small cell with a intense yellow glow. Can be used on Mediguns to unlock the Burn II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Burn3"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn3
//Toxin III//
/obj/item/medicell/toxin3
	name = "Toxin III Medicell"
	desc = "A small cell with a intense green glow. Can be used on Mediguns to unlock the Toxin II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Toxin3"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin3
//Oxygen III//
/obj/item/medicell/oxy3
	name = "Oxygen III Medicell"
	desc = "A small cell with a intense blue glow. Can be used on Mediguns to unlock the Oxygen II Functoinality"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "Oxy3"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy3
//End of Tier III
//Medigun Gunsets/
/obj/item/storage/briefcase/medicalgunset/
	name = "Medigun Supply Kit"
	desc = "Medigun Supply Kit"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon = 'icons/obj/storage.dmi'
	icon_state = "medbriefcase"
	inhand_icon_state = "lockbox"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/briefcase/medicalgunset/standard
	name = "VeyMedical CWM-479 Cell Powered Medigun starter kit"
	desc = "A stater kit containing the CWM-479 medigun along with a tier I medicells."

/obj/item/storage/briefcase/medicalgunset/standard/PopulateContents()
	new /obj/item/gun/energy/medigun/standard(src)
	new /obj/item/medicell/brute1(src)
	new /obj/item/medicell/burn1(src)
	new /obj/item/medicell/toxin1(src)

/obj/item/storage/briefcase/medicalgunset/cmo
	name = "VeyMedical CWM-479-CC Cell Powered Medigun case"
	desc = "Case that includes the Experimental CWM-479-CC Medigun and Tier I medicells"

/obj/item/storage/briefcase/medicalgunset/cmo/PopulateContents()
	new /obj/item/gun/energy/medigun/cmo(src)
	new /obj/item/medicell/brute1(src)
	new /obj/item/medicell/burn1(src)
	new /obj/item/medicell/toxin1(src)

//Medigun Cell Insertion and Removal//
/obj/item/gun/energy/medigun/attackby(obj/item/medicell/M, mob/user)
	if(istype(M, /obj/item/medicell))
		if(cellcount >= maxcells)
			to_chat(user, span_notice("The Medigun is full, take a cell out to make room"))
		else
			if(!user.transferItemToLoc(M, src))
				return
			playsound(loc, 'sound/machines/click.ogg', 50, 1)
			to_chat(user, span_notice("You install the medicell."))
			ammo_type += new M.ammo_type(src)
			installedcells += M
			cellcount += 1
	else
		..()

/obj/item/gun/energy/medigun/AltClick(mob/user, modifiers)
	if(cellcount >= 1)
		to_chat(user, span_notice("You remove a cell"))
		var/obj/item/last_cell = installedcells[installedcells.len]
		if(last_cell)
			last_cell.forceMove(drop_location())
		installedcells -= last_cell
		ammo_type.len--
		cellcount -= 1
		select_fire(user)
	else
		to_chat(user, span_notice("The Medigun has no cells inside"))
		return ..()
//Procs//
