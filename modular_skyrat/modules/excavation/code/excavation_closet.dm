/obj/structure/closet/excavation
	name = "excavation closet"
	icon_state = "mining"
	desc = "Contains equipment necessary for conducting excavation."

/obj/structure/closet/excavation/PopulateContents()
	..()
	new /obj/item/storage/excavation_pick_set/full(src)
	new /obj/item/excavation_locator(src)
	new /obj/item/excavation_measuring_tape(src)
	new /obj/item/excavation_depth_scanner(src)
	new /obj/item/pickaxe(src)
	new /obj/item/flashlight(src)
	new /obj/item/clothing/glasses/meson(src)
