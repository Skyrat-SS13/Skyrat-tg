/obj/item/clothing/strapon
	name = "strapon"
	desc = "Sometimes you need a special way to humiliate someone."
	icon_state = "strapon_human"
	base_icon_state = "strapon"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	slot_flags = ITEM_SLOT_BELT
	var/in_hands = FALSE
	var/type_changed = FALSE
	var/strapon_type = "human"
	var/obj/item/strapon_dildo/strapon_item
	var/static/list/strapon_types
	actions_types = list(/datum/action/item_action/take_strapon)

//create radial menu
/obj/item/clothing/strapon/proc/populate_strapon_types()
	strapon_types = list(
		"avian" = image (icon = src.icon, icon_state = "strapon_avian"),
		"canine" = image (icon = src.icon, icon_state = "strapon_canine"),
		"dragon" = image (icon = src.icon, icon_state = "strapon_dragon"),
		"equine" = image (icon = src.icon, icon_state = "strapon_equine"),
		"human" = image (icon = src.icon, icon_state = "strapon_human"))

//to change model
/obj/item/clothing/strapon/click_alt(mob/user)
	if(type_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, strapon_types, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	strapon_type = choice
	update_icon()
	type_changed = TRUE
	return CLICK_ACTION_SUCCESS

//Check if we can change strapon's model
/obj/item/clothing/strapon/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/strapon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	update_mob_action_buttonss()
	if(!length(strapon_types))
		populate_strapon_types()

//shitcode here, please improve if you can. Genitals overlapping with strapon, doesn't cool!

/obj/item/clothing/strapon/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	var/obj/item/organ/external/genital/vagina/affected_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/external/genital/womb/affected_womb = affected_mob.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/external/genital/penis/affected_penis = affected_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/external/genital/testicles/affected_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)

	if(src == affected_mob.belt)
		affected_vagina?.visibility_preference = GENITAL_NEVER_SHOW
		affected_womb?.visibility_preference = GENITAL_NEVER_SHOW
		affected_penis?.visibility_preference = GENITAL_NEVER_SHOW
		affected_testicles?.visibility_preference = GENITAL_NEVER_SHOW
		affected_mob.update_body()
	else
		return

/obj/item/clothing/strapon/dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	var/obj/item/organ/external/genital/vagina/affected_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/external/genital/womb/affected_womb = affected_mob.get_organ_slot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/external/genital/penis/affected_penis = affected_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/external/genital/testicles/affected_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)

	if(strapon_item && !ismob(loc) && in_hands == TRUE && src != affected_mob.belt)
		qdel(strapon_item)
		in_hands = FALSE

	if(src == affected_mob.belt)
		affected_vagina?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_womb?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_penis?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_testicles?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		affected_mob.update_body()
	else
		return

/obj/item/clothing/strapon/update_icon_state()
	.=..()
	icon_state = "[base_icon_state]_[strapon_type]"

//Functionality stuff
/obj/item/clothing/strapon/proc/update_mob_action_buttonss()
	for(var/datum/action/item_action/take_strapon/action_button in actions_types)
		action_button.button_icon_state = "dildo_[strapon_type]"
		action_button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	update_icon()

//button stuff
/datum/action/item_action/take_strapon
	name = "Put strapon in hand"
	desc = "Put the strapon in your hand in order to use it properly."

/datum/action/item_action/take_strapon/Trigger(trigger_flags)
	var/obj/item/clothing/strapon/affected_item = target
	if(istype(affected_item))
		affected_item.check()

/obj/item/clothing/strapon/proc/check()
	var/mob/living/carbon/human/user = usr
	if(src == user.belt)
		toggle(user)
	else
		to_chat(user, span_warning("You need to put the strapon around your waist before you can use it!"))

/obj/item/clothing/strapon/proc/toggle(mob/living/carbon/human/user)
	conditional_pref_sound(user, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE)
	var/obj/item/held = user.get_active_held_item()
	var/obj/item/unheld = user.get_inactive_held_item()

	if(in_hands == TRUE)
		if(istype(held, /obj/item/strapon_dildo))
			qdel(held)
			user.visible_message(span_notice("[user] puts the strapon back."))
			in_hands = FALSE
			return

		else if(istype(unheld, /obj/item/strapon_dildo))
			qdel(unheld)
			user.visible_message(span_notice("[user] puts the strapon back."))
			in_hands = FALSE
			return

		else if(held == null)
			if(istype(unheld, /obj/item/strapon_dildo) && unheld.item_flags == ABSTRACT | HAND_ITEM)
				if(src == user.belt)
					qdel(unheld)
					//CODE FOR PUTTING STRAPON IN HANDS
					strapon_item = new()
					user.put_in_hands(strapon_item)
					strapon_item.strapon_type = strapon_type
					strapon_item.update_icon_state()
					strapon_item.update_icon()
					user.visible_message(span_notice("[user] holds the strapon in their hand menacingly."))
					in_hands = TRUE
					return
		else
			user.visible_message(span_notice("[user] tries to hold the strapon in their hand, but their hand isn't empty!"))
			return
	else
		strapon_item = new()
		user.put_in_hands(strapon_item)
		strapon_item.strapon_type = strapon_type
		strapon_item.update_icon_state()
		strapon_item.update_icon()
		user.visible_message(span_notice("[user] holds the strapon in their hand menacingly."))
		in_hands = TRUE
		return

/obj/item/strapon_dildo
	name = "strapon"
	desc = "An item with which to be menacing and merciless."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "dildo_human"
	base_icon_state = "dildo"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = ABSTRACT | HAND_ITEM | DROPDEL
	var/strapon_type = "human" //Default var, but we always getting var from strapon_type from item on top

/obj/item/strapon_dildo/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_STRAPON)

/obj/item/strapon_dildo/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[strapon_type]"

/obj/item/strapon_dildo/attack(mob/living/carbon/human/hit_mob, mob/living/carbon/human/user)
	if(hit_mob == user)
		return
	. = ..()
	if(!istype(hit_mob, /mob/living/carbon/human))
		return

	var/message = ""
	var/obj/item/organ/external/genital/vagina = hit_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(hit_mob.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		switch(user.zone_selected) //to let code know what part of body we gonna fuck
			if(BODY_ZONE_PRECISE_GROIN)
				if(vagina)
					if(hit_mob.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
						message = pick("delicately rubs [hit_mob]'s vagina with [src]", "uses [src] to fuck [hit_mob]'s vagina", "jams [hit_mob]'s pussy with [src]", "teases [hit_mob]'s pussy with [src]")
						hit_mob.adjust_arousal(6)
						hit_mob.adjust_pleasure(8)
						if(prob(40))
							hit_mob.try_lewd_autoemote(pick("twitch_s", "moan"))
						user.visible_message(span_purple("[user] [message]!"))
						conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 60, TRUE)
					else
						to_chat(user, span_danger("[hit_mob]'s groin is covered!"))
						return
				else
					to_chat(user, span_danger("[hit_mob] doesn't have suitable genitalia for that!"))
					return

			if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
				if(!hit_mob.is_mouth_covered())
					message = pick("fucks [hit_mob]'s mouth with [src]", "chokes [hit_mob] by inserting [src] into [hit_mob.p_their()] throat", "forces [hit_mob] to suck [src]", "inserts [src] into [hit_mob]'s throat")
					hit_mob.adjust_arousal(4)
					hit_mob.adjust_pleasure(1)
					hit_mob.adjustOxyLoss(1.5)
					if(prob(70))
						hit_mob.try_lewd_autoemote(pick("gasp", "moan"))
					user.visible_message(span_purple("[user] [message]!"))
					conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 40, TRUE)

				else
					to_chat(user, span_danger("[hit_mob]'s mouth is covered!"))
					return

			else
				if(hit_mob.is_bottomless())
					message = pick("fucks [hit_mob]'s ass with [src]", "uses [src] to fuck [hit_mob]'s anus", "jams [hit_mob]'s ass with [src]", "roughly fucks [hit_mob]'s ass with [src], causing their eyes to roll back")
					hit_mob.adjust_arousal(5)
					hit_mob.adjust_pleasure(5)
					if(prob(60))
						hit_mob.try_lewd_autoemote(pick("twitch_s", "moan", "shiver"))
					user.visible_message(span_purple("[user] [message]!"))
					conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 100, TRUE)

				else
					to_chat(user, span_danger("[hit_mob]'s anus is covered!"))
					return
	else
		to_chat(user, span_danger("[hit_mob] doesn't want you to do that."))
		return
