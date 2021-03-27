/obj/item/storage/belt/crusader	//Belt + sheath combination - still only holds one sword at a time though
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/storage.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/storage.dmi'
	name = "crusader belt"
	desc = "Holds an assortment of equipment for whatever situation an adventurer may encounter, as well as having an attached sheath."
	icon_state = "crusader_belt"
	worn_icon_state = "crusader_belt"
	inhand_icon_state = "utility"
	w_class = WEIGHT_CLASS_BULKY //Cant fit a sheath in your bag

/obj/item/storage/belt/crusader/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return
	if(contents.len == 2)
		var/obj/item/drawn_item = contents[2]
		add_fingerprint(user)
		playsound(src, 'sound/items/unsheath.ogg', 50, TRUE, -5)
		if(!user.put_in_hands(drawn_item))
			to_chat(user, "<span class='notice'>You fumble for [drawn_item] and it falls on the floor.</span>")
			update_appearance()
			return
		update_appearance()
		user.visible_message("<span class='notice'>[user] takes [drawn_item] out of [src].</span>", "<span class='notice'>You take [drawn_item] out of [src].</span>")
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")
	. = ..()

/obj/item/storage/belt/crusader/update_appearance(updates)
	if(contents.len == 2)	//Checks for a sword/rod in the sheath slot, changes the sprite accordingly
		icon_state = "crusader_belt_sheathed"
		worn_icon_state = "crusader_belt_sheathed"
	else
		icon_state = "crusader_belt"
		worn_icon_state = "crusader_belt"
	. = ..()

/obj/item/storage/belt/crusader/examine(mob/user)
	. = ..()
	if(contents.len == 2)	//If there's no sword/rod in the sheath slot it doesnt display the alt-click instruction
		. += "<span class='notice'>Alt-click it to quickly draw the blade.</span>"
		return
/datum/component/storage/belt/crusader/quick_empty(mob/M)	//simply pushes the quick_empty into the pouch storage instead of the belt, keeping the pouch from being dumped anywhere
	var/atom/A = parent
	if(!M.canUseStorage() || !A.Adjacent(M) || M.incapacitated())
		return
	if(locked)
		to_chat(M, "<span class='warning'>[parent] seems to be locked!</span>")
		return FALSE
	to_chat(M, "<span class='notice>[parent] is too unwieldy to dump like that... maybe you can dump just the pouches?</span>")
	return
	/*A.add_fingerprint(M)
	to_chat(M, "<span class='notice'>You start dumping out [parent].</span>")
	var/turf/T = get_turf(A)
	var/obj/item/storage/pouch = contents(1)
	var/list/things = pouch.contents()
	var/datum/progressbar/progress = new(M, length(things), T)
	while (do_after(M, 1 SECONDS, T, NONE, FALSE, CALLBACK(src, .proc/mass_remove_from_storage, T, things, progress)))
		stoplag(1)
	progress.end_progress()*/

/obj/item/storage/belt/crusader/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	STR.max_items = 2
	STR.rustle_sound = TRUE
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC	//Max size makes sure that the storage_pouch item still properly fits in it - the whitelist keeps anything fucky out
	STR.allow_big_nesting = TRUE //Same as above
	STR.set_holdable(list(
		/obj/item/storage/belt/storage_pouch,
		/obj/item/melee/sabre,
		/obj/item/melee/cleric_mace,
		/obj/item/nullrod	//holds any subset of nullrod in the sheath-storage, so this doesnt become a massive list
		))

/obj/item/storage/belt/crusader/PopulateContents()
	. = ..()
	new /obj/item/storage/belt/storage_pouch(src)
	return

/obj/item/storage/belt/storage_pouch	//seperate mini-storage inside the belt, leaving room for only one sword. Inspired by a (very poorly implemented) belt on Desert Rose
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/storage.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/storage.dmi'
	name = "storage pouch"
	desc = "<span class='notice'>Click on this to open your belt's inventory!</span>"
	icon_state = "storage_pouch_icon"
	worn_icon_state = "no name"	//Intentionally sets the worn icon to an error
	w_class = WEIGHT_CLASS_GIGANTIC	//Keeps it from being dragged into other bags
	anchored = 1	//Dont want people taking it out with their hands

/obj/item/storage/belt/storage_pouch/attack_hand(mob/user, list/modifiers)	//Opens the bag on click - considering it's already anchored, this makes it function similar to how ghosts can open all nested inventories
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.user_show_to_mob(user)
	return

/obj/item/storage/belt/storage_pouch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	STR.max_items = 6
	STR.rustle_sound = TRUE
	STR.max_w_class = WEIGHT_CLASS_SMALL //Rather than have a huge whitelist, the belt can simply hold anything a pocket can hold - Can be changed if it becomes an issue

//End of Crusader Belt code (Finally)
			//This will be a Newline when its all complete




//-------------- DELETE WHEN DONE---------------
/*TODO:
-you can Dump the pouch out of the belt, at which point its stuck on the ground - override normal dumping code so we dont drop the fucking pouch
-BoH's can have the pouch dumped into them, where its then anchored to the BoH (at least they can be dragged back, but it could possibly be abused for more than 1 sword)

*/
//-----------------------------------------------
//Very very failed code - keeping it for now to see if its fixable, considering I like the idea for stuff like holsters
/*
//Checks for a sword/nullrod already in the belt (keeps it to a max of 1 sword/chaplain sword)
/datum/component/storage/concrete/crusader/slave_can_insert_object(obj/item/inserted, stop_messages, mob/user)
	if(!istype(inserted, list(/obj/item/melee, /obj/item/nullrod)))
		return ..()
	var/obj/item/melee/sword = locate() in real_location()
	var/obj/item/nullrod/chap_rod = locate() in real_location()
	if(sword)
		to_chat(user, "<span class = 'warning'>[parent] already has [sword] in it!</span>")
		return FALSE
	if(chap_rod)
		to_chat(user, "<span class = 'warning'>[parent] already has [chap_rod] in it!</span>")
		return FALSE
	return ..()
*/