/obj/item/storage/belt/crusader	//Belt + sheath combination - still only holds one sword at a time though
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "crusader belt"
	desc = "Holds an assortment of equipment for whatever situation an adventurer may encounter, as well as having an attached sheath."
	icon_state = "crusader_belt"
	worn_icon_state = "crusader_belt"
	inhand_icon_state = "utility"
	w_class = WEIGHT_CLASS_BULKY //Cant fit a sheath in your bag
	component_type = /datum/component/storage/concrete/belt/crusader

//Credit to Funce for this chunk of code directly below, which overrides normal dumping code and instead dumps from the pouch item inside
/datum/component/storage/concrete/belt/crusader/dump_content_at(atom/dest_object, mob/M)
    var/atom/used_belt = parent
    var/atom/dump_destination = dest_object.get_dumping_location()
    if(used_belt.Adjacent(M) && dump_destination && M.Adjacent(dump_destination))
        var/obj/item/storage/belt/storage_pouch/pouch = locate() in real_location()
        if (!pouch)
            to_chat(M, span_warning("[parent] doesn't seem to have a pouch to empty."))
            return FALSE //oopsie!! If we don't have a pouch! You're fucked!
        var/datum/component/storage/STR = pouch.GetComponent(/datum/component/storage)
        if(locked)
            to_chat(M, span_warning("[parent] seems to be locked!"))
            return FALSE
        if(dump_destination.storage_contents_dump_act(STR, M))
            playsound(used_belt, SFX_RUSTLE, 50, TRUE, -5)
            used_belt.do_squish(0.8, 1.2)
            return TRUE
    return FALSE

/obj/item/storage/belt/crusader/CtrlClick(mob/user)	//Makes ctrl-click also open the inventory, so that you can open it with full hands without dropping the sword
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.user_show_to_mob(user)
	return

/obj/item/storage/belt/crusader/AltClick(mob/user)	//This is basically the same as the normal sheath, but because there's always an item locked in the first slot it uses the second slot for swords
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return
	if(contents.len == 2)
		var/obj/item/drawn_item = contents[2]
		add_fingerprint(user)
		playsound(src, 'sound/items/unsheath.ogg', 50, TRUE, -5)
		if(!user.put_in_hands(drawn_item))
			to_chat(user, span_notice("You fumble for [drawn_item] and it falls on the floor."))
			update_appearance()
			return
		user.visible_message(span_notice("[user] takes [drawn_item] out of [src]."), span_notice("You take [drawn_item] out of [src]."))
		update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))
	. = ..()

/obj/item/storage/belt/crusader/update_icon(updates)
	if(contents.len == 2)	//Checks for a sword/rod in the sheath slot, changes the sprite accordingly
		icon_state = "crusader_belt_sheathed"
		worn_icon_state = "crusader_belt_sheathed"
	else
		icon_state = "crusader_belt"
		worn_icon_state = "crusader_belt"
	. = ..()

/obj/item/storage/belt/crusader/examine(mob/user)
	. = ..()
	.+= span_notice("Ctrl-click it to easily open its inventory.")
	if(contents.len == 2)	//If there's no sword/rod in the sheath slot it doesnt display the alt-click instruction
		. += span_notice("Alt-click it to quickly draw the blade.")
		return

/obj/item/storage/belt/crusader/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	STR.max_items = 2
	STR.rustle_sound = TRUE
	STR.max_w_class = WEIGHT_CLASS_BULKY	//This makes sure swords and the pouches can fit in here - the whitelist keeps the bad stuff out
	STR.allow_big_nesting = TRUE //Same as above, lets the pouch work
	STR.set_holdable(list(
		/obj/item/storage/belt/storage_pouch,
		/obj/item/forging/reagent_weapon/sword,
		/obj/item/melee/sabre,
		/obj/item/claymore,
		/obj/item/melee/cleric_mace,
		/obj/item/knife,
		/obj/item/melee/baton,
		/obj/item/melee/baton,
		/obj/item/nullrod	//holds any subset of nullrod in the sheath-storage - - -
		), list(	// - - - except the second list's items (no fedora in the sheath)
		/obj/item/nullrod/armblade,
		/obj/item/nullrod/carp,
		/obj/item/nullrod/chainsaw,
		/obj/item/nullrod/claymore/bostaff,
		/obj/item/nullrod/hammer,
		/obj/item/nullrod/pitchfork,
		/obj/item/nullrod/pride_hammer,
		/obj/item/nullrod/spear,
		/obj/item/nullrod/staff,
		/obj/item/nullrod/fedora,
		/obj/item/nullrod/godhand,
		/obj/item/nullrod/staff,
		/obj/item/nullrod/whip
		))

/obj/item/storage/belt/crusader/PopulateContents()
	. = ..()
	new /obj/item/storage/belt/storage_pouch(src)

/obj/item/storage/belt/storage_pouch	//seperate mini-storage inside the belt, leaving room for only one sword. Inspired by a (very poorly implemented) belt on Desert Rose
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "storage pouch"
	desc = span_notice("Click on this to open your belt's inventory!")
	icon_state = "storage_pouch_icon"
	worn_icon_state = "no name"	//Intentionally sets the worn icon to an error
	w_class = WEIGHT_CLASS_BULKY //Still cant put it in your bags, its technically a belt
	anchored = 1	//Dont want people taking it out with their hands

/obj/item/storage/belt/storage_pouch/attack_hand(mob/user, list/modifiers)	//Opens the bag on click - considering it's already anchored, this makes it function similar to how ghosts can open all nested inventories
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.user_show_to_mob(user)

/obj/item/storage/belt/storage_pouch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	STR.max_items = 6
	STR.rustle_sound = TRUE
	STR.max_w_class = WEIGHT_CLASS_SMALL //Rather than have a huge whitelist, the belt can simply hold anything a pocket can hold - Can easily be changed if it somehow becomes an issue

/obj/item/storage/belt/holster/cowboy
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "cowboy belt"
	desc = "Yee haw! The holster on the side of the hip is leather stamped with swirling lines, all leading back to a deer's antlers."
	icon_state = "cowboy_belt"
	worn_icon_state = "cowboy_belt"
	inhand_icon_state = "utility"

/obj/item/storage/belt/medbandolier
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "medical bandolier"
	desc = "A pocketed, pine green belt slung like a sash over the shoulder. Features numerous pockets for medicines and poisons alike. Now is coward healing time."
	icon_state = "med_bandolier"
	worn_icon_state = "med_bandolier"

/obj/item/storage/belt/medbandolier/ComponentInitialize()
	. = ..()
	var/datum/component/storage/bandolier_storage = GetComponent(/datum/component/storage)
	bandolier_storage.max_w_class = WEIGHT_CLASS_NORMAL
	bandolier_storage.max_items = 14
	bandolier_storage.max_combined_w_class = 35
	bandolier_storage.set_holdable(list(
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/storage/pill_bottle,
		/obj/item/implanter,
		/obj/item/reagent_containers/glass/vial,
		/obj/item/weaponcell/medical
		))
