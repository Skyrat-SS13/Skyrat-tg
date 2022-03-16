//KITS
/datum/outfit/assaultops
	name = "I couldn't choose one!"

	mask = /obj/item/clothing/mask/gas/syndicate
	glasses = /obj/item/clothing/glasses/thermal
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/fireproof
	ears = /obj/item/radio/headset/syndicate/alt
	l_pocket = /obj/item/pinpointer/nuke/goldeneye
	id = /obj/item/card/id/advanced/chameleon
	back = /obj/item/mod/control/pre_equipped/nuclear
	suit_store = /obj/item/gun/ballistic/automatic/pistol/aps
	r_pocket = /obj/item/ammo_box/magazine/m9mm_aps
	belt = /obj/item/storage/belt/utility/syndicate

	var/command_radio = FALSE
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

	l_hand = /obj/item/gun/ballistic/automatic/pps

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/gun/energy/disabler,
		/obj/item/ammo_box/magazine/pps = 2,
		/obj/item/storage/medkit/tactical = 2,
		/obj/item/gun/medbeam,
	)

/datum/outfit/assaultops/heavy
	name = "Assault Operative - Heavy Gunner"

	l_hand = /obj/item/gun/ballistic/automatic/mg34/mg42

	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/knife/combat,
		/obj/item/gun/energy/disabler,
		/obj/item/grenade/syndieminibomb,
		/obj/item/ammo_box/magazine/mg42,
	)


/datum/outfit/assaultops/assault
	name = "Assault Operative - Assault"

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

/datum/outfit/assaultops/tech
	name = "Assault Operative - Tech"

	suit = /obj/item/mod/control/pre_equipped/elite/flamethrower

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

