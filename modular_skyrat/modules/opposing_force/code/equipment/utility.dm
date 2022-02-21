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
	description = "An implant that prevents you from dropping items in your hand involuntarily. Comes loaded in a syndicate autosurgeon."

/datum/opposing_force_equipment/gear/hackerman
	item_type = /obj/item/autosurgeon/organ/syndicate/hackerman
	name = "Hacking Arm Implant"
	description = "An advanced arm implant that comes with cutting edge hacking tools. Perfect for the cybernetically enhanced wirerunners."

/datum/opposing_force_equipment/gear/mulligan
	name = "Mulligan"
	item_type = /obj/item/reagent_containers/syringe/mulligan
	description = "A syringe containing a chemical that can completely change the user's identity."

/datum/opposing_force_equipment/gear/dump_eet
	name = "Crab-17 Phone"
	item_type = /obj/item/suspiciousphone
	description = "\"Bogdanoff, he did it.\" \"He bought?\" \"He went all in.\" \"Dump it.\"" // I'm sorry

/datum/opposing_force_equipment/gear/borer_egg
	name = "Cortical Borer Egg"
	item_type = /obj/effect/gibspawner/generic
	description = "The egg of a cortical borer. The cortical borer is a parasite that can produce chemicals upon command, as well as learn new chemicals through the blood if old enough."
	admin_note = "Allows a ghost to take control of a Cortical Borer."

/datum/opposing_force_equipment/gear/borer_egg/on_issue(mob/living/target)
	new /obj/effect/mob_spawn/ghost_role/borer_egg(get_turf(src))

/datum/opposing_force_equipment/gear/ventcrawl_book
	item_type = /obj/item/book/granter/traitsr/ventcrawl_book
	admin_note = "WARNING: Incredibly powerful, use discretion when handing this out."
