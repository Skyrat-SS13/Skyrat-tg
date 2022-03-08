/// Global list of equipment parents, used for unit testing. PLEASE PLEASE PLEASE UPDATE THIS WITH NEW CATEGORIES AS THEY GET ADDED
GLOBAL_LIST_INIT(opfor_equipment_parents, list(
	/datum/opposing_force_equipment/ammo,
	/datum/opposing_force_equipment/clothing,
	/datum/opposing_force_equipment/bomb,
	/datum/opposing_force_equipment/implant,
	/datum/opposing_force_equipment/loadout,
	/datum/opposing_force_equipment/martial_art,
	/datum/opposing_force_equipment/melee,
	/datum/opposing_force_equipment/other,
	/datum/opposing_force_equipment/pistol,
	/datum/opposing_force_equipment/rifle,
	/datum/opposing_force_equipment/service,
	/datum/opposing_force_equipment/shotgun,
	/datum/opposing_force_equipment/spell,
	/datum/opposing_force_equipment/submachine_gun,
	/datum/opposing_force_equipment/gear
))

/**
 * OPFOR EQUIPMENT DATUM
 *
 * The OPFOR subsystem will gather all of these on initialisation and populate a list, which is then passed
 * into the OPFOR UI, which can be selected by the user.
 *
 * The User will be equipped with whatever they have selected if the approving admin authorises it.
 */


/datum/opposing_force_equipment
	/// The name of the equipment used in the listing, if not set, it will use the items name.
	var/name
	/// The description of the equipment used in the listing, if not set, it will use the items description.
	var/description
	/// The item path that we refer to when equipping.
	var/obj/item_type
	/// Category of the item. See opposing_force_defines.dm for a list of categories.
	var/category = ""
	/// Note to admins, useful if the item is extraordinarily strong
	var/admin_note
