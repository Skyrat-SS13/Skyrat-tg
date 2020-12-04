/datum/component/storage/concrete/pockets/small/collar
	max_items = 1

/datum/component/storage/concrete/pockets/small/collar/Initialize()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/food/cookie/sugar))

/datum/component/storage/concrete/pockets/small/collar/locked/Initialize()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/food/cookie/sugar,
	/obj/item/key/collar))

/obj/item/clothing/neck/human_petcollar
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/neck.dmi'
	name = "pet collar"
	desc = "It's for pets. Though you probably could wear it yourself, you'd doubtless be the subject of ridicule. It seems to be made out of a polychromic material."
	icon_state = "petcollar"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar
	var/poly_states = 1
	var/poly_colors = list("#00BBBB")
	var/tagname = null
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/human_petcollar/Initialize()
	. = ..()
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/human_petcollar/ComponentInitialize()
	. = ..()
	if(!poly_states)
		return
	//AddElement(/datum/element/polychromic, poly_colors, poly_states)

/obj/item/clothing/neck/human_petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/human_petcollar/leather
	name = "leather pet collar"
	icon_state = "leathercollar"
	poly_states = 2
	poly_colors = list("#222222", "#888888")

/obj/item/clothing/neck/human_petcollar/choker
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	name = "choker"
	icon_state = "choker"
	poly_colors = list("#222222")

/obj/item/clothing/neck/human_petcollar/locked
	name = "locked collar"
	desc = "A collar that has a small lock on it to keep it from being removed."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar/locked
	treat_path = /obj/item/key/collar
	var/lock = FALSE

/obj/item/clothing/neck/human_petcollar/locked/attackby(obj/item/K, mob/user, params)
	if(istype(K, /obj/item/key/collar))
		if(lock != FALSE)
			to_chat(user, "<span class='warning'>With a click the collar unlocks!</span>")
			lock = FALSE
		else
			to_chat(user, "<span class='warning'>With a click the collar locks!</span>")
			lock = TRUE
	return

/obj/item/clothing/neck/human_petcollar/locked/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && lock != FALSE)
		to_chat(user, "<span class='warning'>The collar is locked! You'll need unlock the collar before you can take it off!</span>")
		return
	..()

/obj/item/clothing/neck/human_petcollar/locked/leather
	name = "leather pet collar"
	icon_state = "leathercollar"
	poly_states = 2
	poly_colors = list("#222222", "#888888")

/obj/item/clothing/neck/human_petcollar/locked/choker
	name = "choker"
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	icon_state = "choker"
	poly_colors = list("#222222")

/obj/item/key/collar
	name = "Collar Key"
	desc = "A key for a tiny lock on a collar or bag."
