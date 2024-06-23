/datum/loadout_category/shoes
	category_name = "Shoes"
	category_ui_icon = FA_ICON_SHOE_PRINTS
	type_to_generate = /datum/loadout_item/shoes
	tab_order = /datum/loadout_category/head::tab_order + 11

/datum/loadout_item/shoes
	abstract_type = /datum/loadout_item/shoes

/datum/loadout_item/shoes/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.shoes)
		LAZYADD(outfit.backpack_contents, outfit.shoes)
	outfit.shoes = item_path

/*
*	JACKBOOTS
*/

/datum/loadout_item/shoes/jackboots
	name = "Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots

// Thedragmeme's donator reward, they've decided to make them available to everybody.
/datum/loadout_item/shoes/jackboots/heel
	name = "High-Heel Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/kneeboot
	name = "Knee Boots"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/datum/loadout_item/shoes/recolorable_jackboots
	name = "Recolorable Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/recolorable

/*
*	MISC BOOTS
*/

/datum/loadout_item/shoes/timbs
	name = "Fashionable Boots"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/jungle
	name = "Jungle Boots"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/winter_boots
	name = "Winter Boots"
	item_path = /obj/item/clothing/shoes/winterboots

/datum/loadout_item/shoes/work_boots
	name = "Work Boots"
	item_path = /obj/item/clothing/shoes/workboots

/datum/loadout_item/shoes/work_boots/old
	name = "Old Work Boots"
	item_path = /obj/item/clothing/shoes/workboots/old

/datum/loadout_item/shoes/mining_boots
	name = "Mining Boots"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/russian_boots
	name = "Russian Boots"
	item_path = /obj/item/clothing/shoes/russian

/*
*	COWBOY
*/

/datum/loadout_item/shoes/brown_cowboy_boots
	name = "Brown Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy

/datum/loadout_item/shoes/black_cowboy_boots
	name = "Black Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy/black

/datum/loadout_item/shoes/white_cowboy_boots
	name = "White Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy/white

/datum/loadout_item/shoes/cowboyboots
	name = "Cowboy Boots (Brown)"
	item_path = /obj/item/clothing/shoes/cowboyboots

/datum/loadout_item/shoes/cowboyboots_black
	name = "Cowboy Boots (Black)"
	item_path = /obj/item/clothing/shoes/cowboyboots/black

/*
*	SNEAKERS
*/

/datum/loadout_item/shoes/greyscale_sneakers
	name = "Colorable Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers

/datum/loadout_item/shoes/black_sneakers
	name = "Black Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/black

/datum/loadout_item/shoes/blue_sneakers
	name = "Blue Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/blue

/datum/loadout_item/shoes/brown_sneakers
	name = "Brown Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/brown

/datum/loadout_item/shoes/green_sneakers
	name = "Green Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/green

/datum/loadout_item/shoes/purple_sneakers
	name = "Purple Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/purple

/datum/loadout_item/shoes/orange_sneakers
	name = "Orange Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/orange

/datum/loadout_item/shoes/yellow_sneakers
	name = "Yellow Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/yellow

/datum/loadout_item/shoes/white_sneakers
	name = "White Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/white

/*
*	LEG WRAPS
*/

/datum/loadout_item/shoes/gildedcuffs
	name = "Gilded Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/silvercuffs
	name = "Silver Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/redcuffs
	name = "Red Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/bluecuffs
	name = "Blue Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/cuffs/colourable
	name = "Colourable Leg Wraps"
	item_path = /obj/item/clothing/shoes/wraps/colourable

/datum/loadout_item/shoes/clothwrap
	name = "Colourable Cloth Wraps"
	item_path = /obj/item/clothing/shoes/wraps/cloth

/*
*	MISC
*/

/datum/loadout_item/shoes/laceup
	name = "Laceup Shoes"
	item_path = /obj/item/clothing/shoes/laceup

/datum/loadout_item/shoes/recolorable_laceups
	name = "Recolorable Laceups"
	item_path = /obj/item/clothing/shoes/colorable_laceups

/datum/loadout_item/shoes/recolorable_sandals
	name = "Recolorble Sandals"
	item_path = /obj/item/clothing/shoes/colorable_sandals

/datum/loadout_item/shoes/high_heels
	name = "High Heels"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/black_heels
	name = "Fancy Heels"
	item_path = /obj/item/clothing/shoes/fancy_heels

/datum/loadout_item/shoes/disco
	name = "Green Snakeskin Shoes"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/kim
	name = "Aerostatic Shoes"
	item_path = /obj/item/clothing/shoes/kim

/datum/loadout_item/shoes/dominaheels
	name = "Dominant Heels"
	item_path = /obj/item/clothing/shoes/latex_heels/domina_heels
	erp_item = TRUE

/datum/loadout_item/shoes/griffin
	name = "Griffon Boots"
	item_path = /obj/item/clothing/shoes/griffin

/datum/loadout_item/shoes/sandals
	name = "Sandals"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/sportshoes
	name = "Sport Shoes"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/rollerskates
	name = "Roller Skates"
	item_path = /obj/item/clothing/shoes/wheelys/rollerskates

/datum/loadout_item/shoes/jingleshoes
	name = "Jester Shoes"
	item_path = /obj/item/clothing/shoes/jester_shoes

/*
*	SEASONAL
*/

/datum/loadout_item/shoes/christmas
	name = "Red Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas

/datum/loadout_item/shoes/christmas/green
	name = "Green Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas/green


/*
*	JOB-RESTRICTED
*/

/datum/loadout_item/shoes/jester
	name = "Clown's Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/clown_shoes/pink
	name = "Pink Clown Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/pink
	restricted_roles = list(JOB_CLOWN)

/*
*	DONATOR
*/

/datum/loadout_item/shoes/donator
	donator_only = TRUE

/datum/loadout_item/shoes/donator/blackjackboots
	name = "Black Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/donator/rainbow
	name = "Rainbow Converse"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow
