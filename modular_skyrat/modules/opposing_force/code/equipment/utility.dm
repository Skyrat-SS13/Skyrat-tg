/datum/opposing_force_equipment/gear
	category = OPFOR_EQUIPMENT_CATEGORY_UTILITY

/datum/opposing_force_equipment/gear/emag
	name = "Cryptographic Sequencer"
	item_type = /obj/item/card/emag
	description = "An electromagnetic ID card used to break machinery and disable safeties. Notoriously used by Syndicate agents, now commonly traded hardware at blackmarkets."

/datum/opposing_force_equipment/gear/doormag
	name = "Airlock Override Card"
	item_type = /obj/item/card/emag/doorjack
	description = "Identifies commonly as a \"doorjack\", this illegally modified ID card can disrupt airlock electronics. Has a self recharging cell."

/datum/opposing_force_equipment/gear/stoolbox
	item_type = /obj/item/storage/toolbox/syndicate
	description = "A fully-kitted toolbox scavenged from maintenance by our highly-paid monkeys. The toolbox \
		itself is weighted especially to bash any head in and comes with a free pair of insulated combat gloves."

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
	name = "Chameleon Projector"
	item_type = /obj/item/chameleon
	description = "A projector that allows its user to turn into any scanned object. Pairs well with a cluttered room and ambush weapon."

/datum/opposing_force_equipment/gear/sechud
	item_type = /obj/item/clothing/glasses/hud/security/chameleon
	description = "A stolen Security HUD refitted with chameleon technology. Provides flash protection."

/datum/opposing_force_equipment/gear/aidetector
	name = "AI Detector Multitool"
	item_type = /obj/item/multitool/ai_detect
	description = "A multitool that lets you see the AI's vision cone with an overlaid HUD and know if you're being watched."

/datum/opposing_force_equipment/gear/noslip
	name = "Chameleon No-Slips"
	item_type = /obj/item/clothing/shoes/chameleon/noslip
	description = "No-slip chameleon shoes, for when you plan on running through hell and back."

/datum/opposing_force_equipment/gear/suppressor
	item_type = /obj/item/suppressor

/datum/opposing_force_equipment/gear/extendedrag
	item_type = /obj/item/reagent_containers/glass/rag/large
	description = "A damp rag made with extra absorbant materials. The perfectly innocent tool to kidnap your local assistant. \
			Apply up to 30u liquids and use combat mode to smother anyone not covering their mouth."

/datum/opposing_force_equipment/gear/mulligan
	name = "Mulligan"
	item_type = /obj/item/reagent_containers/syringe/mulligan
	description = "A syringe containing a chemical that can completely change the user's identity."

/* Removing it for lag-related reason, for now. Might make it permanent later.
/datum/opposing_force_equipment/gear/dump_eet
	name = "Crab-17 Phone"
	item_type = /obj/item/suspiciousphone
	description = "\"Bogdanoff, he did it.\" \"He bought?\" \"He went all in.\" \"Dump it.\"" // I'm sorry
*/

/datum/opposing_force_equipment/gear/borer_egg
	name = "Cortical Borer Egg"
	item_type = /obj/effect/gibspawner/generic
	description = "The egg of a cortical borer. The cortical borer is a parasite that can produce chemicals upon command, as well as learn new chemicals through the blood if old enough."
	admin_note = "Allows a ghost to take control of a Cortical Borer."

/datum/opposing_force_equipment/gear/borer_egg/on_issue(mob/living/target)
	new /obj/effect/mob_spawn/ghost_role/borer_egg/opfor(get_turf(target))

/datum/opposing_force_equipment/gear/ventcrawl_book
	item_type = /obj/item/book/granter/traitsr/ventcrawl_book
	admin_note = "WARNING: Incredibly powerful, use discretion when handing this out."

/datum/opposing_force_equipment/gear/holoparasite
	item_type = /obj/item/guardiancreator/tech/choose/traitor
	admin_note = "Lets a ghost take control of a guardian spirit bound to the user."

/datum/opposing_force_equipment/gear/launchpad
	name = "Briefcase Launchpad"
	item_type = /obj/item/storage/briefcase/launchpad
	description = "A briefcase containing a launchpad, a device able to teleport items and people to and from targets up to eight tiles away from the briefcase. \
			Also includes a remote control, disguised as an ordinary folder. Touch the briefcase with the remote to link it."

/datum/opposing_force_equipment/gear/camera_bug
	name = "Camera Bug"
	item_type = /obj/item/camera_bug

/datum/opposing_force_equipment/gear/microlaser
	name = "Radioactive Microlaser"
	item_type = /obj/item/healthanalyzer/rad_laser
	description = "A radioactive microlaser disguised as a standard Nanotrasen health analyzer. When used, it emits a \
			powerful burst of radiation, which, after a short delay, can incapacitate all but the most protected \
			of humanoids."

/datum/opposing_force_equipment/gear/stimpack
	name = "Stimulant Medipen"
	item_type = /obj/item/reagent_containers/hypospray/medipen/stimulants

/datum/opposing_force_equipment/gear/hypnoflash
	name = "Hypnotic Flash"
	item_type = /obj/item/assembly/flash/hypnotic
	description = "A modified flash able to hypnotize targets. If the target is not in a mentally vulnerable state, it will only confuse and pacify them temporarily."
	admin_note = "Able to hypnotize people with the next phrase said after exposure."

/datum/opposing_force_equipment/gear/hypnobang
	name = "Hypnotic Flashbang"
	item_type = /obj/item/grenade/hypnotic
	description = "A modified flashbang able to hypnotize targets. If the target is not in a mentally vulnerable state, it will only confuse and pacify them temporarily."
	admin_note = "Able to hypnotize people with the next phrase said after exposure."

/datum/opposing_force_equipment/gear/agentcard
	name = "Agent Card"
	item_type = /obj/item/card/id/advanced/chameleon
	description = "A highly advanced chameleon ID card. Touch this card on another ID card or player to choose which accesses to copy. Has special magnetic properties which force it to the front of wallets."

/datum/opposing_force_equipment/gear/agentcarddeluxe
	name = "Deluxe Agent Identification Card"
	item_type = /obj/item/card/id/advanced/chameleon/black
	description = "Created by Cybersun Industries to be the ultimate for field operations, this upgraded Agent ID \
	comes with all the fluff of the original, but with an upgraded microchip - allowing for the storage of all \
	standard Nanotrasen access codes in one conveinent package. Now in glossy olive by default!"
	admin_note = "Has no limit on how many accesses it can store."

/datum/opposing_force_equipment/gear/chameleonheadsetdeluxe
	name = "Advanced Chameleon Headset"
	item_type = /obj/item/radio/headset/chameleon/advanced
	description = "A premium model Chameleon Headset. All the features you love of the original, but now with flashbang \
	protection, voice amplification, memory-foam, HD Sound Quality, and extra-wide spectrum dial. Usually reserved \
	for high-ranking Cybersun officers, a few spares have been reserved for field agents."

/datum/opposing_force_equipment/gear/syndiejaws
	name = "Syndicate Jaws of Life"
	item_type = /obj/item/crowbar/power/syndicate
	description = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
	In its crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or its departments."

/datum/opposing_force_equipment/gear/combatmedkit
	name = "Syndicate Combat Medic Kit"
	item_type = /obj/item/storage/medkit/tactical
	description = "This first aid kit is a suspicious brown and red. Included is a combat stimulant injector \
			for rapid healing, a medical night vision HUD for quick identification of injured personnel, \
			and other supplies helpful for a field medic."

/datum/opposing_force_equipment/gear/ai_module
	name = "Syndicate AI Law Module"
	item_type = /obj/item/ai_module/syndicate
	description = "When used with an upload console, this module allows you to upload priority laws to an artificial intelligence. \
			Be careful with wording, as artificial intelligences may look for loopholes to exploit."

/datum/opposing_force_equipment/gear/powersink
	name = "Power Sink"
	item_type = /obj/item/powersink
	description = "When screwed to wiring attached to a power grid and activated, this large device lights up and places excessive \
			load on the grid, causing a station-wide blackout. The sink is large and cannot be stored in most \
			traditional bags and boxes. Caution: Will explode if the powernet contains sufficient amounts of energy."
	admin_note = "Drains power from the station, explodes if overloaded."

/datum/opposing_force_equipment/gear/gorilla_cubes
	name = "Box of Gorilla Cubes"
	item_type = /obj/item/storage/box/gorillacubes
	description = "A box with three Waffle Co. brand gorilla cubes. Eat big to get big. \
			Caution: Product may rehydrate when exposed to water."

/datum/opposing_force_equipment/gear/sentry_gun
	name = "Toolbox Sentry Gun"
	item_type = /obj/item/storage/toolbox/emergency/turret
	description = "A disposable sentry gun deployment system cleverly disguised as a toolbox, apply wrench for functionality."

/datum/opposing_force_equipment/gear/cloak_mod
	item_type = /obj/item/mod/module/stealth/ninja
	description = "An upgraded MODsuit cloaking module stolen from the Spider Clan's finest. Consumes less power than the standard, but is obviously illegal."

/datum/opposing_force_equipment/gear/chameleon
	item_type = /obj/item/mod/module/chameleon
	description = "A module that enables the user to disguise their MODsuit as any other type. Only works while undeployed."

/datum/opposing_force_equipment/gear/thermal_mod
	item_type = /obj/item/mod/module/visor/thermal
	description = "A visor module for a MODsuit that allows the user to see heat signatures through hard surfaces."

/datum/opposing_force_equipment/gear/noslip_mod
	item_type = /obj/item/mod/module/noslip
	description = "A module that prohibits you from slipping on slippery surfaces without the bulk of magboots."

/datum/opposing_force_equipment/gear/jetpack_mod
	item_type = /obj/item/mod/module/jetpack/advanced
	description = "A jetpack usually reserved for Syndicate MODsuits, this jetpack had the safety limiters removed, allowing it to move much faster in space."

/datum/opposing_force_equipment/gear/energyshield_mod
	item_type = /obj/item/mod/module/energy_shield
	description = "A highly illegal MODsuit module that projects a shield of energy around you, temporarily blocking conventional kinetic and laser projectiles."

/datum/opposing_force_equipment/gear/biteof87_mod
	item_type = /obj/item/mod/module/springlock/bite_of_87
	description = "An advanced springlock module that allows the user to enter and exit their MODsuit at extremely fast speeds. There's a scratched-off warning label on the back."

/datum/opposing_force_equipment/gear/flamethrower_mod
	item_type = /obj/item/mod/module/flamethrower
	description = "A module that allows the user to fire flames at a target from their wrist."
