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
	description "A semi-automatic .45 caliber pistol. Gold standard for sidearms."

/datum/opposing_force_equipment/gun/m16
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/m16
	description = "A variable fire mode 5.56x45mm assault rifle. Surprisingly compact. Highly illegal outside of the hands of SolGov's military."
	
/datum/opposing_force_equipment/gun/m23
	item_type = /obj/item/gun/ballistic/shotgun/m23
	description = "An eight-round pump-action shotgun found in an old station. Comes loaded with beanbag shells but can take any 12 gauge load."
	
/datum/opposing_force_equipment/gun/as2
	item_type = /obj/item/gun/ballistic/shotgun/automatic/as2
	description = "A compact version of the combat shotgun. Comes with a four-round tube and can be silenced as well as holstered to your belt or vest. \
		Comes loaded with slugs but can take any 12 Gauge load."
	
/datum/opposing_force_equipment/gun/sas14
	item_type = /obj/item/gun/ballistic/shotgun/sas14
	description = "A semi automatic, mag fed shotgun chambered in 14 Gauge. Standard mags can take 5 rounds. \
		Despite the lower damage of 14 Gauge it can take the highly praised Taser Shots."
		
/datum/opposing_force_equipment/gun/g357
	item_type = /obj/item/gun/ballistic/revolver
	description = "A .357 magnum revolver. Seven shots, more than enough to kill anything that moves."
	
/datum/opposing_force_equipment/gun/uzi
	item_type = /obj/item/gun/ballistic/automatic/mini_uzi
	description = "The uzi nine millimeter, a timeless submachinegun for a warrior out of time."

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

/datum/opposing_force_equipment/ammo/m16
	item_type = /obj/item/ammo_box/magazine/m16
	description = "A twenty round magazine for the M16 assault rifle. Uses 5.56x45mm ammunition."

/datum/opposing_force_equipment/ammo/m45
	item_type = /obj/item/ammo_box/magazine/m45
	description = "An eight round magazine for the M1911 pistol. Uses .45 caliber ammunition."

/datum/opposing_force_equipment/ammo/m9mm
	item_type = /obj/item/ammo_box/magazine/uzim9mm
	description = "A thirty-two round magazine for the mini uzi. Uses 9x19mm ammunition."

/datum/opposing_force_equipment/ammo/a357
	item_type = /obj/item/ammo_box/a357
	description = "A seven round .357 magnum speedloader for a revolver."

/datum/opposing_force_equipment/ammo/a357match
	item_type = /obj/item/ammo_box/a357/match
	description = "A seven round .357 magnum speedloader for a revolver, loaded with match-grade ammunition that bounces off of walls several times."

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
	item_type = /obj/item/vibro_weapon
	description = "A high frequency vibrating sword. Able to cut through any and all materials but lacks the robustness of other swords. Can be wielded to deflect gunfire"
	
/datum/opposing_force_equipment/melee/eswordarm
	item_type = /obj/item/autosurgeon/organ/syndicate/esword_arm
	name = "Energy Sword Arm Implant"
	description = "It's an energy sword, in your arm. Pretty decent for getting past stop-searches and assassinating people. Comes loaded in a Syndicate brand autosurgeon to boot!"

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
	
/datum/opposing_force_equipment/clothing/vest
	item_type = /obj/item/clothing/suit/armor/vest
	description = "A basic Type-1 armored vest for all manners of protection."
	
/datum/opposing_force_equipment/clothing/ballistic
	item_type = /obj/item/clothing/suit/armor/bulletproof
	description = "A bulletproof vest, for the aspiring warfighter."
	
/datum/opposing_force_equipment/clothing/laser
	item_type = /obj/item/clothing/suit/armor/laserproof
	description = "A laserproof vest, for the aspiring bane of security."
	
/datum/opposing_force_equipment/clothing/heavy
	item_type = /obj/item/clothing/suit/armor/heavy
	description = "A superheavy armor suit purpose-built to ensure all injuries are pushovers. WARNING: Not spaceproof."
	
/datum/opposing_force_equipment/clothing/infiltrator
	name = "Infiltrator Gear"
	item_type = /obj/item/storage/toolbox/infiltrator
	description = "A box of equipment specially made for an infiltration expert, including sound-insulated boots, nanochip apprehension gloves, \
				and a voice-masking balaclava.Too bad it's made in such a red color..."
	
/datum/opposing_force_equipment/clothing/helmet
	item_type = /obj/item/clothing/head/helmet/swat
	description = "A red-striped SWAT helmet. More robust than the standard-issue Nanotrasen security issue helmet, and spaceproof to boot."
	
/datum/opposing_force_equipment/clothing/syndierig
	item_type = /obj/item/storage/belt/military
	
/datum/opposing_force_equipment/clothing/assaultbelt
	item_type = /obj/item/storage/belt/military/assault
	
/datum/opposing_force_equipment/clothing/bandolier
	item_type = /obj/item/storage/belt/bandolier
	
/datum/opposing_force_equipment/clothing/bandolier
	item_type = /obj/item/storage/belt/grenade
	description = "A belt for holding grenades. Does not come with grenades unfortunately."
	
//NRI larping equipment here	
			
/datum/opposing_force_equipment/clothing/nrihelm
	item_type = /obj/item/clothing/head/helmet/rus_helmet/nri
	
/datum/opposing_force_equipment/clothing/nriberet
	item_type = /obj/item/clothing/head/beret/sec/nri
	name = "NRI Commander Beret"
	description = "An armored beret worn by high ranking NRI officers"
	
/datum/opposing_force_equipment/clothing/reduthelm
	item_type = /obj/item/clothing/head/helmet/nri_heavy
	description = "A specialized ultra-heavy composite ballistic helmet stolen from space russians. Purpose-built for heavy duty combat, \
				or murder with a frying pan."

/datum/opposing_force_equipment/clothing/nrivest
	item_type = /obj/item/clothing/suit/armor/vest/russian/nri
	
/datum/opposing_force_equipment/clothing/redut
	item_type = /obj/item/clothing/suit/armor/heavy/nri
	
/datum/opposing_force_equipment/clothing/nrijumpsuit
	item_type = /obj/item/clothing/under/costume/nri
	
/datum/opposing_force_equipment/clothing/nribelt
	item_type = /obj/item/storage/belt/military/nri

//end of NRI larp equipment

/datum/opposing_force_equipment/clothing/holster
	item_type = /obj/item/storage/belt/holster/chameleon
	description = "A chameleon holster that fits into your belt designed to hold one sidearm and a spare load of ammo for it. Also allows you to spin \
				your revolver, if you have one."
				
/datum/opposing_force_equipment/clothing/holsternk
	item_type = /obj/item/storage/belt/holster/nukie
	description = "A holster retrieved from a nuclear operative. Able to hold any two types of weaponry or ammo as long as it is not extremely large. \
					Expect security to be not so friendly if they see you wearing one of these..."
				
/datum/opposing_force_equipment/clothing/gunman
	item_type = /obj/item/storage/box/syndie_kit/gunman_outfit //we need a proper loadout tab

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

/datum/opposing_force_equipment/gear/thermalgoggles
	item_type = /obj/item/clothing/glasses/thermal
	description = "A pair of thermal goggles. Cannot be chameleon disguised." 

/datum/opposing_force_equipment/gear/xraygoggles
	item_type = /obj/item/clothing/glasses/thermal/xray
	description = "A pair of low-light x-ray goggles manufactured by the Syndicate. Cannot be chameleon disguised. Makes wearer more vulnerable to bright lights."
	
/datum/opposing_force_equipment/gear/thermalgogglessyndi
	item_type = /obj/item/clothing/glasses/thermal/syndi
	description = "A pair of thermal goggles. Syndicate variant, which comes with the chameleon disguse module." 
	
/datum/opposing_force_equipment/gear/cloakerbelt
	item_type = /obj/item/shadowcloak
	description = "A belt that allows it's wearer to temporarily turn invisible. Only recharges in dark areas, use wisely."
	
/datum/opposing_force_equipment/gear/projector
	item_type = /obj/item/chameleon
	description = "A projector that allows its user to turn into any scanned object. Pairs well with a cluttered room and ambush weapon."
	
/datum/opposing_force_equipment/gear/box
	item_type = /obj/item/implanter/stealth
	description = "An implanter that grants you the ability to wield the ultimate in invisible box technology. Best used in conjunction with \
					a tape recorder playing Snake Eater."
	
/datum/opposing_force_equipment/gear/sechud
	item_type = /obj/item/clothing/glasses/hud/security/chameleon
	description = "A stolen Security HUD refitted with chameleon technology. Provides flash protection."
	
/datum/opposing_force_equipment/gear/aidetector
	item_type = /obj/item/multitool/ai_detect
	description = "A multitool that lets you see the AI's vision cone with an overlaid HUD and know if you're being watched."

/datum/opposing_force_equipment/gear/noslip
	item_type = /obj/item/clothing/shoes/chameleon/noslip
	description = "No-slip chameleon shoes, for when you plan on running through hell and back."
	
/datum/opposing_force_equipment/gear/cloakmod
	item_type = /obj/item/mod/module/stealth/ninja
	description = "An upgraded MODsuit cloaking module stolen from the Spider Clan's finest. Consumes less power than the standard, but is obviously illegal."
					
//BOMBS!EXPLOSIVES!!WOOOO!!one!
	
/datum/opposing_force_equipment/gear/henade
	item_type = /obj/item/grenade/syndieminibomb/concussion
	description = "A grenade intended to concuss and incapacitate enemies. Still rather explosive."
	
/datum/opposing_force_equipment/gear/fragnade
	item_type = /obj/item/grenade/frag
	description = "A fragmentation grenade that looses pieces of shrapnel after detonating for maximum injury."
	
/datum/opposing_force_equipment/gear/radnade
	item_type = /obj/item/grenade/gluon
	description = "A prototype grenade that freezes the target area and unleashes a wave of deadly radiation."
	
/datum/opposing_force_equipment/gear/c4
	item_type = /obj/item/grenade/c4
	description = "A brick of plastic explosives, for breaking open walls, doors, and optionally people."
	
/datum/opposing_force_equipment/gear/x4
	item_type = /obj/item/grenade/c4/x4
	description = "Similar to C4, but with a stronger blast that is directional instead of circular."

/datum/opposing_force_equipment/gear/extendedrag
	item_type = /obj/item/reagent_containers/glass/rag/large  
	description = "A damp rag made with extra absorbant materials. The perfectly innocent tool to kidnap your local assistant. \
			Apply up to 30u liquids and use combat mode to smother anyone not covering their mouth."
	
/**
 * OTHER
 */
/datum/opposing_force_equipment/other/
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER
	
/datum/opposing_force_equipment/other/uplink
	item_type = /obj/item/uplink/opfor
	name = "Syndicate Uplink"
	description = "An old-school syndicate uplink without a password and an empty TC account. Perfect for the aspiring operatives."
		
/datum/opposing_force_equipment/other/tc1
	item_type = item = /obj/item/stack/telecrystal
	name = "1 Raw Telecrystal"
	description = "A telecrystal in its rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."
	
/datum/opposing_force_equipment/other/tc5
	item_type = item = /obj/item/stack/telecrystal/five
	name = "5 Raw Telecrystals"
	description = "A bunch of telecrystals in their rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/other/tc20
	item_type = item = /obj/item/stack/telecrystal/twenty
	name = "20 Raw Telecrystals"
	description = "A bundle of telecrystals in their rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."
	//WHAT DO WE PUT HERE? MAYBE ADD EXPLOSIVES AS ITS CATEGORY?
