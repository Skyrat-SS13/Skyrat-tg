// --- Loadout item datums for shoes items ---

/// Shoe Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_shoes, generate_loadout_items(/datum/loadout_item/shoes))

/datum/loadout_item/shoes
	category = LOADOUT_ITEM_SHOES

/datum/loadout_item/shoes/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.shoes)
			LAZYADD(outfit.backpack_contents, outfit.shoes)
		outfit.shoes = item_path
	else
		outfit.shoes = item_path


//christmas, after that remove them
/datum/loadout_item/shoes/christmas
	name = "Red Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas

/datum/loadout_item/shoes/christmas/green
	name = "Green Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas/green
//every christmas is last christmas

/datum/loadout_item/shoes/jackboots
	name = "Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots

// Thedragmeme's donator reward, they've decided to make them available to everybody.
/datum/loadout_item/shoes/jackboots/heel
	name = "High-heel Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/junhle
	name = "Brown Jackboots"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/thighboot
	name = "Thigh Boots"
	item_path = /obj/item/clothing/shoes/jackboots/thigh

/datum/loadout_item/shoes/kneeboot
	name = "Knee Boots"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/datum/loadout_item/shoes/timbs
	name = "Fashionable Boots"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/winter_boots
	name = "Winter Boots"
	item_path = /obj/item/clothing/shoes/winterboots

/datum/loadout_item/shoes/work_boots
	name = "Work Boots"
	item_path = /obj/item/clothing/shoes/workboots

/datum/loadout_item/shoes/mining_boots
	name = "Mining Boots"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/laceup
	name = "Laceup Shoes"
	item_path = /obj/item/clothing/shoes/laceup

/datum/loadout_item/shoes/russian_boots
	name = "Russian Boots"
	item_path = /obj/item/clothing/shoes/russian

/datum/loadout_item/shoes/black_cowboy_boots
	name = "Black Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy/black

/datum/loadout_item/shoes/brown_cowboy_boots
	name = "Brown Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy

/datum/loadout_item/shoes/white_cowboy_boots
	name = "White Cowboy Boots"
	item_path = /obj/item/clothing/shoes/cowboy/white

/datum/loadout_item/shoes/greyscale_sneakers
	name = "Greyscale Sneakers"
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

/datum/loadout_item/shoes/rainbow_sneakers
	name = "Rainbow Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow

/datum/loadout_item/shoes/yellow_sneakers
	name = "Yellow Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/yellow

/datum/loadout_item/shoes/white_sneakers
	name = "White Sneakers"
	item_path = /obj/item/clothing/shoes/sneakers/white

/datum/loadout_item/shoes/griffin
	name = "Griffon Boots"
	item_path = /obj/item/clothing/shoes/griffin

/datum/loadout_item/shoes/sandals
	name = "Sandals"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/sportshoes
	name = "Sport Shoes"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/gildedcuffs
	name = "Gilded leg wraps"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/silvercuffs
	name = "Silver leg wraps"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/redcuffs
	name = "Red leg wraps"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/bluecuffs
	name = "Blue leg wraps"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/clothwrap
	name = "Colourable Cloth Wraps"
	item_path = /obj/item/clothing/shoes/wraps/poly

/datum/loadout_item/shoes/high_heels
	name = "High Heels"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/cowboyboots
	name = "Cowboy Boots, Brown"
	item_path = /obj/item/clothing/shoes/cowboyboots

/datum/loadout_item/shoes/cowboyboots_black
	name = "Cowboy Boots, Black"
	item_path = /obj/item/clothing/shoes/cowboyboots/black

/datum/loadout_item/shoes/disco
	name = "Green Snakeskin Shoes"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/dominaheels
	name = "Dominant heels"
	item_path = /obj/item/clothing/shoes/dominaheels

// Job Restricted
/datum/loadout_item/shoes/jester
	name = "Jester shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester
	restricted_roles = list(JOB_CLOWN)

//Families Gear
/datum/loadout_item/shoes/deckers
	name = "Deckers Shoes"
	item_path = /obj/item/clothing/shoes/deckers

/datum/loadout_item/shoes/morningstar
	name = "Morningstar Shoes"
	item_path = /obj/item/clothing/shoes/morningstar

/datum/loadout_item/shoes/saints
	name = "Saints Shoes"
	item_path = /obj/item/clothing/shoes/saints

/datum/loadout_item/shoes/phantom
	name = "Phantom Shoes"
	item_path = /obj/item/clothing/shoes/phantom

/datum/loadout_item/shoes/sybil
	name = "Sybil Shoes"
	item_path = /obj/item/clothing/shoes/sybil_slickers

/datum/loadout_item/shoes/basil
	name = "Basil Shoes"
	item_path = /obj/item/clothing/shoes/basil_boys

//Donator shoes here
/datum/loadout_item/shoes/donator
	donator_only = TRUE

/datum/loadout_item/shoes/donator/blackjackboots
	name = "Black Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/donator/rainbow
	name = "Rainbow Converse"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow
