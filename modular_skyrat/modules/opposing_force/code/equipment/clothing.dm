/datum/opposing_force_equipment/clothing_syndicate
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_SYNDICATE

/datum/opposing_force_equipment/clothing_syndicate/operative
	name = "Syndicate Operative"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/operative

/obj/item/storage/backpack/duffelbag/syndie/operative/PopulateContents() //basically old insurgent bundle -nukie mod
	new /obj/item/clothing/under/syndicate(src)
	new /obj/item/clothing/under/syndicate/skirt(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/tackler/combat(src)
	new /obj/item/clothing/mask/gas/syndicate(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/storage/box/syndie_kit/space_suit(src)

/datum/opposing_force_equipment/clothing_syndicate/engineer
	name = "Syndicate Engineer"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/engineer

/obj/item/storage/backpack/duffelbag/syndie/engineer/PopulateContents()
	new /obj/item/clothing/under/syndicate/skyrat/overalls(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls/skirt(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/mask/gas/syndicate(src)
	new /obj/item/storage/belt/utility/syndicate(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/clothing/glasses/night(src)
	new /obj/item/storage/box/syndie_kit/space_suit(src)

/datum/opposing_force_equipment/clothing_syndicate/spy
	name = "Syndicate Spy"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/spy

/obj/item/storage/backpack/duffelbag/syndie/spy/PopulateContents()
	new /obj/item/clothing/under/suit/black/armoured(src)
	new /obj/item/clothing/under/suit/black/skirt/armoured(src)
	new /obj/item/clothing/suit/jacket/det_suit/noir/armoured(src)
	new /obj/item/storage/belt/holster/detective/dark(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)
	new /obj/item/clothing/mask/gas/syndicate/ds(src) //a red spy is in the base
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/hhmirror/syndie(src)
	new /obj/item/storage/box/syndie_kit/space_suit(src)

/datum/opposing_force_equipment/clothing_syndicate/maid
	name = "Syndicate Maid"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/maid

/obj/item/storage/backpack/duffelbag/syndie/maid/PopulateContents() //by far the weakest bundle
	new /obj/item/clothing/under/syndicate/skyrat/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_syndicate/cybersun_operative
	name = "Cybersun Operative"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/cybersun_operative

/obj/item/storage/backpack/duffelbag/syndie/cybersun_operative/PopulateContents() //drip maxxed
	new /obj/item/clothing/under/syndicate/combat(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/mask/gas/sechailer/syndicate(src)
	new /obj/item/clothing/glasses/meson/night(src)
	new /obj/item/storage/belt/military/assault(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_syndicate/cybersun_hacker
	name = "Cybersun Hacker"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/cybersun_hacker

/obj/item/storage/backpack/duffelbag/syndie/cybersun_hacker/PopulateContents()
	new /obj/item/clothing/under/syndicate/ninja(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/mask/gas/ninja(src)
	new /obj/item/clothing/glasses/hud/health/night/meson(src) //damn its sexy
	new /obj/item/storage/belt/military/assault(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_syndicate/lone_gunman
	name = "Lone Gunman"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/lone_gunman

/obj/item/storage/backpack/duffelbag/syndie/lone_gunman/PopulateContents()
	new /obj/item/clothing/under/pants/track/robohand(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/jacket/trenchcoat/gunman(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)


/datum/opposing_force_equipment/clothing_sol
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_SOL

/datum/opposing_force_equipment/clothing_sol/sol_militant
	name = "Sol Militant"
	admin_note = "Uniquely strong HEV armour."
	item_type = /obj/item/storage/backpack/ert/odst/hecu/sol_militant

/obj/item/storage/backpack/ert/odst/hecu/sol_militant/PopulateContents()
	new /obj/item/clothing/under/rank/security/officer/hecu(src)
	new /obj/item/clothing/suit/space/hev_suit/pcv(src)
	new /obj/item/clothing/head/helmet/space/hev_suit/pcv(src)
	new /obj/item/storage/belt/military/assault/hecu(src)
	new /obj/item/clothing/mask/gas/hecu2(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/glasses/night(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_sol/dogginos
	name = "Dogginos Courier"
	item_type = /obj/item/storage/backpack/satchel/leather/dogginos

/obj/item/storage/backpack/satchel/leather/dogginos/PopulateContents()
	new /obj/item/clothing/under/pizza(src)
	new /obj/item/clothing/suit/pizzaleader(src)
	new /obj/item/clothing/suit/toggle/jacket/hoodie/pizza(src)
	new /obj/item/clothing/head/pizza(src)
	new /obj/item/clothing/head/soft/red(src)
	new /obj/item/clothing/glasses/betterunshit(src)
	new /obj/item/clothing/mask/fakemoustache/italian(src)
	new /obj/item/clothing/shoes/sneakers/red(src)
	new /obj/item/radio/headset/headset_cent/impostorsr(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_sol/impostor
	name = "CentCom Impostor"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/impostor

/obj/item/storage/backpack/duffelbag/syndie/impostor/PopulateContents()
	new /obj/item/clothing/under/rank/centcom/officer(src)
	new /obj/item/clothing/under/rank/centcom/officer_skirt(src)
	new /obj/item/clothing/head/hats/centcom_cap(src)
	new /obj/item/clothing/suit/armor/centcom_formal(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/radio/headset/headset_cent/impostorsr(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clipboard(src)
	new /obj/item/card/id/advanced/chameleon/impostorsr(src) //this thing has bridge access, and no one knows about that
	new /obj/item/stamp/centcom(src)
	new /obj/item/clothing/gloves/combat(src)


/datum/opposing_force_equipment/clothing_pirate
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_PIRATE

/datum/opposing_force_equipment/clothing_pirate/space_pirate
	name = "Space Pirate"
	item_type = /obj/item/storage/backpack/duffelbag/syndie/space_pirate

/obj/item/storage/backpack/duffelbag/syndie/space_pirate/PopulateContents()
	new /obj/item/clothing/under/costume/pirate(src)
	new /obj/item/clothing/suit/space/pirate(src)
	new /obj/item/clothing/head/helmet/space/pirate(src)
	new /obj/item/clothing/head/costume/pirate/armored(src)
	new /obj/item/clothing/shoes/pirate/armored(src)
	new /obj/item/clothing/glasses/eyepatch(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_pirate/akula
	name = "Azulean Boarder"
	admin_note = "Uniquely spaceproofed."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/akula

/obj/item/storage/backpack/duffelbag/syndie/akula/PopulateContents()
	new /obj/item/clothing/under/skinsuit(src)
	new /obj/item/clothing/suit/armor/riot/skinsuit_armor(src)
	new /obj/item/clothing/head/helmet/space/skinsuit_helmet(src)
	new /obj/item/clothing/gloves/tackler/combat(src) //tackles in space
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)

/datum/opposing_force_equipment/clothing_pirate/nri_soldier
	name = "NRI Soldier"
	item_type = /obj/item/storage/backpack/industrial/cin_surplus/forest/nri_soldier

/obj/item/storage/backpack/industrial/cin_surplus/forest/nri_soldier/PopulateContents()
	new /obj/item/clothing/under/syndicate/rus_army(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/tackler/combat(src)
	new /obj/item/clothing/mask/gas/hecu2(src)
	new /obj/item/clothing/suit/armor/vest/marine(src)
	new /obj/item/clothing/head/beret/sec/nri(src)
	new /obj/item/storage/belt/military/nri/plus_mre(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/clothing/glasses/sunglasses(src)

/datum/opposing_force_equipment/clothing_pirate/heister
	name = "Professional"
	admin_note = "Has uniquely strong armour."
	item_type = /obj/item/storage/backpack/duffelbag/syndie/heister

/obj/item/storage/backpack/duffelbag/syndie/heister/PopulateContents()
	var/obj/item/clothing/new_mask = new /obj/item/clothing/mask/gas/clown_hat(src) //-animal mask +clow mask
	new_mask.set_armor(new_mask.get_armor().generate_new_with_specific(list(
		MELEE = 30,
		BULLET = 25,
		LASER = 25,
		ENERGY = 25,
		BOMB = 0,
		BIO = 0,
		FIRE = 100,
		ACID = 100,
	)))
	new /obj/item/storage/box/syndie_kit/space_suit(src)
	new /obj/item/clothing/gloves/latex/nitrile/heister(src)
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/under/suit/black/skirt(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/suit/jacket/det_suit/noir/heister(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/radio/headset/syndicate/alt(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/restraints/handcuffs/cable/zipties(src)
	new /obj/item/restraints/handcuffs/cable/zipties(src)


/datum/opposing_force_equipment/clothing_magic
	category = OPFOR_EQUIPMENT_CATEGORY_CLOTHING_MAGIC


