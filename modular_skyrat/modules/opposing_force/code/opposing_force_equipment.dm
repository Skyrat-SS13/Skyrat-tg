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
	description = "A semi-automatic .45 caliber pistol. Gold standard for sidearms."

/datum/opposing_force_equipment/gun/m16
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/m16

/datum/opposing_force_equipment/gun/m16m
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/m16/modern

/datum/opposing_force_equipment/gun/m16patriot
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/m16/modern/v2

/datum/opposing_force_equipment/gun/akm
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/akm

/datum/opposing_force_equipment/gun/akmm
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/akm/modern

/datum/opposing_force_equipment/gun/mp40
	item_type = /obj/item/gun/ballistic/automatic/submachine_gun/mp40

/datum/opposing_force_equipment/gun/mp40m/modern
	item_type = /obj/item/gun/ballistic/automatic/submachine_gun/mp40

/datum/opposing_force_equipment/gun/pps
	item_type = /obj/item/gun/ballistic/automatic/submachine_gun/pps
	description = "A very cheap, barely reliable reproduction of a personal defense weapon based on the original Soviet model. Not nearly as infamous as the Mosin. \
		Compact enough to fit in your backpack!"

/datum/opposing_force_equipment/gun/ppsh
	item_type = /obj/item/gun/ballistic/automatic/submachine_gun/ppsh

/datum/opposing_force_equipment/gun/ppshm
	item_type = /obj/item/gun/ballistic/automatic/submachine_gun/ppsh/modern

/datum/opposing_force_equipment/gun/stg
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/stg

/datum/opposing_force_equipment/gun/stgm
	item_type = /obj/item/gun/ballistic/automatic/assault_rifle/stg/modern

/datum/opposing_force_equipment/gun/fg42
	item_type = /obj/item/gun/ballistic/automatic/battle_rifle/fg42

/datum/opposing_force_equipment/gun/fg42m
	item_type = /obj/item/gun/ballistic/automatic/battle_rifle/fg42/modern

/datum/opposing_force_equipment/gun/uzi
	item_type = /obj/item/gun/ballistic/automatic/mini_uzi
	description = "The uzi nine millimeter, a timeless submachinegun for a warrior out of time."

/datum/opposing_force_equipment/gun/mg34
	item_type = /obj/item/gun/ballistic/automatic/mg34

/datum/opposing_force_equipment/gun/cfa
	item_type = /obj/item/gun/ballistic/automatic/cfa_rifle

/datum/opposing_force_equipment/gun/m23
	item_type = /obj/item/gun/ballistic/shotgun/m23
	description = "An eight-round pump-action shotgun found in an old station. Comes loaded with beanbag shells but can take any 12 gauge load."

/datum/opposing_force_equipment/gun/as2
	item_type = /obj/item/gun/ballistic/shotgun/automatic/as2
	description = "A compact version of the combat shotgun. Comes with a four-round tube and can be silenced as well as holstered to your belt or vest. \
		Comes loaded with slugs but can take any 12 gauge load."

/datum/opposing_force_equipment/gun/sas14
	item_type = /obj/item/gun/ballistic/shotgun/sas14
	description = "A semi-automatic, magazine-fed shotgun chambered in 14 gauge. Standard mags can take five rounds. \
		Despite the lower damage of 14 gauge, it can load the highly praised taser shots."

/datum/opposing_force_equipment/gun/g357
	item_type = /obj/item/gun/ballistic/revolver
	description = "A .357 magnum revolver. Seven shots, more than enough to kill anything that moves."

/datum/opposing_force_equipment/gun/mateba
	item_type = /obj/item/gun/ballistic/revolver/mateba

/datum/opposing_force_equipment/gun/nagant
	item_type = /obj/item/gun/ballistic/revolver/nagant

/datum/opposing_force_equipment/gun/snub
	item_type = /obj/item/gun/ballistic/automatic/pistol/cfa_snub

/datum/opposing_force_equipment/gun/ruby
	item_type = /obj/item/gun/ballistic/automatic/pistol/cfa_ruby

/datum/opposing_force_equipment/gun/wildcat
	item_type = /obj/item/gun/ballistic/automatic/cfa_wildcat

//oddities
/datum/opposing_force_equipment/gun/ninjastar
	item_type = /obj/item/throwing_star
	description = "Be the maintenance ninja you always wanted to be. Does not come with multi-throwing cybernetics"

/datum/opposing_force_equipment/gun/throwing_weapons
	item_type = /obj/item/storage/box/syndie_kit/throwing_weapons
	description = "A box of shurikens and reinforced bolas from ancient Earth martial arts. They are highly effective \
		throwing weapons. The bolas can knock a target down and the shurikens will embed into limbs."
	name = "Box of Throwing Weapons"

/datum/opposing_force_equipment/gun/origami
	item_type = /obj/item/storage/box/syndie_kit/origami_bundle
	description = "A box containing a guide on how to craft masterful works of origami, allowing you to transform normal pieces of paper into \
		perfectly aerodynamic (and potentially lethal) paper airplanes."



/**
 * AMMO
 */
/datum/opposing_force_equipment/ammo
	category = OPFOR_EQUIPMENT_CATEGORY_AMMUNITION

/datum/opposing_force_equipment/ammo/m45
	item_type = /obj/item/ammo_box/magazine/m45
	description = "An eight-round magazine for the M1911 pistol. Uses .45 caliber ammunition."

/datum/opposing_force_equipment/ammo/m16
	item_type = /obj/item/ammo_box/magazine/m16
	description = "A twenty-round magazine for the M16 assault rifle. Uses 5.56x45mm ammunition."

/datum/opposing_force_equipment/ammo/akm
	item_type = /obj/item/ammo_box/magazine/akm

/datum/opposing_force_equipment/ammo/akmbanan
	item_type = /obj/item/ammo_box/magazine/akm/banana

/datum/opposing_force_equipment/ammo/mp40
	item_type = /obj/item/ammo_box/magazine/mp40
	description = "A thirty-two round magazine for the MP-40. Uses 9x19mm ammunition."

/datum/opposing_force_equipment/ammo/pps
	item_type = /obj/item/ammo_box/magazine/pps

/datum/opposing_force_equipment/ammo/ppsh
	item_type = /obj/item/ammo_box/magazine/ppsh

/datum/opposing_force_equipment/ammo/stg
	item_type = /obj/item/ammo_box/magazine/stg

/datum/opposing_force_equipment/ammo/fg42
	item_type = /obj/item/ammo_box/magazine/fg42
	description = "A twenty round magazine for the FG-42. Uses 7.92×57mm ammunition."

/datum/opposing_force_equipment/ammo/m9mm
	item_type = /obj/item/ammo_box/magazine/uzim9mm
	description = "A thirty-two round magazine for the mini uzi. Uses 9x19mm ammunition."

/datum/opposing_force_equipment/ammo/mg34
	item_type = /obj/item/ammo_box/magazine/mg34

/datum/opposing_force_equipment/ammo/cm762
	item_type = /obj/item/ammo_box/magazine/cm762
	description = "7.62 bullets in a ten round magazine for Cantanheim 7.62 rifle."

/datum/opposing_force_equipment/ammo/a357
	item_type = /obj/item/ammo_box/a357
	description = "A seven-round .357 magnum speedloader for a revolver."

/datum/opposing_force_equipment/ammo/a357match
	item_type = /obj/item/ammo_box/a357/match
	description = "A seven-round .357 magnum speedloader for a revolver, loaded with match-grade ammunition that bounces off walls several times."

/datum/opposing_force_equipment/ammo/cfa_snub
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_snub

/datum/opposing_force_equipment/ammo/cfa_snubap
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_snub/ap

/datum/opposing_force_equipment/ammo/cfa_snubrubber
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_snub/rubber

/datum/opposing_force_equipment/ammo/cfa_snubincendiary
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_snub/incendiary

/datum/opposing_force_equipment/ammo/cfa_ruby
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby

/datum/opposing_force_equipment/ammo/cfa_rubyap
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/ap

/datum/opposing_force_equipment/ammo/cfa_rubyrubber
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber

/datum/opposing_force_equipment/ammo/cfa_rubyhp
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/hp

/datum/opposing_force_equipment/ammo/cfa_rubyincendiary
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/incendiary

/datum/opposing_force_equipment/ammo/wildcat
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat

/datum/opposing_force_equipment/ammo/wildcatap
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/ap

/datum/opposing_force_equipment/ammo/wildcatrubber
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/rubber

/datum/opposing_force_equipment/ammo/wildcatincendiary
	item_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat/incendiary
/**
 * MELEE WEAPONS
 */
/datum/opposing_force_equipment/melee
	category = OPFOR_EQUIPMENT_CATEGORY_MELEE_WEAPONS

/datum/opposing_force_equipment/melee/switchblade
	item_type = /obj/item/switchblade

/datum/opposing_force_equipment/melee/metalbat
	item_type = /obj/item/melee/baseball_bat/ablative
	description = "A highly reflective baseball bat for when you need to crack skulls and run away from security in the same night."

/datum/opposing_force_equipment/melee/esword
	item_type = /obj/item/melee/energy/sword
	description = "The energy sword is an edged weapon with a blade of pure energy. The sword is small enough to be \
		pocketed when inactive. Activating it produces a loud, distinctive noise."

/datum/opposing_force_equipment/melee/epirate
	item_type = /obj/item/melee/energy/sword/pirate
	description = "A variant of the energy sword styled as a cutlass. Pirate costume sold separately. Warranty void if bought."

/datum/opposing_force_equipment/melee/edagger
	item_type = /obj/item/pen/edagger
	name = "Energy Dagger"
	description = "A dagger made of energy that looks and functions as a pen when off."

/datum/opposing_force_equipment/melee/cutlass
	item_type = /obj/item/claymore/cutlass

/datum/opposing_force_equipment/melee/claymore
	item_type = /obj/item/claymore
	description = "An extremely sharp and robust sword perfect to cleave through any opposition. Also highly illegal."

/datum/opposing_force_equipment/melee/katana
	item_type = /obj/item/katana
	description = "An extremely sharp and robust sword folded over nine thousand times until perfection. Highly lethal and illegal."

/datum/opposing_force_equipment/melee/ekatana
	item_type = /obj/item/energy_katana
	description = "An energy katana seized from a dead Spider Clan ninja. As well as being highly robust, it allows the \
		user to teleport short distances using right-click."

/datum/opposing_force_equipment/melee/eswordarm
	item_type = /obj/item/autosurgeon/organ/syndicate/esword_arm
	name = "Energy Sword Arm Implant"
	description = "It's an energy sword, in your arm. Pretty decent for getting past stop-searches and assassinating people. Comes loaded in a Syndicate brand autosurgeon to boot!"

/datum/opposing_force_equipment/melee/powerfist
	item_type = /obj/item/melee/powerfist
	name = "Power Fist"
	description = "The power-fist is a metal gauntlet with a built-in piston-ram powered by an external gas supply.\
		Upon hitting a target, the piston-ram will extend forward to make contact for some serious damage. \
		Using a wrench on the piston valve will allow you to tweak the amount of gas used per punch to \
		deal extra damage and hit targets further. Use a screwdriver to take out any attached tanks."

//martialarts

/datum/opposing_force_equipment/melee/cqc
	item_type = /obj/item/book/granter/martial/cqc
	description = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."

/datum/opposing_force_equipment/melee/carp
	item_type = /obj/item/book/granter/martial/carp
	description = "This scroll contains the secrets of an ancient martial arts technique. You will master unarmed combat \
			and gain the ability to swat bullets from the air, but you will also refuse to use dishonorable ranged weaponry."

/datum/opposing_force_equipment/melee/kravmaga
	item_type = /obj/item/clothing/gloves/krav_maga/combatglovesplus //yes its a glove but it exists to give krav maga martial arts so its here

/**
 * ARMOR AND CLOTHES
 */
/datum/opposing_force_equipment/clothing
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING

/datum/opposing_force_equipment/clothing/syndiebag
	item_type = /obj/item/storage/backpack/duffelbag/syndie
	name = "Syndicate Brand Duffelbag"
	description = "Thanks to being made from a lighter yet sturdier material, this duffelbag holds just the same as any other duffelbag without the speed penalty of its counterparts."

/datum/opposing_force_equipment/clothing/vest
	item_type = /obj/item/clothing/suit/armor/vest
	description = "A basic armored vest, rated for all manner of protections."

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
				and a voice-masking balaclava. Too bad it's made in such a red color..."

/datum/opposing_force_equipment/clothing/helmet
	item_type = /obj/item/clothing/head/helmet/swat
	description = "A red-striped SWAT helmet. More robust than the standard-issue Nanotrasen security issue helmet, and spaceproof to boot."

/datum/opposing_force_equipment/clothing/syndierig
	item_type = /obj/item/storage/belt/military

/datum/opposing_force_equipment/clothing/assaultbelt
	item_type = /obj/item/storage/belt/military/assault

/datum/opposing_force_equipment/clothing/bandolier
	item_type = /obj/item/storage/belt/bandolier

/datum/opposing_force_equipment/clothing/grenades
	item_type = /obj/item/storage/belt/grenade
	description = "A belt for holding grenades. Does not come with grenades unfortunately."

//NRI larping equipment here

/datum/opposing_force_equipment/clothing/nrihelm
	item_type = /obj/item/clothing/head/helmet/rus_helmet/nri

/datum/opposing_force_equipment/clothing/nriberet
	item_type = /obj/item/clothing/head/beret/sec/nri
	name = "NRI Commander Beret"
	description = "An armored beret worn by high-ranking NRI officers"

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
	description = "A chameleon holster that fits into your belt. Designed to hold one sidearm and a spare load of ammunition, it also allows you to spin \
		your revolver, if you have one."

/datum/opposing_force_equipment/clothing/holsternk
	item_type = /obj/item/storage/belt/holster/nukie
	description = "A holster retrieved from a nuclear operative. Able to hold any two types of weaponry or ammo as long as it is not extremely large. \
		Expect security to be not so friendly if they see you wearing one of these..."

//modsuits in 2022

/datum/opposing_force_equipment/clothing/basicmod
	item_type = /obj/item/mod/control/pre_equipped/advanced

/datum/opposing_force_equipment/clothing/syndiemod
	item_type = /obj/item/mod/control/pre_equipped/traitor

/datum/opposing_force_equipment/clothing/nukiemod
	item_type = /obj/item/mod/control/pre_equipped/nuclear

/datum/opposing_force_equipment/clothing/elitemod
	item_type = /obj/item/mod/control/pre_equipped/elite

/**
 * UTILITY ITEMS
 */
/datum/opposing_force_equipment/gear/
	category = OPFOR_EQUIPMENT_CATEGORY_UTILITY

/datum/opposing_force_equipment/gear/emag
	name = "Cryptographic Sequencer"
	item_type = /obj/item/card/emag
	description = "An electromagnetic ID card used to break machinery and disable safeties. Notoriously used by Syndicate agents, now commonly traded hardware at blackmarkets."

/datum/opposing_force_equipment/gear/stoolbox
	item_type = /obj/item/storage/toolbox/syndicate
	description = "A fully-kitted toolbox scavenged from maintenance by our highly-paid monkeys. The toolbox \
		itself is weighted especially to bash any head in and comes with a free pair of insulated combat gloves."

/datum/opposing_force_equipment/gear/engichip
	item_type = /obj/item/skillchip/job/engineer
	description = "A skillchip that, when installed, allows the user to recognise airlock and APC wire layouts and understand their functionality at a glance. Highly valuable and sought after."

/datum/opposing_force_equipment/gear/roboticist
	item_type = /obj/item/skillchip/job/roboticist
	description = "A skillchip that, when installed, allows the user to recognise cyborg wire layouts and understand their functionality at a glance."

/datum/opposing_force_equipment/gear/tacticool
	item_type = /obj/item/skillchip/chameleon/reload

/datum/opposing_force_equipment/gear/thermalgoggles
	item_type = /obj/item/clothing/glasses/thermal
	description = "A pair of thermal goggles. Cannot be chameleon disguised."

/datum/opposing_force_equipment/gear/xraygoggles
	item_type = /obj/item/clothing/glasses/thermal/xray
	description = "A pair of low-light x-ray goggles manufactured by the Syndicate. Cannot be chameleon disguised. Makes wearer more vulnerable to bright lights."

/datum/opposing_force_equipment/gear/thermalgogglessyndi
	item_type = /obj/item/clothing/glasses/thermal/syndi
	description = "A Syndicate take on the classic thermal goggles, complete with chameleon disguise functionality."

/datum/opposing_force_equipment/gear/cloakerbelt
	item_type = /obj/item/shadowcloak
	description = "A belt that allows its wearer to temporarily turn invisible. Only recharges in dark areas. Use wisely."

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

/datum/opposing_force_equipment/gear/suppressor
	item_type = /obj/item/suppressor

/datum/opposing_force_equipment/gear/extendedrag
	item_type = /obj/item/reagent_containers/glass/rag/large
	description = "A damp rag made with extra absorbant materials. The perfectly innocent tool to kidnap your local assistant. \
			Apply up to 30u liquids and use combat mode to smother anyone not covering their mouth."

/datum/opposing_force_equipment/gear/nodrop
	item_type = /obj/item/autosurgeon/organ/syndicate/nodrop
	name = "Anti Drop Implant"
	description = "An implant that prevents you from dropping items in your hand involuntarily. Comes loaded in a syndicate autosurgeon"

/datum/opposing_force_equipment/gear/hackerman
	item_type = /obj/item/autosurgeon/organ/syndicate/hackerman
	name = "Hacking Arm Implant"
	description = "An advanced arm implant that comes with cutting edge hacking tools. Perfect for the cybernetically enhanced wirerunners."

/**
 * EXPLOSIVES
 */
/datum/opposing_force_equipment/bomb
	category = OPFOR_EQUIPMENT_CATEGORY_EXPLOSIVES

/datum/opposing_force_equipment/bomb/henade
	item_type = /obj/item/grenade/syndieminibomb/concussion
	description = "A grenade intended to concuss and incapacitate enemies. Still rather explosive."

/datum/opposing_force_equipment/bomb/fragnade
	item_type = /obj/item/grenade/frag
	description = "A fragmentation grenade that looses pieces of shrapnel after detonating for maximum injury."

/datum/opposing_force_equipment/bomb/radnade
	item_type = /obj/item/grenade/gluon
	description = "A prototype grenade that freezes the target area and unleashes a wave of deadly radiation."

/datum/opposing_force_equipment/bomb/c4
	item_type = /obj/item/grenade/c4
	description = "A brick of plastic explosives, for breaking open walls, doors, and optionally people."

/datum/opposing_force_equipment/bomb/x4
	item_type = /obj/item/grenade/c4/x4
	description = "Similar to C4, but with a stronger blast that is directional instead of circular."

/**
 * LOADOUTS
 */
/datum/opposing_force_equipment/loadout
	category = OPFOR_EQUIPMENT_CATEGORY_LOADOUT

/datum/opposing_force_equipment/loadout/gunman
	item_type = /obj/item/storage/box/syndie_kit/gunman_outfit

/datum/opposing_force_equipment/loadout/grenadier
	item_type = /obj/item/storage/belt/grenade/full
	name = "Grenadier Kit"
	description = "A belt full of grenades and bombs. May gods have mercy upon us if they approve this."

/**
 * OTHER
 */
/datum/opposing_force_equipment/other
	category = OPFOR_EQUIPMENT_CATEGORY_OTHER

/datum/opposing_force_equipment/other/uplink
	item_type = /obj/item/uplink/opfor
	name = "Syndicate Uplink"
	description = "An old-school syndicate uplink without a password and an empty TC account. Perfect for the aspiring operatives."

/datum/opposing_force_equipment/other/tc1
	item_type = /obj/item/stack/telecrystal
	name = "1 Raw Telecrystal"
	description = "A telecrystal in its rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/other/tc5
	item_type = /obj/item/stack/telecrystal/five
	name = "5 Raw Telecrystals"
	description = "A bunch of telecrystals in their rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/other/tc20
	item_type = /obj/item/stack/telecrystal/twenty
	name = "20 Raw Telecrystals"
	description = "A bundle of telecrystals in their rawest and purest form; can be utilized on active uplinks to increase their telecrystal count."

/datum/opposing_force_equipment/other/cashcase
	item_type = /obj/item/storage/secure/briefcase/syndie
	name = "Syndicate Briefcase Full of Cash"
	description = "A secure briefcase containing 5000 space credits. Useful for bribing personnel, or purchasing goods \
			and services at lucrative prices. The briefcase also feels a little heavier to hold; it has been \
			manufactured to pack a little bit more of a punch if your client needs some convincing."

/datum/opposing_force_equipment/other/c10k
	name = "10000 Space Cash Bill"
	item_type = /obj/item/stack/spacecash/c10000
	description = "Cold hard cash. When you REALLY need to bribe or buy your way in. Or to payroll your gangmembers."
