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

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/climax_verb

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
