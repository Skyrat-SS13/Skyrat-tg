/obj/item/disk/nifsoft_uploader/summoner
	name = "Grimoire Akasha"
	loaded_nifsoft = /datum/nifsoft/summoner/book

/datum/nifsoft/summoner/book
	name = "Grimoire Akasha"
	program_desc = "Grimoire Akasha is a fork of the Grimoire Caeruleam NIFSoft, that is designed around giving the user access to various educational hardlight books. Due to it's educational nature and miniscule size, Grimoire Akasha is typically provided for free at most NIFSoft marketplaces."
	summonable_items = list()
	purchase_price = 0 // This is a tool intended to help out newer players.
	max_summoned_items = 2
	buying_category = NIFSOFT_CATEGORY_INFORMATION
	ui_icon = "book"

/datum/nifsoft/summoner/book/New()
	. = ..()
	summonable_items += subtypesof(/obj/item/book/manual/wiki) //That's right! all of the manual books!

/datum/nifsoft/summoner/book/apply_custom_properties(obj/item/book/generated_book)
	if(!istype(generated_book))
		return FALSE

	generated_book.can_be_carved = FALSE
	return TRUE

// Need this code here so that we don't have people carving out the summoned books
/obj/item/book
	/// Can the parent book be carved? By default this is set to `TRUE`
	var/can_be_carved = TRUE

/obj/item/book/try_carve(obj/item/carving_item, mob/living/user, params)
	if(!can_be_carved)
		balloon_alert(user, "unable to be carved!")
		return FALSE

	return ..()
