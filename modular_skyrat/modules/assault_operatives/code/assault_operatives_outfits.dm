//KITS
/datum/outfit/assaultops
	name = "I couldn't choose one!"

	head = /obj/item/clothing/head/helmet/swat
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

/datum/outfit/assaultops/post_equip(mob/living/carbon/human/H)
	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_SYNDICATE)
	R.freqlock = TRUE
	if(command_radio)
		R.command = TRUE

	if(cqc)
		var/datum/martial_art/cqc/MA = new
		MA.teach(H)

	var/obj/item/implant/weapons_auth/W = new/obj/item/implant/weapons_auth(H)
	W.implant(H)

	H.update_icons()

/datum/outfit/assaultops/cqb
	name = "Assault Operative - CQB"

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/knife/combat,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/c20r,\
		/obj/item/ammo_box/magazine/smgm45=4,\
		)

	cqc = TRUE

/datum/outfit/assaultops/demoman
	name = "Assault Operative - Demolitions"

	belt = /obj/item/storage/belt/grenade/full
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/knife/combat,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/shotgun/bulldog,\
		/obj/item/ammo_box/magazine/m12g=4,\
		/obj/item/implant/explosive/macro, \
		/obj/item/storage/box/assaultops/demoman
		)
	l_hand = /obj/item/mod/control/pre_equipped/research

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
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/pps,\
		/obj/item/ammo_box/magazine/pps=2,\
		/obj/item/storage/medkit/tactical=2,\
		/obj/item/gun/medbeam)

/datum/outfit/assaultops/heavy
	name = "Assault Operative - Heavy Gunner"

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/knife/combat,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/mg34/mg42,\
		/obj/item/ammo_box/magazine/mg42=1,\
		/obj/item/grenade/syndieminibomb)


/datum/outfit/assaultops/assault
	name = "Assault Operative - Assault"

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/knife/combat,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/stg,\
		/obj/item/ammo_box/magazine/stg=4,\
		/obj/item/grenade/syndieminibomb=2)

/datum/outfit/assaultops/sniper
	name = "Assault Operative - Sniper"


	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/knife/combat,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket,\
		/obj/item/ammo_box/magazine/sniper_rounds=4,\
		/obj/item/grenade/syndieminibomb=2)

/datum/outfit/assaultops/tech
	name = "Assault Operative - Tech"

	suit = /obj/item/mod/control/pre_equipped/elite/flamethrower

	belt = /obj/item/storage/belt/military/abductor/full/assaultops

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/knife/combat,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/fg42,\
		/obj/item/ammo_box/magazine/fg42=4,\
		/obj/item/card/emag,\
		/obj/item/card/emag/doorjack)

/obj/item/storage/belt/military/abductor/full/assaultops
	name = "Assault Belt"
	desc = "A tactical belt full of highly advanced hacking equipment."

