/*
*	LOADOUT ITEM DATUMS FOR BACKPACK/POCKET SLOTS
*/

/// Pocket items (Moved to backpack)
GLOBAL_LIST_INIT(loadout_pocket_items, generate_loadout_items(/datum/loadout_item/pocket_items))

/datum/loadout_item/pocket_items
	category = LOADOUT_ITEM_MISC

/datum/loadout_item/pocket_items/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE) // these go in the backpack
	return FALSE

// The wallet loadout item is special, and puts the player's ID and other small items into it on initialize (fancy!)
/datum/loadout_item/pocket_items/wallet
	name = "Wallet"
	item_path = /obj/item/storage/wallet
	additional_tooltip_contents = list("FILLS AUTOMATICALLY - This item will populate itself with your ID card and other small items you may have on spawn.")

// We add our wallet manually, later, so no need to put it in any outfits.
/datum/loadout_item/pocket_items/wallet/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only)
	return FALSE

// We didn't spawn any item yet, so nothing to call here.
/datum/loadout_item/pocket_items/wallet/on_equip_item(datum/preferences/preference_source, mob/living/carbon/human/equipper, visuals_only)
	return FALSE

// We add our wallet at the very end of character initialization (after quirks, etc) to ensure the backpack / their ID is all set by now.
/datum/loadout_item/pocket_items/wallet/post_equip_item(datum/preferences/preference_source, mob/living/carbon/human/equipper)
	var/obj/item/card/id/advanced/id_card = equipper.get_item_by_slot(ITEM_SLOT_ID)
	if(istype(id_card, /obj/item/storage/wallet))
		return

	var/obj/item/storage/wallet/wallet = new(equipper)
	if(istype(id_card))
		equipper.temporarilyRemoveItemFromInventory(id_card, force = TRUE)
		equipper.equip_to_slot_if_possible(wallet, ITEM_SLOT_ID, initial = TRUE)
		id_card.forceMove(wallet)

		if(equipper.back)
			var/list/backpack_stuff = equipper.back.atom_storage?.return_inv(FALSE)
			for(var/obj/item/thing in backpack_stuff)
				if(wallet.contents.len >= 3)
					break
				if(thing.w_class <= WEIGHT_CLASS_SMALL)
					wallet.atom_storage.attempt_insert(src, thing, equipper, TRUE, FALSE)
	else
		if(!equipper.equip_to_slot_if_possible(wallet, slot = ITEM_SLOT_BACKPACK, initial = TRUE))
			wallet.forceMove(equipper.drop_location())

/*
*	GUM
*/

/datum/loadout_item/pocket_items/gum_pack
	name = "Pack of Gum"
	item_path = /obj/item/storage/box/gum

/datum/loadout_item/pocket_items/gum_pack_nicotine
	name = "Pack of Nicotine Gum"
	item_path = /obj/item/storage/box/gum/nicotine

/datum/loadout_item/pocket_items/gum_pack_hp
	name = "Pack of HP+ Gum"
	item_path = /obj/item/storage/box/gum/happiness

/*
*	LIPSTICK
*/

/datum/loadout_item/pocket_items/lipstick_black
	name = "Black Lipstick"
	item_path = /obj/item/lipstick/black

/datum/loadout_item/pocket_items/lipstick_jade
	name = "Jade Lipstick"
	item_path = /obj/item/lipstick/jade

/datum/loadout_item/pocket_items/lipstick_purple
	name = "Purple Lipstick"
	item_path = /obj/item/lipstick/purple

/datum/loadout_item/pocket_items/lipstick_red
	name = "Red Lipstick"
	item_path = /obj/item/lipstick

/*
*	MISC
*/

/datum/loadout_item/pocket_items/rag
	name = "Rag"
	item_path = /obj/item/reagent_containers/cup/rag

/datum/loadout_item/pocket_items/razor
	name = "Razor"
	item_path = /obj/item/razor

/datum/loadout_item/pocket_items/matches
	name = "Matchbox"
	item_path = /obj/item/storage/box/matches

/datum/loadout_item/pocket_items/cheaplighter
	name = "Cheap Lighter"
	item_path = /obj/item/lighter/greyscale

/datum/loadout_item/pocket_items/zippolighter
	name = "Zippo Lighter"
	item_path = /obj/item/lighter

/datum/loadout_item/pocket_items/ttsdevice
	name = "Text-to-Speech Device"
	item_path = /obj/item/ttsdevice

/datum/loadout_item/pocket_items/paicard
	name = "Personal AI Device"
	item_path = /obj/item/pai_card

/datum/loadout_item/pocket_items/link_scryer
	name = "MODlink Scryer"
	item_path = /obj/item/clothing/neck/link_scryer/loaded

/datum/loadout_item/pocket_items/cigarettes
	name = "Cigarette Pack"
	item_path = /obj/item/storage/fancy/cigarettes

/datum/loadout_item/pocket_items/cigar //smoking is bad mkay
	name = "Cigar"
	item_path = /obj/item/clothing/mask/cigarette/cigar

/datum/loadout_item/pocket_items/flask
	name = "Flask"
	item_path = /obj/item/reagent_containers/cup/glass/flask

/datum/loadout_item/pocket_items/multipen
	name = "Multicolored Pen"
	item_path = /obj/item/pen/fourcolor

/datum/loadout_item/pocket_items/fountainpen
	name = "Fancy Pen"
	item_path = /obj/item/pen/fountain

/datum/loadout_item/pocket_items/modular_laptop
	name = "Modular Laptop"
	item_path = /obj/item/modular_computer/laptop/preset/civilian/closed

/datum/loadout_item/pocket_items/ringbox_gold
	name = "Gold Ring Box"
	item_path = /obj/item/storage/fancy/ringbox

/datum/loadout_item/pocket_items/ringbox_silver
	name = "Silver Ring Box"
	item_path = /obj/item/storage/fancy/ringbox/silver

/datum/loadout_item/pocket_items/ringbox_diamond
	name = "Diamond Ring Box"
	item_path = /obj/item/storage/fancy/ringbox/diamond

/datum/loadout_item/pocket_items/tapeplayer
	name = "Universal Recorder"
	item_path = /obj/item/taperecorder

/datum/loadout_item/pocket_items/tape
	name = "Spare Cassette Tape"
	item_path = /obj/item/tape/random

/datum/loadout_item/pocket_items/newspaper
	name = "Newspaper"
	item_path = /obj/item/newspaper

/datum/loadout_item/pocket_items/hhmirror
	name = "Handheld Mirror"
	item_path = /obj/item/hhmirror

/datum/loadout_item/pocket_items/cross
	name = "Ornate Cross"
	item_path = /obj/item/crucifix

/datum/loadout_item/pocket_items/clipboard
	name = "Clipboard"
	item_path = /obj/item/clipboard

/datum/loadout_item/pocket_items/folder
	name = "Folder"
	item_path = /obj/item/folder

/*
*	UTILITY
*/

/datum/loadout_item/pocket_items/moth_mre
	name = "Mothic Rations Pack"
	item_path = /obj/item/storage/box/mothic_rations

/datum/loadout_item/pocket_items/cloth_ten
	name = "Ten Cloth Sheets"
	item_path = /obj/item/stack/sheet/cloth/ten

/datum/loadout_item/pocket_items/random_pizza
	name = "Random Pizza Box"
	item_path = /obj/item/pizzabox/random

/datum/loadout_item/pocket_items/medkit
	name = "First-Aid Kit"
	item_path = /obj/item/storage/medkit/regular

/datum/loadout_item/pocket_items/deforest_cheesekit
	name = "Civil Defense Medical Kit"
	item_path = /obj/item/storage/medkit/civil_defense/stocked

/datum/loadout_item/pocket_items/deforest_frontiermedkit
	name = "Frontier Medical Kit"
	item_path = /obj/item/storage/medkit/frontier/stocked

/datum/loadout_item/pocket_items/ingredients
	name = "Wildcard Ingredient Box"
	item_path = /obj/item/storage/box/ingredients/wildcard

/datum/loadout_item/pocket_items/six_beer
	name = "Beer Six-Pack"
	item_path = /obj/item/storage/cans/sixbeer

/datum/loadout_item/pocket_items/six_soda
	name = "Soda Six-Pack"
	item_path = /obj/item/storage/cans/sixsoda

/datum/loadout_item/pocket_items/power_cell
	name = "Standard Power Cell"
	item_path = /obj/item/stock_parts/cell

/datum/loadout_item/pocket_items/soap
	name = "Bar of Soap"
	item_path = /obj/item/soap

/datum/loadout_item/pocket_items/mini_extinguisher
	name = "Mini Fire Extinguisher"
	item_path = /obj/item/extinguisher/mini

/datum/loadout_item/pocket_items/binoculars
	name = "Pair of Binoculars"
	item_path = /obj/item/binoculars

/datum/loadout_item/pocket_items/drugs_happy
	name = "Happy Pills"
	item_path = /obj/item/storage/pill_bottle/happy

/datum/loadout_item/pocket_items/drugs_lsd
	name = "Mindbreaker Pills"
	item_path = /obj/item/storage/pill_bottle/lsd

/datum/loadout_item/pocket_items/drugs_weed
	name = "Cannabis Seeds"
	item_path = /obj/item/seeds/cannabis

/datum/loadout_item/pocket_items/drugs_reishi
	name = "Reishi Seeds"
	item_path = /obj/item/seeds/reishi

/datum/loadout_item/pocket_items/drugs_liberty
	name = "Liberty Cap Seeds"
	item_path = /obj/item/seeds/liberty

/*
*	FRAGRANCES
*/

/datum/loadout_item/pocket_items/fragrance_cologne
	name = "Cologne Bottle"
	item_path = /obj/item/perfume/cologne

/datum/loadout_item/pocket_items/fragrance_wood
	name = "Wood Perfume"
	item_path = /obj/item/perfume/wood

/datum/loadout_item/pocket_items/fragrance_rose
	name = "Rose Perfume"
	item_path = /obj/item/perfume/rose

/datum/loadout_item/pocket_items/fragrance_jasmine
	name = "Jasmine Perfume"
	item_path = /obj/item/perfume/jasmine

/datum/loadout_item/pocket_items/fragrance_mint
	name = "Mint Perfume"
	item_path = /obj/item/perfume/mint

/datum/loadout_item/pocket_items/fragrance_vanilla
	name = "Vanilla Perfume"
	item_path = /obj/item/perfume/vanilla

/datum/loadout_item/pocket_items/fragrance_pear
	name = "Pear Perfume"
	item_path = /obj/item/perfume/pear

/datum/loadout_item/pocket_items/fragrance_strawberry
	name = "Strawberry Perfume"
	item_path = /obj/item/perfume/strawberry

/datum/loadout_item/pocket_items/fragrance_cherry
	name = "Cherry Perfume"
	item_path = /obj/item/perfume/cherry

/datum/loadout_item/pocket_items/fragrance_amber
	name = "Amber Perfume"
	item_path = /obj/item/perfume/amber


/*
*	DONATOR
*/

/datum/loadout_item/pocket_items/donator
	donator_only = TRUE

/datum/loadout_item/pocket_items/donator/coin
	name = "Iron Coin"
	item_path = /obj/item/coin/iron

/datum/loadout_item/pocket_items/donator/havana_cigar_case
	name = "Havanian Cigars"
	item_path = /obj/item/storage/fancy/cigarettes/cigars/havana

/datum/loadout_item/pocket_items/donator/vape
	name = "E-Cigarette"
	item_path = /obj/item/clothing/mask/vape