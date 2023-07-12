/obj/structure/closet/secure_closet/interdynefob/medical
	icon_state = "med_secure"
	name = "medical gear locker"

/obj/item/storage/bag/garment/syndicate_medical
	name = "medical garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to medical."

/obj/item/storage/bag/garment/syndicate_medical/PopulateContents()
	new /obj/item/clothing/gloves/latex/nitrile/ntrauma(src)
	new /obj/item/clothing/suit/toggle/labcoat/interdyne(src)
	new /obj/item/clothing/suit/toggle/labcoat/interdyne(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/health(src)
	new /obj/item/clothing/glasses/hud/ar/aviator/health(src)

/obj/structure/closet/secure_closet/interdynefob/medical/PopulateContents()
	..()

	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/storage/bag/garment/syndicate_medical(src)
