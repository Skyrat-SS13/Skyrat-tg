/obj/item/storage/belt/military/nri
	name = "green tactical belt"
	desc = "A green tactical belt made for storing military grade hardware."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "russian_green_belt"
	inhand_icon_state = "security"
	worn_icon_state = "russian_green_belt"

/obj/item/storage/belt/military/nri/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/akm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/full_heavy/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/full_commander/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/ppsh = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/full_support/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/plastikov9mm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)
