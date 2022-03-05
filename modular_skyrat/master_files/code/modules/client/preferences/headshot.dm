/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	/// Assoc list of ckeys and their link, used to cut down on chat spam
	var/list/stored_link = list()

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["headshot"] = value

/datum/preference/text/headshot/is_valid(value)
	if(!length(value)) //Just to get blank ones out of the way
		return TRUE
	if(!is_veteran_player(usr?.client) && !(usr?.ckey in GLOB.donator_list))
		to_chat(usr, span_warning("You must be a veteran or donator to use this feature!"))
		return
	if(!findtext(value, "https://"))
		to_chat(usr, span_warning("You need \"https://\" in the link!"))
		return
	if(!findtext(value, ".png") && !findtext(value, ".jpg"))
		to_chat(usr, span_warning("You need either \".png\" or \".jpg\" in the link!"))
		return
	if(!findtext(value, "https://imgur.com") && !findtext(value, "https://i.gyazo.com") && !findtext(value, "https://media.discordapp.com"))
		to_chat(usr, span_warning("The link needs to be an unshortened Imgur, Gyazo, or Discordapp link!"))
		return
	if(!stored_link[usr.ckey])
		stored_link[usr.ckey] = null
	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please make sure to use a relatively work-safe image of the head to shoulder or chest area to maintain immersion level. Think of it as a headshot for your ID."))
		to_chat(usr, span_notice("If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser."))
		to_chat(usr, span_notice("Keep in mind that the photo will be downsized to 250x250 pixels, so the more square the photo, the better it will look."))
	stored_link[usr.ckey] = value
	return TRUE

/datum/preference/text/headshot/deserialize(input, datum/preferences/preferences)
	if(!is_veteran_player(usr?.client) && !(usr?.ckey in GLOB.donator_list))
		input = ""
	return STRIP_HTML_SIMPLE(input, MAX_FLAVOR_LEN)
