// --- Loadout item datums for backpack / pocket items ---

/// Pocket items (Moved to backpack)
GLOBAL_LIST_INIT(loadout_pocket_items, generate_loadout_items(/datum/loadout_item/pocket_items))

/datum/loadout_item/pocket_items
	category = LOADOUT_ITEM_MISC

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
			var/list/backpack_stuff = list()
			SEND_SIGNAL(equipper.back, COMSIG_TRY_STORAGE_RETURN_INVENTORY, backpack_stuff, FALSE)
			for(var/obj/item/thing in backpack_stuff)
				if(wallet.contents.len >= 3)
					break
				if(thing.w_class <= WEIGHT_CLASS_SMALL)
					SEND_SIGNAL(wallet, COMSIG_TRY_STORAGE_INSERT, thing, equipper, TRUE, FALSE)
	else
		if(!equipper.equip_to_slot_if_possible(wallet, slot = ITEM_SLOT_BACKPACK, initial = TRUE))
			wallet.forceMove(equipper.drop_location())

/datum/loadout_item/pocket_items/rag
	name = "Rag"
	item_path = /obj/item/reagent_containers/glass/rag

/datum/loadout_item/pocket_items/gum_pack
	name = "Pack of Gum"
	item_path = /obj/item/storage/box/gum

/datum/loadout_item/pocket_items/gum_pack_nicotine
	name = "Pack of Nicotine Gum"
	item_path = /obj/item/storage/box/gum/nicotine

/datum/loadout_item/pocket_items/gum_pack_hp
	name = "Pack of HP+ Gum"
	item_path = /obj/item/storage/box/gum/happiness

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

/datum/loadout_item/pocket_items/razor
	name = "Razor"
	item_path = /obj/item/razor

/datum/loadout_item/pocket_items/lighter
	name = "Lighter"
	item_path = /obj/item/lighter


/datum/loadout_item/pocket_items/card_binder
	name = "Card Binder"
	item_path = /obj/item/storage/card_binder

/datum/loadout_item/pocket_items/card_deck
	name = "Playing Card Deck"
	item_path = /obj/item/toy/cards/deck

/datum/loadout_item/pocket_items/kotahi_deck
	name = "Kotahi Deck"
	item_path = /obj/item/toy/cards/deck/kotahi

/datum/loadout_item/pocket_items/wizoff_deck
	name = "Wizoff Deck"
	item_path = /obj/item/toy/cards/deck/wizoff

/datum/loadout_item/pocket_items/d1
	name = "D1"
	item_path = /obj/item/dice/d1

/datum/loadout_item/pocket_items/d2
	name = "D2"
	item_path = /obj/item/dice/d2

/datum/loadout_item/pocket_items/d4
	name = "D4"
	item_path = /obj/item/dice/d4

/datum/loadout_item/pocket_items/d6
	name = "D6"
	item_path = /obj/item/dice/d6

/datum/loadout_item/pocket_items/d6_ebony
	name = "D6 (Ebony)"
	item_path = /obj/item/dice/d6/ebony

/datum/loadout_item/pocket_items/d6_space
	name = "D6 (Space)"
	item_path = /obj/item/dice/d6/space

/datum/loadout_item/pocket_items/d8
	name = "D8"
	item_path = /obj/item/dice/d8

/datum/loadout_item/pocket_items/d10
	name = "D10"
	item_path = /obj/item/dice/d10

/datum/loadout_item/pocket_items/d12
	name = "D12"
	item_path = /obj/item/dice/d12

/datum/loadout_item/pocket_items/d20
	name = "D20"
	item_path = /obj/item/dice/d20

/datum/loadout_item/pocket_items/d100
	name = "D100"
	item_path = /obj/item/dice/d100

/datum/loadout_item/pocket_items/d00
	name = "D00"
	item_path = /obj/item/dice/d00

/datum/loadout_item/pocket_items/matches
	name = "Matchbox"
	item_path = /obj/item/storage/box/matches

/datum/loadout_item/pocket_items/cheaplighter
	name = "Cheap lighter"
	item_path = /obj/item/lighter/greyscale

/datum/loadout_item/pocket_items/zippolighter
	name = "Zippo Lighter"
	item_path = /obj/item/lighter


/datum/loadout_item/pocket_items/ttsdevice
	name = "Text-to-Speech Device"
	item_path = /obj/item/ttsdevice


/datum/loadout_item/pocket_items/paicard
	name = "Personal AI device"
	item_path = /obj/item/paicard


/datum/loadout_item/pocket_items/cigar
	name = "Cigar"
	item_path = /obj/item/clothing/mask/cigarette/cigar
	 //smoking is bad mkay

/datum/loadout_item/pocket_items/cigarettes
	name = "Cigarette pack"
	item_path = /obj/item/storage/fancy/cigarettes

/datum/loadout_item/pocket_items/wallet
	name = "Wallet"
	item_path = /obj/item/storage/wallet

/datum/loadout_item/pocket_items/flask
	name = "Flask"
	item_path = /obj/item/reagent_containers/food/drinks/flask


/datum/loadout_item/pocket_items/skub
	name = "Skub"
	item_path = /obj/item/skub

/datum/loadout_item/pocket_items/multipen
	name = "A multicolored pen"
	item_path = /obj/item/pen/fourcolor

/datum/loadout_item/pocket_items/fountainpen
	name = "A fancy pen"
	item_path = /obj/item/pen/fountain


/datum/loadout_item/pocket_items/modular_tablet
	name = "A modular tablet"
	item_path = /obj/item/modular_computer/tablet/preset/cheap/


/datum/loadout_item/pocket_items/modular_laptop
	name = "A modular laptop"
	item_path = /obj/item/modular_computer/laptop/preset/civilian


/datum/loadout_item/pocket_items/ringbox_gold
	name = "A gold ring box"
	item_path = /obj/item/storage/fancy/ringbox


/datum/loadout_item/pocket_items/ringbox_silver
	name = "A silver ring box"
	item_path = /obj/item/storage/fancy/ringbox/silver


/datum/loadout_item/pocket_items/ringbox_diamond
	name = "A diamond ring box"
	item_path = /obj/item/storage/fancy/ringbox/diamond


/datum/loadout_item/pocket_items/tapeplayer
	name = "Taperecorder"
	item_path = /obj/item/taperecorder

/datum/loadout_item/pocket_items/tape
	name = "Spare cassette tape"
	item_path = /obj/item/tape/random

/datum/loadout_item/pocket_items/newspaper
	name = "Newspaper"
	item_path = /obj/item/newspaper

/datum/loadout_item/pocket_items/hhmirror
	name = "Handheld Mirror"
	item_path = /obj/item/hhmirror


//TOYS
/datum/loadout_item/pocket_items/toy
	can_be_named = TRUE

/datum/loadout_item/pocket_items/toy/dice
	name = "Dice bag"
	item_path = /obj/item/storage/dice

/datum/loadout_item/pocket_items/toy/eightball
	name = "Magic eightball"
	item_path = /obj/item/toy/eightball

/datum/loadout_item/pocket_items/toy/tennis
	name = "Classic Tennis Ball"
	item_path = /obj/item/toy/tennis

/datum/loadout_item/pocket_items/toy/tennisred
	name = "Red Tennis Ball"
	item_path = /obj/item/toy/tennis/red

/datum/loadout_item/pocket_items/toy/tennisyellow
	name = "Yellow Tennis Ball"
	item_path = /obj/item/toy/tennis/yellow

/datum/loadout_item/pocket_items/toy/tennisgreen
	name = "Green Tennis Ball"
	item_path = /obj/item/toy/tennis/green

/datum/loadout_item/pocket_items/toy/tenniscyan
	name = "Cyan Tennis Ball"
	item_path = /obj/item/toy/tennis/cyan

/datum/loadout_item/pocket_items/toy/tennisblue
	name = "Blue Tennis Ball"
	item_path = /obj/item/toy/tennis/blue

/datum/loadout_item/pocket_items/toy/tennispurple
	name = "Purple Tennis Ball"
	item_path = /obj/item/toy/tennis/purple

/datum/loadout_item/pocket_items/toy/toykatana
	name = "Toy Katana"
	item_path = /obj/item/toy/katana


/datum/loadout_item/pocket_items/toy/crayons
	name = "Box of crayons"
	item_path = /obj/item/storage/crayons

/datum/loadout_item/pocket_items/cross
	name = "Ornate Cross"
	item_path = /obj/item/crucifix
	restricted_roles = list("Chaplain")

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
