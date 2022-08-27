// Forces foreigner to give all races uncommon, because we don't follow TG's species language stuff.
/datum/quirk/foreigner/add()
	. = ..()
	if(!ishumanbasic(quirk_holder)) // Not gonna try to add the language twice to pure humans.
		quirk_holder.grant_language(/datum/language/uncommon)
	var/datum/language_holder/language_holder = quirk_holder.get_language_holder()
	language_holder.selected_language = /datum/language/uncommon // Saves foreigner users from having to select it themselves.
