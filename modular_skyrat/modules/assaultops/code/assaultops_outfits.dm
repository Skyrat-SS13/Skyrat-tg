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
	ears = /obj/item/radio/headset/syndicate/alt/assault
	l_pocket = /obj/item/modular_computer/tablet/nukeops
	id = /obj/item/card/id/advanced/chameleon
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	suit_store = /obj/item/gun/ballistic/automatic/pistol/aps
	r_pocket = /obj/item/ammo_box/magazine/m9mm_aps
	belt = /obj/item/storage/belt/utility/syndicate

	id_trim = /datum/id_trim/chameleon/operative

	var/command_radio = FALSE
	var/cqc = FALSE

/datum/outfit/assaultops/cqb
	name = "Assault Operative - CQB"

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/c20r,\
		/obj/item/ammo_box/magazine/smgm45=4,\
		)

	cqc = TRUE

/datum/outfit/assaultops/demoman
	name = "Assault Operative - Demolitions"

	belt = /obj/item/storage/belt/grenade/full
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/gyropistol,\
		/obj/item/ammo_box/magazine/m75=4,\
		/obj/item/implant/explosive/macro, \
		/obj/item/storage/box/assaultops/demoman
		)
	l_hand = /obj/item/clothing/suit/space/hardsuit/rd

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
		/obj/item/gun/ballistic/automatic/submachine_gun/pps,\
		/obj/item/ammo_box/magazine/pps=2,\
		/obj/item/storage/firstaid/tactical=2,\
		/obj/item/gun/medbeam)

/datum/outfit/assaultops/heavy
	name = "Assault Operative - Heavy Gunner"


	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler)

	r_hand = /obj/item/minigunpack

	r_pocket = /obj/item/grenade/syndieminibomb


/datum/outfit/assaultops/assault
	name = "Assault Operative - Assault"


	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/assault_rifle/akm,\
		/obj/item/ammo_box/magazine/akm=4,\
		/obj/item/grenade/syndieminibomb=2)

/datum/outfit/assaultops/sniper
	name = "Assault Operative - Sniper"


	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket,\
		/obj/item/ammo_box/magazine/sniper_rounds=4,\
		/obj/item/grenade/syndieminibomb=2)

/datum/outfit/assaultops/tech
	name = "Assault Operative - Tech"


	suit = /obj/item/clothing/suit/space/hardsuit/shielded

	belt = /obj/item/storage/belt/military/abductor/full/assaultops

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/battle_rifle/fg42,\
		/obj/item/ammo_box/magazine/fg42=4,\
		/obj/item/card/emag,\
		/obj/item/card/emag/doorjack)

/obj/item/storage/belt/military/abductor/full/assaultops
	name = "Assault Belt"
	desc = "A tactical belt full of highly advanced hacking equipment."

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
