//Use this to add item variations

/obj/item/uplink/opfor
	name = "old radio"
	desc = "A dusty and old looking radio."

/obj/item/uplink/old/Initialize(mapload, owner, tc_amount = 0)
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
 	body_parts_covered = CHEST|GROIN|ARMS //does not protect the legs since we have damn combat shoes
	armor = list(MELEE = 45, BULLET = 40, LASER = 40, ENERGY = 50, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10) //makes it in line with the rest of the armor
	
/obj/item/storage/box/syndie_kit/gunman_outfit/PopulateContents()
	new /obj/item/clothing/under/pants/black/robohand
	new /obj/item/clothing/glasses/sunglasses/robohand
	new /obj/item/clothing/suit/armor/vest/leather/gunman
	new /obj/item/clothing/shoes/combat

// 45, 40 armor on general without a helmet. 
