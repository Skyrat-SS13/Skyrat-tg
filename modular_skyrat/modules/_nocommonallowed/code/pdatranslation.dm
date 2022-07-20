/obj/item/modular_computer/tablet/pda
	var/list/autotranslated_languages = list(
		/datum/language/sol,
		/datum/language/tajaran,
		/datum/language/akulan
	)
	desc = "A small portable microcomputer.\n<span class=\"warning\">Required for autotranslation services.</span>"

/obj/item/modular_computer/tablet/pda/dropped(mob/user, silent = FALSE)
	. = ..()
	if (istype(user, /mob/living/carbon/human) && !pda_in_inventory(user))
		remove_languages(user)

/obj/item/modular_computer/tablet/pda/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if (istype(user, /mob/living/carbon/human))
		give_languages(user)

/obj/item/modular_computer/tablet/pda/proc/give_languages(mob/user)
	for(var/language in autotranslated_languages)
		if(!user.has_language(language))
			user.grant_language(language, understood = TRUE, spoken = FALSE, source = LANGUAGE_PDA)

/obj/item/modular_computer/tablet/pda/proc/remove_languages(mob/user)
	for(var/language in autotranslated_languages)
		user.remove_language(language, source = LANGUAGE_PDA)

/obj/item/modular_computer/tablet/pda/proc/pda_in_inventory(mob/user)
	for(var/obj/item/modular_computer/tablet/pda/content in user.contents)
		if(content.enabled == TRUE)
			return TRUE
