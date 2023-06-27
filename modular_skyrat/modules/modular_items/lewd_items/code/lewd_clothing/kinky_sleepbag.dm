#define SOUND_SLEEPING_BAG_LATEX 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg'
#define SOUND_COOLDOWN_LENGTH 20 SECONDS
#define SLOWDOWN_INFLATED 14
#define SLOWDOWN_DEFLATED 4
#define FOLD_VOLUME 40
#define PROCESS_NOISE_VOLUME 100
#define ICON_STATE_FOLDED_PINK "sleepbag_pink_deflated_folded"
#define ICON_STATE_FOLDED_TEAL "sleepbag_teal_deflated_folded"
#define BAG_NOISE_CHANCE 1

#define BREAKOUT_TIME_INFLATED 10 SECONDS
#define BREAKOUT_TIME_DEFLATED 5 SECONDS

/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag
	name = "latex sleeping bag"
	desc = "A tight sleeping bag made of a shiny material. It would be dangerous to put it on yourself."

	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_normal.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_special.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_special.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/sleepbag_special.dmi'
	icon_state = "sleepbag_pink_deflated_folded"
	base_icon_state = "sleepbag"
	worn_y_dimension = 64
	worn_x_dimension = 64
	clothing_flags = LARGE_WORN_ICON
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL

	flags_inv = HIDEHEADGEAR|HIDENECK|HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDESUITSTORAGE|HIDEHAIR|HIDESEXTOY|HIDETAIL
	breakouttime = 2 MINUTES
	slowdown = 2
	slot_flags = NONE
	species_exception = list(/datum/species/plasmaman)
	custom_price = PAYCHECK_CREW * 12 // 600 credits

	/// The overlays removed when we wear this thing un-inflated
	var/static/list/applied_overlays = list(
		BACK_LAYER,
		BELT_LAYER,
		BODY_BEHIND_LAYER,
		BODY_FRONT_LAYER,
		HAIR_LAYER,
		HEAD_LAYER,
		NECK_LAYER,
		SHOES_LAYER,
	)

	/// The overlays removed when we wear this thing and it's inflated
	var/static/list/bonus_overlays = list(
		HAIR_LAYER,
		HEAD_LAYER,
	)

	/// The overlays we had before putting the bag on, so we can put them back when we take it off
	var/list/previous_overlays = list()

	/// Is the bag inflated?
	var/inflated = FALSE
	/// Is the bag folded?
	var/folded = TRUE
	/// The color of the bag
	var/bag_color = "pink"
	/// Has the color been changed?
	var/color_changed = FALSE
	/// The colors for the radial menu
	var/list/bag_colors

	COOLDOWN_DECLARE(sound_cooldown)


/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!length(bag_colors))
		populate_bag_colors()


// to reskin the bag
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/AltClick(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user

	if(istype(human_user.wear_suit, /obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag))
		balloon_alert("hands tied!")
		return FALSE

	if(!color_changed)
		handle_color_change(human_user)
		return

	if(!fold(human_user))
		return
	to_chat(human_user, span_notice("The sleeping bag now is [folded? "folded." : "unfolded."]"))
	update_icon()


/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/update_icon_state()
	. = ..()
	var/new_icon = build_icon_state()

	icon_state = new_icon


/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user) || !(slot & ITEM_SLOT_OCLOTHING))
		return
	var/mob/living/carbon/human/affected_human = user
	if(check_prefs(user))
		ADD_TRAIT(affected_human, TRAIT_FLOORED, CLOTHING_TRAIT)

	for(var/overlay in applied_overlays)
		if(!affected_human.overlays_standing[overlay])
			continue
		previous_overlays += affected_human.overlays_standing[overlay]
		affected_human.cut_overlay(affected_human.overlays_standing[overlay])

	if(inflated)
		to_chat(affected_human, span_purple("You realize that you can't move even an inch. [src] squeezes you from all sides!"))
		for(var/overlay in bonus_overlays)
			previous_overlays += affected_human.overlays_standing[overlay]
			affected_human.cut_overlay(affected_human.overlays_standing[overlay])
	else
		to_chat(affected_human, span_purple("You realize that moving now is much harder. You're fully restrained, any struggling is useless!"))

	START_PROCESSING(SSobj, src)


// in/deflates the bag
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/attack_self(mob/user)
	var/mob/living/carbon/human/affected_human = user
	if(folded)
		balloon_alert(affected_human, "can't [inflated ? "de" : "in"]flate while folded!")
		return
	toggle_mode(affected_human)
	update_icon()


/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/dropped(mob/user)
	..()
	STOP_PROCESSING(SSobj, src)

	if(!ishuman(user))
		return
	var/mob/living/carbon/human/affected_human = user
	if(!affected_human.wear_suit == src)
		return

	REMOVE_TRAIT(affected_human, TRAIT_FLOORED, CLOTHING_TRAIT)
	to_chat(affected_human, span_purple("You're free! [src] is no longer constricting your movements."))


	for(var/overlay in previous_overlays)
		affected_human.add_overlay(overlay)

	affected_human.regenerate_icons()


/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/process(seconds_per_tick)
	if(!ishuman(loc))
		STOP_PROCESSING(SSobj, src)
		return
	if(!COOLDOWN_FINISHED(src, sound_cooldown))
		return
	if(prob(BAG_NOISE_CHANCE))
		playsound(loc, SOUND_SLEEPING_BAG_LATEX, PROCESS_NOISE_VOLUME, TRUE, ignore_walls = FALSE)
		COOLDOWN_START(src, sound_cooldown, SOUND_COOLDOWN_LENGTH)


/**
 * Checks if the user has the preference to use this item.
 *
 * @param user The user to check.
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/check_prefs(mob/user)
	if(user.client?.prefs.read_preference(/datum/preference/toggle/erp/sex_toy))
		return TRUE
	else
		return FALSE


/**
 * Populates colours / designs for the radial menu
 * We don't need to worry about the inflated state because you can't inflate it before reskinning it
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/populate_bag_colors()
	bag_colors = list(
		"pink" = image(icon = src.icon, icon_state = ICON_STATE_FOLDED_PINK),
		"teal" = image(icon = src.icon, icon_state = ICON_STATE_FOLDED_TEAL),
		)


/**
 * Checks if the user is able to access the reskin menu
 *
 * @params user The mob being checked
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE


/**
 * Handles changing the colour of the bag
 *
 * @params user The mob changing the colour
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/handle_color_change(mob/living/user)
	var/choice = show_radial_menu(user, src, bag_colors, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	bag_color = choice
	update_icon()
	color_changed = TRUE
	return


/**
 * Folds the bag
 * Changes the folded state, weight class, and slot flags
 *
 * @params user The mob folding the bag
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/fold(mob/user)
	if(inflated)
		balloon_alert(user, "need to deflate!")
		return

	folded = !folded
	playsound(user, SOUND_SLEEPING_BAG_LATEX, FOLD_VOLUME, vary = TRUE, ignore_walls = FALSE)
	if(folded)
		w_class = WEIGHT_CLASS_SMALL
		slot_flags = NONE
	else
		w_class = WEIGHT_CLASS_HUGE
		slot_flags = ITEM_SLOT_OCLOTHING
	update_icon()


/**
 * Builds the icon state for the bag
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/build_icon_state()
	var/built_icon_state

	built_icon_state += "[base_icon_state]"
	built_icon_state += "_[bag_color]"
	built_icon_state += "_[inflated ? "inflated" : "deflated"]"
	built_icon_state += "_[folded? "folded" : "unfolded"]"

	return built_icon_state


/**
 * Toggles the inflated state of the bag
 * Changes the slowdown and breakout time
 *
 * @params user The mob in/deflating the bag
 */
/obj/item/clothing/suit/jacket/straight_jacket/sleeping_bag/proc/toggle_mode(mob/user)
	inflated = !inflated
	if(inflated)
		breakouttime = BREAKOUT_TIME_INFLATED
		slowdown = SLOWDOWN_INFLATED
	else
		breakouttime = BREAKOUT_TIME_DEFLATED
		slowdown = SLOWDOWN_DEFLATED

	balloon_alert(user, "[inflated ? "inflated" : "deflated"]")

