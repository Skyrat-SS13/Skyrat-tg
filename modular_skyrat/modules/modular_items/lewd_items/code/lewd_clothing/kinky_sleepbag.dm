/*
/obj/item/clothing/suit/straight_jacket/kinky_sleepbag
	name = "latex sleeping bag"
	desc = "A tight sleeping bag made of a shiny material. It would be dangerous to put it on yourself."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_normal.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_special.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_special.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_special.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
	icon_state = "sleepbag"
	inhand_icon_state = "sleepbag"
	w_class = WEIGHT_CLASS_SMALL
	var/bag_state = "deflated"
	var/bag_fold = TRUE
	var/bag_color = "pink"
	var/color_changed = FALSE
	var/time_to_sound = 20
	var/time_to_sound_left
	var/time = 2
	var/tt
	var/static/list/bag_colors
	flags_inv = HIDEHEADGEAR|HIDENECK|HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDESUITSTORAGE|HIDEHAIR|HIDESEXTOY|HIDETAIL // SKYRAT EDIT ADDITION - HIDETAIL
	strip_delay = 300
	breakouttime = 1200 //do not touch. First - It's contraband item, Second - It's damn expensive, Third - it's ERP item, so you can't legally use it on characters without enabled non-con or erp pref.
	var/static/list/bag_inf_states
	var/list/bag_states = list("deflated" = "inflated", "inflated" = "deflated")
	var/state_thing = "deflated"
	var/mutable_appearance/bag_overlay
	var/obj/item/bodypart/l_leg/legr
	var/obj/item/bodypart/l_leg/legl
	slowdown = 2
	equip_delay_other = 300
	equip_delay_self = NONE
	worn_x_dimension = 64
	worn_y_dimension = 64
	clothing_flags = LARGE_WORN_ICON
	slot_flags = NONE
	species_exception = list(/datum/species/plasmaman)
	custom_price = 600

//create radial menu
/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/proc/populate_bag_colors()
	bag_colors = list(
		"pink" = image (icon = src.icon, icon_state = "sleepbag_pink_deflated_folded"),
		"teal" = image(icon = src.icon, icon_state = "sleepbag_teal_deflated_folded"))

//radial menu for changing type
/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/proc/populate_bag_inf_states()
	bag_inf_states = list(
		"inflated" = image (icon = src.icon, icon_state = "sleepbag_pink_deflated_folded"),
		"deflated" = image(icon = src.icon, icon_state = "sleepbag_teal_deflated_folded"))

//to update model lol
/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/AltClick(mob/user)
	var/mob/living/carbon/human/clicking_human = user
	if(istype(clicking_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		to_chat(user, span_warning("Your hands are stuck, you can't do this!"))
		return FALSE
	switch(color_changed)
		if(FALSE)
			. = ..()
			if(.)
				return
			var/choice = show_radial_menu(user, src, bag_colors, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
			if(!choice)
				return FALSE
			bag_color = choice
			update_icon()
			update_icon_state()
			color_changed = TRUE

		if(TRUE)
			if(bag_state == "deflated")
				fold()
				to_chat(user, span_notice("The sleeping bag now is [bag_fold? "folded." : "unfolded."]"))
				update_icon()
				update_icon_state()
			else
				to_chat(user, span_notice("You can't fold the bag while it's inflated!"))

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(bag_colors))
		populate_bag_colors()
	if(!length(bag_inf_states))
		populate_bag_inf_states()

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[bag_color]_[bag_state]_[bag_fold? "folded" : "unfolded"]"
	inhand_icon_state = "[initial(icon_state)]_[bag_color]_[bag_state]_[bag_fold? "folded" : "unfolded"]"

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/equipped(mob/user, slot)
	var/mob/living/carbon/human/affected_human = user
	if(ishuman(user) && slot == ITEM_SLOT_OCLOTHING)
		ADD_TRAIT(user, TRAIT_FLOORED, CLOTHING_TRAIT)

		affected_human.cut_overlay(affected_human.overlays_standing[SHOES_LAYER])
		affected_human.cut_overlay(affected_human.overlays_standing[BELT_LAYER])
		affected_human.cut_overlay(affected_human.overlays_standing[NECK_LAYER])
		affected_human.cut_overlay(affected_human.overlays_standing[BACK_LAYER])
		affected_human.cut_overlay(affected_human.overlays_standing[BODY_BEHIND_LAYER])

		START_PROCESSING(SSobj, src)
		time_to_sound_left = time_to_sound

		if(bag_state == "inflated")
			to_chat(affected_human, span_purple("You realize that you can't move even an inch. The inflated sleeping bag squeezes you from all sides!"))
			affected_human.cut_overlay(affected_human.overlays_standing[HEAD_LAYER])
			affected_human.cut_overlay(affected_human.overlays_standing[HAIR_LAYER])
		if(bag_state == "deflated")
			to_chat(affected_human, span_purple("You realize that moving now is much harder. You're fully restrained, any struggling is useless!"))
	. = ..()

//to inflate/deflate that thing
/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/attack_self(mob/user)
	var/mob/living/carbon/human/affected_human = user
	if(bag_fold == FALSE)
		toggle_mode()
		to_chat(affected_human, span_notice("The sleeping bag now is [bag_state? "inflated." : "deflated."]"))
		update_icon()
		update_icon_state()
	else
		to_chat(affected_human, span_notice("You need to unfold the bag before inflating it!"))

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/proc/fold(mob/user, src)
	bag_fold = !bag_fold
	playsound(user, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE, ignore_walls = FALSE)
	if(bag_fold == TRUE)
		w_class = WEIGHT_CLASS_SMALL
		slot_flags = NONE
	if(bag_fold == FALSE)
		w_class = WEIGHT_CLASS_HUGE
		slot_flags = ITEM_SLOT_OCLOTHING
	update_icon_state()
	update_icon()

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/proc/toggle_mode()
	state_thing = bag_states[state_thing]
	switch(state_thing)
		if("deflated")
			bag_state = "deflated"
			breakouttime = 1 MINUTES
			slowdown = 4 //moving like a caterpillar now
		if("inflated")
			bag_state = "inflated"
			breakouttime = 2 MINUTES //do not touch
			slowdown = 14 //it should be almost impossible to move in that thing, so this big slowdown have reasons.
	// appearance_update()

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/dropped(mob/user)
	var/mob/living/carbon/human/affected_human = user

	if(ishuman(user))
		if(src == affected_human.wear_suit)
			REMOVE_TRAIT(user, TRAIT_FLOORED, CLOTHING_TRAIT)
			to_chat(user, span_purple("You are finally free! The bag is no longer constricting your movements."))

			affected_human.add_overlay(affected_human.overlays_standing[SHOES_LAYER])
			affected_human.update_inv_shoes()
			affected_human.add_overlay(affected_human.overlays_standing[BELT_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[NECK_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[BACK_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[BODY_BEHIND_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[BODY_FRONT_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[HEAD_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[HAIR_LAYER])
			affected_human.add_overlay(affected_human.overlays_standing[SHOES_LAYER])

			affected_human.update_inv_shoes()
			affected_human.regenerate_icons()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/process(delta_time)
	if(time_to_sound_left <= 0)
		if(tt <= 0)
			playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 100, TRUE, ignore_walls = FALSE)
			tt = rand(15, 35) //to do random funny sounds when character inside that thing.
		else
			tt -= delta_time
	else
		time_to_sound_left -= delta_time


/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/doStrip(mob/stripper, mob/owner)
	. = ..()
	owner.update_inv_hands()
	stripper.update_inv_hands()
*/
