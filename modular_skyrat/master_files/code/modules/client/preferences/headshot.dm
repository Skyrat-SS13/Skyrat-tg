// Hey listen! Imgur doesn't actually work, it's been tested.

/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	maximum_value_length = MAX_MESSAGE_LEN
	/// Assoc list of ckeys and their link, used to cut down on chat spam
	var/list/stored_link = list()
	var/static/link_regex = regex("i.gyazo.com|media.discordapp.net|cdn.discordapp.com")
	var/static/list/valid_extensions = list("jpg", "png", "jpeg") // Regex works fine, if you know how it works

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target?.dna.features["headshot"] = preferences?.headshot

/datum/preference/text/headshot/is_valid(value)
	if(!length(value)) // Just to get blank ones out of the way
		usr?.client?.prefs?.headshot = null
		return TRUE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		to_chat(usr, span_warning("Your link must be https!"))
		return

	if(!findtext(value, "."))
		to_chat(usr, span_warning("Invalid link!"))
		return
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(extension in valid_extensions))
		to_chat(usr, span_warning("The image must be one of the following extensions: '[english_list(valid_extensions)]'"))
		return

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		to_chat(usr, span_warning("The image must be hosted on one of the following sites: 'Gyazo, Discord'"))
		return

	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Think of it as a headshot for your ID. Lastly, [span_bold("do not use a real life photo or use any image that is less than serious.")]"))
		to_chat(usr, span_notice("If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser."))
		to_chat(usr, span_notice("Keep in mind that the photo will be downsized to 250x250 pixels, so the more square the photo, the better it will look."))
		log_game("[usr] has set their Headshot image to '[value]'.")
	stored_link[usr?.ckey] = value
	usr?.client?.prefs.headshot = value
	return TRUE
