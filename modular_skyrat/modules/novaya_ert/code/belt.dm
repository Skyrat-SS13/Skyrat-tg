/obj/item/storage/belt/military/nri
	name = "green tactical belt"
	desc = "A green tactical belt made for storing military grade hardware."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/belt.dmi'
	icon_state = "russian_green_belt"
	inhand_icon_state = "security"
	worn_icon_state = "russian_green_belt"

/obj/item/storage/belt/military/nri/captain
	name = "black tactical belt"
	desc = "A black tactical belt made for storing military grade hardware."
	icon_state = "russian_black_belt"
	worn_icon_state = "russian_black_belt"

/obj/item/storage/belt/military/nri/medic
	name = "blue tactical belt"
	desc = "A blue tactical belt made for storing military grade hardware."
	icon_state = "russian_white_belt"
	worn_icon_state = "russian_white_belt"

/obj/item/storage/belt/military/nri/engineer
	name = "brown tactical belt"
	desc = "A brown tactical belt made for storing military grade hardware."
	icon_state = "russian_brown_belt"
	worn_icon_state = "russian_brown_belt"

/obj/item/storage/belt/military/nri/soldier/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/akm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/heavy/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/m9mm_aps = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/captain/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/akm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/medic/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/multi_sprite/cfa_lynx = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/engineer/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/multi_sprite/cfa_lynx = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)
