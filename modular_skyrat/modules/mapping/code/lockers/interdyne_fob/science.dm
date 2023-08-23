/obj/structure/closet/secure_closet/interdynefob/science_gear
	icon_state = "science"
	name = "scientist gear locker"

/obj/item/clothing/accessory/armband/science/syndicate
	name = "researcher armband"
	desc = "An armband, worn by the FOB's operatives to display which department they're assigned to."

/obj/item/storage/bag/garment/syndicate_scientist
	name = "scientist's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a scientist."

/obj/item/storage/bag/garment/syndicate_scientist/PopulateContents()
	new /obj/item/clothing/suit/hooded/wintercoat/science(src)
	new /obj/item/clothing/suit/toggle/labcoat/science(src)
	new /obj/item/clothing/glasses/sunglasses/chemical(src)
	new /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate(src)
	new /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate(src)
	new /obj/item/clothing/accessory/armband/science/syndicate(src)
	new /obj/item/clothing/accessory/armband/science/syndicate(src)

/obj/structure/closet/secure_closet/interdynefob/science_gear/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_scientist(src)

/obj/structure/closet/secure_closet/interdynefob/robotics
	icon_state = "science"
	name = "roboticist gear locker"

/obj/item/storage/bag/garment/syndicate_roboticist
	name = "roboticist's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a roboticist."

/obj/item/storage/bag/garment/syndicate_roboticist/PopulateContents()
	new /obj/item/clothing/suit/hooded/techpriest(src)
	new /obj/item/clothing/suit/toggle/labcoat/roboticist(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls/skirt(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/diagnostic(src)
	new /obj/item/clothing/glasses/hud/diagnostic(src)
	new /obj/item/clothing/suit/hooded/wintercoat/science/robotics(src)

/obj/structure/closet/secure_closet/interdynefob/robotics/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_scientist(src)
