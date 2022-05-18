// Base medigun code
/obj/item/gun/energy/cell_loaded/medigun
	name = "medigun"
	desc = "This is my smart gun, it won't hurt anyone friendly, infact it will make them heal! Please tell github if you somehow manage to get this gun."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun" // Fits best with how the medigun looks, might be changed in the future
	ammo_type = list(/obj/item/ammo_casing/energy/medical) // The default option that heals oxygen
	w_class = WEIGHT_CLASS_NORMAL
	cell_type = /obj/item/stock_parts/cell/medigun/
	modifystate = 1
	ammo_x_offset = 3
	charge_sections = 3
	maxcells = 3
	allowed_cells = list(/obj/item/weaponcell/medical)
	item_flags = null

// Standard medigun - this is what you will get from Cargo, most likely.
/obj/item/gun/energy/cell_loaded/medigun/standard
	name = "VeyMedical CWM-479 cell-powered medigun"
	desc = "This is the standard model medigun produced by Vey-Med, meant for healing in less than ideal scenarios. The medicell chamber is rated to fit three cells"

// Upgraded medigun
/obj/item/gun/energy/cell_loaded/medigun/upgraded
	name = "VeyMedical CWM-479-FC cell-powered medigun"
	desc = "This is the upgraded version of the standard CWM-497 medigun, the battery inside is upgraded to better work with chargers along with having more capacity."
	cell_type = /obj/item/stock_parts/cell/medigun/upgraded

/obj/item/gun/energy/cell_loaded/medigun/upgraded/Initialize()
	. = ..()
	var/mutable_appearance/fastcharge_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_fastcharge")
	add_overlay(fastcharge_medigun)

// CMO and CC MediGun
/obj/item/gun/energy/cell_loaded/medigun/cmo
	name = "VeyMedical CWM-479-CC cell-powered medigun"
	desc = "The most advanced version of the CWM-479 line of mediguns, it features slots for six cells and a auto recharging battery"
	cell_type = /obj/item/stock_parts/cell/medigun/experimental
	maxcells = 6
	selfcharge = 1
	can_charge = FALSE

/obj/item/gun/energy/cell_loaded/medigun/cmo/Initialize()
	. = ..()
	var/mutable_appearance/cmo_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_cmo")
	add_overlay(cmo_medigun)

// Medigun power cells
/obj/item/stock_parts/cell/medigun/ // This is the cell that mediguns from cargo will come with
	name = "basic medigun cell"
	maxcharge = 1200
	chargerate = 40

/obj/item/stock_parts/cell/medigun/upgraded
	name = "upgraded medigun cell"
	maxcharge = 1500
	chargerate = 80

/obj/item/stock_parts/cell/medigun/experimental // This cell type is meant to be used in self charging mediguns like CMO and ERT one.
	name = "experiemental medigun cell"
	maxcharge = 1800
	chargerate = 100
// End of power cells

// Upgrade Kit
/obj/item/device/custom_kit/medigun_fastcharge
	name = "VeyMedical CWM-479 upgrade kit"
	desc = "Upgrades the internal battery inside of the medigun, allowing for faster charging and a higher cell capacity. Any cells inside of the origingal medigun during the upgrade process will be lost!"
	from_obj = /obj/item/gun/energy/cell_loaded/medigun/standard
	to_obj = /obj/item/gun/energy/cell_loaded/medigun/upgraded

// Medigun wiki book
/obj/item/book/manual/wiki/mediguns
	name = "medigun operating manual"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "manual"
	starting_author = "VeyMedical"
	starting_title = "Medigun Operating Manual"
	page_link = "Guide_to_Mediguns"
	skyrat_wiki = TRUE

// Medigun Gunsets
/obj/item/storage/briefcase/medicalgunset/
	name = "medigun supply kit"
	desc = "A supply kit for the medigun."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "case_standard"
	inhand_icon_state = "lockbox"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/briefcase/medicalgunset/standard
	name = "VeyMedical CWM-479 cell-powered medigun case"
	desc = "Contains the CWM-479 medigun."

/obj/item/storage/briefcase/medicalgunset/standard/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/standard(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/obj/item/storage/briefcase/medicalgunset/cmo
	name = "VeyMedical CWM-479-CC cell-powered medigun case"
	desc = "A case that includes the experimental CWM-479-CC medigun and tier I medicells"
	icon_state = "case_cmo"

/obj/item/storage/briefcase/medicalgunset/cmo/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/cmo(src)
	new /obj/item/weaponcell/medical/brute(src)
	new /obj/item/weaponcell/medical/burn(src)
	new /obj/item/weaponcell/medical/toxin(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/*
* Medigun Cells - Spritework is done by Arctaisia!
*/

// Default Cell
/obj/item/weaponcell/medical
	name = "default medicell"
	desc = "The standard oxygen cell, most guns come with this already installed."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	ammo_type = /obj/item/ammo_casing/energy/medical // This is the ammo type that all mediguns come with.
	medicell_examine = TRUE

/obj/item/weaponcell/medical/oxygen

/*
* Tier I cells
*/

// Brute I
/obj/item/weaponcell/medical/brute
	name = "brute I medicell"
	desc = "A small cell with a red glow. Can be used on mediguns to unlock the brute I functionality."
	icon_state = "Brute1"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute1
	primary_mode = /obj/item/ammo_casing/energy/medical/brute1/safe
	toggle_modes = TRUE

// Burn I
/obj/item/weaponcell/medical/burn
	name = "burn I medicell"
	desc = "A small cell with a yellow glow. Can be used on mediguns to unlock the burn I functionality."
	icon_state = "Burn1"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn1
	primary_mode = /obj/item/ammo_casing/energy/medical/burn1/safe
	toggle_modes = TRUE
// Toxin I
/obj/item/weaponcell/medical/toxin
	name = "toxin I medicell"
	desc = "A small cell with a green glow. Can be used on mediguns to unlock the toxin I functionality."
	icon_state = "Toxin1"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin1

/*
* Tier II Cells
*/

// Brute II
/obj/item/weaponcell/medical/brute/better
	name = "brute II medicell"
	desc = "A small cell with a intense red glow. Can be used on mediguns to unlock the brute II functionality."
	icon_state = "Brute2"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute2
	primary_mode = /obj/item/ammo_casing/energy/medical/brute2/safe

// Burn II
/obj/item/weaponcell/medical/burn/better
	name = "burn II medicell"
	desc = "A small cell with a intense yellow glow. Can be used on mediguns to unlock the burn II functionality."
	icon_state = "Burn2"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn2
	primary_mode = /obj/item/ammo_casing/energy/medical/burn2/safe

// Toxin II
/obj/item/weaponcell/medical/toxin/better
	name = "toxin II medicell"
	desc = "A small cell with a intense green glow. Can be used on mediguns to unlock the toxin II functionality."
	icon_state = "Toxin2"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin2

// Oxygen II
/obj/item/weaponcell/medical/oxygen/better
	name = "oxygen II medicell"
	desc = "A small cell with a intense blue glow. Can be used on mediguns to unlock the oxygen II functionality."
	icon_state = "Oxy2"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy2

/*
* Tier III Cells
*/

// Brute III
/obj/item/weaponcell/medical/brute/better/best
	name = "brute III medicell"
	desc = "A small cell with a intense red glow. Can be used on mediguns to unlock the brute III Functoinality"
	icon_state = "Brute3"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute3
	primary_mode = /obj/item/ammo_casing/energy/medical/brute3/safe

// Burn III
/obj/item/weaponcell/medical/burn/better/best
	name = "burn III medicell"
	desc = "A small cell with a intense yellow glow. Can be used on mediguns to unlock the burn III Functoinality"
	icon_state = "Burn3"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn3
	primary_mode = /obj/item/ammo_casing/energy/medical/burn3/safe

// Toxin III
/obj/item/weaponcell/medical/toxin/better/best
	name = "toxin III medicell"
	desc = "A small cell with a intense green glow. Can be used on mediguns to unlock the toxin II functionality."
	icon_state = "Toxin3"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin3

// Oxygen III
/obj/item/weaponcell/medical/oxygen/better/best
	name = "oxygen III medicell"
	desc = "A small cell with a intense blue glow. Can be used on mediguns to unlock the oxygen II functionality."
	icon_state = "Oxy3"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy3

/*
* Utility Cells
*/

/obj/item/weaponcell/medical/utility
	name = "utility class medicell"
	desc = "You really shouldn't be seeing this, if you do, please yell at your local coders."

/obj/item/weaponcell/medical/utility/clotting
	name = "clotting medicell"
	desc = "A medicell designed to help deal with bleeding patients"
	icon_state = "clotting"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/clotting

/obj/item/weaponcell/medical/utility/temperature
	name = "temperature readjustment medicell"
	desc = "A medicell that adjusts the hosts temperature to acceptable levels"
	icon_state = "temperature"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/temperature

/obj/item/weaponcell/medical/utility/hardlight_gown
	name = "hardlight gown medicell"
	desc = "A medicell that creates a hopsital gown made out of hardlight on the target"
	icon_state = "gown"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/gown

/obj/item/weaponcell/medical/utility/salve
	name = "hardlight salve medicell"
	desc = "A medicell that applies a healing globule of synthetic plant matter to a patient"
	icon_state = "salve"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/salve

/obj/item/weaponcell/medical/utility/bed
	name = "hardlight roller bed medicell"
	desc = "A medicell that summons a temporary roller bed under a patient already lying on the floor"
	icon_state = "gown"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/bed

/obj/item/weaponcell/medical/utility/body_teleporter
	name = "body transporter medicell"
	desc = "A medicell that allows the user to transport a dead body to themselves."
	icon_state = "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/body_teleporter

/obj/item/weaponcell/medical/utility/relocation
	name = "Oppressive Force relocation medicell"
	desc = "A medicell that safely relocates personnel"
	icon_state =  "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation/standard

/obj/item/weaponcell/medical/utility/relocation/upgraded
	name = "upgraded Oppressive Force relocation medicell"
	desc = "An upgraded version of the Relocation Medicell. It has the access and area requirements removed, along with having the standard grace period disabled."
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation

//Empty Medicell//
/obj/item/device/custom_kit/empty_cell //Having the empty cell as an upgrade kit sounds jank, but it should work well.
	name = "empty salve medicell"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "empty"
	desc = "An inactive salve medicell, use this on an aloe leaf to make this into a usable cell."
	from_obj = /obj/item/food/grown/aloe
	to_obj = /obj/item/weaponcell/medical/utility/salve

/obj/item/device/custom_kit/empty_cell/Initialize()
	. = ..()
	AddElement(/datum/element/item_scaling, 0.5, 1)

/obj/item/device/custom_kit/empty_cell/body_teleporter
	name = "empty body teleporter medicell"
	desc = "An inactive body teleporter medicell, use this on a bluespace slime extract to make this into a usable cell."
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/body_teleporter
