// Forces foreigner to give non-human races their alternate language, if they have one, otherwise, give them uncommon, because we don't follow TG's species language stuff.
/datum/quirk/foreigner/add()
	if(iscarbon(quirk_holder) && quirk_holder.client)
		var/datum/language_holder/language_holder = quirk_holder.get_language_holder()
		var/language = quirk_holder.client.prefs.try_get_common_language()
		language_holder.remove_language(/datum/language/common)
		quirk_holder.add_blocked_language(/datum/language/common)
		language_holder.grant_language(language)
		language_holder.selected_language = language // Saves foreigner users from having to select it themselves.
