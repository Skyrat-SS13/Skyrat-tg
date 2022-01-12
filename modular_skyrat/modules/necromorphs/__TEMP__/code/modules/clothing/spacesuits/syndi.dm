//Regular syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate
	name = "red space helmet"
	icon_state = "syndicate"
	item_state = "syndicate"
	desc = "A crimson helmet sporting clean lines and durable plating. Engineered to look menacing."
	armor = list(melee = 60, bullet = 50, laser = 50,energy = 15, bomb = 30, bio = 30, rad = 30)
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/syndicate
	name = "red space suit"
	icon_state = "syndicate"
	item_state_slots = list(
		slot_l_hand_str = "space_suit_syndicate",
		slot_r_hand_str = "space_suit_syndicate",
	)
	desc = "A crimson spacesuit sporting clean lines and durable plating. Robust, reliable, and slightly suspicious."
	w_class = ITEM_SIZE_NORMAL
	armor = list(melee = 60, bullet = 50, laser = 50,energy = 15, bomb = 30, bio = 30, rad = 30)
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/syndicate/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1

//Dark green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/green_dark
	name = "dark green space helmet"
	icon_state = "syndicate-helm-green-dark"
	item_state_slots = list(
		slot_l_hand_str = "syndicate-helm-green-dark",
		slot_r_hand_str = "syndicate-helm-green-dark",
	)

/obj/item/clothing/suit/space/syndicate/green_dark
	name = "dark green space suit"
	icon_state = "syndicate-green-dark"
	item_state_slots = list(
		slot_l_hand_str = "syndicate-green-dark",
		slot_r_hand_str = "syndicate-green-dark",
	)