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
	description = "A compact version of the combat shotgun. Comes with a 4 round tube and can be silenced as well as holstered to your belt or vest. \
		Comes loaded with slugs but can take any 12 Gauge load."
	
/datum/opposing_force_equipment/gun/sas14
	item_type = /obj/item/gun/ballistic/shotgun/sas14
	description = "A semi automatic, mag fed shotgun chambered in 14 Gauge. Standard mags can take 5 rounds. \
		Despite the lower damage of 14 Gauge it can take the highly praised Taser Shots."


/datum/opposing_force_equipment/gun/ninjastar
	item_type = /obj/item/throwing_star
	description = "Be the maintenance ninja you always wanted to be. Does not come with multi-throwing cybernetics"
	

/datum/opposing_force_equipment/gun/origami
	item_type = /obj/item/storage/box/syndie_kit/origami_bundle
	description = "This box contains a guide on how to craft masterful works of origami, allowing you to transform normal pieces of paper into \
			perfectly aerodynamic (and potentially lethal) paper airplanes."

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
	
/datum/opposing_force_equipment/melee/esword
	item_type = /obj/item/melee/energy/sword
	description = "The energy sword is an edged weapon with a blade of pure energy. The sword is small enough to be \
			pocketed when inactive. Activating it produces a loud, distinctive noise."
				
/datum/opposing_force_equipment/melee/epirate
	item_type = /obj/item/melee/energy/sword/pirate
	description = "Cutlass variant of the Energy Sword. Pirate costume sold seperate. Warranty void if bought."
	
/datum/opposing_force_equipment/melee/cutlass
	item_type = /obj/item/claymore/cutlass

/datum/opposing_force_equipment/melee/claymore
	item_type = /obj/item/claymore
	description = "An extremely sharp and robust sword perfect to cleave thru any opposition. Also highly illegal."
	
/datum/opposing_force_equipment/melee/katana
	item_type = /obj/item/katana
	description = "An extremely sharp and robust sword folded over 9000 times until perfection. Highly lethal and illegal."

/datum/opposing_force_equipment/melee/ekatana
	item_type = /obj/item/energy_katana
	description = "An Energy Katana seized from a dead Spider Clan Ninja. As well as being highly robust, it allows the \
					user to teleport short distances using right-click."
					
/datum/opposing_force_equipment/melee/vibro
	item_type =/obj/item/vibro_weapon
	description = "A high frequency vibrating sword. Able to cut through any and all materials but lacks the robustness of other swords. Can be wielded to deflect gunfire"

//martialarts

/datum/opposing_force_equipment/melee/cqc
	item_type = /obj/item/book/granter/martial/cqc
	description = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."

/datum/opposing_force_equipment/melee/carp
	item_type = /obj/item/book/granter/martial/carp
	description = "This scroll contains the secrets of an ancient martial arts technique. You will master unarmed combat \
			and gain the ability to swat bullets from the air, but you will also refuse to use dishonorable ranged weaponry."


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
	
/datum/opposing_force_equipment/gear/stoolbox
	item_type = /obj/item/storage/toolbox/syndicate
	description = "A fully kitted toolbox scavenged from the maints by our highly paid monkies. Comes with insulated combat gloves and the toolbox \
					itself is weighted a tad more then typical toolboxes to bash any head in."
					
/datum/opposing_force_equipment/gear/engichip
	item_type = /obj/item/skillchip/job/engineer
	description = "A skillchip, when installed, that lets the user read off what each wire does in doors. Highly valuable and sought after."

/datum/opposing_force_equipment/gear/stoolbox
	item_type = /obj/item/clothing/glasses/thermal/xray
					
//BOMBS!EXPLOSIVES!!WOOOO!!one!
	
/datum/opposing_force_equipment/gear/henade
	item_type = /obj/item/grenade/syndieminibomb/concussion
	
/datum/opposing_force_equipment/gear/fragnade
	item_type = /obj/item/grenade/frag
	
/datum/opposing_force_equipment/gear/radnade
	item_type = /obj/item/grenade/gluon
	
/datum/opposing_force_equipment/gear/c4
	item_type = /obj/item/grenade/c4
	
/datum/opposing_force_equipment/gear/x4
	item_type = /obj/item/grenade/c4/x4
	description = "Similar to C4, but with a stronger blast that is directional instead of circular."

/datum/opposing_force_equipment/gear/extendedrag
	item_type = /obj/item/reagent_containers/glass/rag/sus  //I have to actually add this in.
	description = "A damp rag made with extra absorbant materials. The perfectly innocent tool to kidnap your local assistant. \
			Apply up to 30u liquids and use harm intent to smother anyone not covering their mouth."
	
/**
 * OTHER
 */
/datum/opposing_force_equipment/other/
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER
	
	//WHAT DO WE PUT HERE? MAYBE ADD EXPLOSIVES AS ITS CATEGORY?
