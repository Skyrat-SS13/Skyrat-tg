/datum/crafting_recipe/chain_armor
	name = "Chain Armor"
	result = /obj/item/clothing/suit/armor/reagent_clothing
	reqs = list(/obj/item/forging/complete/chain = 6)
	time = 40
	category = CAT_CLOTHING

/datum/crafting_recipe/chain_glove
	name = "Chain Gloves"
	result = /obj/item/clothing/gloves/reagent_clothing
	reqs = list(/obj/item/forging/complete/chain = 3)
	time = 40
	category = CAT_CLOTHING

/datum/crafting_recipe/reagent_sword
	name = "Reagent Sword"
	result = /obj/item/forging/reagent_weapon/sword
	reqs = list(/obj/item/forging/complete/sword = 1,
				/obj/item/stack/sheet/mineral/wood = 2)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/reagent_staff
	name = "Reagent Staff"
	result = /obj/item/forging/reagent_weapon/staff
	reqs = list(/obj/item/forging/complete/staff = 1,
				/obj/item/stack/sheet/mineral/wood = 2)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//cargo supply pack for items
/datum/supply_pack/service/forging_items
	name = "Forging Starter Item Pack"
	desc = "Featuring: Forging. This pack is full of three items necessary to start your forging career: tongs, hammer, and billow."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/forging/tongs, /obj/item/forging/hammer, /obj/item/forging/billow)
	crate_name = "forging start items"
	crate_type = /obj/structure/closet/crate/forging_items

/obj/structure/closet/crate/forging_items
	name = "forging starter items"
	desc = "A crate filled with the items necessary to start forging (billow, hammer, and tongs)."
