/obj/item/clothing/mask/paper
	name = "paper mask"
	desc = "It's true. Once you wear a mask for so long, you forget about who you are. Wonder if that happens with shitty paper ones."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "mask_paper"
	clothing_flags = MASKINTERNALS
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust)
	unique_reskin = list(
			"Blank" = "mask_paper",
			"Neutral" = "mask_neutral",
			"Eye" = "mask_eye",
			"Sleep" = "mask_sleep",
			"Heart" = "mask_heart",
			"Core" = "mask_core",
			"Plus" = "mask_plus",
			"Square" = "mask_square",
			"Bullseye" = "mask_bullseye",
			"Vertical" = "mask_vertical",
			"Horizontal" = "mask_horizontal",
			"X" = "mask_x",
			"Bug" = "mask_bug",
			"Double" = "mask_double",
			"Mark" = "mask_mark",
			"Line" = "mask_line",
			"Minus" = "mask_minus",
			"Four" = "mask_four",
			"Diamond" = "mask_diamond",
			"Cat" = "mask_cat",
			"Big Eye" = "mask_bigeye",
			"Good" = "mask_good",
			"Bad" = "mask_bad",
			"Happy" = "mask_happy",
			"Sad" = "mask_sad",
	)

	/// Whether or not the mask is currently being layered over (or under!) hair.
	var/wear_over_hair = TRUE

/obj/item/clothing/mask/paper/Initialize(mapload)
	. = ..()
	register_context()
	if(wear_over_hair)
		alternate_worn_layer = BACK_LAYER

/obj/item/clothing/mask/paper/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Change Mask Face"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/mask/paper/reskin_obj(mob/user)
	. = ..()
	user.update_worn_mask()
	current_skin = null //so we can infinitely reskin

/obj/item/clothing/mask/paper/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/adjust))
		adjust_mask(user)

/obj/item/clothing/mask/paper/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated())
		wear_over_hair = !wear_over_hair
		var/is_worn = user.wear_mask == src
		if(wear_over_hair)
			alternate_worn_layer = BACK_LAYER
			to_chat(user, "You [is_worn ? "" : "will "]sweep your hair over the mask.")
		else
			alternate_worn_layer = initial(alternate_worn_layer)
			to_chat(user, "You [is_worn ? "" : "will "]sweep your hair under the mask.")

		user.update_body_parts()
		user.update_inv_ears(0)
		user.update_worn_mask()

// Because alternate_worn_layer can potentially get reset on unequipping the mask (ex: for 'Top' snouts), let's make sure we don't lose it our settings
/obj/item/clothing/mask/paper/dropped(mob/living/carbon/human/user)
	var/prev_alternate_worn_layer = alternate_worn_layer
	. = ..()
	alternate_worn_layer = prev_alternate_worn_layer

/obj/item/clothing/mask/paper/verb/toggle()
		set category = "Object"
		set name = "Adjust Mask"
		set src in usr
		adjust_mask(usr)
