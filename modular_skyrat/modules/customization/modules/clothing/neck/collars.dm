/datum/storage/pockets/small/collar
	max_slots = 1

/datum/storage/pockets/small/collar/New()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie))

/datum/storage/pockets/small/collar/locked/New()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/key/collar))

/obj/item/clothing/neck/human_petcollar
	name = "pet collar"
	desc = "It's for pets. Though you probably could wear it yourself, you'd doubtless be the subject of ridicule."
	icon_state = "pet"
	greyscale_config = /datum/greyscale_config/collar/pet
	greyscale_config_worn = /datum/greyscale_config/collar/pet/worn
	greyscale_colors = "#44BBEE#FFCC00"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER
	/// What's the name on the tag, if any?
	var/tagname = null
	/// What treat item spawns inside the collar?
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/human_petcollar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/collar)
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/human_petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	if(tagname)
		name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/human_petcollar/leather
	name = "leather pet collar"
	icon_state = "leather"
	greyscale_config = /datum/greyscale_config/collar/leather
	greyscale_config_worn = /datum/greyscale_config/collar/leather/worn
	greyscale_colors = "#222222#888888#888888"

/obj/item/clothing/neck/human_petcollar/choker
	name = "choker"
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	icon_state = "choker"
	greyscale_config = /datum/greyscale_config/collar/choker
	greyscale_config_worn = /datum/greyscale_config/collar/choker/worn
	greyscale_colors = "#222222"

/obj/item/clothing/neck/human_petcollar/thinchoker
	name = "thin choker"
	desc = "Like the normal one, but thinner!"
	icon_state = "thinchoker"
	greyscale_config = /datum/greyscale_config/collar/thinchoker
	greyscale_config_worn = /datum/greyscale_config/collar/thinchoker/worn
	greyscale_colors = "#222222"

/obj/item/key/collar
	name = "collar key"
	desc = "A key for a tiny lock on a collar or bag."

/obj/item/clothing/neck/human_petcollar/locked
	name = "locked collar"
	desc = "A collar that has a small lock on it to keep it from being removed."
	treat_path = /obj/item/key/collar
	/// Is the collar currently locked?
	var/locked = FALSE

/obj/item/clothing/neck/human_petcollar/locked/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_lock))
	create_storage(storage_type = /datum/storage/pockets/small/collar/locked)

/obj/item/clothing/neck/human_petcollar/locked/proc/try_lock(atom/source, mob/user, obj/item/attacking_item, params)
	if(istype(attacking_item, /obj/item/key/collar))
		to_chat(user, span_warning("With a click, the collar [locked ? "unlocks" : "locks"]!"))
		locked = !locked
	return TRUE

/obj/item/clothing/neck/human_petcollar/locked/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && locked)
		to_chat(user, span_warning("The collar is locked! You'll need unlock the collar before you can take it off!"))
		return
	..()

/obj/item/clothing/neck/human_petcollar/locked/examine(mob/user)
	. = ..()
	. += "It seems to be [locked ? "locked" : "unlocked"]."

/obj/item/clothing/neck/human_petcollar/locked/bell
	name = "bell collar"
	desc = "A loud and annoying collar for your little kitten!"
	icon_state = "bell"
	greyscale_config = /datum/greyscale_config/collar/bell
	greyscale_config_worn = /datum/greyscale_config/collar/bell/worn
	greyscale_colors = "#663300#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/choker
	name = "choker"
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	icon_state = "choker"
	greyscale_config = /datum/greyscale_config/collar/choker
	greyscale_config_worn = /datum/greyscale_config/collar/choker/worn
	greyscale_colors = "#222222"

/obj/item/clothing/neck/human_petcollar/locked/cow
	name = "cowbell collar"
	desc = "Don't fear the reaper, now your pet doesn't have to."
	icon_state = "cow"
	greyscale_config = /datum/greyscale_config/collar/cow
	greyscale_config_worn = /datum/greyscale_config/collar/cow/worn
	greyscale_colors = "#663300#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/cross
	name = "cross collar"
	desc = "A religious punishment, probably."
	icon_state = "cross"
	greyscale_config = /datum/greyscale_config/collar/cross
	greyscale_config_worn = /datum/greyscale_config/collar/cross/worn
	greyscale_colors = "#663300#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/holo
	name = "holocollar"
	desc = "A collar with holographic information. Like a microchip, but around the neck."
	icon_state = "holo"
	greyscale_config = /datum/greyscale_config/collar/holo
	greyscale_config_worn = /datum/greyscale_config/collar/holo/worn
	greyscale_colors = "#292929#3399FF"

/obj/item/clothing/neck/human_petcollar/locked/leather
	name = "leather pet collar"
	icon_state = "leather"
	greyscale_config = /datum/greyscale_config/collar/leather
	greyscale_config_worn = /datum/greyscale_config/collar/leather/worn
	greyscale_colors = "#222222#888888#888888"

/obj/item/clothing/neck/human_petcollar/locked/spike
	name = "spiked collar"
	desc = "A collar for a moody pet. Or a pitbull."
	icon_state = "spike"
	greyscale_config = /datum/greyscale_config/collar/spike
	greyscale_config_worn = /datum/greyscale_config/collar/spike/worn
	greyscale_colors = "#292929#C0C0C0"
