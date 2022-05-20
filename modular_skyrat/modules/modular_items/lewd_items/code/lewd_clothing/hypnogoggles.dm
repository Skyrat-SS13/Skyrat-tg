/*
/obj/item/clothing/glasses/hypno
	name = "hypnotic goggles"
	desc = "Woaa-a-ah... This is lewd."
	icon_state = "hypnogoggles"
	inhand_icon_state = "hypnogoggles"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_eyes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_eyes.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// If the color of the goggles have been changed before.
	var/color_changed = FALSE
	/// Current color of the goggles, can change and affects sprite
	var/current_hypnogoggles_color = "pink"
	/// Static list of all goggle designs, used in the color picker radial selection menu
	var/static/list/hypnogoggles_designs
	/// The person wearing the goggles
	var/mob/living/carbon/victim
	/// The hypnotic codephrase. Default always required otherwise things break.
	var/codephrase = "Obey."

/obj/item/clothing/glasses/hypno/equipped(mob/user, slot)//Adding hypnosis on equip
	. = ..()
	victim = user
	if(slot != ITEM_SLOT_EYES)
		return
	if(!(iscarbon(victim) && victim.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return
	if(codephrase != "")
		victim.gain_trauma(new /datum/brain_trauma/induced_hypnosis(codephrase), TRAUMA_RESILIENCE_BASIC)
	else
		codephrase = "Obey."
		victim.gain_trauma(new /datum/brain_trauma/induced_hypnosis(codephrase), TRAUMA_RESILIENCE_BASIC)

/obj/item/clothing/glasses/hypno/dropped(mob/user)//Removing hypnosis on unequip
	. = ..()
	if(!(victim.glasses == src))
		return
	victim.cure_trauma_type(/datum/brain_trauma/induced_hypnosis, TRAUMA_RESILIENCE_BASIC)
	victim = null

/obj/item/clothing/glasses/hypno/Destroy()
	. = ..()
	if(!victim)
		return
	if(!(victim.glasses == src))
		return
	victim.cure_trauma_type(/datum/brain_trauma/induced_hypnosis, TRAUMA_RESILIENCE_BASIC)

/obj/item/clothing/glasses/hypno/attack_self(mob/user)//Setting up hypnotising phrase
	. = ..()
	codephrase = tgui_input_text(user, "Change the hypnotic phrase", max_length = MAX_MESSAGE_LEN)

/// Populates the list of hypnogoggle designs to pick from, called on init
/obj/item/clothing/glasses/hypno/proc/populate_hypnogoggles_designs()
	hypnogoggles_designs = list(
		"pink" = image (icon = src.icon, icon_state = "hypnogoggles_pink"),
		"teal" = image(icon = src.icon, icon_state = "hypnogoggles_teal"))

//to update model lol
/obj/item/clothing/glasses/hypno/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/glasses/hypno/AltClick(mob/user)
	if(color_changed)
		return
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, hypnogoggles_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	current_hypnogoggles_color = choice
	update_icon()
	color_changed = TRUE

//to check if we can change kinkphones's model
/obj/item/clothing/glasses/hypno/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/glasses/hypno/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(hypnogoggles_designs))
		populate_hypnogoggles_designs()

/obj/item/clothing/glasses/hypno/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_hypnogoggles_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_hypnogoggles_color]"

/datum/brain_trauma/induced_hypnosis
	name = "Hypnosis"
	desc = "Patient's subconscious is completely enthralled by a word or sentence. It appears to be induced by something they're wearing."
	scan_desc = "epileptic induced looping thought pattern"
	gain_text = ""
	lose_text = ""
	resilience = TRAUMA_RESILIENCE_BASIC

	var/hypnotic_phrase = ""
	var/regex/target_phrase

/datum/brain_trauma/induced_hypnosis/New(phrase)
	if(!phrase)
		qdel(src)
	hypnotic_phrase = phrase
	try
		target_phrase = new("(\\b[REGEX_QUOTE(hypnotic_phrase)]\\b)", "ig")
	catch(var/exception/caught_exception)
		stack_trace("[caught_exception] on [caught_exception.file]:[caught_exception.line]")
		qdel(src)
	return ..()

/datum/brain_trauma/induced_hypnosis/on_gain()
	log_game("[key_name(owner)] was hypnogoggled'.")
	to_chat(owner, "<span class = 'reallybig hypnophrase'>[hypnotic_phrase]</span>")
	to_chat(owner, span_notice(pick("You feel your thoughts focusing on this phrase... you can't seem to get it out of your head.",
									"Your head hurts, but this is all you can think of. It must be vitally important.",
									"You feel a part of your mind repeating this over and over. You need to follow these words.",
									"Something about this sounds... right, for some reason. You feel like you should follow these words.",
									"These words keep echoing in your mind. You find yourself completely fascinated by them.")))
	to_chat(owner, span_boldwarning("You've been hypnotized by this sentence. You must follow these words. If it isn't a clear order, you can freely interpret how to do so, as long as you act like the words are your highest priority."))
	var/atom/movable/screen/alert/hypnosis/hypno_alert = owner.throw_alert("hypnosis", /atom/movable/screen/alert/hypnosis)
	hypno_alert.desc = "\"[hypnotic_phrase]\"... your mind seems to be fixated on this concept."
	return ..()

/datum/brain_trauma/induced_hypnosis/on_lose()
	log_game("[key_name(owner)] is no longer hypnogoggled.")
	to_chat(owner, span_userdanger("You suddenly snap out of your hypnosis. The phrase '[hypnotic_phrase]' no longer feels important to you."))
	owner.clear_alert("hypnosis")
	..()

/datum/brain_trauma/induced_hypnosis/on_life(delta_time, times_fired)
	..()
	if(!(DT_PROB(1, delta_time)))
		return
	switch(rand(1, 2))
		if(1)
			to_chat(owner, span_hypnophrase("<i>...[lowertext(hypnotic_phrase)]...</i>"))
		if(2)
			new /datum/hallucination/chat(owner, TRUE, FALSE, span_hypnophrase("[hypnotic_phrase]"))

/datum/brain_trauma/induced_hypnosis/handle_hearing(datum/source, list/hearing_args)
	hearing_args[HEARING_RAW_MESSAGE] = target_phrase.Replace(hearing_args[HEARING_RAW_MESSAGE], span_hypnophrase("$1"))
*/
