/obj/item/clothing/shoes/sneakers
	dying_key = DYE_REGISTRY_SNEAKERS
	icon_state = "sneakers"
	inhand_icon_state = "sneakers_back"
	lefthand_file = 'icons/mob/inhands/clothing/shoes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/shoes_righthand.dmi'
	greyscale_colors = "#2d2d33#ffffff"
	greyscale_config = /datum/greyscale_config/sneakers
	greyscale_config_worn = /datum/greyscale_config/sneakers/worn
	greyscale_config_inhand_left = /datum/greyscale_config/sneakers/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/sneakers/inhand_right
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_config_worn_digi = /datum/greyscale_config/sneakers/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	interaction_flags_mouse_drop = NEED_HANDS

/obj/item/clothing/shoes/sneakers/black
	name = "black shoes"
	desc = "A pair of black shoes."
	custom_price = PAYCHECK_CREW

	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/sneakers/brown
	name = "brown shoes"
	desc = "A pair of brown shoes."
	greyscale_colors = "#472c21#ffffff"

/obj/item/clothing/shoes/sneakers/blue
	name = "blue shoes"
	greyscale_colors = "#4f88df#ffffff"
	armor_type = /datum/armor/sneakers_blue

/datum/armor/sneakers_blue
	bio = 95

/obj/item/clothing/shoes/sneakers/green
	name = "green shoes"
	greyscale_colors = "#3bca5a#ffffff"

/obj/item/clothing/shoes/sneakers/yellow
	name = "yellow shoes"
	greyscale_colors = "#deb63d#ffffff"

/obj/item/clothing/shoes/sneakers/purple
	name = "purple shoes"
	greyscale_colors = "#7e1980#ffffff"

/obj/item/clothing/shoes/sneakers/red
	name = "red shoes"
	desc = "Stylish red shoes."
	greyscale_colors = "#a52f29#ffffff"

/obj/item/clothing/shoes/sneakers/white
	name = "white shoes"
	greyscale_colors = "#ffffff#ffffff"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "shoes_cloth"
	armor_type = /datum/armor/sneakers_white

/datum/armor/sneakers_white
	bio = 95

/obj/item/clothing/shoes/sneakers/rainbow
	name = "rainbow shoes"
	desc = "Very gay shoes."
	icon_state = "rain_bow"
	inhand_icon_state = "rainbow_sneakers"

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	flags_1 = NONE

/obj/item/clothing/shoes/sneakers/orange
	name = "orange shoes"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "prisonshoes"
	greyscale_colors = "#d15b1b#ffffff"
	greyscale_config = /datum/greyscale_config/sneakers_orange
	greyscale_config_worn = /datum/greyscale_config/sneakers_orange/worn
	greyscale_config_inhand_left = /datum/greyscale_config/sneakers_orange/inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/sneakers_orange/inhand_right
	flags_1 = NONE
	var/obj/item/restraints/handcuffs/attached_cuffs
	greyscale_config_worn_digi = /datum/greyscale_config/sneakers_orange/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale

/obj/item/clothing/shoes/sneakers/orange/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_HANDCUFFED)

/obj/item/clothing/shoes/sneakers/orange/Destroy()
	QDEL_NULL(attached_cuffs)
	return ..()

/obj/item/clothing/shoes/sneakers/orange/Exited(atom/movable/gone, direction)
	if(gone == attached_cuffs)
		attached_cuffs = null
		slowdown = SHOES_SLOWDOWN
		update_appearance(UPDATE_ICON)
	return ..()

/obj/item/clothing/shoes/sneakers/orange/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(arrived.type == /obj/item/restraints/handcuffs)
		attached_cuffs = arrived
		slowdown = 15
		update_appearance(UPDATE_ICON)
	return ..()

/obj/item/clothing/shoes/sneakers/orange/update_icon_state()
	. = ..()
	if(attached_cuffs)
		icon_state = inhand_icon_state = "sneakers_chained"
	else
		icon_state = initial(icon_state)
		inhand_icon_state = initial(inhand_icon_state)
	update_greyscale()

/obj/item/clothing/shoes/sneakers/orange/attack_self(mob/user)
	if(attached_cuffs)
		to_chat(user, span_notice("You remove [attached_cuffs] from [src]."))
		if(Adjacent(user)) //tk is love, tk is life.
			user.put_in_hands(attached_cuffs)
		else
			attached_cuffs.forceMove(drop_location())
		return
	return ..()

/obj/item/clothing/shoes/sneakers/orange/pre_attack(atom/movable/attacking_movable, mob/living/user, params)
	if(attached_cuffs || attacking_movable.type != /obj/item/restraints/handcuffs)
		return ..()
	attacking_movable.forceMove(src)
	return TRUE

/obj/item/clothing/shoes/sneakers/orange/attackby(obj/item/attacking_item, mob/user, params)
	if(attached_cuffs || attacking_item.type != /obj/item/restraints/handcuffs) 	// Note: not using istype here because we want to ignore all subtypes
		return ..()
	attacking_item.forceMove(src)

/obj/item/clothing/shoes/sneakers/orange/allow_attack_hand_drop(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/C = user
		if(C.shoes == src && attached_cuffs)
			to_chat(user, span_warning("You need help taking these off!"))
			return FALSE
	return ..()

/obj/item/clothing/shoes/sneakers/orange/mouse_drop_dragged(atom/over_object, mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/c = user
		if(c.shoes == src && attached_cuffs)
			to_chat(c, span_warning("You need help taking these off!"))
			return
	return ..()

/obj/item/clothing/shoes/sneakers/mime
	name = "mime shoes"
	greyscale_colors = "#ffffff#ffffff"

/obj/item/clothing/shoes/sneakers/marisa
	desc = "A pair of magic black shoes."
	name = "magic shoes"
	greyscale_colors = "#2d2d33#ffffff"
	greyscale_config = /datum/greyscale_config/sneakers_marisa
	greyscale_config_worn = /datum/greyscale_config/sneakers_marisa/worn
	strip_delay = 5
	equip_delay_other = 50
	can_be_tied = FALSE
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/shoes/sneakers/cyborg
	name = "cyborg boots"
	desc = "Shoes for a cyborg costume."
	greyscale_colors = "#4e4e4e#4e4e4e"
