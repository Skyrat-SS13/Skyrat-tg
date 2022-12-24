/obj/item/mesmotron
	name = "hypnotic pocketwatch"
	desc = "An elaberate gold etched pocket, with an enchanting face, and captivating mechanical tick."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/pocketwatch.dmi'
	icon_state = "pocketwatch"
	w_class = WEIGHT_CLASS_SMALL
	/// This stores the target it's successful on for future use in giving suggestions
	var/mob/living/carbon/subject
	/// Icon State with alt-click
	var/closed = FALSE

// Hypnotize Someone
/obj/item/mesmotron/attack(mob/living/carbon/human/target, mob/living/user)
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("[target] doesn't want to be hypnotized."))
		return

	if(target.IsSleeping())
		to_chat(user, span_danger("You can't hypnotize [target] while they're sleeping!"))
		return

	if(!(in_range(user, target)) || closed)
		return

	if(!do_mob(user, target, 12 SECONDS))
		return

	user.visible_message(span_notice("[user] begins to wave an golden etched watch in front of [target]'s face in a mesmorizing manner."))
	var/response = tgui_alert(target, "Do you want to fall asleep? (This will allow [user] to issue hypnotic suggestions)", "Hypnosis", list("Yes", "No"))
	if(response == "Yes")
		target.visible_message(span_purple("[target] falls into a deep, hypnotic slumber right at the snap of your fingers."), span_purple("You suddenly fall limp at the snap of [user]'s fingers."))
		target.SetSleeping(60 SECONDS)
		subject = target
	else
		target.visible_message(span_warning("[target]'s attention breaks despite your efforts. They clearly don't seem interested!"), span_danger("Your attention breaks as you realize that you don't want to listen to [user]'s suggestions."))


/obj/item/mesmotron/attack_self(mob/user)
	if(closed || !subject)
		return

	if(!subject.IsSleeping())
		subject = null
		to_chat(user, span_purple("[subject] seems to no longer be asleep."))
		return

	var/response = tgui_alert(user, "Would you like to release your subject or give them a suggestion?", "Hypnotic Pocketwatch", list("Suggestion", "Release"))
	if(response == "Suggestion")
		if(!in_range(user, subject))
			to_chat(span_purple("You must be in whisper range to [subject]."))
			return
		var/text = tgui_input_text(user, "What would you like to suggest?", "Hypnotic Suggestion")
		to_chat(user, span_purple("You whisper into [subject]'s ears in a smooth, calming voice."))
		to_chat(subject, span_hypnophrase("[text]"))
	else
		subject.visible_message(span_purple("[subject] wakes up from their slumber."), span_purple("You wake up from your deep, hypnotc slumber and the new compulsions settle into your mind."))
		subject.SetSleeping(0)
		subject = null

/obj/item/mesmotron/AltClick(mob/user)
	if(icon_state == "pocketwatch")
		icon_state = "pocketwatch_closed"
		desc = "An elaberate pocket watch with a gold etching. It's closed however and you can't see its face."
		closed = TRUE
	else
		icon_state = "pocketwatch"
		desc = "An elaberate gold etched pocket, with an enchanting face, and captivating mechanical tick."
		closed = FALSE

/obj/item/mesmotron/Destroy(force)
    subject = null
    return ..()
