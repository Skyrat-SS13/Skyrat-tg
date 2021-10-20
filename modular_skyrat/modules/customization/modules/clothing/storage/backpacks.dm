/obj/item/storage/backpack/satchel/crusader	//Not very special, really just a satchel texture
	icon = 'modular_skyrat/master_files/icons/obj/clothing/storage.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	name = "crusader bandolier"
	desc = "A bandolier-satchel combination for holding all your dungeon loot."
	icon_state = "crusader_bandolier"
	inhand_icon_state = "explorerpack"
	w_class = WEIGHT_CLASS_BULKY


//////////////////////////
////SYNDIE POPCONTENTS////
//////////////////////////

/obj/item/storage/backpack/duffelbag/syndie/emag
	desc = "A large duffel bag containing a stash of the infamous emags. Oppositie of the Syndicate logo, is the MI13 insignia."

/obj/item/storage/backpack/duffelbag/syndie/emag/PopulateContents()
	new /obj/item/card/emag(src)
	new /obj/item/card/emag(src)
	new /obj/item/card/emag(src)
	new /obj/item/card/emag(src)

/obj/item/storage/backpack/duffelbag/syndie/doorjack
	desc = "A large duffel bag containing a stash of doorjacks. Oppositie of the Syndicate logo, is the MI13 insignia."

/obj/item/storage/backpack/duffelbag/syndie/doorjack/PopulateContents()
	new /obj/item/card/emag/doorjack(src)
	new /obj/item/card/emag/doorjack(src)
	new /obj/item/card/emag/doorjack(src)
	new /obj/item/card/emag/doorjack(src)

/obj/item/storage/backpack/duffelbag/syndie/suppressors
	desc = "A sinister looking duffel bag full of suppressors. Looks cheap."

/obj/item/storage/backpack/duffelbag/syndie/suppressors/PopulateContents()
	new /obj/item/suppressor/specialoffer(src)
	new /obj/item/suppressor/specialoffer(src)
	new /obj/item/suppressor/specialoffer(src)
	new /obj/item/suppressor/specialoffer(src)


/obj/item/storage/backpack/duffelbag/syndie/randomjunk
	desc = "A sinister looking duffel bag full of what looks to be just a bunch of random junk. Who the hell supplied this?"

/obj/item/storage/backpack/duffelbag/syndie/suppressors/PopulateContents()
	new /obj/item/suppressor/specialoffer(src)
	new /obj/item/suppressor/specialoffer(src)
	new /obj/item/suppressor/specialoffer(src)
	new /obj/item/suppressor/specialoffer(src)
