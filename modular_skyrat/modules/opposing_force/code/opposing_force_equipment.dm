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

/**
 * GUNS
 */

/datum/opposing_force_equipment/gun
	category = OPFOR_EQUIPMENT_CATEGORY_RANGED_WEAPONS

/datum/opposing_force_equipment/gun/m1911
	item_type = /obj/item/gun/ballistic/automatic/pistol/m1911

/datum/opposing_force_equipment/gun/m16
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/m16
	
/datum/opposing_force_equipment/gun/m23
	item_type = /obj/item/gun/ballistic/shotgun/m23
	description = "An eight round pump action shotgun found in an old station. Comes loaded with beanbag shells but can take any 12 Gauge load."
	
/datum/opposing_force_equipment/gun/as2
	item_type = /obj/item/gun/ballistic/shotgun/automatic/as2
	description = "A compact version of the combat shotgun. Comes with a 4 round tube and can be silenced as well as holstered to your belt or vest. Comes loaded with slugs but can take any 12 Gauge load."
	
/datum/opposing_force_equipment/gun/sas14
	item_type = /obj/item/gun/ballistic/shotgun/sas14
	description = "A semi automatic, mag fed shotgun chambered in 14 Gauge. Standard mags can take 5 rounds. Despite the lower damage of 14 Gauge it can take the highly praised Taser Shots."


/datum/opposing_force_equipment/gun/ninjastar
	item_type = /obj/item/throwing_star
	description = "Be the maintenance ninja you always wanted to be. Does not come with multi-throwing cybernetics"

/**
 * AMMO
 */
/datum/opposing_force_equipment/ammo/
	category = OPFOR_EQUIPMENT_CATEGORY_AMMUNITION

/**
 * MELEE
 */
/datum/opposing_force_equipment/melee/
	category = OPFOR_EQUIPMENT_CATEGORY_MELEE_WEAPONS
	
/datum/opposing_force_equipment/melee/switchblade
	item_type = /obj/item/switchblade 

/datum/opposing_force_equipment/melee/metalbat
	item_type = /obj/item/melee/baseball_bat/ablative
	description = "A highly reflective baseball bat. When you must crack skulls and run away from security in the same night."

/**
 * ARMOR AND CLOTHES
 */
/datum/opposing_force_equipment/clothing/
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING

/**
 * UTILITY
 */
/datum/opposing_force_equipment/gear/
	category = OPFOR_EQUIPMENT_CATEGORY_UTILITY


/datum/opposing_force_equipment/gear/extendedrag
	item_type = /obj/item/reagent_containers/glass/rag/extended  //I have to actually add this in.
	description = "A damp rag made with extra absorbant materials. The perfectly innocent tool to kidnap your local assistant. Apply liquids and use harm intent to smother anyone not covering their mouth."
	
/**
 * OTHER
 */
/datum/opposing_force_equipment/other/
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER
