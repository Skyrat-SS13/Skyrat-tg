//////////////////
///NORMAL DILDO///
//////////////////

/obj/item/clothing/sextoy/dildo
	name = "dildo"
	desc = "A large plastic penis, much like the one in your mother's bedside drawer."
	icon_state = "dildo"
	inhand_icon_state = "dildo"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	var/current_color = "human"
	var/color_changed = FALSE
	var/static/list/dildo_designs
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ANUS|ITEM_SLOT_VAGINA
	moth_edible = FALSE

//create radial menu
/obj/item/clothing/sextoy/dildo/proc/populate_dildo_designs()
	dildo_designs = list(
		"avian" = image (icon = src.icon, icon_state = "dildo_avian"),
		"canine" = image(icon = src.icon, icon_state = "dildo_canine"),
		"equine" = image(icon = src.icon, icon_state = "dildo_equine"),
		"dragon" = image(icon = src.icon, icon_state = "dildo_dragon"),
		"human" = image(icon = src.icon, icon_state = "dildo_human"),
		"tentacle" = image(icon = src.icon, icon_state = "dildo_tentacle"))

/obj/item/clothing/sextoy/dildo/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, dildo_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change dildo's model
/obj/item/clothing/sextoy/dildo/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/sextoy/dildo/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(dildo_designs))
		populate_dildo_designs()

/obj/item/clothing/sextoy/dildo/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/sextoy/dildo/equipped(mob/user, slot)
	.=..()
	var/mob/living/carbon/human/H = user
	if(src == H.anus || src == H.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/dildo/dropped(mob/user, slot)
	.=..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/dildo/process(delta_time)
	var/mob/living/carbon/human/U = loc
	if(U.arousal < 25)
		U.adjustArousal(0.8 * delta_time)
		U.adjustPleasure(0.8 * delta_time)

/obj/item/clothing/sextoy/dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
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
						message = (user == M) ? pick("rubs [M.p_their()] vagina with [src]","gently jams [M.p_their()] pussy with [src]","fucks [M.p_their()] vagina with a [src]") : pick("delicately rubs [M]'s vagina with [src]", "uses [src] to fuck [M]'s vagina","jams [M]'s pussy with [src]", "teasing [M]'s pussy with [src]")
						M.adjustArousal(6)
						M.adjustPleasure(8)
						if(prob(40) && (M.stat != DEAD))
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
					to_chat(user, span_danger("[M] don't have suitable genitalia for that!"))
					return

			if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
				if(!M.is_mouth_covered())
					message = (user == M) ? pick("licks [src] erotically","sucks on [src], slowly inserting it into [M.p_their()] throat") : pick("fucks [M]'s mouth with [src]", "inserts [src] into [M]'s throat, choking [M.p_them()]", "forces [M] to suck [src]", "inserts [src] into [M]'s throat")
					M.adjustArousal(4)
					M.adjustPleasure(1)
					M.adjustOxyLoss(1.5)
					if(prob(70) && (M.stat != DEAD))
						M.emote(pick("gasp","moan"))
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 40, TRUE, ignore_walls = FALSE)

				else
					to_chat(user, span_danger("Looks like [M]'s mouth is covered!"))
					return

			else
				if(M.is_bottomless())
					message = (user == M) ? pick("puts [src] into [M.p_their()] anus","slowly inserts [src] into [M.p_their()] ass") : pick("fucks [M]'s ass with [src]", "uses [src] to fuck [M]'s anus", "jams [M]'s ass with [src]", "roughly fucks [M]'s ass with [src], making [M.p_their()] eyes roll back")
					M.adjustArousal(5)
					M.adjustPleasure(5)
					if(prob(60) && (M.stat != DEAD))
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

///////////////////////
///POLYCHROMIC DILDO///
///////////////////////

GLOBAL_LIST_INIT(dildo_colors, list(//mostly neon colors
		"Cyan"		= "#00f9ff",//cyan
		"Green"		= "#49ff00",//green
		"Pink"		= "#ff4adc",//pink
		"Yellow"	= "#fdff00",//yellow
		"Blue"		= "#00d2ff",//blue
		"Lime"		= "#89ff00",//lime
		"Black"		= "#101010",//black
		"Red"		= "#ff0000",//red
		"Orange"	= "#ff9a00",//orange
		"Purple"	= "#e300ff",//purple
		"White"		= "#c0c0c0",//white
		))

/obj/item/clothing/sextoy/custom_dildo
	name = "custom dildo"
	desc = "A dildo that can be customized to your specification."
	icon_state = "polydildo"
	inhand_icon_state = "polydildo"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	var/poly_size = "medium"
	var/list/poly_colors = list("#FFFFFF", "#FF8888", "#888888")
	var/can_customize = TRUE
	var/size_changed = FALSE
	var/color_changed = FALSE
	var/static/list/dildo_sizes
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ANUS|ITEM_SLOT_VAGINA
	moth_edible = FALSE

//radial menu for sizes
/obj/item/clothing/sextoy/custom_dildo/proc/populate_dildo_sizes()
	dildo_sizes = list(
		"small" = image (icon = src.icon, icon_state = "polydildo_small"),
		"medium" = image(icon = src.icon, icon_state = "polydildo_medium"),
		"big" = image(icon = src.icon, icon_state = "polydildo_big"))

//for that one cool polychromic form.
//i hate polychromics, hue-shifting better, but they wanted it - i made it.

/obj/item/clothing/sextoy/custom_dildo/AltClick(mob/living/user, obj/item/I)
	. = ..()
	if(size_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, dildo_sizes, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		poly_size = choice
		update_icon()
		size_changed = TRUE

	if(size_changed == TRUE)
		if(color_changed == FALSE)
			if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return
			customize(user)
			color_changed = TRUE
			return TRUE

/obj/item/clothing/sextoy/custom_dildo/proc/customize(mob/living/user)
	if(!can_customize)
		return FALSE
	if(src && !user.incapacitated() && in_range(user,src))
		var/color_choice = input(user,"Choose a color for your dildo.","Dildo Color") as null|anything in GLOB.dildo_colors
		if(src && color_choice && !user.incapacitated() && in_range(user,src))
			sanitize_inlist(color_choice, GLOB.dildo_colors, "Red")
			color = GLOB.dildo_colors[color_choice]
	update_icon_state()
	if(src && !user.incapacitated() && in_range(user,src))
		var/transparency_choice = input(user,"Choose the transparency of your dildo. Lower is more transparent!(192-255)","Dildo Transparency") as null|num
		if(src && transparency_choice && !user.incapacitated() && in_range(user,src))
			sanitize_integer(transparency_choice, 192, 255, 192)
			alpha = transparency_choice
	update_icon_state()
	return TRUE

/obj/item/clothing/sextoy/custom_dildo/examine(mob/user)
	. = ..()
	if(can_customize)
		. += span_notice("Alt-Click \the [src.name] to customize it.")

//to check if we can change dildo's model
/obj/item/clothing/sextoy/custom_dildo/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/sextoy/custom_dildo/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(dildo_sizes))
		populate_dildo_sizes()

/obj/item/clothing/sextoy/custom_dildo/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[poly_size]"
	inhand_icon_state = "[initial(icon_state)]_[poly_size]"

/obj/item/clothing/sextoy/custom_dildo/equipped(mob/user, slot)
	.=..()
	var/mob/living/carbon/human/H = user
	if(src == H.anus || src == H.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/custom_dildo/dropped(mob/user, slot)
	.=..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/custom_dildo/process(delta_time)
	var/mob/living/carbon/human/U = loc
	if(poly_size == "small" && U.arousal < 20)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)
	if(poly_size == "medium" && U.arousal < 25)
		U.adjustArousal(0.8 * delta_time)
		U.adjustPleasure(0.8 * delta_time)
	if(poly_size == "big" && U.arousal < 30)
		U.adjustArousal(1 * delta_time)
		U.adjustPleasure(1 * delta_time)

/obj/item/clothing/sextoy/custom_dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
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
						message = (user == M) ? pick("rubs [M.p_their()] vagina with [src]","gently jams [M.p_their()] pussy with [src]","fucks [M.p_their()] vagina with [src]") : pick("delicately rubs [M]'s vagina with [src]", "uses [src] to fuck [M]'s vagina","jams [M]'s pussy with [src]", "teasing [M]'s pussy with [src]")
						if(poly_size == "small")
							M.adjustArousal(4)
							M.adjustPleasure(5)
							if(prob(20) && (M.stat != DEAD))
								M.emote("moan")
						if(poly_size == "medium")
							M.adjustArousal(6)
							M.adjustPleasure(8)
							if(prob(40) && (M.stat != DEAD))
								M.emote(pick("twitch_s","moan"))
						if(poly_size == "big")
							M.adjustArousal(8)
							M.adjustPleasure(10)
							M.adjustPain(2)
							if(prob(60) && (M.stat != DEAD))
								M.emote(pick("twitch_s","moan","gasp"))

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
					message = (user == M) ? pick("licks [src] erotically","sucks on [src], slowly inserting it into [M.p_their()] throat") : pick("fucks [M]'s mouth with [src]", "inserts [src] into [M]'s throat, choking [M.p_them()]", "forces [M] to suck [src]", "inserts [src] into [M]'s throat")
					M.adjustArousal(4)
					M.adjustPleasure(1)
					M.adjustOxyLoss(1.5)
					if(prob(70) && (M.stat != DEAD))
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
					message = (user == M) ? pick("puts [src] into [M.p_their()] anus","slowly inserts [src] into [M.p_their()] ass") : pick("fucks [M]'s ass with [src]", "uses [src] to fuck [M]'s anus", "jams [M]'s ass with [src]", "roughly fucks [M]'s ass with [src], making [M.p_their()] eyes roll back")
					M.adjustArousal(5)
					M.adjustPleasure(5)
					if(prob(60) && (M.stat != DEAD))
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

//////////////////
///DOUBLE DILDO///
//////////////////

/obj/item/clothing/sextoy/double_dildo
	name = "double dildo"
	desc = "You'll have to be a real glizzy gladiator to contend with this."
	icon_state = "dildo_double"
	inhand_icon_state = "dildo_double"
	worn_icon_state = "dildo_side"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ANUS|ITEM_SLOT_VAGINA
	actions_types = list(/datum/action/item_action/take_dildo)
	var/in_hands = FALSE
	var/obj/item/clothing/sextoy/dildo_side/W
	moth_edible = FALSE

/obj/item/clothing/sextoy/double_dildo/Initialize()
	. = ..()
	update_action_buttons_icons()

/obj/item/clothing/sextoy/double_dildo/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//Functionality stuff
/obj/item/clothing/sextoy/double_dildo/proc/update_action_buttons_icons()
	var/datum/action/item_action/M
	if(istype(M, /datum/action/item_action/take_dildo))
		M.button_icon_state = "dildo_side"
		M.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	update_icon()

//button stuff
/datum/action/item_action/take_dildo
    name = "Take the other side of the double dildo in hand"
    desc = "You can feel one side inside you, time to share this feeling with someone..."

/datum/action/item_action/take_dildo/Trigger(trigger_flags)
	var/obj/item/clothing/sextoy/double_dildo/H = target
	if(istype(H))
		H.check()

/obj/item/clothing/sextoy/double_dildo/proc/check()
	var/mob/living/carbon/human/C = usr
	if(src == C.vagina)
		toggle(C)
	else if(src == C.anus)
		to_chat(C, span_warning("You can't use [src] from this angle!"))
	else
		to_chat(C, span_warning("You need to equip [src] before you can use it!"))

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/clothing/sextoy/double_dildo/proc/toggle(mob/living/carbon/user)
	var/mob/living/carbon/human/C = usr
	playsound(C, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE, ignore_walls = FALSE)
	var/obj/item/held = C.get_active_held_item()
	var/obj/item/unheld = C.get_inactive_held_item()

	if(in_hands == TRUE)
		if(held?.name == "dildo side" && held?.item_flags == ABSTRACT | HAND_ITEM)
			qdel(held)
			C.visible_message(span_notice("[user] puts one end of [src] back.")) // I tried to work out what this message is trying to say, but I can't quite get it.
			in_hands = FALSE
			return

		else if(unheld?.name == "dildo side" && unheld?.item_flags == ABSTRACT | HAND_ITEM)
			qdel(unheld)
			C.visible_message(span_notice("[user] puts one end of [src] back."))
			in_hands = FALSE
			return

		else if(held == null)
			if(unheld.name =="dildo side" && unheld.item_flags == ABSTRACT | HAND_ITEM)
				if(src == C.belt)
					qdel(unheld)
					//CODE FOR PUTTING DILDO IN HANDS
					W = new()
					C.put_in_hands(W)
					W.update_icon_state()
					W.update_icon()
					C.visible_message(span_notice("[C] holds one end of [src] in [C.p_their()] hand."))
					in_hands = TRUE
					return
		else
			C.visible_message(span_notice("[C] tries to hold one end of [src] in [C.p_their()] hand, but [C.p_their()] hand isn't empty!"))
			return
	else
		W = new()
		C.put_in_hands(W)
		W.update_icon_state()
		W.update_icon()
		C.visible_message(span_notice("[C] holds one end of [src] in [C.p_their()] hand."))
		in_hands = TRUE
		return

//dumb way to fix organs overlapping with toys, but WHY NOT. Find a better way if you're not lazy as me.
/obj/item/clothing/sextoy/double_dildo/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/vagina/V = H.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/W = H.getorganslot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)

	if(src == H.anus || src == H.vagina)
		START_PROCESSING(SSobj, src)

	if(src == H.vagina)
		V?.visibility_preference = GENITAL_NEVER_SHOW
		W?.visibility_preference = GENITAL_NEVER_SHOW
		P?.visibility_preference = GENITAL_NEVER_SHOW
		T?.visibility_preference = GENITAL_NEVER_SHOW
		H.update_body()

	else if(src == H.anus)
		H.cut_overlay(H.overlays_standing[ANUS_LAYER])

/obj/item/clothing/sextoy/double_dildo/dropped(mob/living/user)
	.=..()
	var/mob/living/carbon/human/M = user
	STOP_PROCESSING(SSobj, src)
	if(W && !ismob(loc) && in_hands == TRUE && src != M.belt)
		qdel(W)
		in_hands = FALSE

/obj/item/clothing/sextoy/double_dildo/process(delta_time)
	var/mob/living/carbon/human/U = loc
	//i tried using switch here, but it need static value, and u.arousal can't be it. So fuck switches. Reject it, embrace the IFs
	if(U.arousal < 25)
		U.adjustArousal(0.8 * delta_time)
		U.adjustPleasure(0.8 * delta_time)

/obj/item/clothing/sextoy/double_dildo/dropped(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/vagina/V = H.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/W = H.getorganslot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)

	if(src == H.vagina)
		V?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		W?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		P?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		T?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
		H.update_body()
	else
		return

/obj/item/clothing/sextoy/double_dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
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
						message = (user == M) ? pick("rubs [M.p_their()] vagina with [src]","gently jams [M.p_their()] pussy with [src]","fucks [M.p_their()] vagina with [src]") : pick("delicately rubs [M]'s vagina with [src]", "uses [src] to fuck [M]'s vagina","jams [M]'s pussy with [src]", "teases [M]'s pussy with [src]")
						M.adjustArousal(6)
						M.adjustPleasure(8)
						if(prob(40) && (M.stat != DEAD))
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
					to_chat(user, span_danger("[M] don't have suitable genitalia for that!"))
					return

			if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
				if(!M.is_mouth_covered())
					message = (user == M) ? pick("licks [src] erotically","sucks on [src], slowly inserting it into [M.p_their()] throat") : pick("fucks [M]'s mouth with [src]", "inserts [src] into [M]'s throat, choking [M.p_them()]", "forces [M] to suck [src]", "inserts [src] into [M]'s throat")
					M.adjustArousal(4)
					M.adjustPleasure(1)
					M.adjustOxyLoss(1.5)
					if(prob(70) && (M.stat != DEAD))
						M.emote(pick("gasp","moan"))
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 40, TRUE, ignore_walls = FALSE)

				else
					to_chat(user, span_danger("Looks like [M]'s mouth is covered!"))
					return

			else
				if(M.is_bottomless())
					message = (user == M) ? pick("puts [src] into [M.p_their()] anus","slowly inserts [src] into [M.p_their()] ass") : pick("fucks [M]'s ass with [src]", "uses [src] to fuck [M]'s anus", "jams [M]'s ass with [src]", "roughly fucks [M]'s ass with [src], making [M.p_their()] eyes roll back")
					M.adjustArousal(5)
					M.adjustPleasure(5)
					if(prob(60) && (M.stat != DEAD))
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

/obj/item/clothing/sextoy/dildo_side
	name = "dildo side"
	desc = "You looking so hot!"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	icon_state = "dildo_side"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = ABSTRACT | HAND_ITEM
	moth_edible = FALSE

/obj/item/clothing/sextoy/dildo_side/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, STRAPON_TRAIT)

/obj/item/clothing/sextoy/dildo_side/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
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
						message = (user == M) ? pick("rubs [M.p_their()] vagina with the [src]","gently jams [M.p_their()] pussy with [src]","fucks [M.p_their()] vagina with a [src]") : pick("delicately rubs [M]'s vagina with [src]", "uses [src] to fuck [M]'s vagina","jams [M]'s pussy with [src]", "teasing [M]'s pussy with [src]")
						M.adjustArousal(6)
						M.adjustPleasure(8)
						user.adjustArousal(6)
						user.adjustPleasure(8)
						if(prob(40) && (M.stat != DEAD))
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
					message = (user == M) ? pick("licks [src] erotically","sucks on [src], slowly inserting it into [M.p_their()] throat") : pick("fucks [M]'s mouth with [src]", "inserts [src] into [M]'s throat, choking [M.p_them()]", "forces [M] to suck [src]", "inserts [src] into [M]'s throat")
					M.adjustArousal(4)
					M.adjustPleasure(1)
					M.adjustOxyLoss(1.5)
					user.adjustArousal(6)
					user.adjustPleasure(8)
					if(prob(70) && (M.stat != DEAD))
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
					message = (user == M) ? pick("puts [src] into [M.p_their()] anus","slowly inserts [src] into [M.p_their()] ass") : pick("fucks [M]'s ass with [src]", "uses [src] to fuck [M]'s anus", "jams [M]'s ass with [src]", "roughly fucks [M]'s ass with [src], making [M.p_their()] eyes roll back")
					M.adjustArousal(5)
					M.adjustPleasure(5)
					user.adjustArousal(6)
					user.adjustPleasure(8)
					if(prob(60) && (M.stat != DEAD))
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
