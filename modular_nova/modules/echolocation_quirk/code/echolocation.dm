/datum/quirk/echolocation
	name = "Echolocation"
	desc = "Though your eyes no longer function, you accommodate for it by some means of extrasensory echolocation and sensitive hearing. Beware: if you're ever deafened, you'll also lose your echolocation until you recover!"
	gain_text = span_notice("The slightest sounds map your surroundings.")
	lose_text = span_notice("The world resolves into colour and clarity.")
	value = 0
	icon = FA_ICON_EAR_LISTEN
	mob_trait = TRAIT_GOOD_HEARING
	medical_record_text = "Patient's eyes are biologically nonfunctional. Hearing tests indicate almost supernatural acuity."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	mail_goodies = list(/obj/item/clothing/glasses/sunglasses, /obj/item/cane/white)
	/// where we store easy access to the character's echolocation component (for stuff like drugs)
	var/datum/component/echolocation/esp
	/// where we store access to the client colour we make
	var/datum/client_colour/echolocation_custom/esp_color
	/// The action we add with this quirk in add(), used for easy deletion later
	var/datum/action/cooldown/spell/added_action

/datum/quirk/echolocation/add(client/client_source)
	// echolocation component handles blinding us already so we don't need to worry about that
	var/mob/living/carbon/human/human_holder = quirk_holder
	// set up the desired echo group from our quirk preferences
	var/client_echo_group = lowertext(client_source?.prefs.read_preference(/datum/preference/choiced/echolocation_key))
	if (isnull(client_echo_group))
		client_echo_group = "echolocation"
	if (client_echo_group == "psychic")
		client_echo_group = "psyker" // set this non-player-facing so they share echolocation with coded chaplain psykers/pirates and the like

	var/client_use_echo = client_source?.prefs.read_preference(/datum/preference/toggle/echolocation_overlay)
	if (isnull(client_use_echo))
		client_use_echo = TRUE

	human_holder.AddComponent(/datum/component/echolocation, blocking_trait = TRAIT_DEAF, echo_range = 5, echo_group = client_echo_group, images_are_static = FALSE, use_echo = client_use_echo, show_own_outline = TRUE)
	esp = human_holder.GetComponent(/datum/component/echolocation)

	// HEY! we probably need something to make sure they don't set a color that's too dark or their UI could be totally invisible.
	// GOOD NEWS! we can re-use the runechat colour stuff for this (probably)
	human_holder.remove_client_colour(/datum/client_colour/monochrome/blind) // get rid of the existing blind one
	esp_color = human_holder.add_client_colour(/datum/client_colour/echolocation_custom)
	var/col = process_chat_color(client_source?.prefs.read_preference(/datum/preference/color/echolocation_outline))
	esp_color.priority = 1 // mirrors PRIORITY_ABSOLUTE def inside client_color.dm, stops pipes and stuff showing as different colours
	esp_color.update_colour(col)

	// double the ear/hearing damage multiplier from any source.
	var/obj/item/organ/internal/ears/echo_ears = human_holder.get_organ_slot(ORGAN_SLOT_EARS)
	if (!istype(echo_ears))
		return

	echo_ears.damage_multiplier *= 2

	// add an action/spell to allow the player to toggle echolocation off for a bit (eyestrain on longer rounds, or just roleplay)
	var/datum/action/cooldown/spell/echolocation_toggle/toggle_action = new /datum/action/cooldown/spell/echolocation_toggle()
	toggle_action.Grant(human_holder)
	added_action = toggle_action

/datum/quirk/echolocation/remove()
	QDEL_NULL(esp) // echolocation component removal handles graceful disposal of everything above except the ears
	QDEL_NULL(added_action) // remove the stall action, too
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/internal/ears/echo_ears = human_holder.get_organ_slot(ORGAN_SLOT_EARS)
	if (!istype(echo_ears))
		return
	echo_ears.damage_multiplier = initial(echo_ears.damage_multiplier)
	human_holder.remove_client_colour(/datum/client_colour/echolocation_custom) // clean up the custom colour override we added

/datum/client_colour/echolocation_custom

/datum/action/cooldown/spell/echolocation_toggle
	name = "Toggle echolocation"
	desc = "Decide whether you want to stop echolocating (or start again). Useful if you need a break - it's not an easy process!"
	spell_requirements = NONE
	cooldown_time = 2 SECONDS
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "blink"

/datum/action/cooldown/spell/echolocation_toggle/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/echolocation_toggle/cast(mob/living/carbon/human/cast_on)
	. = ..()
	var/datum/quirk/echolocation/echo = cast_on.get_quirk(/datum/quirk/echolocation)
	if (isnull(echo))
		return

	var/datum/component/echolocation/quirk_esp = echo.esp
	if (isnull(quirk_esp))
		return

	if (quirk_esp.stall)
		quirk_esp.stall = FALSE
		cast_on.balloon_alert(cast_on, "started echolocating!")
		cast_on.visible_message(span_notice("[cast_on] perks up, suddenly seeming more vigilant!"))
	else
		quirk_esp.stall = TRUE
		cast_on.balloon_alert(cast_on, "stopped echolocating!")
		cast_on.visible_message(span_notice("[cast_on] relaxes slightly, seeming less vigilant for the moment."))

/datum/quirk_constant_data/echolocation
	associated_typepath = /datum/quirk/echolocation
	customization_options = list(/datum/preference/color/echolocation_outline, /datum/preference/choiced/echolocation_key, /datum/preference/toggle/echolocation_overlay)

// Client preference for echolocation outline colour
/datum/preference/color/echolocation_outline
	savefile_key = "echolocation_outline"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/echolocation_outline/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/color/echolocation_outline/apply_to_human(mob/living/carbon/human/target, value)
	return

// Client preference for echolocation key type
/datum/preference/choiced/echolocation_key
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_key"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/echolocation_key/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/choiced/echolocation_key/init_possible_values()
	var/list/values = list("Extrasensory", "Psychic", "Auditory/Vibrational")
	return values

/datum/preference/choiced/echolocation_key/apply_to_human(mob/living/carbon/human/target, value)
	return

// Client preference for whether we display the echolocation overlay or not
/datum/preference/toggle/echolocation_overlay
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_use_echo"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/toggle/echolocation_overlay/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/toggle/echolocation_overlay/apply_to_human(mob/living/carbon/human/target, value)
	return
