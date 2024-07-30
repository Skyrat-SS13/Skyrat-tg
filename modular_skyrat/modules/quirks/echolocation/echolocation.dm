/datum/quirk/echolocation
	name = "Echolocation"
	desc = "Though your eyes no longer function, you accommodate for it by some means of extrasensory echolocation and sensitive hearing. Beware: if you're ever deafened, you'll also lose your echolocation until you recover!"
	gain_text = span_notice("The slightest sounds map your surroundings.")
	lose_text = span_notice("The world resolves into colour and clarity.")
	value = -14
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
	var/client_echo_group = LOWER_TEXT(client_source?.prefs.read_preference(/datum/preference/choiced/echolocation_key))
	if (isnull(client_echo_group))
		client_echo_group = "echolocation"
	if (client_echo_group == "psychic")
		client_echo_group = "psyker" // set this non-player-facing so they share echolocation with coded chaplain psykers/pirates and the like

	// Get the prefs
	var/client_show_outline = client_source?.prefs.read_preference(/datum/preference/toggle/echolocation_overlay)
	var/col = color_hex2color_matrix(client_source?.prefs.read_preference(/datum/preference/color/echolocation_outline))

	human_holder.AddComponent(\
		/datum/component/echolocation, \
		blocking_trait = TRAIT_DEAF, \
		cooldown_time = 2 SECONDS, \
		echo_range = 7, \
		echo_group = client_echo_group, \
		images_are_static = FALSE, \
		use_echo = FALSE, \
		show_own_outline = client_show_outline, \
		personal_color = col \
	)
	esp = human_holder.GetComponent(/datum/component/echolocation)

	human_holder.remove_client_colour(/datum/client_colour/monochrome/blind)
	esp_color = human_holder.add_client_colour(/datum/client_colour/echolocation_custom)
	esp_color.update_colour(col)

	// add an action/spell to allow the player to toggle echolocation off for a bit (eyestrain on longer rounds, or just roleplay)
	var/datum/action/cooldown/spell/echolocation_toggle/toggle_action = new /datum/action/cooldown/spell/echolocation_toggle()
	toggle_action.Grant(human_holder)
	added_action = toggle_action
	RegisterSignal(human_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine_text))

/datum/quirk/echolocation/remove()
	QDEL_NULL(esp) // echolocation component removal handles graceful disposal of everything above
	QDEL_NULL(added_action) // remove the stall action, too
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.remove_client_colour(/datum/client_colour/echolocation_custom) // clean up the custom colour override we added
	UnregisterSignal(human_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine_text))

/datum/quirk/echolocation/proc/on_examine_text(client/client_source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/quirk/echolocation/echo = human_holder.get_quirk(/datum/quirk/echolocation)
	var/datum/component/echolocation/quirk_esp = echo.esp

	if(quirk_esp.stall == TRUE)
		return
	examine_list += span_cyan("[human_holder.p_They()] [human_holder.p_have()] [human_holder.p_their()] ears perked up, listening closely to even slightest noise.")

/datum/client_colour/echolocation_custom
	colour = COLOR_MATRIX_SEPIATONE
	priority = 1
	override = TRUE

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
