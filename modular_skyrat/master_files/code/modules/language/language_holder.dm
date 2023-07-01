GLOBAL_DATUM_INIT(language_holder_adjustor, /datum/language_holder_adjustor, new)

/// Language code needs to be purged. Make sure, once and for all, that we get the correct languages on spawn.
/// Every time a crew member joins the adjustor will personally fix their language, because there is too much coupling between mind and language code to do it reliably otherwise.
/// It has already needed to be fixed like 3 times. This will (hopefully) be the final time.
/datum/language_holder_adjustor/New()
	RegisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED, PROC_REF(handle_new_player))

/datum/language_holder_adjustor/proc/handle_new_player(datum/source, mob/living/new_crewmember, rank)
	SIGNAL_HANDLER

	// sanity checking because we really do not want to be causing any runtimes
	if(!ishuman(new_crewmember))
		return
	if(isnull(new_crewmember.mind))
		return
	if(isnull(new_crewmember.mind.language_holder))
		return

	var/mob/living/carbon/human/new_human = new_crewmember
	var/datum/language_holder/language_holder = new_human.get_language_holder()

	if(isnull(language_holder))
		return

	language_holder.adjust_languages_to_prefs(new_human.client?.prefs)

/datum/language_holder_adjustor/Destroy()
	..()
	UnregisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED)

/datum/language_holder/proc/adjust_languages_to_prefs(datum/preferences/preferences)
	// no prefs? then don't remove any languages
	if(!preferences)
		return

	// remove the innate languages (like common, and other species languages) and instead use the language prefs
	// do not remove any languages granted by spawners, which are denoted by source = LANGUAGE_SPAWNER
	remove_all_languages(source = LANGUAGE_MIND)
	remove_all_languages(source = LANGUAGE_ATOM)

	for(var/lang_path in preferences.languages)
		grant_language(lang_path)

	get_selected_language()

//************************************************
//*        Specific language holders              *
//*      Use atom language sources only.           *
//************************************************/

/datum/language_holder/machine // SYNTHETIC LIZARD & CO LANGUAGE
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/machine = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/machine = list(LANGUAGE_ATOM))
