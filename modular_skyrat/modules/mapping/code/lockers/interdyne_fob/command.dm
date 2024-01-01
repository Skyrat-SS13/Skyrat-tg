/obj/structure/closet/secure_closet/interdynefob/sa_locker
	icon_door = "cap"
	icon_state = "cap"
	name = "\proper station admiral's locker"

/obj/item/clothing/accessory/medal/gold/admiral
	name = "medal of admiralty"
	desc = "A golden medal awarded exclusively to those promoted to the rank of captain. \
		It signifies the codified responsibilities of an Admiral to the Sothran Syndicate, and their undisputable authority over their crew."

/obj/item/storage/bag/garment/station_admiral
	name = "station admiral's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the station admiral."

/obj/item/storage/bag/garment/station_admiral/PopulateContents()
	new /obj/item/clothing/head/hats/hos/cap/syndicate(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/syndicate(src)
	new /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/syndicate/winter(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/accessory/medal/gold/admiral(src)

/obj/structure/closet/secure_closet/interdynefob/sa_locker/PopulateContents()
	..()

	new /obj/item/ammo_box/magazine/m9mm_aps(src)
	new /obj/item/storage/bag/garment/station_admiral(src)
	new /obj/item/radio/headset/interdyne/command(src)

/obj/structure/closet/secure_closet/interdynefob/maa_locker
	icon_door = "warden"
	icon_state = "warden"
	name = "master at arms' locker"
	req_access = list("syndicate_leader")

/obj/item/clothing/accessory/medal/silver/maa_medal
	name = "military excellence medal"
	desc = "The Sothran Syndicate's dictionary defines excellence as \"the ability to crush NT scum under one's boot\". \
		This is awarded to those rare operatives who fit that definition."

/obj/item/clothing/suit/armor/hos/maa_greatcoat
	name = "Master at Arms' armored greatcoat"
	desc = "A greatcoat enhanced with a special alloy for some extra protection and style for those with a likely chance to get bullied for being outside of the brig"

/obj/item/clothing/suit/armor/hos/trenchcoat/maa_greatcoat
	name = "Master at Arms' armored trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. It has little Syndicate logos sewn onto the shoulder badges with the letters 'MAA' just under it."

/obj/item/storage/bag/garment/master_arms
	name = "master at arms' garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the master at arms."

/obj/item/storage/bag/garment/master_arms/PopulateContents()
	new /obj/item/clothing/accessory/medal/silver/maa_medal(src)
	new /obj/item/clothing/suit/armor/vest/warden/syndicate(src)
	new /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate(src)
	new /obj/item/clothing/under/suit/skyrat/helltaker(src)
	new /obj/item/clothing/suit/armor/hos/maa_greatcoat(src)
	new /obj/item/clothing/head/beret/sec/navywarden/syndicate(src)
	new /obj/item/clothing/head/hats/hos/beret/syndicate(src)

/obj/structure/closet/secure_closet/interdynefob/maa_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/watertank/pepperspray(src)
	new /obj/item/gun/energy/disabler(src)
	new /obj/item/storage/bag/garment/master_arms(src)
	new /obj/item/radio/headset/interdyne(src)

/obj/structure/closet/secure_closet/interdynefob/cl_locker
	icon_door = "hop"
	icon_state = "hop"
	name = "\proper corporate liaison's locker"
	req_access = list("syndicate_leader")

/obj/item/clothing/neck/chaplain/black/cl_cloak
	name = "corporate liaison's cloak"
	desc = "A unique cloak that shimmers with the Corporate Liaison's emblem."

/obj/item/storage/bag/garment/corprate_liaison
	name = "corprate liaison's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the corprate liaison."

/obj/item/storage/bag/garment/corprate_liaison/PopulateContents()
	new /obj/item/clothing/under/syndicate/skyrat/baseball(src)
	new /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate(src)
	new /obj/item/clothing/under/suit/skyrat/helltaker(src)
	new /obj/item/clothing/neck/chaplain/black/cl_cloak(src)
	new /obj/item/clothing/head/hats/hos/beret/syndicate(src)
	new /obj/item/clothing/glasses/sunglasses(src)

/obj/structure/closet/secure_closet/interdynefob/cl_locker/PopulateContents()
	..()

	new /obj/item/card/id/advanced/chameleon/black(src)
	new /obj/item/card/id/advanced/chameleon/black(src)
	new /obj/item/card/id/advanced/chameleon/black(src)
	new /obj/item/encryptionkey/headset_syndicate/interdyne(src)
	new /obj/item/encryptionkey/headset_syndicate/interdyne(src)
	new /obj/item/encryptionkey/headset_syndicate/interdyne(src)
	new /obj/item/language_manual/codespeak_manual/unlimited(src)
	new /obj/item/storage/bag/garment/corprate_liaison(src)
	new /obj/item/radio/headset/interdyne/command(src)
