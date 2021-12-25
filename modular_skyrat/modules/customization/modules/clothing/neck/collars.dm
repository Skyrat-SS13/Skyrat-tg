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
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	name = "pet collar"
	desc = "It's for pets. Though you probably could wear it yourself, you'd doubtless be the subject of ridicule. It seems to be made out of a polychromic material."
	icon_state = "petcollar_poly"
	alternate_worn_layer = UNDER_SUIT_LAYER
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar
	var/is_polychromic = TRUE
	var/poly_colors = list("#00BBBB", "#FFCC00", "#FFFFFF")
	var/tagname = null
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/human_petcollar/Initialize()
	. = ..()
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/human_petcollar/ComponentInitialize()
	. = ..()
	if(is_polychromic)
		AddElement(/datum/element/polychromic, poly_colors)

/obj/item/clothing/neck/human_petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/human_petcollar/leather
	name = "leather pet collar"
	icon_state = "leathercollar_poly"
	poly_colors = list("#222222", "#888888", "#888888")

/obj/item/clothing/neck/human_petcollar/choker
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	name = "choker"
	icon_state = "choker"
	is_polychromic = FALSE //It's 1 customizable color, can be changed in loadout
	color = "#222222"

/obj/item/clothing/neck/human_petcollar/locked
	name = "locked collar"
	desc = "A collar that has a small lock on it to keep it from being removed."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar/locked
	treat_path = /obj/item/key/collar
	var/lock = FALSE

/obj/item/clothing/neck/human_petcollar/locked/attackby(obj/item/K, mob/user, params)
	if(istype(K, /obj/item/key/collar))
		if(lock != FALSE)
			to_chat(user, span_warning("With a click the collar unlocks!"))
			lock = FALSE
		else
			to_chat(user, span_warning("With a click the collar locks!"))
			lock = TRUE
	return

/obj/item/clothing/neck/human_petcollar/locked/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && lock != FALSE)
		to_chat(user, span_warning("The collar is locked! You'll need unlock the collar before you can take it off!"))
		return
	..()

/obj/item/clothing/neck/human_petcollar/locked/leather
	name = "leather pet collar"
	icon_state = "leathercollar_poly"
	poly_colors = list("#222222", "#888888", "#888888")

/obj/item/clothing/neck/human_petcollar/locked/choker
	name = "choker"
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	icon_state = "choker"
	is_polychromic = FALSE
	color = "#222222"

/obj/item/key/collar
	name = "collar key"
	desc = "A key for a tiny lock on a collar or bag."

/obj/item/clothing/neck/human_petcollar/locked/cowcollar
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	name = "cowbell collar"
	desc = "Don't fear the reaper, now your pet doesn't have to."
	icon_state = "collar_cowbell"

/obj/item/clothing/neck/human_petcollar/locked/bellcollar
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	name = "bell collar"
	desc = "A loud and annoying collar for your little kittens!"
	icon_state = "collar_bell"


/obj/item/clothing/neck/human_petcollar/locked/spikecollar
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	name = "spiked collar"
	desc = "A collar for moody pets. Or pitbulls."
	icon_state = "collar_spik"
	is_polychromic = FALSE

/obj/item/clothing/neck/human_petcollar/locked/holocollar
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	name = "holocollar"
	desc = "A collar with holographic information, like a microchip, but around the neck."
	icon_state = "collar_holo"
	is_polychromic = FALSE

/obj/item/clothing/neck/human_petcollar/locked/cross
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	name = "cross collar"
	desc = "A religious punishment, probably."
	icon_state = "collar_blk"




