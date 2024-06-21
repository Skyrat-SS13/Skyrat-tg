/obj/item/disk/nifsoft_uploader/dorms/hypnosis
	name = "Purpura Eye"
	loaded_nifsoft = /datum/nifsoft/action_granter/hypnosis

/datum/nifsoft/action_granter/hypnosis
	name = "Libidine Eye"
	program_desc = "Based on the hypnotic equipment provided by the LustWish vendor, the Libidine Eye NIFSoft allows the user to ensnare others in a hypnotic trance. ((This is intended as a tool for ERP, don't use this for gameplay reasons.))"
	buying_category = NIFSOFT_CATEGORY_FUN
	lewd_nifsoft = TRUE
	purchase_price = 150
	able_to_keep = TRUE
	active_cost = 0.1
	ui_icon = "eye"
	action_to_grant = /datum/action/innate/nif_hypnotize

/datum/action/innate/nif_hypnotize
	name = "Hypnotize"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "hypnotize"

/datum/action/innate/nif_hypnotize/Activate()
	var/mob/living/carbon/human/user = owner
	if(!istype(user))
		return FALSE

	var/mob/living/carbon/human/target_human = user.pulling
	if(!istype(target_human) || user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You need to aggressively grab someone to hypnotize them."))
		return FALSE

	if(!target_human.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_warning("[target_human] doesn't want to be hypnotized."))
		return FALSE

	to_chat(user, span_notice("You begin to place [target_human] into a hypnotic trance."))

	if(!do_after(user, 12 SECONDS, target_human))
		return FALSE

	var/choice = tgui_alert(target_human, "Do you believe in hypnosis? (This will allow [user] to issue hypnotic suggestions.)", "Hypnosis", list("Yes", "No"))
	if(choice != "Yes")
		to_chat(user, span_warning("[target_human]'s attention breaks despite your efforts. They clearly don't seem interested!"))
		to_chat(target_human, span_warning("Your attention breaks as you realize that you don't want to listen to [user]'s suggestions."))
		return FALSE

	user.visible_message(span_purple("[target_human] falls into a deep, hypnotic slumber right at the snap of your fingers."), span_purple("You suddenly fall limp at the snap of [user]'s fingers."))
	user.emote("snap")
	target_human.SetSleeping(60 SECONDS)
	target_human.log_message("[target_human] was placed into a hypnotic sleep by [user].", LOG_GAME)

	var/secondary_choice = tgui_alert(user, "Would you like to give [target_human] a hypnotic suggestion or release them?", "Hypnosis", list("Suggestion", "Release"))
	while(secondary_choice == "Suggestion" && target_human.IsSleeping())
		if(!in_range(user, target_human))
			to_chat(user, span_warning("You must be in whisper range to [target_human] in order to give hypnotic suggestions."))
			target_human.SetSleeping(0)
			return FALSE

		var/input_text = tgui_input_text(user, "What would you like to suggest?", "Hypnotic Suggestion")
		to_chat(user, span_purple("You whisper into [target_human]'s ears in a soothing voice."))
		to_chat(target_human, span_hypnophrase("[input_text]"))
		secondary_choice = tgui_alert(user, "Would you like to give [target_human] an additional hypnotic suggestion or release them?", "Hypnosis", list("Suggestion", "Release"))

	user.visible_message(span_purple("You wake up from your deep, hypnotic slumber. The suggestions from [user] now settled into your mind."), span_purple("[target_human] wakes up from their slumber."))
	target_human.SetSleeping(0)
