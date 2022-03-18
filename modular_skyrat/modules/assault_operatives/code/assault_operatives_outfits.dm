GLOBAL_LIST_INIT(assaultops_equipment, build_assaultops_equipment())

/datum/assaultops_outfit
	/// The name of this outfit, if not set, defaults to the outfit name.
	var/name
	/// Our description to display what this outfit is.
	var/description = "No description set"
	/// The icon we pass to TGUI.
	var/icon = "cog"
	/// The linked outfit.
	var/datum/outfit/assaultops/outfit = /datum/outfit/assaultops

/// Builds a list of available assaultops equipment.
/proc/build_assaultops_equipment()
	var/list/equipment_list = list()
	for(var/datum/assaultops_outfit/iterating_assaultops_outfit as anything in subtypesof(/datum/assaultops_outfit))
		var/datum/assaultops_outfit/spawned_assaultops_outfit = new iterating_assaultops_outfit()
		spawned_assaultops_outfit.name ||= initial(spawned_assaultops_outfit.outfit.name)
		equipment_list += spawned_assaultops_outfit
	return equipment_list

/datum/assaultops_outfit/cqb
	name = "Close Quarters Combat"
	description = "A class that excels in close quarters combat."
	outfit = /datum/outfit/assaultops/cqb
	icon = "hand-back-fist"

/datum/assaultops_outfit/demoman
	name = "Demolitions Expert"
	description = "A class that excels in 'controlled demolitions', or to blow shit up, in other words."
	outfit = /datum/outfit/assaultops/demoman
	icon = "bomb"

/datum/assaultops_outfit/medic
	name = "Medic"
	description = "A class that excels in healing."
	outfit = /datum/outfit/assaultops/medic
	icon = "syringe"

/datum/assaultops_outfit/heavy
	name = "Heavy Weapons Specialist"
	description = "A class that excels in heavy weapons. You get the big guns."
	outfit = /datum/outfit/assaultops/heavy
	icon = "weight-hanging"

/datum/assaultops_outfit/assault
	name = "Infantry Man"
	description = "A class that is a well rounded class, capable of taking on any situation."
	outfit = /datum/outfit/assaultops/assault
	icon = "running"

/datum/assaultops_outfit/sniper
	name = "Sniper"
	description = "A class that excels in long range combat."
	outfit = /datum/outfit/assaultops/sniper
	icon = "binoculars"

/datum/assaultops_outfit/engineer
	name = "Engineer"
	description = "A class that excels in hacking and engineering."
	outfit = /datum/outfit/assaultops/engineer
	icon = "wrench"

//KITS
/datum/outfit/assaultops
	name = "Assault Ops - Default"

	mask = /obj/item/clothing/mask/gas/syndicate
	glasses = /obj/item/clothing/glasses/thermal
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/fireproof
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	belt = /obj/item/storage/belt/utility/syndicate

	/// Do we spawn with a command radio?
	var/command_radio = FALSE
	/// Do we give the mob CQC?
	var/cqc = FALSE

/datum/outfit/assaultops/post_equip(mob/living/carbon/human/equipping_human)
	var/obj/item/radio/radio = equipping_human.ears
	radio.set_frequency(FREQ_SYNDICATE)
	radio.freqlock = TRUE
	if(command_radio)
		radio.command = TRUE

	if(cqc)
		var/datum/martial_art/cqc/martial_arts = new
		martial_arts.teach(equipping_human)

	var/obj/item/implant/weapons_auth/weapons_authorisation = new/obj/item/implant/weapons_auth(equipping_human)
	weapons_authorisation.implant(equipping_human)

	equipping_human.update_icons()

/datum/outfit/assaultops/cqb
	name = "Assault Operative - CQB"

	l_hand = /obj/item/gun/ballistic/automatic/c20r

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/gun/energy/disabler,
		/obj/item/ammo_box/magazine/smgm45 = 4,
	)

	cqc = TRUE

/datum/outfit/assaultops/demoman
	name = "Assault Operative - Demolitions"

	belt = /obj/item/storage/belt/grenade/full

	r_hand = /obj/item/gun/ballistic/shotgun/bulldog

	l_hand = /obj/item/mod/control/pre_equipped/research

	implants = list(/obj/item/implant/explosive/macro)

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/gun/energy/disabler,
		/obj/item/implant/explosive/macro,
		/obj/item/storage/box/assaultops/demoman,
		/obj/item/ammo_box/magazine/m12g = 4,
	)


/obj/item/storage/box/assaultops/demoman
	name = "Assault Operative - Demolitions"

/obj/item/storage/box/assaultops/demoman/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/grenade/syndieminibomb(src)
		new /obj/item/grenade/c4/x4(src)

/datum/outfit/assaultops/medic
	name = "Assault Operative - Medic"

	glasses = /obj/item/clothing/glasses/hud/health

	belt = /obj/item/storage/belt/medical/paramedic

	l_hand = /obj/item/gun/ballistic/automatic/p90

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/gun/energy/disabler,
		/obj/item/ammo_box/magazine/p90 = 2,
		/obj/item/storage/medkit/tactical = 2,
		/obj/item/gun/medbeam,
	)

/datum/outfit/assaultops/heavy
	name = "Assault Operative - Heavy Gunner"

	l_hand = /obj/item/gun/ballistic/automatic/pitbull/pulse/r40


	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/gun/energy/disabler,
		/obj/item/grenade/syndieminibomb,
		/obj/item/ammo_box/magazine/pulse/r40 = 4,
	)


/datum/outfit/assaultops/assault
	name = "Assault Operative - Infantry"

	l_hand = /obj/item/gun/ballistic/automatic/stg

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/grenade/syndieminibomb = 2,
		/obj/item/ammo_box/magazine/stg = 4,
	)

/datum/outfit/assaultops/sniper
	name = "Assault Operative - Sniper"

	l_hand = /obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/gun/energy/disabler,
		/obj/item/grenade/syndieminibomb = 2,
		/obj/item/ammo_box/magazine/sniper_rounds = 4,
	)

/datum/outfit/assaultops/engineer
	name = "Assault Operative - Engineer"

	back = /obj/item/mod/control/pre_equipped/elite/flamethrower

	belt = /obj/item/storage/belt/military/abductor/full/assaultops

	l_hand = /obj/item/gun/ballistic/automatic/fg42

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/gun/energy/disabler,
		/obj/item/card/emag,
		/obj/item/card/emag/doorjack,
		/obj/item/ammo_box/magazine/fg42 = 4,
	)

/obj/item/storage/belt/military/abductor/full/assaultops
	name = "Assault Belt"
	desc = "A tactical belt full of highly advanced hacking equipment."

