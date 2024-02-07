/mob/living/carbon/human/verb/climax_verb()
	set name = "Climax"
	set category = "IC"

	if(!has_status_effect(/datum/status_effect/climax_cooldown))
		if(tgui_alert(usr, "Are you sure you want to cum?", "Climax", list("Yes", "No")) == "Yes")
			if(stat != CONSCIOUS)
				to_chat(usr, span_warning("You can't climax right now..."))
				return
			else
				climax(TRUE)
	else
		to_chat(src, span_warning("You can't cum right now!"))

/mob/living/verb/reflexes_verb()
    set name = "Toggle Reflexes"
    set category = "IC"
    if(!HAS_TRAIT_FROM(src, TRAIT_QUICKREFLEXES, REF(src)))
        ADD_TRAIT(src, TRAIT_QUICKREFLEXES, REF(src))
        to_chat(src, span_notice("[get_reflexes_gain_text()]"))
    else
        REMOVE_TRAIT(src, TRAIT_QUICKREFLEXES, REF(src))
        to_chat(src, span_notice("[get_reflexes_lose_text()]"))

/mob/living/proc/get_reflexes_gain_text()
	return "You don't feel like being touched right now."

/mob/living/proc/get_reflexes_lose_text()
	return "You'll allow yourself to be touched now."

/mob/living/silicon/get_reflexes_gain_text()
	return "Our systems will disallow platonic contact."

/mob/living/silicon/get_reflexes_lose_text()
	return "Our systems will allow platonic contact."

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/climax_verb
	if(CONFIG_GET(flag/disable_lewd_items))
		verbs -= /mob/living/carbon/human/verb/safeword

/mob/living/carbon/human/verb/safeword()
	set name = "Remove Lewd Items"
	set category = "OOC"
	set desc = "Removes any and all lewd items from you."

	log_message("[key_name(src)] used the Remove Lewd Items verb.", LOG_ATTACK)
	for(var/obj/item/equipped_item in get_equipped_items())
		if(!(equipped_item.type in GLOB.pref_checked_clothes))
			continue

		log_message("[equipped_item] was removed from [key_name(src)].", LOG_ATTACK)
		dropItemToGround(equipped_item, TRUE)

	return TRUE

/mob/living/carbon/human/verb/lick(mob/living/carbon/human/target in get_human_hearers_in_view(1, src))
	set name = "Lick"
	set category = "IC"

	if(!istype(target))
		return FALSE

	var/taste = target.get_taste_or_smell()
	if(!taste)
		to_chat(src, span_warning("[target] doesn't seem to have a taste."))
		return FALSE

	to_chat(src, span_notice("[target] tastes like [taste]."))
	to_chat(target, span_notice("[target] licks you."))

/mob/living/carbon/human/verb/smell(mob/living/carbon/human/target in get_human_hearers_in_view(1, src))
	set name = "Smell"
	set category = "IC"

	if(!istype(target))
		return FALSE

	var/smell = target.get_taste_or_smell(TRUE)
	if(!smell)
		to_chat(src, span_warning("[target] doesn't seem to have a smell."))
		return FALSE

	to_chat(src, span_notice("[target] smells like [smell]."))

/// Returns the smell/taste of the parent mob
/mob/living/carbon/human/proc/get_taste_or_smell(smell = FALSE)
	var/datum/preferences/preferences = client?.prefs
	if(!istype(preferences))
		return FALSE

	var/string_to_return = preferences.read_preference(/datum/preference/text/taste)
	if(smell)
		string_to_return = preferences.read_preference(/datum/preference/text/smell)

	return string_to_return


/// Functions similiar to get hearers in view, but it only counts humans.
/proc/get_human_hearers_in_view(view_radius, atom/source)
	var/list/hear_list = get_hearers_in_view(view_radius, source)
	for(var/mob/living/carbon/human/hearer as anything in hear_list)
		if(ishuman(hearer))
			continue

		hear_list -= hearer

	return hear_list

