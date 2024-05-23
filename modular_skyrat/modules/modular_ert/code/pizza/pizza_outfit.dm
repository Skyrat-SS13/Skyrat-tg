/datum/outfit/centcom/ert/pizza //da pizza for you and me
	name = "Pizza Delivery Boy"
	id = /obj/item/card/id/advanced/centcom/ert
	suit = /obj/item/clothing/suit/toggle/jacket/hoodie/pizza
	glasses = /obj/item/clothing/glasses/regular/betterunshit
	head = /obj/item/clothing/head/soft/red
	mask = /obj/item/clothing/mask/fakemoustache/italian
	uniform = /obj/item/clothing/under/pizza
	ears = /obj/item/radio/headset/headset_cent/alt
	back = /obj/item/storage/backpack/ert/odst
	backpack_contents = list(
		/obj/item/storage/box/survival,\
		/obj/item/knife,\
		/obj/item/storage/box/ingredients/italian,\
		)

/datum/outfit/centcom/ert/pizza/leader //da pizza for you and me
	name = "Pizza Delivery Manager"
	id = /obj/item/card/id/advanced/centcom/ert
	suit = /obj/item/clothing/suit/pizzaleader
	uniform = /obj/item/clothing/under/pizza
	mask = /obj/item/clothing/mask/fakemoustache/italian
	head = /obj/item/clothing/head/pizza
	ears = /obj/item/radio/headset/headset_cent/alt
	back = /obj/item/storage/backpack/ert/odst
	backpack_contents = list(
		/obj/item/storage/box/survival,\
		/obj/item/knife/hotknife,\
		/obj/item/storage/box/ingredients/italian,\
		)

/datum/outfit/centcom/ert/pizza/pre_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	var/list/pizza_list = list(/obj/item/pizzabox/margherita, /obj/item/pizzabox/mushroom, /obj/item/pizzabox/meat, /obj/item/pizzabox/pineapple)
	r_hand = pick(pizza_list)
