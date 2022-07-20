/obj/item/modular_computer/tablet/pda
	var/list/autotranslated_languages = list(
		/datum/language/sol,
		/datum/language/akulan,
		/datum/language/tajaran
	)
	var/list/given_languages = list()
	desc = "A small portable microcomputer.\n<span class=\"warning\">Required for autotranslation services.</span>"

/obj/item/modular_computer/tablet/pda/dropped(mob/user, silent = FALSE)
	. = ..()
	if (istype(user, /mob/living/carbon/human))
		if(!pda_in_inventory(user))
			take_languages(user)

/obj/item/modular_computer/tablet/pda/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if (istype(user, /mob/living/carbon/human))
		give_languages(user)

/obj/item/modular_computer/tablet/pda/proc/give_languages(mob/user)
	for(var/language in autotranslated_languages)
		if(!user.has_language(language))
			user.grant_language(language, TRUE, FALSE)
			given_languages.Add(language)

/obj/item/modular_computer/tablet/pda/proc/take_languages(mob/user)
	for(var/language in given_languages)
		user.remove_language(language)
	given_languages.Cut()

/obj/item/modular_computer/tablet/pda/proc/pda_in_inventory(mob/user)
	for(var/content in user.contents)
		if(istype(content, /obj/item/modular_computer/tablet/pda))
			return TRUE
