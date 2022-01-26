//Use this to add item variations

/obj/item/uplink/opfor
	name = "old radio"
	desc = "A dusty and old looking radio."

/obj/item/uplink/opfor/Initialize(mapload, owner, tc_amount = 0)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "old radio"



/obj/item/reagent_containers/glass/rag/large
    volume = 30
    amount_per_transfer_from_this = 30
    desc = "A damp rag made from a highly absorbant materials. Can hold up to 30u liquids. You can also clean up messes I guess."


/obj/item/storage/box/syndie_kit/gunman_outfit
	name = "Gunman Clothing Bundle"
	desc = "A box filled with armored and stylish clothing for the aspiring gunmans."

/obj/item/clothing/suit/armor/vest/leather/gunman
	name = "leather overcoat"
	desc = "An armored leather overcoat, intended as the go-to wear for any aspiring gunman."
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list(MELEE = 45, BULLET = 40, LASER = 40, ENERGY = 50, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10) //makes it in line with the rest of the armor

/obj/item/storage/box/syndie_kit/gunman_outfit/PopulateContents() // 45, 40 armor on general without a helmet.
	new /obj/item/clothing/under/pants/black/robohand(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/armor/vest/leather/gunman(src)
	new /obj/item/clothing/shoes/combat(src)

/obj/item/ammo_box/magazine/m16/extended //i will add custom sprites to this
	name = "m4a1 magazine (5.56×45mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/m16/m16.dmi'
	icon_state = "5.56mm"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY




/obj/item/autosurgeon/organ/syndicate/hackerman
	starting_organ = /obj/item/organ/cyberimp/arm/hacker
