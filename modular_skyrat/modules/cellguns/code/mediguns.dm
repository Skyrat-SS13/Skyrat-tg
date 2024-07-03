// Base medigun code
/obj/item/gun/energy/cell_loaded/medigun
	name = "medigun"
	desc = "This is my smart gun, it won't hurt anyone friendly, infact it will make them heal! Please tell github if you somehow manage to get this gun."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun" // Fits best with how the medigun looks, might be changed in the future
	ammo_type = list(/obj/item/ammo_casing/energy/medical) // The default option that heals oxygen
	w_class = WEIGHT_CLASS_NORMAL
	cell_type = /obj/item/stock_parts/power_store/cell/medigun
	modifystate = 1
	ammo_x_offset = 3
	charge_sections = 3
	maxcells = 3
	allowed_cells = list(/obj/item/weaponcell/medical)
	item_flags = null
	gun_flags = TURRET_INCOMPATIBLE

// Standard medigun - this is what you will get from Cargo, most likely.
/obj/item/gun/energy/cell_loaded/medigun/standard
	name = "VeyMedical CWM-479 cell-powered medigun"
	desc = "This is a standard model medigun produced by Vey-Med, for healing in less than ideal scenarios. The medicell chamber is rated to fit three cells."

// Upgraded medigun
/obj/item/gun/energy/cell_loaded/medigun/upgraded
	name = "VeyMedical CWM-479-FC cell-powered medigun"
	desc = "This is an upgraded variant of the standard CWM-479 medigun. While it still only fits three cells, its cell has been upgraded for higher capacity and faster charging."
	cell_type = /obj/item/stock_parts/power_store/cell/medigun/upgraded

/obj/item/gun/energy/cell_loaded/medigun/upgraded/Initialize(mapload)
	. = ..()
	var/mutable_appearance/fastcharge_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_fastcharge")
	add_overlay(fastcharge_medigun)

// CMO and CC MediGun
/obj/item/gun/energy/cell_loaded/medigun/cmo
	name = "VeyMedical CWM-479-CC cell-powered medigun"
	desc = "The most advanced version of the CWM-479 line of mediguns, it features slots for six cells and a auto recharging battery"
	cell_type = /obj/item/stock_parts/power_store/cell/medigun/experimental
	maxcells = 6
	selfcharge = 1
	can_charge = FALSE

/obj/item/gun/energy/cell_loaded/medigun/cmo/Initialize(mapload)
	. = ..()
	var/mutable_appearance/cmo_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_cmo")
	add_overlay(cmo_medigun)

// Medigun power cells
/obj/item/stock_parts/power_store/cell/medigun // This is the cell that mediguns from cargo will come with
	name = "basic medigun cell"
	maxcharge = STANDARD_CELL_CHARGE
	chargerate = STANDARD_CELL_CHARGE * 0.03

/obj/item/stock_parts/power_store/cell/medigun/upgraded
	name = "upgraded medigun cell"
	maxcharge = STANDARD_CELL_CHARGE * 1.4
	chargerate = STANDARD_CELL_CHARGE * 0.06

/obj/item/stock_parts/power_store/cell/medigun/experimental // This cell type is meant to be used in self charging mediguns like CMO and ERT one.
	name = "experimental medigun cell"
	maxcharge = 1.8 * STANDARD_CELL_CHARGE
	chargerate = 0.1 * STANDARD_CELL_CHARGE
// End of power cells

// Upgrade Kit
/obj/item/device/custom_kit/medigun_fastcharge
	name = "VeyMedical CWM-479 upgrade kit"
	desc = "Upgrades the internal battery inside of the medigun, allowing for faster charging and a higher cell capacity. Requires the medigun's cells to be removed first!"
	// don't tinker with a loaded (medi)gun. fool
	from_obj = /obj/item/gun/energy/cell_loaded/medigun/standard
	to_obj = /obj/item/gun/energy/cell_loaded/medigun/upgraded

/obj/item/device/custom_kit/medigun_fastcharge/pre_convert_check(obj/target_obj, mob/user)
	var/obj/item/gun/energy/cell_loaded/medigun/standard/our_medigun = target_obj
	if(length(our_medigun.installedcells))
		balloon_alert(user, "unload it first!")
		return FALSE
	return TRUE

// Medigun wiki book
/obj/item/book/manual/wiki/mediguns
	name = "medigun operating manual"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "manual"
	starting_author = "VeyMedical"
	starting_title = "Medigun Operating Manual"
	page_link = "Guide_to_Mediguns"

// Medigun Gunsets
/obj/item/storage/briefcase/medicalgunset
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
	desc = "A briefcase that contains the CWM-479 medigun and an instruction manual."

/obj/item/storage/briefcase/medicalgunset/standard/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/standard(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/obj/item/storage/briefcase/medicalgunset/cmo
	name = "VeyMedical CWM-479-CC cell-powered medigun case"
	desc = "A briefcase that contains the experimental CWM-479-CC medigun, a basic set of three medigun cells, and an instruction manual."
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
	name = "oxygen I medicell"
	desc = "A small cell with a slight blue glow. Can be used on mediguns to enable basic oxygen deprivation healing functionality."

/*
* Tier I cells
*/

// Brute I
/obj/item/weaponcell/medical/brute
	name = "brute I medicell"
	desc = "A small cell with a slight red glow. Can be used on mediguns to enable basic brute damage healing functionality."
	icon_state = "Brute1"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute1
	primary_mode = /obj/item/ammo_casing/energy/medical/brute1/safe
	toggle_modes = TRUE

// Burn I
/obj/item/weaponcell/medical/burn
	name = "burn I medicell"
	desc = "A small cell with a slight yellow glow. Can be used on mediguns to enable basic burn damage healing functionality."
	icon_state = "Burn1"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn1
	primary_mode = /obj/item/ammo_casing/energy/medical/burn1/safe
	toggle_modes = TRUE
// Toxin I
/obj/item/weaponcell/medical/toxin
	name = "toxin I medicell"
	desc = "A small cell with a slight green glow. Can be used on mediguns to enable basic toxin damage healing functionality."
	icon_state = "Toxin1"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin1

/*
* Tier II Cells
*/

// Brute II
/obj/item/weaponcell/medical/brute/tier_2
	name = "brute II medicell"
	desc = "A small cell with a noticeable red glow. Can be used on mediguns to enable improved brute damage healing functionality."
	icon_state = "Brute2"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute2
	primary_mode = /obj/item/ammo_casing/energy/medical/brute2/safe

// Burn II
/obj/item/weaponcell/medical/burn/tier_2
	name = "burn II medicell"
	desc = "A small cell with a noticeable yellow glow. Can be used on mediguns to enable improved burn damage healing functionality."
	icon_state = "Burn2"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn2
	primary_mode = /obj/item/ammo_casing/energy/medical/burn2/safe

// Toxin II
/obj/item/weaponcell/medical/toxin/tier_2
	name = "toxin II medicell"
	desc = "A small cell with a noticeable green glow. Can be used on mediguns to enable improved toxin damage healing functionality."
	icon_state = "Toxin2"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin2

// Oxygen II
/obj/item/weaponcell/medical/oxygen/tier_2
	name = "oxygen II medicell"
	desc = "A small cell with a notable blue glow. Can be used on mediguns to enable improved oxygen deprivation healing functionality."
	icon_state = "Oxy2"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy2

/*
* Tier III Cells
*/

// Brute III
/obj/item/weaponcell/medical/brute/tier_3
	name = "brute III medicell"
	desc = "A small cell with an intense red glow and a reinforced casing. Can be used on mediguns to enable advanced brute damage healing functionality."
	icon_state = "Brute3"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute3
	primary_mode = /obj/item/ammo_casing/energy/medical/brute3/safe

// Burn III
/obj/item/weaponcell/medical/burn/tier_3
	name = "burn III medicell"
	desc = "A small cell with an intense yellow glow and a reinforced casing. Can be used on mediguns to enable advanced burn damage healing functionality."
	icon_state = "Burn3"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn3
	primary_mode = /obj/item/ammo_casing/energy/medical/burn3/safe

// Toxin III
/obj/item/weaponcell/medical/toxin/tier_3
	name = "toxin III medicell"
	desc = "A small cell with an intense green glow and a reinforced casing. Can be used on mediguns to enable advanced toxin damage healing functionality."
	icon_state = "Toxin3"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin3

// Oxygen III
/obj/item/weaponcell/medical/oxygen/tier_3
	name = "oxygen III medicell"
	desc = "A small cell with an intense blue glow and a reinforced casing. Can be used on mediguns to enable advanced oxygen deprivation healing functionality."
	icon_state = "Oxy3"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy3

/*
* Utility Cells
*/

/obj/item/weaponcell/medical/utility
	name = "utility class medicell"
	desc = "You really shouldn't be seeing this. If you do, please yell at your local coders."

/obj/item/weaponcell/medical/utility/clotting
	name = "clotting medicell"
	desc = "A medicell designed to help deal with bleeding patients."
	icon_state = "clotting"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/clotting

/obj/item/weaponcell/medical/utility/temperature
	name = "temperature readjustment medicell"
	desc = "A medicell that adjusts a patient's temperature to the sweet spot between \"blood frozen in veins\" and \"blood flash-boiling in veins\"."
	icon_state = "temperature"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/temperature

/obj/item/weaponcell/medical/utility/hardlight_gown
	name = "hardlight gown medicell"
	desc = "A medicell that creates a hardlight hospital gown on the target."
	icon_state = "gown"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/gown

/obj/item/weaponcell/medical/utility/salve
	name = "hardlight salve medicell"
	desc = "A medicell that applies a healing globule of synthetic plant matter to a patient."
	icon_state = "salve"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/salve

/obj/item/weaponcell/medical/utility/bed
	name = "hardlight roller bed medicell"
	desc = "A medicell that summons a temporary roller bed under a patient already lying on the floor."
	icon_state = "gown"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/bed

/obj/item/weaponcell/medical/utility/body_teleporter
	name = "body transporter medicell"
	desc = "A medicell that allows the user to transport a dead body to themselves."
	icon_state = "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/body_teleporter

/obj/item/weaponcell/medical/utility/relocation
	name = "oppressive force relocation medicell"
	desc = "A medicell that safely relocates personnel after a given grace period, if used by someone with the appropriate access and within an appropriately designated area (usually Medbay)."
	icon_state =  "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation/standard

/obj/item/weaponcell/medical/utility/relocation/upgraded
	name = "upgraded oppressive force relocation medicell"
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

/obj/item/device/custom_kit/empty_cell/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.5, 1)

/obj/item/device/custom_kit/empty_cell/body_teleporter
	name = "empty body teleporter medicell"
	desc = "An inactive body teleporter medicell, use this on a bluespace slime extract to make this into a usable cell."
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/body_teleporter

/obj/item/device/custom_kit/empty_cell/relocator
	name = "empty oppressive force relocator medicell"
	desc = "An inactive oppressive force relocator medicell, use this on a bluespace slime extract to make this into a usable cell."
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/relocation
