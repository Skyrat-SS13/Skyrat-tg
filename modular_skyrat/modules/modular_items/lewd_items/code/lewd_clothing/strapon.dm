/obj/item/clothing/strapon
	name = "strapon"
	desc = "Sometimes you need a special way to humiliate someone."
	icon_state = "strapon"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	slot_flags = ITEM_SLOT_BELT
	var/in_hands = FALSE
	var/type_changed = FALSE
	var/strapon_type = "human"
	var/obj/item/strapon_dildo/W
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

//to update model
/obj/item/clothing/strapon/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/strapon/AltClick(mob/user, obj/item/I)
	if(type_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, strapon_types, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		strapon_type = choice
		update_icon()
		type_changed = TRUE
	else
		return

//Check if we can change strapon's model
/obj/item/clothing/strapon/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/strapon/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	update_action_buttons_icons()
	if(!length(strapon_types))
		populate_strapon_types()

//shitcode here, please improve if you can. Genitals overlapping with strapon, doesn't cool!

/obj/item/clothing/strapon/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/vagina/V = H.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/W = H.getorganslot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)

	if(src == H.belt)
		V?.visibility_preference = GENITAL_NEVER_SHOW
		W?.visibility_preference = GENITAL_NEVER_SHOW
		P?.visibility_preference = GENITAL_NEVER_SHOW
		T?.visibility_preference = GENITAL_NEVER_SHOW
		H.update_body()
	else
		return

/obj/item/clothing/strapon/dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/vagina/Vagene = H.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/Wombo = H.getorganslot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/Penus = H.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/Testes = H.getorganslot(ORGAN_SLOT_TESTICLES)

	if(W && !ismob(loc) && in_hands == TRUE && src != H.belt)
		qdel(W)
		in_hands = FALSE

	if(src == H.belt)
		Vagene?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		Wombo?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		Penus?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		Testes?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		H.update_body()
	else
		return

/obj/item/clothing/strapon/update_icon_state()
	.=..()
	icon_state = "[initial(icon_state)]_[strapon_type]"

//Functionality stuff
/obj/item/clothing/strapon/proc/update_action_buttons_icons()
	for(var/datum/action/item_action/take_strapon/M in actions_types)
		M.button_icon_state = "dildo_[strapon_type]"
		M.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	update_icon()

//button stuff
/datum/action/item_action/take_strapon
    name = "Put strapon in hand"
    desc = "Put the strapon in your hand in order to use it properly."

/datum/action/item_action/take_strapon/Trigger(trigger_flags)
	var/obj/item/clothing/strapon/H = target
	if(istype(H))
		H.check()

/obj/item/clothing/strapon/proc/check()
	var/mob/living/carbon/human/C = usr
	if(src == C.belt)
		toggle(C)
	else
		to_chat(C, span_warning("You need to put the strapon around your waist before you can use it!"))

/obj/item/clothing/strapon/proc/toggle(user)
	var/mob/living/carbon/human/C = usr
	playsound(C, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE, ignore_walls = FALSE)
	var/obj/item/held = C.get_active_held_item()
	var/obj/item/unheld = C.get_inactive_held_item()

	if(in_hands == TRUE)
		if(istype(held, /obj/item/strapon_dildo))
			qdel(held)
			C.visible_message(span_notice("[user] puts the strapon back."))
			in_hands = FALSE
			return

		else if(istype(unheld, /obj/item/strapon_dildo))
			qdel(unheld)
			C.visible_message(span_notice("[user] puts the strapon back."))
			in_hands = FALSE
			return

		else if(held == null)
			if(unheld.name =="strapon" && unheld.item_flags == ABSTRACT | HAND_ITEM)
				if(src == C.belt)
					qdel(unheld)
					//CODE FOR PUTTING STRAPON IN HANDS
					W = new()
					C.put_in_hands(W)
					W.strapon_type = strapon_type
					W.update_icon_state()
					W.update_icon()
					C.visible_message(span_notice("[user] holds the strapon in their hand menacingly."))
					in_hands = TRUE
					return
		else
			C.visible_message(span_notice("[user] tries to hold the strapon in their hand, but their hand isn't empty!"))
			return
	else
		W = new()
		C.put_in_hands(W)
		W.strapon_type = strapon_type
		W.update_icon_state()
		W.update_icon()
		C.visible_message(span_notice("[user] holds the strapon in their hand menacingly."))
		in_hands = TRUE
		return

/obj/item/strapon_dildo
	name = "strapon"
	desc = "An item with which to be menacing and merciless."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "dildo"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = ABSTRACT | HAND_ITEM | DROPDEL
	var/strapon_type = "human" //Default var, but we always getting var from strapon_type from item on top

/obj/item/strapon_dildo/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	ADD_TRAIT(src, TRAIT_NODROP, STRAPON_TRAIT)

/obj/item/strapon_dildo/update_icon_state()
	.=..()
	icon_state = "[initial(icon_state)]_[strapon_type]"

/obj/item/strapon_dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(M == user)
		return
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""
	var/obj/item/organ/genital/vagina = M.getorganslot(ORGAN_SLOT_VAGINA)
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		switch(user.zone_selected) //to let code know what part of body we gonna fuck
			if(BODY_ZONE_PRECISE_GROIN)
				if(vagina)
					if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
						message = pick("delicately rubs [M]'s vagina with [src]", "uses [src] to fuck [M]'s vagina","jams [M]'s pussy with [src]", "teases [M]'s pussy with [src]")
						M.adjustArousal(6)
						M.adjustPleasure(8)
						if(prob(40))
							M.emote(pick("twitch_s","moan"))
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 60, TRUE, ignore_walls = FALSE)
					else
						to_chat(user, span_danger("[M]'s groin is covered!"))
						return
				else
					to_chat(user, span_danger("[M] doesn't have suitable genitalia for that!"))
					return

			if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
				if(!M.is_mouth_covered())
					message = pick("fucks [M]'s mouth with [src]", "chokes [M] by inserting [src] into [M.p_their()] throat", "forces [M] to suck [src]", "inserts [src] into [M]'s throat")
					M.adjustArousal(4)
					M.adjustPleasure(1)
					M.adjustOxyLoss(1.5)
					if(prob(70))
						M.emote(pick("gasp","moan"))
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 40, TRUE, ignore_walls = FALSE)

				else
					to_chat(user, span_danger("[M]'s mouth is covered!"))
					return

			else
				if(M.is_bottomless())
					message = pick("fucks [M]'s ass with [src]", "uses [src] to fuck [M]'s anus", "jams [M]'s ass with [src]", "roughly fucks [M]'s ass with [src], causing their eyes to roll back")
					M.adjustArousal(5)
					M.adjustPleasure(5)
					if(prob(60))
						M.emote(pick("twitch_s","moan","shiver"))
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 100, TRUE, ignore_walls = FALSE)

				else
					to_chat(user, span_danger("[M]'s anus is covered!"))
					return
	else
		to_chat(user, span_danger("[M] doesn't want you to do that."))
		return
